Return-Path: <SRS0=AG+E=EA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37145C4363A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2020 14:31:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94B2F20853
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2020 14:31:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94B2F20853
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWh3Z-0008AD-AF
	for qemu-devel@archiver.kernel.org; Sun, 25 Oct 2020 10:31:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35064)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1kWh2P-0007d3-OL
 for qemu-devel@nongnu.org; Sun, 25 Oct 2020 10:30:25 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:26654)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1kWh2M-00044v-Eu
 for qemu-devel@nongnu.org; Sun, 25 Oct 2020 10:30:24 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id C00E87475FE;
 Sun, 25 Oct 2020 15:30:07 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 96A687475FA; Sun, 25 Oct 2020 15:30:07 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 94A3A746333;
 Sun, 25 Oct 2020 15:30:07 +0100 (CET)
Date: Sun, 25 Oct 2020 15:30:07 +0100 (CET)
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>
Subject: Re: [PATCH 0/6] tests/acceptance: Test the Fuloong 2E machine
In-Reply-To: <d2851fba-040c-9f39-ccf7-2d22b862ec2b@amsat.org>
Message-ID: <ed6d6b59-cd2c-a59-5d8-4c93c7fa88ef@eik.bme.hu>
References: <20201021105035.2477784-1-f4bug@amsat.org>
 <54a947e4-929c-aaa4-52b0-339827a010b8@ilande.co.uk>
 <d2851fba-040c-9f39-ccf7-2d22b862ec2b@amsat.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1305300983-1603636207=:24248"
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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
Cc: Huacai Chen <zltjiangshi@gmail.com>, Thomas Huth <thuth@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Cleber Rosa <crosa@redhat.com>,
 Huacai Chen <chenhc@lemote.com>,
 =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Reply-to: BALATON Zoltan <balaton@eik.bme.hu>
From: BALATON Zoltan via <qemu-devel@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1305300983-1603636207=:24248
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Sun, 25 Oct 2020, Philippe Mathieu-Daudé wrote:
> On 10/25/20 12:18 PM, Mark Cave-Ayland wrote:
>> On 21/10/2020 11:50, Philippe Mathieu-Daudé wrote:
>> 
>>> This series add tests for the MIPS Fuloong 2E machine.
>>> 
>>> I have been using these tests for over 1 year now.
>>> After recent discussions with Huacai and Mark regarding
>>> how to contribute tests for machines using private blob,
>>> I think it is time to publish this series, to see how
>>> the final part will be discussed, as it tests a blob
>>> which Lemote company doesn't publish the sources. The
>>> binary is know to work and has been used for various
>>> years on real hardware. Its MD5 is also know (I am not
>>> using SHA-1 because it has been published with MD5).
>>> 
>>> The idea is to be able to share tests without infringing
>>> licenses issues.
>>> 
>>> Please comment :)
>>> 
>>> Phil.
>>> 
>>> Philippe Mathieu-Daudé (6):
>>>    tests/acceptance: Remove unused import
>>>    tests/acceptance: Use .ppm extention for Portable PixMap files
>>>    tests/acceptance: Extract tesseract_available() helper in new
>>>      namespace
>>>    tests/acceptance: Introduce tesseract_ocr() helper
>>>    tests/acceptance: Test Linux on the Fuloong 2E machine
>>>    tests/acceptance: Test PMON on the Fuloong 2E machine
>>> 
>>>   MAINTAINERS                                |   1 +
>>>   tests/acceptance/machine_m68k_nextcube.py  |  51 ++---------
>>>   tests/acceptance/machine_mips_fuloong2e.py | 101 +++++++++++++++++++++
>>>   tests/acceptance/tesseract_utils.py        |  46 ++++++++++
>>>   4 files changed, 158 insertions(+), 41 deletions(-)
>>>   create mode 100644 tests/acceptance/machine_mips_fuloong2e.py
>>>   create mode 100644 tests/acceptance/tesseract_utils.py
>> 
>> In general this looks good: certainly I don't see any reason why the 
>> tesseract_ocr helper changes shouldn't be merged, since I expect that this 
>> is something that will be used more in future.
>> 
>> Looking at the fuloong test it seems that it stops fairly early in the 
>> kernel boot: one of the problems that Zoltan's VIA southbridge patches were 
>> trying to solve earlier in the year was because of problems with PCI IRQ 
>> routing, so it would be nice to include a small OS image that can be used 
>> to boot to userspace to ensure that such problems can be detected in 
>> future.
>
> The Linux tests (ab)use of the rescue image prepared for the Yeeloong
> machine which we don't model (Loongson 2F CPU, 1GB of DRAM). The kernel
> triggers DATA ABORT while accessing >256MB because we do not model
> mapping more than 256MB :/ (The Fuloong comes with 512MB extensible to 1GB). 
> I have a branch adding that but had the idea nobody was interested
> in the Fuloong 2E so I didn't insist (I have more interest in embedded
> 32-bit CPUs). I might try to post it after the release, as it makes this
> test complete.

I've noticed that missing high RAM when cleaning up SPD EEPROMs and addded 
a FIXME comment but did't know MIPS enough to attemt to fix it. Anyway I'm 
also only interested in fuloong2e as a test case for the devices also used 
by Pegasos2 (that I'll need to update and clean up to submit eventually) 
but not beyond that.

I haven't seen these patches before, so I've spotted only now that your 
test case uses -vga std. Shouldn't it work with ati-vga,model=rv100 which 
I think is the default for this machine and that's what the pmon firmware 
expects and has a driver for?

Regards,
BALATON Zoltan
--3866299591-1305300983-1603636207=:24248--

