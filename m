Return-Path: <SRS0=n1BB=Y3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D79CBCA9EB0
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Nov 2019 21:10:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DCE62190F
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Nov 2019 21:10:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DCE62190F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRN8u-0002t8-Cl
	for qemu-devel@archiver.kernel.org; Sun, 03 Nov 2019 16:10:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51464)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1iRMvY-0000FS-H8
 for qemu-devel@nongnu.org; Sun, 03 Nov 2019 15:56:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1iRMvX-0002Wd-5C
 for qemu-devel@nongnu.org; Sun, 03 Nov 2019 15:56:48 -0500
Received: from mail.ilande.co.uk ([46.43.2.167]:43484
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1iRMvW-0002W9-Us
 for qemu-devel@nongnu.org; Sun, 03 Nov 2019 15:56:47 -0500
Received: from host86-185-106-131.range86-185.btcentralplus.com
 ([86.185.106.131] helo=[192.168.1.65])
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.89)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1iRMw3-0000lO-EN; Sun, 03 Nov 2019 20:57:19 +0000
To: Sven Schnelle <svens@stackframe.org>
References: <20191022205941.23152-1-svens@stackframe.org>
 <20191022205941.23152-6-svens@stackframe.org>
 <b91ee508-2ae4-0307-561a-f930a7709404@ilande.co.uk>
 <20191025093159.GA4261@stackframe.org>
 <1a414492-1623-5620-9e5b-097b45fc746a@ilande.co.uk>
 <20191026175439.GA10792@stackframe.org>
 <20191101215943.GB9053@t470p.stackframe.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Openpgp: preference=signencrypt
Autocrypt: addr=mark.cave-ayland@ilande.co.uk; keydata=
 mQENBFQJuzwBCADAYvxrwUh1p/PvUlNFwKosVtVHHplgWi5p29t58QlOUkceZG0DBYSNqk93
 3JzBTbtd4JfFcSupo6MNNOrCzdCbCjZ64ik8ycaUOSzK2tKbeQLEXzXoaDL1Y7vuVO7nL9bG
 E5Ru3wkhCFc7SkoypIoAUqz8EtiB6T89/D9TDEyjdXUacc53R5gu8wEWiMg5MQQuGwzbQy9n
 PFI+mXC7AaEUqBVc2lBQVpAYXkN0EyqNNT12UfDLdxaxaFpUAE2pCa2LTyo5vn5hEW+i3VdN
 PkmjyPvL6DdY03fvC01PyY8zaw+UI94QqjlrDisHpUH40IUPpC/NB0LwzL2aQOMkzT2NABEB
 AAG0ME1hcmsgQ2F2ZS1BeWxhbmQgPG1hcmsuY2F2ZS1heWxhbmRAaWxhbmRlLmNvLnVrPokB
 OAQTAQIAIgUCVAm7PAIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQW8LFb64PMh9f
 NAgAuc3ObOEY8NbZko72AGrg2tWKdybcMVITxmcor4hb9155o/OWcA4IDbeATR6cfiDL/oxU
 mcmtXVgPqOwtW3NYAKr5g/FrZZ3uluQ2mtNYAyTFeALy8YF7N3yhs7LOcpbFP7tEbkSzoXNG
 z8iYMiYtKwttt40WaheWuRs0ZOLbs6yoczZBDhna3Nj0LA3GpeJKlaV03O4umjKJgACP1c/q
 T2Pkg+FCBHHFP454+waqojHp4OCBo6HyK+8I4wJRa9Z0EFqXIu8lTDYoggeX0Xd6bWeCFHK3
 DhD0/Xi/kegSW33unsp8oVcM4kcFxTkpBgj39dB4KwAUznhTJR0zUHf63LkBDQRUCbs8AQgA
 y7kyevA4bpetM/EjtuqQX4U05MBhEz/2SFkX6IaGtTG2NNw5wbcAfhOIuNNBYbw6ExuaJ3um
 2uLseHnudmvN4VSJ5Hfbd8rhqoMmmO71szgT/ZD9MEe2KHzBdmhmhxJdp+zQNivy215j6H27
 14mbC2dia7ktwP1rxPIX1OOfQwPuqlkmYPuVwZP19S4EYnCELOrnJ0m56tZLn5Zj+1jZX9Co
 YbNLMa28qsktYJ4oU4jtn6V79H+/zpERZAHmH40IRXdR3hA+Ye7iC/ZpWzT2VSDlPbGY9Yja
 Sp7w2347L5G+LLbAfaVoejHlfy/msPeehUcuKjAdBLoEhSPYzzdvEQARAQABiQEfBBgBAgAJ
 BQJUCbs8AhsMAAoJEFvCxW+uDzIfabYIAJXmBepHJpvCPiMNEQJNJ2ZSzSjhic84LTMWMbJ+
 opQgr5cb8SPQyyb508fc8b4uD8ejlF/cdbbBNktp3BXsHlO5BrmcABgxSP8HYYNsX0n9kERv
 NMToU0oiBuAaX7O/0K9+BW+3+PGMwiu5ml0cwDqljxfVN0dUBZnQ8kZpLsY+WDrIHmQWjtH+
 Ir6VauZs5Gp25XLrL6bh/SL8aK0BX6y79m5nhfKI1/6qtzHAjtMAjqy8ChPvOqVVVqmGUzFg
 KPsrrIoklWcYHXPyMLj9afispPVR8e0tMKvxzFBWzrWX1mzljbBlnV2n8BIwVXWNbgwpHSsj
 imgcU9TTGC5qd9g=
