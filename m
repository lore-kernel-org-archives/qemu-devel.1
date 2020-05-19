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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63934C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 21:20:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E90A2072C
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 21:20:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O5WOO2td"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E90A2072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb9fP-00035b-CG
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 17:20:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37210)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jb9eY-00028a-4k
 for qemu-devel@nongnu.org; Tue, 19 May 2020 17:19:58 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:36433)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jb9eX-0004U8-Aj
 for qemu-devel@nongnu.org; Tue, 19 May 2020 17:19:57 -0400
Received: by mail-io1-xd42.google.com with SMTP id c16so825698iol.3
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 14:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=635MI2UsXHJuzWzjh3AwSkAkPl4uiFsySNmohbmCuds=;
 b=O5WOO2tdIKWc9Fgty0u5tu8viJYV226PPcCnC1w8pWLMZB5eITWT1b50N/Fukh/MOe
 TuY5C5Gimc/UfzhZvcMsjnZUavp5BpA0ceJxK3AfHIXFWA/eZX33+lOdUJ8KpPlACOG/
 Ut5KhgZ5gfA2JF6zxRHQfso1TkNFMLlV5XlQc8K0/Npo5Txi3AUminloEgprK3EN3TG1
 P30aE5SLPuXeqrhOh6E7P1JchITbSNYx6Ym5CGKmq/HkVZziOima/rWiISE/NPc+mQhL
 N+uoX5p4LuwkY2iCGiOMDGO3Q+3Vj8bqoZ1hLfcaCKdYIX8XLcXBNzFFtmozlTcGJWb5
 Pvww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=635MI2UsXHJuzWzjh3AwSkAkPl4uiFsySNmohbmCuds=;
 b=fFiykx6KiQ05LigkvctiD/8WjWLtZkaJ3JwDNdEz7lppPmj3GGuYhi4v9i3YnRBOXf
 yY3GcgN+toT7ip6B50cOqNrdxnN/XjlYESijb83DjyQ9MhvJ7M4vrEE5kGKJ4OFcM+ZB
 vCOfCwxs4LrH4jCBWoI/A2xslolJiWucdCqznuEx5IrXtGCgXQWyQODuIHTlBLp2XAM8
 MokAr0bq81frgOHxogdj47GTZB876NOV77WzIPu7NbI33HWn6yYcNaPigbU9V7+EuhZd
 ktqn4+2smmO8A/Ejw6fXbjrGp/l8ugbURUXYpTfKPOeO9b8JRCv7zD3R9OWoHK9yjQwN
 CKvA==
X-Gm-Message-State: AOAM530dSod34Mp3rM3NfKdLesuaZJ4Mk3BsZNr30pEUhzwW9IseVftf
 s0ZdDx24J2mhmsgUt0LHnSXhas2Rvb63XVjk6XSaEuLU
X-Google-Smtp-Source: ABdhPJxFUc5v3zyQZpJu929zjnO5zzNQIwqS/OoNVsoveEvuzTjxPg42zf6gXPmahaftyNqP8g9JiQjT5k8k0Wyd2aI=
X-Received: by 2002:a6b:dc11:: with SMTP id s17mr929388ioc.42.1589923196262;
 Tue, 19 May 2020 14:19:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200519145551.22836-1-armbru@redhat.com>
 <20200519145551.22836-25-armbru@redhat.com>
In-Reply-To: <20200519145551.22836-25-armbru@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 19 May 2020 14:11:03 -0700
Message-ID: <CAKmqyKPpNMdOGjmAdfyHBSYbNx3si35a_iqufCMm3EPzgw8CdA@mail.gmail.com>
Subject: Re: [PATCH 24/55] ssi: ssi_create_slave_no_init() is now unused, drop
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d42;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd42.google.com
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

On Tue, May 19, 2020 at 8:06 AM Markus Armbruster <armbru@redhat.com> wrote:
>
> Cc: Alistair Francis <alistair@alistair23.me>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  include/hw/ssi/ssi.h | 1 -
>  hw/ssi/ssi.c         | 5 -----
>  2 files changed, 6 deletions(-)
>
> diff --git a/include/hw/ssi/ssi.h b/include/hw/ssi/ssi.h
> index 1725b13c32..93f2b8b0be 100644
> --- a/include/hw/ssi/ssi.h
> +++ b/include/hw/ssi/ssi.h
> @@ -79,7 +79,6 @@ extern const VMStateDescription vmstate_ssi_slave;
>  }
>
>  DeviceState *ssi_create_slave(SSIBus *bus, const char *name);
> -DeviceState *ssi_create_slave_no_init(SSIBus *bus, const char *name);
>
>  /* Master interface.  */
>  SSIBus *ssi_create_bus(DeviceState *parent, const char *name);
> diff --git a/hw/ssi/ssi.c b/hw/ssi/ssi.c
> index 58e7d904db..67b48c31cd 100644
> --- a/hw/ssi/ssi.c
> +++ b/hw/ssi/ssi.c
> @@ -90,11 +90,6 @@ static const TypeInfo ssi_slave_info = {
>      .abstract = true,
>  };
>
> -DeviceState *ssi_create_slave_no_init(SSIBus *bus, const char *name)
> -{
> -    return qdev_create(BUS(bus), name);
> -}
> -
>  DeviceState *ssi_create_slave(SSIBus *bus, const char *name)
>  {
>      DeviceState *dev = qdev_new(name);
> --
> 2.21.1
>
>

