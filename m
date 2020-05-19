Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AFB9C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 21:08:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52FE420758
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 21:08:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TQxXx7R/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52FE420758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb9TF-0001tN-HD
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 17:08:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35914)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jb9SL-0000x3-O9
 for qemu-devel@nongnu.org; Tue, 19 May 2020 17:07:21 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:36905)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jb9SK-0001r8-LM
 for qemu-devel@nongnu.org; Tue, 19 May 2020 17:07:21 -0400
Received: by mail-io1-xd41.google.com with SMTP id t15so787614ios.4
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 14:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yoOxZj/HdBPnPjUa1p2NrUO9AmXeNtoE6mRa+A805Rg=;
 b=TQxXx7R/k2ymMXYiGtJgJevxKYDQF6s7HoFD/8amrWZtXv0+Wp6OsLnCe7tTYvNvBh
 SdFVUvueuQ9pRJxu2CWbpjBqmxEebup6ONEJPKDF28TInqxnzo24Qzf90XRW5u7bmQDy
 qYtiTvtiT//zJiIqXu+gqUIvZ48DYceJGNK0FT/kq1e5CTfqSyU1nj3z9rjCh2qUm72e
 s07tHBvEGA5ZijbVSicIwPR2koV840FLpow88ER4rV7Il2eVU92sqRpE2++PiyikLd42
 0EUFSs149p+1Vtl//oYwU0AhYV5XAdB96/yiVBYrkBvodZDJ0jU9YHOnq7Id7BQJCOJN
 55aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yoOxZj/HdBPnPjUa1p2NrUO9AmXeNtoE6mRa+A805Rg=;
 b=E2ZzeD+O328kieb3TjoBwHOVSwOuUQla6dGMZ5Z17V0iMsnD0Iev+LGjm7MvdWqKTC
 4bdj+dNQ6NspBsTRZbWle2nUDz32DHGG3EqjhA9Og79Yzm3M3VVwuov89yahAM77+wnk
 TGyxjp2tePq5ym6yWsu6E4DykbHHo+vVk3elSBfB1tgXtJJo+fzVNHWzgj/ve2J1du2F
 YcHONRu32FCQiYIREBI/PE6AMvBk5Hf5eYKbDfJSQFlXB2JbQGefVk4/0y7q/03GXn5r
 sMlBNHWbT/NXQxN88EgP2Aayk0YFB/ZMfEDsvDykldVTuYDrfp/i6KkX/uaUhdYj5P44
 1psw==
X-Gm-Message-State: AOAM533tmmXJNi9pUdF/8AZ9DvafhhgUQt1vUMy6Au5eETBZ+UQV7VUE
 H7Yi5sTf0UYPvSKs3uAvviFtLFRrwV/5BwFNMrg=
X-Google-Smtp-Source: ABdhPJwOSUrcgTjBw61c4FCfPvWJgqejSHQXpHTiKbfy3l79erK0fg4wSbBLP1zxfQOoQWY3HDO2dpTI9LjJGRNWhP4=
X-Received: by 2002:a6b:bf83:: with SMTP id p125mr853812iof.118.1589922439288; 
 Tue, 19 May 2020 14:07:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200519145551.22836-1-armbru@redhat.com>
 <20200519145551.22836-24-armbru@redhat.com>
In-Reply-To: <20200519145551.22836-24-armbru@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 19 May 2020 13:58:26 -0700
Message-ID: <CAKmqyKPt4wN2jX5pyHQumu1Er9Ao-ndEyGbT3qHbBQMWuqekAA@mail.gmail.com>
Subject: Re: [PATCH 23/55] ssi: Convert last use of ssi_create_slave_no_init()
 manually
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d41;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd41.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 19, 2020 at 8:03 AM Markus Armbruster <armbru@redhat.com> wrote:
>
> Same transformation as in the previous commit.  Manual, because
> convincing Coccinelle to transform this case is not worthwhile.
>
> Cc: Alistair Francis <alistair@alistair23.me>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Looks sane.

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/ssi/ssi.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/hw/ssi/ssi.c b/hw/ssi/ssi.c
> index 54106f5ef8..58e7d904db 100644
> --- a/hw/ssi/ssi.c
> +++ b/hw/ssi/ssi.c
> @@ -16,6 +16,7 @@
>  #include "hw/ssi/ssi.h"
>  #include "migration/vmstate.h"
>  #include "qemu/module.h"
> +#include "qapi/error.h"
>
>  struct SSIBus {
>      BusState parent_obj;
> @@ -96,9 +97,9 @@ DeviceState *ssi_create_slave_no_init(SSIBus *bus, const char *name)
>
>  DeviceState *ssi_create_slave(SSIBus *bus, const char *name)
>  {
> -    DeviceState *dev = ssi_create_slave_no_init(bus, name);
> +    DeviceState *dev = qdev_new(name);
>
> -    qdev_init_nofail(dev);
> +    qdev_realize_and_unref(dev, &bus->parent_obj, &error_fatal);
>      return dev;
>  }
>
> --
> 2.21.1
>
>

