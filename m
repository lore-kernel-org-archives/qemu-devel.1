Return-Path: <SRS0=l02z=YT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E59BCA9EB9
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 09:47:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CC0920867
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 09:47:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CC0920867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOIfI-0005v5-2k
	for qemu-devel@archiver.kernel.org; Sat, 26 Oct 2019 05:47:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56675)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1iOIe0-0003oQ-6L
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 05:46:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1iOIdy-000365-ND
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 05:45:59 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:11694)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1iOIdy-000333-3P
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 05:45:58 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 36204747EC7;
 Sat, 26 Oct 2019 11:45:55 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id A04167456CA; Sat, 26 Oct 2019 11:45:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 91A7074569A;
 Sat, 26 Oct 2019 11:45:54 +0200 (CEST)
Date: Sat, 26 Oct 2019 11:45:54 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Howard Spoelstra <hsp.cat7@gmail.com>
Subject: Re: USB-audio sound issues with qemu-system-ppc in Linux and Windows.
In-Reply-To: <alpine.BSF.2.21.99999.352.1910261123220.27453@zero.eik.bme.hu>
Message-ID: <alpine.BSF.2.21.99999.352.1910261145210.27453@zero.eik.bme.hu>
References: <CABLmASG1413=5he48wC0e2hrdoKjs7kasY18WVkyCrRypqZRqw@mail.gmail.com>
 <CABLmASGCX07G7bOcTYZuqLDzoZ9eEyF9t61hKHhC343jxRtUdg@mail.gmail.com>
 <alpine.BSF.2.21.99999.352.1910261123220.27453@zero.eik.bme.hu>
User-Agent: Alpine 2.21.99999 (BSF 352 2019-06-22)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2001:738:2001:2001::2001
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
Cc: qemu-devel qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 26 Oct 2019, BALATON Zoltan wrote:
> On Sat, 26 Oct 2019, Howard Spoelstra wrote:
>> I'd like to add to the previous report that similar issues are present in
>> OSX (Sierra) builds of qemu-system-ppc.
>
> I think the problem is not specific to host OS so instead of giving debugging 
> info for all hosts which would just confuse anyone trying to reproduce it, it 
> may be better to just concentrate on Linux (as that's what most developers 
> would have) and ignore Windows and OSX hosts for now.
>
> It's probably also not specific to MacOS guests because I get similar 
> crackling sound on sam460ex with the ES1370 device with AmigaOS4 and can 
> reproduce the usb-audio shows up but does not make sound problem on 
> mac99,via=pmu with MorphOS so maybe either it's something with the sound 
> backend (like a buffer underflow in case of crackling that may be improved by 
> tweaking some parameters but I don't know what parameters are available or 
> how to set them) or maybe a problem with irqs (in case of no sound or 
> crashing MacOS guest but I don't know how to debug that either). Or I may be 
> completely wrong with my guesses so any advice from people knowing sound and 
> USB emulation in QEMU better is very welcome. (Also likely there are more 
> than one problem here so reporting them at once is also confusing, these may 
> need to be debugged separately.)
>
> So to most likely get useful feedback you should find a simple way to 
> reproduce it with Linux host and guest and describe that in the shortest way 
> to make it easy for interested developers to reproduce it then also cc your 
> Gerd who is the audio and USB maintainer. Otherwise it's likely these will

correction: cc your message to Gerd

> get ignored because nobody can reproduce it who would able to attempt 
> debugging it.
>
> Regards,
> BALATON Zoltan
>
>

