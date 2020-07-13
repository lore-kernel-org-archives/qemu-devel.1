Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93139C433F8
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 07:47:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 671A520674
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 07:47:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 671A520674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jutBd-0004XI-LW
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 03:47:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35104)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1jutB5-00047P-8Q
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 03:47:07 -0400
Received: from mga04.intel.com ([192.55.52.120]:45334)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1jutB2-0001JC-Lj
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 03:47:06 -0400
IronPort-SDR: DPgWpCXjNFjXG2bLEt4Uw/ALUOvy0m+sXbBko77uvRrn3/7oOWAXCLdnQhJ1Vnmivc9Z6GrDEa
 lJu/9HcXuUnQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9680"; a="146052973"
X-IronPort-AV: E=Sophos;i="5.75,346,1589266800"; d="scan'208";a="146052973"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jul 2020 00:45:59 -0700
IronPort-SDR: Oi22n65L8GcSE3IqfhwOixeZs+bME3rv+L3AH0fe8/glrcjQjeVcuBU0qmxdIuwOK5c0+ifJ4f
 DzPPSctV+D0A==
X-IronPort-AV: E=Sophos;i="5.75,346,1589266800"; d="scan'208";a="268302688"
Received: from unknown (HELO [10.239.13.102]) ([10.239.13.102])
 by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jul 2020 00:45:57 -0700
Subject: Re: [PATCH v5 1/4] target/i386: add missing vmx features for several
 CPU models
To: Chenyi Qiang <chenyi.qiang@intel.com>,
 Eduardo Habkost <ehabkost@redhat.com>
References: <20200619073114.24303-1-chenyi.qiang@intel.com>
 <20200619073114.24303-2-chenyi.qiang@intel.com>
 <20200709221226.GM780932@habkost.net>
 <d3542ac6-9282-ed88-3819-3cc8b3368ee7@intel.com>
 <20200710164832.GR780932@habkost.net>
 <7b8ceab5-2bf4-0905-ff9f-b2d9e2bd89a1@intel.com>
From: Xiaoyao Li <xiaoyao.li@intel.com>
Message-ID: <b67d7f1c-4a1f-dc57-ceb5-70dd8da9b5d8@intel.com>
Date: Mon, 13 Jul 2020 15:45:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <7b8ceab5-2bf4-0905-ff9f-b2d9e2bd89a1@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.120; envelope-from=xiaoyao.li@intel.com;
 helo=mga04.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 03:46:00
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.001,
 HK_RANDOM_FROM=1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Robert Hoo <robert.hu@linux.intel.com>,
 qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/13/2020 3:23 PM, Chenyi Qiang wrote:
> 
> 
> On 7/11/2020 12:48 AM, Eduardo Habkost wrote:
>> On Fri, Jul 10, 2020 at 09:45:49AM +0800, Chenyi Qiang wrote:
>>>
>>>
>>> On 7/10/2020 6:12 AM, Eduardo Habkost wrote:
>>>>
>>>> I'm very sorry for taking so long to review this.  Question
>>>> below:
>>>>
>>>> On Fri, Jun 19, 2020 at 03:31:11PM +0800, Chenyi Qiang wrote:
>>>>> Add some missing VMX features in Skylake-Server, Cascadelake-Server 
>>>>> and
>>>>> Icelake-Server CPU models based on the output of Paolo's script.
>>>>>
>>>>> Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
>>>>
>>>> Why are you changing the v1 definition instead adding those new
>>>> features in a new version of the CPU model, just like you did in
>>>> patch 3/4?
>>>>
>>>
>>> I suppose these missing vmx features are not quite necessary for 
>>> customers.
>>> Just post it here to see if they are worth being added.
>>> Adding a new version is reasonable. Is it appropriate to put all the 
>>> missing
>>> features in patch 1/4, 3/4, 4/4 in a same version?
>>
>> Yes, it would be OK to add only one new version with all the new
>> features.
>>
> 
> During the coding, I prefer to split the missing vmx features into a new 
> version of CPU model, because the vmx features depends on CPUID_EXT_VMX. 
> I think It would be better to distinguish it instead of enabling the vmx 
> transparently. i.e.
> {
>      .version = 4,
>      .props = (PropValue[]) {
>          { "sha-ni", "on" },
>          ... ...
>          { "model", "106" },
>                  { /* end of list */ }
>      },
> },
> {
>      .version = 5,
>      .props = (PropValue[]) {
>          { "vmx", "on" }

Chenyi,

This is not we have discussed. I prefer to changing the logic of 
versioned CPU model to not add the features in versioned CPU model to 
env->user_features[]. They're not supposed to be added to 
env->user_features[] since they're not set by user through -feature/+feature

Eduardo,

What do you think?


