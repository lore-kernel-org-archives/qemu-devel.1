Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38927C38A30
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 00:45:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0295520782
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 00:45:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=blastwave.org header.i=@blastwave.org header.b="cO8dsXkP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0295520782
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=blastwave.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQh2T-0003o6-2c
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 20:45:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57632)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dclarke@blastwave.org>) id 1jQfJ1-0001eK-Gv
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 18:54:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <dclarke@blastwave.org>) id 1jQfIx-0002LX-Qw
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 18:54:23 -0400
Received: from mail.oetec.com ([108.160.241.186]:35162)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dclarke@blastwave.org>)
 id 1jQfIx-0002KE-8H; Mon, 20 Apr 2020 18:54:19 -0400
X-oetec-MailScanner-From: dclarke@blastwave.org
X-oetec-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
 score=-1.199, required 6, autolearn=not spam, ALL_TRUSTED -1.00,
 DKIM_SIGNED 0.10, DKIM_VALID -0.10, DKIM_VALID_AU -0.10,
 DKIM_VALID_EF -0.10, URIBL_BLOCKED 0.00)
X-oetec-MailScanner: Found to be clean
X-oetec-MailScanner-ID: 03KMrm7j027396
X-oetec-MailScanner-Information: Please contact oetec for more information
Received: from [172.16.35.3]
 (CPEf81d0f84cb23-CMf81d0f84cb20.cpe.net.cable.rogers.com [99.253.169.68])
 (authenticated bits=0)
 by mail.oetec.com (8.15.2/8.15.2/Debian-8) with ESMTPSA id 03KMrm7j027396
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Mon, 20 Apr 2020 18:53:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=blastwave.org;
 s=default; t=1587423231;
 bh=xUFLFB4oLr2+xK5cFnNJ+SO8T/HPIu5KGptj/l+/gp8=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=cO8dsXkPR3CY5qmv66aLQN6VsECsiPeRJ7dw/p4aCPumdsPzeefX9TdRd3HIAy0/t
 QcSm5pfHv+hHyFpmVSgrWdLtsRRFSjsCCgtFrDivbDJ98576GitlBh+wgJqZOGnzta
 b+AesXqlCNlBxDZ1cJMPbigtzYPftxiFsfWFBQvA2P23nT7rK5ivKYAT5Btun2RZ23
 my8Lh5E/srBsGjBJXkAXfxK2mWyi36wgkVEp0+4kk9BXNrqXk00/J7zt9Be3dJm2U9
 8UmGwDSVbj9+RAIJBFU8kKNGM1CUDjUKoMb+zrBhpEwQmJIa1TB/PEPp1KcPxbdeKn
 ERPM6PzZEA/Ew==
Subject: Re: [PATCH-for-5.0?] target/ppc: Fix TCG temporary leaks in
 gen_slbia()
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc <qemu-ppc@nongnu.org>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>
References: <20200417090749.14310-1-f4bug@amsat.org>
 <CAFEAcA-aj77=19d+8jmoWYXBDdm=U8eV8CsHpovMN8bE9uNSvg@mail.gmail.com>
From: Dennis Clarke <dclarke@blastwave.org>
Message-ID: <dcf67e87-da27-68ee-0dd8-5b94edb84291@blastwave.org>
Date: Mon, 20 Apr 2020 22:53:48 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:74.0) Gecko/20100101
 Thunderbird/74.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-aj77=19d+8jmoWYXBDdm=U8eV8CsHpovMN8bE9uNSvg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=108.160.241.186;
 envelope-from=dclarke@blastwave.org; helo=mail.oetec.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/20 18:54:15
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Received-From: 108.160.241.186
X-Mailman-Approved-At: Mon, 20 Apr 2020 20:44:25 -0400
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

On 4/20/20 6:56 PM, Peter Maydell wrote:
> On Fri, 17 Apr 2020 at 10:08, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>
>> This fixes:
>>
>>    $ qemu-system-ppc64 \
>>    -machine pseries-4.1 -cpu power9 \
>>    -smp 4 -m 12G -accel tcg ...
>>    ...
>>    Quiescing Open Firmware ...
>>    Booting Linux via __start() @ 0x0000000002000000 ...
>>    Opcode 1f 12 0f 00 (7ce003e4) leaked temporaries
>>    Opcode 1f 12 0f 00 (7ce003e4) leaked temporaries
>>    Opcode 1f 12 0f 00 (7ce003e4) leaked temporaries
>>
>> [*] https://www.mail-archive.com/qemu-discuss@nongnu.org/msg05400.html
>>
>> Fixes: 0418bf78fe8 ("Fix ISA v3.0 (POWER9) slbia implementation")
>> Reported-by: Dennis Clarke <dclarke@blastwave.org>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> 
> I propose to apply this patch for 5.0 rc4 (as well as the
> ppc pullreq already sent), since the iscsi bugfix means
> we need an rc4 anyway. Any objections?
> 

I have been running rc3 with this patch fine for some days now.  Both 
with and without a debug enabled build wherein the performance 
difference between the two is obvious.

However, I do see warnings from 5.0.0-rc3 that worry me :

$ /usr/local/bin/qemu-system-ppc64 \
 > -machine pseries-4.1 -cpu power9 -smp 4 -m 12G -accel tcg \
 > -drive file=/home/ppc64/ppc64le.qcow2 \
 > -device virtio-net-pci,netdev=usernet \
 > -netdev user,id=usernet,hostfwd=tcp::10000-:22 \
 > -serial stdio -display none -vga none
qemu-system-ppc64: warning: TCG doesn't support requested feature, 
cap-cfpc=workaround
qemu-system-ppc64: warning: TCG doesn't support requested feature, 
cap-sbbc=workaround
qemu-system-ppc64: warning: TCG doesn't support requested feature, 
cap-ibs=workaround


SLOF **********************************************************************
QEMU Starting
  Build Date = Mar 27 2020 13:57:26
  FW Version = git-8e012d6fddb62be8
  Press "s" to enter Open Firmware.

Populating /vdevice methods
Populating /vdevice/vty@71000000
Populating /vdevice/nvram@71000001
Populating /vdevice/v-scsi@71000002
        SCSI: Looking for devices
           8000000000000000 DISK     : "QEMU     QEMU HARDDISK    2.5+"
           8200000000000000 CD-ROM   : "QEMU     QEMU CD-ROM      2.5+"
Populating /pci@800000020000000
                      00 0000 (D) : 1af4 1000    virtio [ net ]
No NVRAM common partition, re-initializing...
Scanning USB
Using default console: /vdevice/vty@71000000

   Welcome to Open Firmware

   Copyright (c) 2004, 2017 IBM Corporation All rights reserved.
   This program and the accompanying materials are made available
   under the terms of the BSD License available at
   http://www.opensource.org/licenses/bsd-license.php


Trying to load:  from: /vdevice/v-scsi@71000002/disk@8000000000000000 
...   Successfully loaded


etc etc etc

What shall I do with "TCG doesn't support requested feature, 
cap-cfpc=workaround" ??

-- 
Dennis Clarke
RISC-V/SPARC/PPC/ARM/CISC
UNIX and Linux spoken
GreyBeard and suspenders optional






