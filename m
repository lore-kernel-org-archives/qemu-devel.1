Return-Path: <SRS0=vx8y=AW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 866FFC433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 02:01:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5628E20767
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 02:01:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5628E20767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ju4pK-0002f0-Kc
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 22:01:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42364)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1ju4oi-0002F9-BL
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 22:00:40 -0400
Received: from mga05.intel.com ([192.55.52.43]:47996)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1ju4of-0001Ed-IO
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 22:00:39 -0400
IronPort-SDR: PN/J4v9meHEh4OXufK/vyHkn3kL+E1DMtU2s+DtrKTUZIKFmUs9G79epYHUuQkgcgvhyjra+Ux
 nisWvS36Z+8w==
X-IronPort-AV: E=McAfee;i="6000,8403,9678"; a="233198407"
X-IronPort-AV: E=Sophos;i="5.75,337,1589266800"; d="scan'208";a="233198407"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2020 19:00:29 -0700
IronPort-SDR: cQrL9SWMl8xfjBqfGDSd1QaGMG/gGeDoiciitlDaM132yrgMkpopg9eylcZLrpwNd5mR+G+oxH
 6g+GjAQTR9tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,337,1589266800"; d="scan'208";a="269231166"
Received: from cqiang-mobl.ccr.corp.intel.com (HELO [10.249.172.8])
 ([10.249.172.8])
 by fmsmga008.fm.intel.com with ESMTP; 10 Jul 2020 19:00:27 -0700
Subject: Re: [PATCH v5 1/4] target/i386: add missing vmx features for several
 CPU models
To: Eduardo Habkost <ehabkost@redhat.com>
References: <20200619073114.24303-1-chenyi.qiang@intel.com>
 <20200619073114.24303-2-chenyi.qiang@intel.com>
 <20200709221226.GM780932@habkost.net>
 <d3542ac6-9282-ed88-3819-3cc8b3368ee7@intel.com>
 <20200710164832.GR780932@habkost.net>
From: Chenyi Qiang <chenyi.qiang@intel.com>
Message-ID: <992b443b-cd59-ba1b-4f14-b111d6e5ffc7@intel.com>
Date: Sat, 11 Jul 2020 10:00:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200710164832.GR780932@habkost.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.55.52.43; envelope-from=chenyi.qiang@intel.com;
 helo=mga05.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/10 22:00:29
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Robert Hoo <robert.hu@linux.intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, qemu-devel@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 7/11/2020 12:48 AM, Eduardo Habkost wrote:
> On Fri, Jul 10, 2020 at 09:45:49AM +0800, Chenyi Qiang wrote:
>>
>>
>> On 7/10/2020 6:12 AM, Eduardo Habkost wrote:
>>>
>>> I'm very sorry for taking so long to review this.  Question
>>> below:
>>>
>>> On Fri, Jun 19, 2020 at 03:31:11PM +0800, Chenyi Qiang wrote:
>>>> Add some missing VMX features in Skylake-Server, Cascadelake-Server and
>>>> Icelake-Server CPU models based on the output of Paolo's script.
>>>>
>>>> Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
>>>
>>> Why are you changing the v1 definition instead adding those new
>>> features in a new version of the CPU model, just like you did in
>>> patch 3/4?
>>>
>>
>> I suppose these missing vmx features are not quite necessary for customers.
>> Just post it here to see if they are worth being added.
>> Adding a new version is reasonable. Is it appropriate to put all the missing
>> features in patch 1/4, 3/4, 4/4 in a same version?
> 
> Yes, it would be OK to add only one new version with all the new
> features.
> 

OK, I'll do it in the next version of patch.

