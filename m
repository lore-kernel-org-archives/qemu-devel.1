Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D09D6C4332B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 00:24:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A751A20719
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 00:24:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A751A20719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGXMs-0008RJ-NX
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 20:24:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57789)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tao3.xu@intel.com>) id 1jGXME-00082i-IJ
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 20:23:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tao3.xu@intel.com>) id 1jGXMC-00008I-KS
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 20:23:49 -0400
Received: from mga02.intel.com ([134.134.136.20]:8518)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1jGXMC-00006R-1M
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 20:23:48 -0400
IronPort-SDR: 1yxIDw8RpAspi4SlfC31jKDL+I+PYIBiz55HSRtMBqtzUgPrk5PPdtN01afJ6nqvkXI7C0zB+D
 0zxiHHxD99CQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Mar 2020 17:23:43 -0700
IronPort-SDR: PvyGoWhzOTRr5mIVaiIOu/KAvNdYMZ7JdhVJNKrSaPbuylYVi2FTnh6Q+g7Xp86Hp7MnTR2i6Q
 JSOkPX3SIcJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,298,1580803200"; d="scan'208";a="446017119"
Received: from txu2-mobl.ccr.corp.intel.com (HELO [10.238.4.86])
 ([10.238.4.86])
 by fmsmga005.fm.intel.com with ESMTP; 23 Mar 2020 17:23:42 -0700
Subject: Re: [PATCH v2] target/i386: Add ARCH_CAPABILITIES related bits into
 Icelake-Server CPU model
To: Eduardo Habkost <ehabkost@redhat.com>
References: <20200316095605.12318-1-xiaoyao.li@intel.com>
 <38253eb8-059c-5020-50cd-e90f7e8e4ae5@intel.com>
 <8324d641-4a1d-cf64-5da5-9410eddc983c@intel.com>
 <20200323183936.GA3784@habkost.net>
From: Tao Xu <tao3.xu@intel.com>
Message-ID: <99e35e3c-c797-ea54-4a55-dfe628cb7d2f@intel.com>
Date: Tue, 24 Mar 2020 08:23:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200323183936.GA3784@habkost.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 134.134.136.20
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Li, Xiaoyao" <xiaoyao.li@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 3/24/2020 2:39 AM, Eduardo Habkost wrote:
> On Mon, Mar 23, 2020 at 10:58:16AM +0800, Xiaoyao Li wrote:
>> On 3/23/2020 10:32 AM, Tao Xu wrote:
>>> Hi Xiaoyao,
>>>
>>> May be you can add .note for this new version.
>>>
>>> for example:
>>>
>>> +                .version = 3,
>>> +                .note = "ARCH_CAPABILITIES",
>>> +                .props = (PropValue[]) {
>>
>> Hi Paolo and Eduardo,
>>
>> Need I spin a new version to add the .note ?
>> Maybe you can add it when queue?
> 
> Please send a follow up patch so we don't hold a bug fix because
> of something that's just cosmetic.  I will queue this patch.  We
> still need a new version of "target/i386: Add notes for versioned
> CPU models"[1], don't we?
> 
> [1] https://lore.kernel.org/qemu-devel/20200228215253.GB494511@habkost.net/
> 
I am sorry for misunderstanding your comments in that patch[1]. I will 
submit a new version of this patch.

