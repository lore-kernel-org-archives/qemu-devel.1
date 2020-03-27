Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A594EC43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 07:46:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A4F320705
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 07:46:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A4F320705
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHjh1-0005ca-KH
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 03:46:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46221)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chenyi.qiang@intel.com>) id 1jHjgO-0005AS-MD
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 03:45:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chenyi.qiang@intel.com>) id 1jHjgM-0007va-Ph
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 03:45:35 -0400
Received: from mga01.intel.com ([192.55.52.88]:38356)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <chenyi.qiang@intel.com>)
 id 1jHjgM-0005du-DT
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 03:45:34 -0400
IronPort-SDR: kUH5gKkSfEed0q3L4zGP1rTebUNbnL5CbOyv7VotODI6NdphYx9eavLjHUM7iov2sUTOUMQ12Q
 lxEcejPeHxcA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2020 00:45:24 -0700
IronPort-SDR: 2LCRUCqaGuFgfVBqQm4wd6m9m/odBCJpZW9vXxQBvEb7u4H9XVOky+cFKbAhpJf5syXpbipAv7
 plPYltoMt39g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,311,1580803200"; d="scan'208";a="448919288"
Received: from cqiang-mobl.ccr.corp.intel.com (HELO [10.238.4.174])
 ([10.238.4.174])
 by fmsmga006.fm.intel.com with ESMTP; 27 Mar 2020 00:45:23 -0700
Subject: Re: [PATCH 0/3] Fix Skylake, Cascadelake and Icelake Server CPU models
From: Chenyi Qiang <chenyi.qiang@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, 
 Eduardo Habkost <ehabkost@redhat.com>
References: <20200227090808.17686-1-chenyi.qiang@intel.com>
 <03fb4682-8430-c792-028b-54f859da3dcb@intel.com>
Message-ID: <84c91667-ccbf-2933-0530-46a81f8d002b@intel.com>
Date: Fri, 27 Mar 2020 15:45:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <03fb4682-8430-c792-028b-54f859da3dcb@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 192.55.52.88
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
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Paolo and Eduardo,

It seems I need to put the missing feature bits in the new version of 
CPU model. I'll resend this patch set.
BTW, what about the missing vmx feature bits? Also put in in new version 
CPU model?

Thanks,
Chenyi

On 3/18/2020 4:02 PM, Chenyi Qiang wrote:
> Ping.
> 
> On 2/27/2020 5:08 PM, Chenyi Qiang wrote:
>> Current Skylake-Server, Cascadelake-Server and Icelake-Server CPU models
>> lack several VMX features. Icelake-Server also lacks two features in
>> FEAT_7_0_EBX. In addition, The model numbers of Icelake-Client and
>> Icelake-Server need to be fixed.
>>
>> Chenyi Qiang (3):
>>    target/i386: add missing vmx features for several CPU models
>>    target/i386: add two missing features for Icelake-Server CPU model
>>    target/i386: modify Icelake-Client and Icelake-Server CPU model number
>>
>>   target/i386/cpu.c | 13 +++++++++----
>>   1 file changed, 9 insertions(+), 4 deletions(-)
>>
> 

