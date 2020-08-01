Return-Path: <SRS0=xT3E=BL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3DF8C433E1
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Aug 2020 17:29:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 746982072A
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Aug 2020 17:29:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="PL+tNfch"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 746982072A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1vK4-0001Ne-Fl
	for qemu-devel@archiver.kernel.org; Sat, 01 Aug 2020 13:29:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58660)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1k1vH5-0000tm-L9
 for qemu-devel@nongnu.org; Sat, 01 Aug 2020 13:26:23 -0400
Received: from mout.gmx.net ([212.227.15.19]:40525)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1k1vH2-00015q-Iu
 for qemu-devel@nongnu.org; Sat, 01 Aug 2020 13:26:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1596302764;
 bh=aCj+G8Ht/TxpVR92SB3eH/CqkUDFvMlexVxFQqnhByg=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=PL+tNfcha9sGcn+3IEDZXn70Epr3x43MQP0HkL3ipdIdFE+RrRIv08lhKm+d/4k/p
 VJ1QesOL1RFzHkcLd1vdlI0R8AB+VOl5+hChRHz30G8srvU9k9WEeJdQa51OfZOzmA
 Sapj7yYA3OtuUiyTJ3Ub5O9OuLcKZf80U8KqT4VI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.162.176]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MHGCo-1jxVPw0WmG-00DGO1; Sat, 01
 Aug 2020 19:26:04 +0200
Subject: Re: [PATCH v2 0/4] target-hppa fixes
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org
References: <20200801131357.17379-1-deller@gmx.de>
 <21ec077f-b3aa-b755-7191-fc12985714bc@msgid.tls.msk.ru>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
 c2TFWAS8k6RLkk41ZUU8ENX8+qZx/Q==
Message-ID: <066e9cd1-9a69-7302-3d8f-0800455b67a7@gmx.de>
Date: Sat, 1 Aug 2020 19:26:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <21ec077f-b3aa-b755-7191-fc12985714bc@msgid.tls.msk.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Z66wGA9ot/VKgnhuosGhifypS//IkFFfSvdU45FvBKuxM6WuHsB
 rUGgth3Arwn8tvXySKqDE9q7ZrJQtaFgQA6zmET5BAg+DxJBWE3jQ1qZv/qhC+oTv7NtkYm
 TGWcuMmsdpzKpeaE3GAziMRnI6YAn9PfMdyQt5yHdcP/lqJJanWUXWiFibPCvFYjKbH7dlB
 Gvf6VMp0Il0eMsS/XQPNA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Fi3meeeLA98=:zVlJEBY6DU33yPFk8LX8tY
 jJXKbmohCMTD7I+7zpjDp3SW3kIqURO4+K1fJqvY+AIDkf5TfyZifr+Ocs07FVgUVtkp37jY0
 OSYuvz7eeXJdBbtFVNopArhHvSAO81wGrDAgtdyrM3XLPW6PK1Y97p0oh3MpSUlhwLwICcB1m
 jIygL3nsw0LcEkINayDxF1j1nS+NE7Yyb9+/BroexBh57mHtx0CeCac2ihzRMMKGeWTZRIZkf
 Y9k/MZ246jO6hErwskCaX/aWNMIWy606vL/LOc1n8OYg/bIaL3j8unKiONEXASQoBXurPaOwt
 76xWKJJZsSeyn3xC5gQCI+1Zts4IBHeWDVWfnv94yLgLzOv2qBI6OfMMq7dLpk6a/dHjM0QKn
 crpQDiX/1F9NWbvi/d0PWuJQPPgm6oB8L5HI48n7s9/T/wsvDa81VBi6bV4FhCnxYJPj5kb4R
 kOdXz0AEZ6cY/TZCVCS5IpuPn7jb9cYzSCVZM2/kmqmNEiduetjm0207Fbml9rFOrtK54DE1L
 hFrKKj+d8KWVURdLkHY0bn9LYNi8iiXriqxIJf9ot5e5yIFECQICqEPNhvXFFCkciLgNUAWLw
 SG3PI2hGyjThvd/sf2IEykYZSjyWLAlBQzb21uO0rCtfownsDZGEYMB0qc7P52YGnKfZf+HRy
 kyfEC/WO2gwO1RHmanNt09YBAauUwnMGzmQ4eKdWb2oB29cfZ5QzolDVUiAjtWdNQSsX+U1bX
 nVB0Cx3s0XIRF2UR0b2p3fvejBnGP4Lw/gC6kUe+zEu/RP/IQ1f4GGUo4hS5fg4LLgVR2u1GS
 f4OEagq+rQl5A20Z0jQsUbw4LPpZwZCvoCz8Tf08BAKmW8yjA2rAVzSLUmVrrqA1hfTRe/r12
 W9ciJ68GAj/Ikfwa9DGHUF6OeK43mhMJS52IOUd8BUr6vZRW2rPCR6ejNom7BnPJk/tEH3rys
 ItijEErd/FVrBNayesLfHGX5Ebz8BsfIWTDJ5FA5uz9TRjaCaUSuMuWTIoQpB35LMbWvBz+S8
 HvMX+yZNHSvUj3U67eIb3WAbySm2ehv+CQSIr4oYiC7iWmPq3ijWnM30aSGEPDuzh81E85yr7
 WOQk3GEdEPksock1LuAkQy7pfii0/lw8lttLKPo5dQ299CreGjB7VOOTXp5vTM861Yn89FAsO
 tkY3sZEXn1ocyVt/Rs7werbzHY8Kj9wVrN546kbEG5gETUy+6anHGm8SOZn/2g9nTd35EDdsQ
 vsJBalr7hqIJvEX0E4bLSCS43hPmBaJtz/NBtDkaUhlsXM0u860jzOrtI9ajrkzI3QGrsX/JM
 kNh52pjkqPpO8yHuPQaw3Sly2I6MlomcRjv8LH1coffwtQaQnOr1HbA7x1MkeymaBKMzt87I
