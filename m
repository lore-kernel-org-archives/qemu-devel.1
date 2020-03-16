Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B141C10DCE
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 02:02:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F9782051A
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 02:02:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F9782051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDf5d-0005bR-1Y
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 22:02:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45559)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cathy.zhang@intel.com>) id 1jDej3-0008T0-6s
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 21:39:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cathy.zhang@intel.com>) id 1jDej0-0001xc-2s
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 21:39:27 -0400
Received: from mga12.intel.com ([192.55.52.136]:52904)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cathy.zhang@intel.com>)
 id 1jDeiz-0001kg-OO
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 21:39:26 -0400
IronPort-SDR: Vup/WMdy5BpqcL7Dc5BULTVgtq3bGXFw5ec6xCpXzTF2+ZSw3cSaqgUZRq7XQU83m06iDejyCV
 sm+Mcz0X7Jpg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Mar 2020 18:39:20 -0700
IronPort-SDR: BcS7Tr12yOfMyCk4pLv5qI2UMNwXiZdt+PLelVs+ky77SkuQmdxvq1nT+KRYOsi4Tas3JI4EHY
 64j0fmZaaodg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,558,1574150400"; d="scan'208";a="243987557"
Received: from zhangj4-mobl1.ccr.corp.intel.com (HELO [10.249.169.66])
 ([10.249.169.66])
 by orsmga003.jf.intel.com with ESMTP; 15 Mar 2020 18:39:17 -0700
Subject: Re: [PATCH 0/2] Fix Cooperlake CPU model
To: Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>
References: <20191225063018.20038-1-xiaoyao.li@intel.com>
 <93c9cc8c-09ec-d13f-f012-edf86fd945ab@redhat.com>
From: "Zhang, Cathy" <cathy.zhang@intel.com>
Message-ID: <759b848d-8261-5997-2e2b-531246bcdf92@intel.com>
Date: Mon, 16 Mar 2020 09:39:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <93c9cc8c-09ec-d13f-f012-edf86fd945ab@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 192.55.52.136
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/7/2020 9:31 PM, Paolo Bonzini wrote:
> On 25/12/19 07:30, Xiaoyao Li wrote:
>> Current Cooperlake CPU model lacks VMX features which are introduced by Paolo
>> several months ago, and it also lacks 2 security features in
>> MSR_IA32_ARCH_CAPABILITIES disclosed recently.
>>
>> Xiaoyao Li (2):
>>    target/i386: Add new bit definitions of MSR_IA32_ARCH_CAPABILITIES
>>    target/i386: Add missed features to Cooperlake CPU model
>>
>>   target/i386/cpu.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++-
>>   target/i386/cpu.h | 13 +++++++-----
>>   2 files changed, 58 insertions(+), 6 deletions(-)
>>
> Queued, thanks.
>
> Paolo

Hi Paolo,

Can I ask one question that will you put all the patches for Cooper Lake 
Cpu model into QEMU v5.0-rc0?


