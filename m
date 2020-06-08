Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8353BC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 16:56:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EEC02053B
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 16:56:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TAfmK0oQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EEC02053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiL4k-0003Bi-Hm
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 12:56:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45328)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1jiL3G-0001Co-6O; Mon, 08 Jun 2020 12:55:10 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:35818)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1jiL32-0000ht-ND; Mon, 08 Jun 2020 12:55:09 -0400
Received: by mail-wm1-x343.google.com with SMTP id q25so245584wmj.0;
 Mon, 08 Jun 2020 09:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:reply-to:to:cc:references:in-reply-to:subject:date:message-id
 :mime-version:content-transfer-encoding:content-language
 :thread-index; bh=oNB6pAr4fcRFpfN0vgO3R/SPq1U20RR7okPBo0+FgUE=;
 b=TAfmK0oQkeSGz62TuViy7NuLCNk1BF68l8xbAdU7an1ZC1hVV98IKOoRjmqyaTwVAN
 +in5sBo54K9vZ+PoT5Dju2DDOh9ml4x74mKWFDeR19EFjNT+Klc17086J5unyRp6crm0
 iX59NmiKjPexLajwu2LCbDjom1z4V5Ya7Tr/x9a2tD7WOo4+qq200GMJWH+At1YTWsbM
 +wJH2TSrIVK7d5tnTy4ZVb1OjT049f7NavDysekPgvsZp+8YL5JJqDIx0twx4zpgFLUZ
 BUPmA4rk/i0fKuA7MEpGHm8R9boPmkow/IyBFJZL0415yukucMZFCcEQRzyZerGGqu0H
 ++ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:reply-to:to:cc:references:in-reply-to
 :subject:date:message-id:mime-version:content-transfer-encoding
 :content-language:thread-index;
 bh=oNB6pAr4fcRFpfN0vgO3R/SPq1U20RR7okPBo0+FgUE=;
 b=caPW/ILB+sQl1KTOUupbXUumWUywu9CuEMZrVwOpvGWFA5jRFMZIpznHcV/FTtC9Mq
 7R/Q07s1zKhlm2jbf1g+jBb/khN/+Wvh9APuJfZ11pxqZVs5VzGiAS+Ue/VeCIFvz9wR
 GtOzketXZCmhArs6bfNxYTmVc8ThpwVJhZNHycypjY2Lue264BOWggxkKftIMpDTWA4i
 WHbnNn/FvPHMvzFNR76DCpUnlxOW2M488hGkweAR3jlzs2gG/Aq9kRU9IVES/hXM3Nj+
 VSP85ixUQGtFC+A4PfUnoxvZVoy1YCZb6Tc0S3RWz788GqiV5Hm4uaocdU9fU5o0y2VB
 wiwA==
X-Gm-Message-State: AOAM532mzw7cf7+1a06FmRFd5ArI+74YoxKxUIdg7REWGV1FPOdnhiol
 rvDaDauNekHA3XzcOfgs3qU=
X-Google-Smtp-Source: ABdhPJxYf2eoroXcg65HH/FtSRR8gJU7TD34bYCLjdlEtahbcmy4LN05uTpS+ECevCEPvzvZc0skGg==
X-Received: by 2002:a1c:4e17:: with SMTP id g23mr274089wmh.38.1591635293576;
 Mon, 08 Jun 2020 09:54:53 -0700 (PDT)
Received: from CBGR90WXYV0 ([54.239.6.185])
 by smtp.gmail.com with ESMTPSA id s72sm120153wme.35.2020.06.08.09.54.50
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 08 Jun 2020 09:54:52 -0700 (PDT)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: "Paul Durrant" <paul@xen.org>
To: =?utf-8?Q?'Philippe_Mathieu-Daud=C3=A9'?= <philmd@redhat.com>,
 <qemu-devel@nongnu.org>
References: <20200608160044.15531-1-philmd@redhat.com>
 <20200608160044.15531-16-philmd@redhat.com>
In-Reply-To: <20200608160044.15531-16-philmd@redhat.com>
Subject: RE: [RFC PATCH 15/35] hw/i386/xen/xen-hvm: Emit warning when old code
 is used
