Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60193C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 16:37:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C7A5206BE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 16:37:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SXkMetIV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C7A5206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCnJB-0003bS-BY
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 12:37:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36049)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jCnHj-0001yb-87
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 12:35:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jCnHg-0000P1-V9
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 12:35:43 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:56325
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jCnHg-0000Ll-RC
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 12:35:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584117340;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ydkFaQ6HWDnOmhWTy3Ayfm89ZRA5mGgO0FgQtAUwKO4=;
 b=SXkMetIVBn2i7QdLMc4UXxf03NkY+ZpMF7Rx1iV59RqpZ+tFsL2ttiGwIN5M33WlySowIM
 NvZzee9jLfnzQEqk7nuhLEsp4W+Zry1kxagc75yeAgaOhnmxahddbAdXbqZUBD1tVDMp/t
 zGlHtxjODY7QZFXXgpl9Gu0V26vJMoU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-166--4k17SNEPkykEE6xoRUcAQ-1; Fri, 13 Mar 2020 12:35:23 -0400
X-MC-Unique: -4k17SNEPkykEE6xoRUcAQ-1
Received: by mail-wr1-f69.google.com with SMTP id b11so4545602wru.21
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 09:35:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dxLTxNr05a/f3DhSwzgbOALYF9tvIKTm8VfVQlXaGqk=;
 b=POnf8/4enXIR4O3UZm0doCHPuvRq2PcqgJJx24j1MpNZbkwCSjifStQeiwW8vph5nQ
 Yh/HpOYLzADgsF6v3TqH9kGIZXvG4JWz4WPm2YNplfqBYcWX9SzQ/nwIUUo/+1DjjBmg
 pjg7BeKH+JA2BNbuYRcj876mCe2OKSZV08LmpIJhQywc9pPttYm6W07fcUHdBcfSEdR6
 pEbvqq8wKqZFeyfnxGvGiIy8scaloIcBWgto1FucviQAlTTElEilOLyzts+tqcCj8gzv
 SZxnYnQ4m6+BkYrk8gMXxltwF5BNRpuYiNRq94fgYbUrbJCbVvhdmteNpa0jDLyqlvLk
 77Bw==
X-Gm-Message-State: ANhLgQ20+IeUgxZyObl3YnV0hhGaKTkFzQY46989E0mAYlhPr4PZz+Ox
 vIchXZ3+RNwZ4Xg11SIMCcHvVKWlIlG34+0ZBxMvylFtHF1PI+dMJQSsTudRlwwjL2wyry0wvTL
 SJcADj5THOMQZHYI=
X-Received: by 2002:a1c:6885:: with SMTP id d127mr11728621wmc.33.1584117322353; 
 Fri, 13 Mar 2020 09:35:22 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vs3aQXEKcdsoA4AgVR2iXPO/SbCaJ/hccdLzdfTT+4fb07gcMWjXI/XvkRvgr6dvzi6xe0T+Q==
X-Received: by 2002:a1c:6885:: with SMTP id d127mr11728602wmc.33.1584117322058; 
 Fri, 13 Mar 2020 09:35:22 -0700 (PDT)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id k126sm17549516wme.4.2020.03.13.09.35.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Mar 2020 09:35:21 -0700 (PDT)
Subject: Re: [PATCH 2/3] MAINTAINERS: Adjust maintainer's email
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 qemu-devel@nongnu.org, peter.maydell@linaro.org
References: <1584061252-16635-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1584061252-16635-3-git-send-email-aleksandar.markovic@rt-rk.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <bf500781-f951-c9f2-839b-c9a7684a0dc6@redhat.com>
Date: Fri, 13 Mar 2020 17:35:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1584061252-16635-3-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/13/20 2:00 AM, Aleksandar Markovic wrote:
> From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
>=20
> For some longish time I've been using multiple email addresses
> for mailing list communication, and would like to consolidate it
> into a single email address that is the most convenient to me.
> My other emails, from rt-rk.com and wavecomp.com domains remain
> active and I will respond from them too, if needed, but I would
> like to manage almost all communication using gmail.com account.
>=20
> Signed-off-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
> ---
>   .mailmap    |  5 +++--
>   MAINTAINERS | 12 ++++++------
>   2 files changed, 9 insertions(+), 8 deletions(-)
>=20
> diff --git a/.mailmap b/.mailmap
> index 76154c7..e431d1f 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -39,8 +39,9 @@ Julia Suvorova <jusual@mail.ru> Julia Suvorova via Qemu=
-devel <qemu-devel@nongnu
>   Justin Terry (VM) <juterry@microsoft.com> Justin Terry (VM) via Qemu-de=
vel <qemu-devel@nongnu.org>
>  =20
>   # Next, replace old addresses by a more recent one.
> -Aleksandar Markovic <amarkovic@wavecomp.com> <aleksandar.markovic@mips.c=
om>
> -Aleksandar Markovic <amarkovic@wavecomp.com> <aleksandar.markovic@imgtec=
.com>
> +Aleksandar Markovic <aleksandar.m.mail@gmail.com> <aleksandar.markovic@m=
ips.com>
> +Aleksandar Markovic <aleksandar.m.mail@gmail.com> <aleksandar.markovic@i=
mgtec.com>
> +Aleksandar Markovic <aleksandar.m.mail@gmail.com> <amarkovic@wavecomp.co=
m>
>   Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com> <arikalo@wavecomp.com>
>   Anthony Liguori <anthony@codemonkey.ws> Anthony Liguori <aliguori@us.ib=
m.com>
>   James Hogan <jhogan@kernel.org> <james.hogan@imgtec.com>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4fba8b8..8411c96 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -209,7 +209,7 @@ F: hw/microblaze/
>   F: disas/microblaze.c
>  =20
>   MIPS TCG CPUs
> -M: Aleksandar Markovic <amarkovic@wavecomp.com>
> +M: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
>   R: Aurelien Jarno <aurelien@aurel32.net>
>   R: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
>   S: Maintained
> @@ -1016,7 +1016,7 @@ F: hw/display/jazz_led.c
>   F: hw/dma/rc4030.c
>  =20
>   Malta
> -M: Aleksandar Markovic <amarkovic@wavecomp.com>
> +M: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
>   M: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>   R: Aurelien Jarno <aurelien@aurel32.net>
>   S: Maintained
> @@ -1029,14 +1029,14 @@ F: tests/acceptance/linux_ssh_mips_malta.py
>   F: tests/acceptance/machine_mips_malta.py
>  =20
>   Mipssim
> -M: Aleksandar Markovic <amarkovic@wavecomp.com>
> +M: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
>   R: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
>   S: Odd Fixes
>   F: hw/mips/mips_mipssim.c
>   F: hw/net/mipsnet.c
>  =20
>   R4000
> -M: Aleksandar Markovic <amarkovic@wavecomp.com>
> +M: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
>   R: Aurelien Jarno <aurelien@aurel32.net>
>   R: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
>   S: Obsolete
> @@ -1044,7 +1044,7 @@ F: hw/mips/mips_r4k.c
>  =20
>   Fulong 2E
>   M: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> -M: Aleksandar Markovic <amarkovic@wavecomp.com>
> +M: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
>   S: Odd Fixes
>   F: hw/mips/mips_fulong2e.c
>   F: hw/isa/vt82c686.c
> @@ -2508,7 +2508,7 @@ F: tcg/i386/
>   F: disas/i386.c
>  =20
>   MIPS TCG target
> -M: Aleksandar Markovic <amarkovic@wavecomp.com>
> +M: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
>   R: Aurelien Jarno <aurelien@aurel32.net>
>   R: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
>   S: Maintained
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


