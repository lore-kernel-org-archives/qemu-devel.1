Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E33DC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 06:01:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3E1420734
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 06:01:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3E1420734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jl4fU-0001SN-T5
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 02:01:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35220)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jl4ec-000138-PR
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 02:01:02 -0400
Received: from 17.mo3.mail-out.ovh.net ([87.98.178.58]:52256)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jl4eZ-0006hh-T2
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 02:01:02 -0400
Received: from player714.ha.ovh.net (unknown [10.110.103.76])
 by mo3.mail-out.ovh.net (Postfix) with ESMTP id B80B12574B0
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 08:00:56 +0200 (CEST)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player714.ha.ovh.net (Postfix) with ESMTPSA id 472091356BAD7;
 Tue, 16 Jun 2020 06:00:51 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-106R00692477332-a448-4f8d-b5c4-b28f4a887bad,EBFB3A1CCBA6C973625B067ACEBAD7C75398389C)
 smtp.auth=clg@kaod.org
Subject: Re: [PATCH 0/6] Add several Power ISA 3.1 32/64-bit vector
 instructions
To: Lijun Pan <ljp@linux.vnet.ibm.com>
References: <20200613042029.22321-1-ljp@linux.ibm.com>
 <ef31bb82-607c-3fde-577b-559ff5033be6@kaod.org>
 <4A745EBC-6605-4688-9D1A-A29773C14FE3@linux.vnet.ibm.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <27249c0e-32b1-5d02-6061-57b0bd5a9b97@kaod.org>
Date: Tue, 16 Jun 2020 08:00:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <4A745EBC-6605-4688-9D1A-A29773C14FE3@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 6924284428551949120
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrudeiledguddtgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeefffdvtddugeeifeduuefghfejgfeigeeigeeltedthefgieeiveeuiefhgeefgfenucfkpheptddrtddrtddrtddpkedvrdeigedrvdehtddrudejtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejudegrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Received-SPF: pass client-ip=87.98.178.58; envelope-from=clg@kaod.org;
 helo=17.mo3.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 02:00:57
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-ppc@nongnu.org, Lijun Pan <ljp@linux.ibm.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/15/20 10:54 PM, Lijun Pan wrote:
> 
> 
>> On Jun 15, 2020, at 12:36 PM, Cédric Le Goater <clg@kaod.org> wrote:
>>
>> Hello,
>>
>> On 6/13/20 6:20 AM, Lijun Pan wrote:
>>> This patch series add several newly introduced 32/64-bit vector
>>> instructions in Power ISA 3.1. The newly added instructions are
>>> flagged as ISA300 temporarily in vmx-ops.inc.c and vmx-impl.inc.c
>>> to make them compile and function since Power ISA 3.1, together
>>> with next generation processor, has not been fully enabled in QEMU
>>> yet. When Power ISA 3.1 and next generation processor are fully
>>> supported, the flags should be changed.
>>
>> What do you mean ? 
>>
>> ISA 3.1 and POWER10 are merged in Linux and in the QEMU pseries 
>> and PowerNV (OPAL) machines.
>>
>> It's very much empty but it's there.
> 
> I mean it does not work if you boots the guest in TCG mode, not KVM mode.

Something is wrong in your environment. With the latest QEMU and
Linux 5.8-rc1, here is a POWER10 pseries machine : 
    
    BusyBox v1.30.1 (Ubuntu 1:1.30.1-4ubuntu4) built-in shell (ash)
    Enter 'help' for a list of built-in commands.
    
    (initramfs) 
    (initramfs) cat /proc/cpuinfo 
    processor	: 0
    cpu		: POWER10 (architected), altivec supported
    clock	: 1000.000000MHz
    revision	: 1.0 (pvr 0080 0100)
    
    processor	: 1
    cpu		: POWER10 (architected), altivec supported
    clock	: 1000.000000MHz
    revision	: 1.0 (pvr 0080 0100)
    
    processor	: 2
    cpu		: POWER10 (architected), altivec supported
    clock	: 1000.000000MHz
    revision	: 1.0 (pvr 0080 0100)
    
    processor	: 3
    cpu		: POWER10 (architected), altivec supported
    clock	: 1000.000000MHz
    revision	: 1.0 (pvr 0080 0100)
    
    timebase	: 512000000
    platform	: pSeries
    model	: IBM pSeries (emulated by qemu)
    machine	: CHRP IBM pSeries (emulated by qemu)
    MMU		: Radix
    (initramfs) uname -a 
    Linux (none) 5.8.0-rc1+ #199 SMP Tue Jun 16 07:54:06 CEST 2020 ppc64le GNU/Linux



KVM works also but you will need to run the guest under a QEMU
PowerNV machine using my powernv-5.1 branch. All support for
POWER10 baremetal is not merged yet.

Thanks,

C.

