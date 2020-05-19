Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F21C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 21:38:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F42B208C3
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 21:38:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V4FL8Vwj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F42B208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb9wD-00036y-P9
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 17:38:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38838)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jb9vT-0002R7-3R
 for qemu-devel@nongnu.org; Tue, 19 May 2020 17:37:27 -0400
Received: from mail-il1-x141.google.com ([2607:f8b0:4864:20::141]:40526)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jb9vS-00083E-9G
 for qemu-devel@nongnu.org; Tue, 19 May 2020 17:37:26 -0400
Received: by mail-il1-x141.google.com with SMTP id m6so965439ilq.7
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 14:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0Qez3d/I8o/n55+qx5z2LlftJC3Monu5PzuffpM2l38=;
 b=V4FL8VwjsmHiv1YyTKr1FiZHlGjj+T5GjPP1v2/XT2a7BXmPhJqkxGpP3o1/8hAWtJ
 xUjMhvgli0DJzsOapY2kMk4BSgYV3U2aQALBO7ARAjPa14C2xrqH1OwGLH5LeKvCPRRd
 +Pi2e3K3aSMT8Vs4fWFpm/pBJU4mmASYkgMOcQKnyiC0RcjdoL6o/GmmcHCjBnM9dxAY
 1qpExfCPRjGCjGfrindlyaghrtL3LLKTH+am0GJ87DosNmadlV316WssYaEod9LTNLGm
 JfSCK7CB2fzMlfLozbGt6jdZ0PYXV2Rza1l69tCpg3gXvA/ebORCxLTZ/O5rLSO/s0lz
 JMQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0Qez3d/I8o/n55+qx5z2LlftJC3Monu5PzuffpM2l38=;
 b=isp8+P7Yfy9GZ1RE6ymxCG+Yi/w3bLvtyROrYMhqX8hVBxycsZvSjB0QwI4cV05ica
 oqnURsUXgDU4KMR0mCypz2SJhAc4DCpVWKNiR12nhT/nuwSY1i5ETuCwZDFy2/594sXs
 dRGkS1SJulzgL4Bh2tg0glv6gQgZhqCdcZjDg3lBBGbPlgcfIhs7GQV1ZNc1IYM5m9SV
 7h30jGPYrOlFsu7t7vkydmAEyJ1qkQqzSeCztDp9x7q7RurcQq/tRobSlVRoVewaNIXZ
 DyxhoNpvwKtuFnFTTVp0NwPNzfQMTnGXldNAhL3C9x8qMm2JGXcJ5JKGb0DCiIjOymMZ
 eevg==
X-Gm-Message-State: AOAM532JMwvWma/pSaayDhmFs6T+UDoJvW7RtMXUo/lXolo+RB0j8+1S
 jUzzy4iD+Ad5O23l3EMHwBHelm9fNbB33CaLUgtevGmV
X-Google-Smtp-Source: ABdhPJyMuasxPZoXGQcr82ZGZ+fySW058cFjsw6dTNR5Y6hSqq0oeDZNbTu35Do2zbsMvScJZljpFURpr199ahAJutc=
X-Received: by 2002:a92:de02:: with SMTP id x2mr1102954ilm.267.1589924245116; 
 Tue, 19 May 2020 14:37:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200519145551.22836-1-armbru@redhat.com>
 <20200519145551.22836-54-armbru@redhat.com>
In-Reply-To: <20200519145551.22836-54-armbru@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 19 May 2020 14:28:32 -0700
Message-ID: <CAKmqyKP-+N0=K7b2vA6bbPCCNMLEqy=dqywLLuhDVEsWvM4_8w@mail.gmail.com>
Subject: Re: [PATCH 53/55] qdev: Convert bus-less devices to qdev_realize()
 with Coccinelle
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::141;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x141.google.com
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
 "Daniel P. Berrange" <berrange@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 19, 2020 at 8:29 AM Markus Armbruster <armbru@redhat.com> wrote:
>
> All remaining conversions to qdev_realize() are for bus-less devices.
> Coccinelle script:
>
>     // only correct for bus-less @dev!
>
>     @@
>     expression errp;
>     expression dev;
>     @@
>     -    qdev_init_nofail(dev);
>     +    qdev_realize(dev, NULL, &error_fatal);
>
>     @ depends on !(file in "hw/core/qdev.c") && !(file in "hw/core/bus.c")@
>     expression errp;
>     expression dev;
>     symbol true;
>     @@
>     -    object_property_set_bool(OBJECT(dev), true, "realized", errp);
>     +    qdev_realize(DEVICE(dev), NULL, errp);
>
>     @ depends on !(file in "hw/core/qdev.c") && !(file in "hw/core/bus.c")@
>     expression errp;
>     expression dev;
>     symbol true;
>     @@
>     -    object_property_set_bool(dev, true, "realized", errp);
>     +    qdev_realize(DEVICE(dev), NULL, errp);
>
> Note that Coccinelle chokes on ARMSSE typedef vs. macro in
> hw/arm/armsse.c.  Worked around by temporarily renaming the macro for
> the spatch run.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> --
> 2.21.1
>
>

