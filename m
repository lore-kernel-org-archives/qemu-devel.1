Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB6B0C35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:14:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 820FE21744
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:14:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 820FE21744
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6a38-0007zz-La
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 08:14:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53025)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1j6Z2J-0007jr-9G
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:10:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1j6Z2H-0004oY-D1
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:10:02 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:14670)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>)
 id 1j6Z2H-0004ie-6Z; Tue, 25 Feb 2020 07:10:01 -0500
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id A055E74637C;
 Tue, 25 Feb 2020 13:09:49 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 7AE1E745953; Tue, 25 Feb 2020 13:09:49 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 78D6E74569F;
 Tue, 25 Feb 2020 13:09:49 +0100 (CET)
Date: Tue, 25 Feb 2020 13:09:49 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Programmingkid <programmingkidx@gmail.com>
Subject: Re: [RFC PATCH v2] target/ppc: Enable hardfloat for PPC
In-Reply-To: <1BC2E9E9-A694-4ED3-BD3D-D731F23B7245@gmail.com>
Message-ID: <alpine.BSF.2.22.395.2002251241080.22173@zero.eik.bme.hu>
References: <20200218171702.979F074637D@zero.eik.bme.hu>
 <CD566CEF-6844-455C-B9C7-E5DFDE50E770@gmail.com>
 <alpine.BSF.2.22.395.2002191538190.33319@zero.eik.bme.hu>
 <1BC2E9E9-A694-4ED3-BD3D-D731F23B7245@gmail.com>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
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
Cc: Paul Clarke <pc@us.ibm.com>, David Gibson <david@gibson.dropbear.id.au>,
 qemu-ppc@nongnu.org, qemu-devel qemu-devel <qemu-devel@nongnu.org>,
 Howard Spoelstra <hsp.cat7@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 24 Feb 2020, Programmingkid wrote:
> Intel Core i5-2500S CPU @ 2.70GHz.
[...]
> Ok, I did test on the G4, here are my results:
>
> Git commit: c1e667d2598b9b3ce62b8e89ed22dd38dfe9f57f
> Mac OS 10.4.3 VM
> -cpu G4
> -USB audio device
>
> Hardfloat=false
> Audio sounds bad when playing midi file.
> Extraction rate: 1.5x
> Converting rate: 0.7x
> Total time: 7:24
>
> Hardfloat=true
> Midi audio sounded perfect for about 30 seconds, then it went silent!
> Extraction rate: 1.4x (slower with hard float)
> Converting rate: 0.7x (same as without hardfloat)
> Total time: 7:16 (faster time with hardfloat)

How is that extraction rate is slower but total time is less than without 
hardfloat? There must be other factors here than just FP ops. Maybe a 
better test is to not play the audio just save it to a file so other 
issues with USB is not influencing the test.

> When I played sound this second time I hard the same broken audio I 
> usually hear with the USB audio device with hardfloat set to false. When 
> playing the same midi file with hardfloat set to true, the audio played 
> perfectly! It only played for 30 seconds before it went silent.

So probably there are at least two problems: FPU emulation is not fast 
enough to decode audio to fill buffer then there's also something with 
usb-audio that jams it after a while? I don't think all of this is FPU 
related.

> I can give you the full testing suite if you like. I run it on Mac OS 
> 10.4 but it should compile with gcc on Linux. I will send it to you in a 
> separate email because it is big.

Thanks, I'll have a look and see if I can make sense of it but not sure 
when will I find time.

> I have another idea on how to improve QEMU's performance. What if you 
> enabled more CPUs for the PowerPC target? Mac OS 9, Mac OS X, and Linux 
> support multiple CPUs. It might actually be easier to do this than to

Have you tried if it works? I think MTTCG is enabled for PPC64 but not 
sure about 32 bit PPC. The mac99 machine seems to init multiple CPUs but 
not sure if they'll use MTTCG. But you could test it to see if it makes 
any difference.

> improve the FPU. I imagine the performance increase with multiple 
> emulated CPUs would be much more noticeable.

The Amiga like OSes I'm interested in don't use multiple cores so I'm 
mainly interested in improving single core performance. Also I'm not sure 
if (part of) your problem is slow FPU preventing fast enough audio 
decoding then having multiple CPUs with slow FPU would help as this may 
use a single thread anyway.

Regards,
BALATON Zoltan

