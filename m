Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F24FC34022
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 07:56:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48D562464E
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 07:56:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48D562464E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4KDi-00015L-Eh
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 02:56:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52931)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1j4KCt-0000Fe-8j
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 02:55:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1j4KCs-00042B-22
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 02:55:43 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:52957)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1j4KCp-0003ze-Gh; Wed, 19 Feb 2020 02:55:39 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue009 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MHoZS-1jGxmY2VWA-00Ex9P; Wed, 19 Feb 2020 08:55:20 +0100
Subject: Re: [PATCH v4 00/14] Fixes for DP8393X SONIC device emulation
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 Finn Thain <fthain@telegraphics.com.au>
References: <cover.1580290069.git.fthain@telegraphics.com.au>
 <CAL1e-=iOQ52y0vbXAYaYDKqoepD09xO2=3d55WM32=9TFwFzAg@mail.gmail.com>
 <alpine.LNX.2.22.394.2002191150440.8@nippy.intranet>
 <CAL1e-=gaVz5K=JMg+iN53weESLORKEuXRJvq-SFqU7FERojP8Q@mail.gmail.com>
 <CAL1e-=iUHwE2_h0dxOE6vN_FoyRWyYA6LbL++T9BSB9X8heEcA@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <67b0565e-9f2c-7ef0-aca6-01cba798fad4@vivier.eu>
Date: Wed, 19 Feb 2020 08:55:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAL1e-=iUHwE2_h0dxOE6vN_FoyRWyYA6LbL++T9BSB9X8heEcA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ZD/GiUg0BH/9Dq8TCSXqTa6rglBQ+4szjyNP3rshA+TAVIoMHW9
 a0GKt8K63mg2Ff4Dl4DT0WK73mxseKZDRrG4lX9oDhFi1seLBAbZ1yKnpAbyH6x0T2FSUdK
 4a3o9T3IQiQtQJrO+9Eph1pba+fNc6RZEob2vG0vQGILfH6O0JQxuwip2woKIO56hjjO+BO
 87+0EOeIj555t8AbQD2Cw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2dR13jlj+Lk=:rd1PdtN+r1yXgaQkNzZ6wn
 3oXePNfCZC1KMBZUS4M3zwrTyLhrkym9X+mF+5Q2ZRen/v5KUfx0vuPMlku/Uecs2aA1nUTmO
 v0L3BM/CshoFSrBaG064eFquuyreM0kiRnuxBBpwVeoVN2ITuR8RaU3KXVQpt5firPn7Orjd5
 Zcl2ybohKMfoc9pzKqNZPEYiRMfqDD+s11Qe/pspsjLPssUWEMcw+LZ1MSvzzRKGNrMlHdyUS
 aDYcmBClgdUyf+eh6jh1xr00dXsQw0e5RmNaMXP3hMK5iiIVajX8z43QlAmdeoqjwYxDg/I97
 w5/5LYO+meXE2VEuAoujiiXpDo8odOEtnY8y4jFSfPAQdUMGUUzMgvppe4KRnpoaP09dXzQA0
 Gz4OrM8Up295rq480bmoqjhU9IJL/D2oJQWWuea6CAUw6r4yq2pbj1m9VAexIFWcrZtnSew2x
 +0fljl10rGaVu+/X0k1dVdnGmHnaH1rODZfkqmhNTDDR/IJ1BDKwaCOPVoCrG8/A5jyAd4gbD
 Nh38uWe9smuxsN0avsRnm9YTvKGMGt+bDgSLHT26GRaz/JB5ZT+b/rOrueiy3EhapSXsiHJA3
 iPZzlrK3PIwIEVatJ6nk7g/RqDNV15aHR1ZSGzkX0JrEFQHCB0JJgsAeOCh/VSALke/tfxzJ5
 n9FWFJWt2DgzSm8iHdlpGXUZBN9RC8SS5mVhDXRIDb2/hIsktcG0nBUz+CbnQ8lJqFjeCFAWM
 juv+P0e+2uTAkm/Sf+imdo9viBAVD/lu7Rs9AlECp2MlqCirBmm6Tr9YuzFEGj6B8uma5+rZ4
 kJNzHuS30UaPj9x5US9a9izSYvpYE5+io0Qlo5YTiTt2KWz6NH1ji25OW74v3Z/dfyOWM3D
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.130
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
Cc: Jason Wang <jasowang@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 19/02/2020 à 02:57, Aleksandar Markovic a écrit :
> 2:54 AM Sre, 19.02.2020. Aleksandar Markovic
> <aleksandar.m.mail@gmail.com <mailto:aleksandar.m.mail@gmail.com>> је
> написао/ла:
>>
>> 2:06 AM Sre, 19.02.2020. Finn Thain <fthain@telegraphics.com.au
> <mailto:fthain@telegraphics.com.au>> је написао/ла:
>> >
>> > On Tue, 18 Feb 2020, Aleksandar Markovic wrote:
>> >
>> > > On Wednesday, January 29, 2020, Finn Thain
> <fthain@telegraphics.com.au <mailto:fthain@telegraphics.com.au>>
>> > > wrote:
>> > >
>> > > > Hi All,
>> > > >
>> > > > There are bugs in the emulated dp8393x device that can stop packet
>> > > > reception in a Linux/m68k guest (q800 machine).
>> > > >
>> > > > With a Linux/m68k v5.5 guest (q800), it's possible to remotely
> trigger
>> > > > an Oops by sending ping floods.
>> > > >
>> > > > With a Linux/mips guest (magnum machine), the driver fails to probe
>> > > > the dp8393x device.
>> > > >
>> > > > With a NetBSD/arc 5.1 guest (magnum), the bugs in the device can be
>> > > > fatal to the guest kernel.
>> > > >
>> > > > Whilst debugging the device, I found that the receiver algorithm
>> > > > differs from the one described in the National Semiconductor
>> > > > datasheet.
>> > > >
>> > > > This patch series resolves these bugs.
>> > > >
>> > > > AFAIK, all bugs in the Linux sonic driver were fixed in Linux v5.5.
>> > > > ---
>> > >
>> > >
>> > > Herve,
>> > >
>> > > Do your Jazz tests pass with these changes?
>> > >
>> >
>> > AFAIK those tests did not expose the NetBSD panic that is caused by
>> > mainline QEMU (mentioned above).
>> >
>> > I have actually run the tests you requested (Hervé described them in an
>> > earlier thread). There was no regression. Quite the reverse -- it's no
>> > longer possible to remotely crash the NetBSD kernel.
>> >
>> > Apparently my testing was also the first time that the jazzsonic driver
>> > (from the Linux/mips Magnum port) was tested successfully with QEMU. It
>> > doesn't work in mainline QEMU.
>> >
>>
>> Well, I appologize if I missed all these facts. I just did not notice
> them, at least not in this form. And, yes, some "Tested-by:" by Herve
> would be desirable and nice.
>>
> 
> Or, perhaps, even "Reviewed-by:".
> 

It would be nice to have this merged before next release because q800
machine networking is not reliable without them.

And thank you to Finn for all his hard work on this device emulation.

Laurent

