Return-Path: <SRS0=DeAR=WO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72910C3A589
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Aug 2019 23:06:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43E6F2186A
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Aug 2019 23:06:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43E6F2186A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzUG9-0005JA-4a
	for qemu-devel@archiver.kernel.org; Sun, 18 Aug 2019 19:06:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49071)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jiewen.yao@intel.com>) id 1hzUAV-00086W-71
 for qemu-devel@nongnu.org; Sun, 18 Aug 2019 19:01:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jiewen.yao@intel.com>) id 1hzUAT-0002l8-HB
 for qemu-devel@nongnu.org; Sun, 18 Aug 2019 19:00:58 -0400
Received: from mga11.intel.com ([192.55.52.93]:22444)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jiewen.yao@intel.com>)
 id 1hzUAT-0002gT-7v
 for qemu-devel@nongnu.org; Sun, 18 Aug 2019 19:00:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 18 Aug 2019 16:00:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,402,1559545200"; d="scan'208";a="377255834"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
 by fmsmga005.fm.intel.com with ESMTP; 18 Aug 2019 16:00:47 -0700
Received: from fmsmsx153.amr.corp.intel.com (10.18.125.6) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 18 Aug 2019 16:00:47 -0700
Received: from shsmsx151.ccr.corp.intel.com (10.239.6.50) by
 FMSMSX153.amr.corp.intel.com (10.18.125.6) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 18 Aug 2019 16:00:47 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.19]) by
 SHSMSX151.ccr.corp.intel.com ([169.254.3.250]) with mapi id 14.03.0439.000;
 Mon, 19 Aug 2019 07:00:44 +0800
From: "Yao, Jiewen" <jiewen.yao@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Thread-Topic: [edk2-devel] CPU hotplug using SMM with QEMU+OVMF
Thread-Index: AQHVUfF5lMVYZhTq/0GuokGqDPas2Kb6jzUA//+ZRQCAAaHSAIAAFq8AgAEuZqD//8zIAIAAiChAgABQUYCAACK6gIAAmpdAgAJgcwCAALs9dw==
Date: Sun, 18 Aug 2019 23:00:43 +0000
Message-ID: <D2A45071-A097-4642-A34C-6B7C5D7D2466@intel.com>
References: <8091f6e8-b1ec-f017-1430-00b0255729f4@redhat.com>
 <effa5e32-be1e-4703-4419-8866b7754e2d@redhat.com>
 <74D8A39837DF1E4DA445A8C0B3885C503F75B680@shsmsx102.ccr.corp.intel.com>
 <047801f8-624a-2300-3cf7-1daa1395ce59@redhat.com>
 <99219f81-33a3-f447-95f8-f10341d70084@redhat.com>
 <6f8b9507-58d0-5fbd-b827-c7194b3b2948@redhat.com>
 <74D8A39837DF1E4DA445A8C0B3885C503F75FAD3@shsmsx102.ccr.corp.intel.com>
 <7cb458ea-956e-c1df-33f7-025e4f0f22df@redhat.com>
 <74D8A39837DF1E4DA445A8C0B3885C503F7600B9@shsmsx102.ccr.corp.intel.com>
 <bb6fdbe0-2a3b-e586-e9a5-93e1ac0803ec@redhat.com>
 <20190816161933.7d30a881@x1.home>
 <74D8A39837DF1E4DA445A8C0B3885C503F761B96@shsmsx102.ccr.corp.intel.com>,
 <35396800-32d2-c25f-b0d0-2d7cd8438687@redhat.com>
In-Reply-To: <35396800-32d2-c25f-b0d0-2d7cd8438687@redhat.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.93
Subject: Re: [Qemu-devel] [edk2-devel] CPU hotplug using SMM with QEMU+OVMF
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
Cc: "Chen, Yingwen" <yingwen.chen@intel.com>,
 "devel@edk2.groups.io" <devel@edk2.groups.io>,
 Phillip Goerl <phillip.goerl@oracle.com>,
 qemu devel list <qemu-devel@nongnu.org>,
 Alex Williamson <alex.williamson@redhat.com>, "Nakajima,
 Jun" <jun.nakajima@intel.com>, Igor Mammedov <imammedo@redhat.com>, Boris
 Ostrovsky <boris.ostrovsky@oracle.com>, edk2-rfc-groups-io <rfc@edk2.groups.io>,
 Laszlo Ersek <lersek@redhat.com>,
 Joao Marcal Lemos Martins <joao.m.martins@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

in real world, we deprecate AB-seg usage because they are vulnerable to smm=
 cache poison attack.
I assume cache poison is out of scope in the virtual world, or there is a w=
ay to prevent ABseg cache poison.=20

thank you!
Yao, Jiewen


> =1B$B:_=1B(B 2019=1B$BG/=1B(B8=1B$B7n=1B(B19=1B$BF|!$>e8a=1B(B3:50=1B$B!$=
=1B(BPaolo Bonzini <pbonzini@redhat.com> =1B$B<LF;!'=1B(B
>=20
>> On 17/08/19 02:20, Yao, Jiewen wrote:
>> [Jiewen] That is OK. Then we MUST add the third adversary.
>> -- Adversary: Simple hardware attacker, who can use device to perform DM=
A attack in the virtual world.
>> NOTE: The DMA attack in the real world is out of scope. That is be handl=
ed by IOMMU in the real world, such as VTd. -- Please do clarify if this is=
 TRUE.
>>=20
>> In the real world:
>> #1: the SMM MUST be non-DMA capable region.
>> #2: the MMIO MUST be non-DMA capable region.
>> #3: the stolen memory MIGHT be DMA capable region or non-DMA capable
>> region. It depends upon the silicon design.
>> #4: the normal OS accessible memory - including ACPI reclaim, ACPI
>> NVS, and reserved memory not included by #3 - MUST be DMA capable region=
.
>> As such, IOMMU protection is NOT required for #1 and #2. IOMMU
>> protection MIGHT be required for #3 and MUST be required for #4.
>> I assume the virtual environment is designed in the same way. Please
>> correct me if I am wrong.
>>=20
>=20
> Correct.  The 0x30000...0x3ffff area is the only problematic one;
> Igor's idea (or a variant, for example optionally remapping
> 0xa0000..0xaffff SMRAM to 0x30000) is becoming more and more attractive.
>=20
> Paolo