Received-SPF: pass client-ip=212.227.15.19; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/01 13:26:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Michael,

On 01.08.20 18:47, Michael Tokarev wrote:
> 01.08.2020 16:13, Helge Deller wrote:
>> A few late fixes for target-hppa:
>>
>> * Fix the SeaBIOS-hppa firmware build with gcc-10 on Debian
>
> It looks like you forgot the above change somehow.

Actually, no, I did not forgot this patch.
It's part of the seabios-hppa repo, see here:
https://github.com/hdeller/seabios-hppa/commit/14a26ffb0d9ad1fc510da5d0321=
5b0e36f717fce

In this qemu patch series the binary firmware-hppa.img blob I
sent was built with it.

> And me too,
> I forgot to send you a proper [PATCH] for this.  This is what
> I use in Debian:
>
> From: Michael Tokarev <mjt@tls.msk.ru>
> Subject: seabios-hppa: add -fno-ipa-sra to the compiler flags
> Date: Wed, 22 Jul 2020 22:15:46 +0300
>
> This allows seabios-hppa to build with gcc-10. Or else the
> compiler generates eg memset.isra.0 symbols instead of memset,
> and the final link step fails due to missing memset.
>
> Previous versions of gcc, for quite some time already, recognizes
> this option but it does nothing since apparently no-ipa-sra is the
> default. So there's no harm in adding it unconditionally, it seems.
>
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
>
> index c0d5d958..1b7757e8 100644
> --- a/Makefile.parisc
> +++ b/Makefile.parisc
> @@ -76 +76 @@ COMMONCFLAGS :=3D -I$(OUT) -Isrc -Ivgasrc -Os -MD -g \
> -    -fno-builtin-printf
> +    -fno-builtin-printf -fno-ipa-sra
>
>
> This should not be required for the actual binary once it is built,
> however.

Yep.

Thanks!
Helge