Message-ID: <02ba4a0c-97f8-766d-08dd-caff9f448e5f@ilande.co.uk>
Date: Sun, 3 Nov 2019 20:56:43 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191101215943.GB9053@t470p.stackframe.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.185.106.131
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v3 5/6] hppa: Add emulation of Artist graphics
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.43.2.167
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
Cc: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 01/11/2019 21:59, Sven Schnelle wrote:

> On Sat, Oct 26, 2019 at 07:54:40PM +0200, Sven Schnelle wrote:
>> Hi Mark,
>>
>> On Sat, Oct 26, 2019 at 10:35:20AM +0100, Mark Cave-Ayland wrote:
>>
>>>> However, the VRAM in Artist is not really exposed to the Host. Instead,
>>>> there's the Chipset inbetween that can do byte swapping (Colormap is LE,
>>>> VRAM is BE) and Bit-to-Byte/Word/Dword conversion. For example you could
>>>> write 0x55 into that VRAM region, and the chipset would expand that to
>>>> VRAM Bytes: 00 01 00 01 00 01 00 01. And to make it even worse emulation
>>>> wise it can also do different encodings for Read or Write accesses, and
>>>> mask out certain bits of the data. So after trying to convert it to the
>>>> "dirty bitmap" API i decided to just leave it as it is. The CPU load
>>>> used by the display update code is usually < 1%, so it's ok for me.
>>>
>>> Wow that sounds that some interesting hardware(!). Does it make sense to model the
>>> behaviour of the chipset separately using a proxy MemoryRegion similar to virtio i.e.
>>> introduce an intermediate IO MemoryRegion that does the swapping and then forward it
>>> onto the VRAM MemoryRegion?
>>
>> Thanks for the pointer, i'll check whether that would work. For now i
>> think i'll remove the Artist patch from the series, so we can apply the
>> other patches, and i'll re-submit Artist when it's done. I guess the
>> rewrite to use a MemRegion is a bit bigger. But i would to get the other
>> patches in especially the LASI Stuff as both Helge and i have a lot of
>> stuff depending on that.
> 
> I've looked into it again and changed my mind. There are at least the following
> functions that the Artist chip does before a Read/Write is passed to/from VRAM:
> 
> - endianess conversion (actually configurable via some register, but i don't
>   know how and hardwired it depending on CMAP / FB access)
> 
> - The Address passed on the System bus are the X/Y coordinates added to the FB
>   base address in the selected buffer instead of the VRAM offset for pixel data.
>   I think that's configurable via the some registers, but i don't know how.
>   Unfortunately there's absolutely no documentation about Artist available and
>   everything was developed by reverse engineering.
> 
> - bitmap to Byte/Word conversion (not implemented yet for the VRAM window, only
>   for the I/O register window)
> 
> So in my opinion it's way to much effort to squeeze all of that into the memory
> space, and it is not really a Memory range that's just behind a bus bridge.

Hi Sven,

Certainly in some cases it isn't possible to model devices in QEMU exactly as real
hardware, although I think that some of the ideas above could be used to improve the
implementation without too much extra effort.

Then again from my work on QEMU I completely understand that sometimes this can be
difficult with older, more esoteric devices. Ultimately after review that decision
has to come from the maintainer(s) for the relevant devices/machines, so I guess that
would be Richard and/or Gerd in this case?


ATB,

Mark.

