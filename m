Return-Path: <SRS0=Q/S9=2X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10BEDC2D0DC
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 11:11:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE57B2085B
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 11:11:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE57B2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imyO4-00008i-0v
	for qemu-devel@archiver.kernel.org; Thu, 02 Jan 2020 06:11:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42330)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1imyNS-000846-QB
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 06:10:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1imyNR-00008T-J9
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 06:10:54 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:33387)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1imyNR-0008VV-AE
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 06:10:53 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1Mz9d7-1jiFel3Vcx-00wAgk; Thu, 02 Jan 2020 12:10:48 +0100
Subject: Re: [PATCH] q800: implement mac rom reset function for BIOS-less mode
To: "Jason A. Donenfeld" <Jason@zx2c4.com>, qemu-devel@nongnu.org
References: <20200102103644.233370-1-Jason@zx2c4.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <60efe91c-af82-f6d7-36c5-c603971c2f33@vivier.eu>
Date: Thu, 2 Jan 2020 12:10:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200102103644.233370-1-Jason@zx2c4.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:QOlbt+QuUTeKELcDEx0bE5Zu1nwzjfdi+d4nUHykZmvKDkhR5PL
 +mP/R3s+nrTcT2nNnP/S7+BNT2UuiMc+dgdjLasf4gaIIqm+WxEm2n4ahDsKsRovM7Pqmtn
 A2+qozdd1ZQ5isYXtsYlBEVLXqphqRmG/S9PlWuM1vky+qpExnt7IWZu7xJWy0WJb4a4xJk
 FkFajRHww2P52iph8lpbw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4eV7oRqaQ5A=:dD/l/bmJDE9L5BhG8fPRqz
 1bsRbjbi55qFwPkXaBDhn3RkRvuBi7AoaTtip41S7gl8nNmTMlcNyp5Qbzrlsuy82YFFFz09D
 SpLfQ79LlGWDJy5iqqL2tIWTaGTieaOJHPzVbvxJf/4vRSmula8umdfdbVS4BUfokIYX+L/hO
 ujR/yZCYgD2/7WMhsOXpSCHqBf/uE+H722U9N+UmNbw+B88SznzsLJVllgrgcQS/gmaWRviXK
 ZQkVotRFDRYsJBQviDbyZI1AWk0Vix1U8WY16owqj7dZzy0vg7hbxzyIDD4X9Uz5/nDEt+Umd
 JZKVmelR68SyIiemOEXDacejl0+u/MgBI/Hfl9syu4qBki7BUkJ5ipdL7V3o7DzHU70cE/EGk
 rkk2eqkL3a4pw721NKE+A8rtjtoFeLIsxqGMGziSO2SwrdEQcWr7txbsOOI8qHeswq4ZJGxwm
 eG7hj5401AgpE7lSXUikfx4pSXFlLabXjYQKQU7Uj2EhvLi5CMQfK8qEyb7frCMJsyVC5Xzi6
 6e+nYbQ6Kr5gkLTe5uGBA0/ZTrJyoYeUeGB+d66z2/HjsE1PP+O105Xb5O7qS+gsN8gBKuTrT
 hyQQEwlaOREbPRcTtOok6csYIYYZaCwlFBdPpN9wm1HMSm1pkiylOG2Ynqu5D5sOkfLx/Fej9
 WtAAgVsNbf8LVtoYQRc6x80iAn3I8YLs/oou85aIOMT/PiK+2p5qPJbegG046y2PkKgAPjxNT
 VmiuXQQKidYWGGBfWb4amP8LscsH950cXJZNgkbyodAYxoe3iz65snJUENxIFE+du8cAzA5ig
 IazHxJh3ieDSbZ87+6WrGpL9MtSb1ee/wScIc5rgTe6IPmRATGiWfoOSa/D+nYanRNwfaLY8w
 Gn1gLEUfPtNE92NpVGpagygUXLVav8Cs5vIk2X1Kc=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.17.10
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 02/01/2020 à 11:36, Jason A. Donenfeld a écrit :
> On Linux, calling `reboot(RB_AUTOBOOT);` will result in
> arch/m68k/mac/misc.c's mac_reset function being called. That in turn
> looks at the rombase (or uses 0x40800000 is there's no rombase), adds
> 0xa, and jumps to that address. At the moment, there's nothing there, so
> the kernel just crashes when trying to reboot. So, this commit adds a
> very simple implementation at that location, which just writes to via2
> to power down.
> 
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---

There are two cleaners solution to do that:
1- catch the jump to the ROM address in QEMU and shutdown the machine, see

https://github.com/vivier/qemu-m68k/commit/51cd57d1128059819038b9800455fbf794430c15

2- or as you do, write a fake ROM but use the VIA2 port B bit 3 to
shutdown the machine see hw/misc/mac_via.c mos6522_q800_via2_portB_write().

Thanks,
Laurent

