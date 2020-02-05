Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F86C35247
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 17:22:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C8B020702
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 17:22:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C8B020702
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izONI-0006Kx-OY
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 12:22:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37416)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1izOHf-0006NC-En
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 12:16:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1izOHe-00035r-5T
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 12:16:15 -0500
Received: from 7.mo2.mail-out.ovh.net ([188.165.48.182]:53158)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1izOHd-00032X-Uw
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 12:16:14 -0500
Received: from player688.ha.ovh.net (unknown [10.110.208.44])
 by mo2.mail-out.ovh.net (Postfix) with ESMTP id BB4251C7B12
 for <qemu-devel@nongnu.org>; Wed,  5 Feb 2020 18:16:10 +0100 (CET)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player688.ha.ovh.net (Postfix) with ESMTPSA id 09FD7EF4C39B;
 Wed,  5 Feb 2020 17:16:01 +0000 (UTC)
Subject: Re: [PULL 19/35] ppc/pnv: Add models for POWER9 PHB4 PCIe Host bridge
To: Laurent Vivier <lvivier@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, peter.maydell@linaro.org
References: <20200203061123.59150-1-david@gibson.dropbear.id.au>
 <20200203061123.59150-20-david@gibson.dropbear.id.au>
 <bbb36281-287b-70cf-80ab-9ac54eeca8de@redhat.com>
 <ba1e6cd7-083d-5d98-e802-1e828a13c467@kaod.org>
 <254167f7-baca-24fa-e2e0-cf78d5e50234@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <4cee3138-ebab-9154-b9f5-acc59794d9df@kaod.org>
Date: Wed, 5 Feb 2020 18:16:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <254167f7-baca-24fa-e2e0-cf78d5e50234@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 17895616069632625521
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrhedugdelgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrieegrddvhedtrddujedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrieekkedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 188.165.48.182
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, groug@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


>>>> diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
>>>> index e27efe9a24..354828bf13 100644
>>>> --- a/hw/ppc/Kconfig
>>>> +++ b/hw/ppc/Kconfig
>>>> @@ -135,6 +135,8 @@ config XIVE_SPAPR
>>>>      default y
>>>>      depends on PSERIES
>>>>      select XIVE
>>>> +    select PCI
>>>> +    select PCIE_PORT
>>>
>>> This patch is about PowerNV, why do we add dependencies for pseries
>>> configuration?
>>
>> Bogus leftovers from the past. I think we can drop them.
> 
> I will prepare a patch for that.

Thanks. Here is a small command line to check PCI adapters.

C.

$ qemu-system-ppc64 -machine powernv9  -nographic -device ich9-ahci,id=sata0,bus=pcie.1,addr=0x0 -device e1000e,mac=C0:FF:EE:00:01:03,bus=pcie.2,addr=0x0

[    0.011935416,5] OPAL v6.4 starting...
[    0.012528373,7] initial console log level: memory 7, driver 5
[    0.012560514,6] CPU: P9 generation processor (max 4 threads/core)
[    0.012575475,7] CPU: Boot CPU PIR is 0x0000 PVR is 0x004e1200
[    0.012735128,7] OPAL table: 0x30101830 .. 0x30101da0, branch table: 0x30002000
[    0.012945847,7] Assigning physical memory map table for nimbus
[    0.013226493,7] FDT: Parsing fdt @0x1000000
[    0.015091333,5] CHIP: Detected Qemu simulator
...
[    6.259400309,5] PCI Summary:
[    6.259731885,5] PHB#0000:00:00.0 [ROOT] 1014 04c1 R:00 C:060400 B:01..01 
[    6.260025513,5] PHB#0001:00:00.0 [ROOT] 1014 04c1 R:00 C:060400 B:01..01 
[    6.260263027,5] PHB#0001:01:00.0 [PCID] 8086 2922 R:02 C:010601 (          sata) 
[    6.260485810,5] PHB#0002:00:00.0 [ROOT] 1014 04c1 R:00 C:060400 B:01..01 
[    6.260691330,5] PHB#0002:01:00.0 [EP  ] 8086 10d3 R:00 C:020000 (      ethernet) 
[    6.260873711,5] PHB#0003:00:00.0 [ROOT] 1014 04c1 R:00 C:060400 B:01..01 
[    6.261053114,5] PHB#0004:00:00.0 [ROOT] 1014 04c1 R:00 C:060400 B:01..01 
[    6.261237264,5] PHB#0005:00:00.0 [ROOT] 1014 04c1 R:00 C:060400 B:01..01 
[    6.261496700,4] FLASH: Failed to load VERSION data
[    6.423913697,5] INIT: Waiting for kernel...
[    6.424004918,5] INIT: platform wait for kernel load failed
[    6.424114190,5] INIT: Assuming kernel at 0x20000000
[    6.424232276,3] INIT: ELF header not found. Assuming raw binary.
[    6.424407245,3] OCC: Unassigned OCC Common Area. No sensors found
[    6.424629768,2] NVRAM: Failed to load
[    6.494846301,0] FATAL: Kernel is zeros, can't execute!