Date: Mon, 8 Jun 2020 17:54:49 +0100
Message-ID: <004b01d63db5$87a83110$96f89330$@xen.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-gb
Thread-Index: AQFYw0U0oKWIX6kmOq5Lq1JhZGgcHAJ29BtBqbYsFpA=
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=xadimgnik@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Reply-To: paul@xen.org
Cc: 'Peter Maydell' <peter.maydell@linaro.org>,
 'Sagar Karandikar' <sagark@eecs.berkeley.edu>,
 "'Michael S. Tsirkin'" <mst@redhat.com>,
 'Mark Cave-Ayland' <mark.cave-ayland@ilande.co.uk>,
 'Max Filippov' <jcmvbkbc@gmail.com>,
 'Alistair Francis' <Alistair.Francis@wdc.com>,
 'Gerd Hoffmann' <kraxel@redhat.com>,
 "'Edgar E. Iglesias'" <edgar.iglesias@gmail.com>,
 'Stefano Stabellini' <sstabellini@kernel.org>,
 'Magnus Damm' <magnus.damm@gmail.com>, 'Markus Armbruster' <armbru@redhat.com>,
 'Anthony Perard' <anthony.perard@citrix.com>,
 =?utf-8?Q?'Marc-Andr=C3=A9_Lureau'?= <marcandre.lureau@redhat.com>,
 'David Gibson' <david@gibson.dropbear.id.au>,
 'Eduardo Habkost' <ehabkost@redhat.com>,
 'Alistair Francis' <alistair@alistair23.me>, qemu-arm@nongnu.org,
 xen-devel@lists.xenproject.org, qemu-riscv@nongnu.org,
 'Stafford Horne' <shorne@gmail.com>, 'Palmer Dabbelt' <palmer@dabbelt.com>,
 'Richard Henderson' <rth@twiddle.net>,
 "'Daniel P . Berrange'" <berrange@redhat.com>,
 'Thomas Huth' <huth@tuxfamily.org>,
 'Bastian Koppelmann' <kbastian@mail.uni-paderborn.de>,
 'Michael Walle' <michael@walle.cc>, qemu-ppc@nongnu.org,
 'Paolo Bonzini' <pbonzini@redhat.com>, 'Aurelien Jarno' <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> -----Original Message-----
> From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Sent: 08 June 2020 17:00
> To: qemu-devel@nongnu.org
> Cc: qemu-arm@nongnu.org; Markus Armbruster <armbru@redhat.com>; Max =
Filippov <jcmvbkbc@gmail.com>;
> Marcel Apfelbaum <marcel.apfelbaum@gmail.com>; Peter Maydell =
<peter.maydell@linaro.org>; Michael Walle
> <michael@walle.cc>; Edgar E. Iglesias <edgar.iglesias@gmail.com>; =
Aurelien Jarno
> <aurelien@aurel32.net>; Gerd Hoffmann <kraxel@redhat.com>; Stafford =
Horne <shorne@gmail.com>; Andrzej
> Zaborowski <balrogg@gmail.com>; qemu-ppc@nongnu.org; Alistair Francis =
<alistair@alistair23.me>;
> Richard Henderson <rth@twiddle.net>; Mark Cave-Ayland =
<mark.cave-ayland@ilande.co.uk>; Marc-Andr=C3=A9
> Lureau <marcandre.lureau@redhat.com>; Daniel P . Berrange =
<berrange@redhat.com>; qemu-
> riscv@nongnu.org; Michael S. Tsirkin <mst@redhat.com>; =
xen-devel@lists.xenproject.org; Sagar
> Karandikar <sagark@eecs.berkeley.edu>; Anthony Perard =
<anthony.perard@citrix.com>; Palmer Dabbelt
> <palmer@dabbelt.com>; Stefano Stabellini <sstabellini@kernel.org>; =
Paul Durrant <paul@xen.org>; Paolo
> Bonzini <pbonzini@redhat.com>; Alistair Francis =
<Alistair.Francis@wdc.com>; Eduardo Habkost
> <ehabkost@redhat.com>; Thomas Huth <huth@tuxfamily.org>; Bastian =
Koppelmann <kbastian@mail.uni-
> paderborn.de>; David Gibson <david@gibson.dropbear.id.au>; Magnus Damm =
<magnus.damm@gmail.com>;
> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Subject: [RFC PATCH 15/35] hw/i386/xen/xen-hvm: Emit warning when old =
code is used
>=20
> This code hasn't been QOM'ified yet. Warn the user.

"Based on today's IRC chat, this is a trivial RFC series
to anotate pre-qdev/QOM devices so developers using them
without knowing they are not QOM'ified yet can realize
it and convert them if they have time."

So, how should this be coded then? The XenIOState doesn't really qualify =
as a 'device', does it?

  Paul

>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/i386/xen/xen-hvm.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
> index 82ece6b9e7..a1163b1529 100644
> --- a/hw/i386/xen/xen-hvm.c
> +++ b/hw/i386/xen/xen-hvm.c
> @@ -31,7 +31,7 @@
>  #include "sysemu/xen-mapcache.h"
>  #include "trace.h"
>  #include "exec/address-spaces.h"
> -
> +#include "hw/qdev-deprecated.h"
>  #include <xen/hvm/ioreq.h>
>  #include <xen/hvm/e820.h>
>=20
> @@ -1401,6 +1401,8 @@ void xen_hvm_init(PCMachineState *pcms, =
MemoryRegion **ram_memory)
>      xen_pfn_t ioreq_pfn;
>      XenIOState *state;
>=20
> +    qdev_warn_deprecated_function_used();
> +
>      state =3D g_malloc0(sizeof (XenIOState));
>=20
>      state->xce_handle =3D xenevtchn_open(NULL, 0);
> --
> 2.21.3



