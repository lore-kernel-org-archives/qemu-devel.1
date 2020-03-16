Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B9FC0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 11:17:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56C3520658
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 11:17:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56C3520658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDnjz-0004Rs-P6
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 07:17:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58764)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cathy.zhang@intel.com>) id 1jDmq9-0001Ih-6J
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 06:19:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cathy.zhang@intel.com>) id 1jDmq7-0000x8-B5
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 06:19:20 -0400
Received: from mga12.intel.com ([192.55.52.136]:24376)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cathy.zhang@intel.com>)
 id 1jDmq6-0008Jw-V0
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 06:19:19 -0400
IronPort-SDR: dBi42AFRBpJfXjIkEy3H5q++QIqbBU4AgUv7tU0YfkDwyI5PmcNHqU+jMk5zSZPiUJPcFD1KpT
 FMrvAerja3Xg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2020 03:19:13 -0700
IronPort-SDR: jpXuBtVK5PKJM1HKuSD6v0/zo0Gx5jJiVz7NRKhxklNpsOtj/ZqGZsEixQdRlPtG3hLXM4E2Gk
 nZ0uGRZUdKUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,560,1574150400"; d="scan'208";a="247410356"
Received: from zhangj4-mobl1.ccr.corp.intel.com (HELO [10.249.174.94])
 ([10.249.174.94])
 by orsmga006.jf.intel.com with ESMTP; 16 Mar 2020 03:19:11 -0700
Subject: Re: [PATCH 0/2] Fix Cooperlake CPU model
To: Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>
References: <20191225063018.20038-1-xiaoyao.li@intel.com>
 <93c9cc8c-09ec-d13f-f012-edf86fd945ab@redhat.com>
 <759b848d-8261-5997-2e2b-531246bcdf92@intel.com>
 <a972442e-2d29-674b-7ad6-2f056330ed84@redhat.com>
From: "Zhang, Cathy" <cathy.zhang@intel.com>
Message-ID: <d86b7681-8d99-523b-ebb5-d7d388ef4ca5@intel.com>
Date: Mon, 16 Mar 2020 18:19:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <a972442e-2d29-674b-7ad6-2f056330ed84@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
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

On 3/16/2020 4:41 PM, Paolo Bonzini wrote:
> On 16/03/20 02:39, Zhang, Cathy wrote:
>> On 1/7/2020 9:31 PM, Paolo Bonzini wrote:
>>> On 25/12/19 07:30, Xiaoyao Li wrote:
>>>> Current Cooperlake CPU model lacks VMX features which are introduced
>>>> by Paolo
>>>> several months ago, and it also lacks 2 security features in
>>>> MSR_IA32_ARCH_CAPABILITIES disclosed recently.
>>>>
>>>> Xiaoyao Li (2):
>>>>     target/i386: Add new bit definitions of MSR_IA32_ARCH_CAPABILITIES
>>>>     target/i386: Add missed features to Cooperlake CPU model
>>>>
>>>>    target/i386/cpu.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++-
>>>>    target/i386/cpu.h | 13 +++++++-----
>>>>    2 files changed, 58 insertions(+), 6 deletions(-)
>>>>
>>> Queued, thanks.
>>>
>>> Paolo
>> Hi Paolo,
>>
>> Can I ask one question that will you put all the patches for Cooper Lake
>> Cpu model into QEMU v5.0-rc0?
> These are included already:
>
> commit b952544fe8a061f0c0cccfd50a58220bc6ac94da
> Merge: dc65a5bdc9 083b266f69
> Author: Peter Maydell <peter.maydell@linaro.org>
> Date:   Fri Jan 10 17:16:49 2020 +0000
>
>      Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging
>      
>      * Compat machines fix (Denis)
>      * Command line parsing fixes (Michal, Peter, Xiaoyao)
>      * Cooperlake CPU model fixes (Xiaoyao)
>      * i386 gdb fix (mkdolata)
>      * IOEventHandler cleanup (Philippe)
>      * icount fix (Pavel)
>      * RR support for random number sources (Pavel)
>      * Kconfig fixes (Philippe)
>      
> Paolo
Yes, I see they are already in master, but not in v4.2 yet, so will they 
be in the next release v5.0?

