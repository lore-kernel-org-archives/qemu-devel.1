Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B74C43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 02:48:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6C5D206F4
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 02:48:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6C5D206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ie96T-0007aE-Vn
	for qemu-devel@archiver.kernel.org; Sun, 08 Dec 2019 21:48:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44035)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tao3.xu@intel.com>) id 1ie95Y-00077K-2Y
 for qemu-devel@nongnu.org; Sun, 08 Dec 2019 21:47:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tao3.xu@intel.com>) id 1ie95X-0002Rg-0a
 for qemu-devel@nongnu.org; Sun, 08 Dec 2019 21:47:55 -0500
Received: from mga02.intel.com ([134.134.136.20]:44007)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1ie95W-0002JP-LS
 for qemu-devel@nongnu.org; Sun, 08 Dec 2019 21:47:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 08 Dec 2019 18:47:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,294,1571727600"; d="scan'208";a="237602583"
Received: from txu2-mobl.ccr.corp.intel.com (HELO [10.239.197.115])
 ([10.239.197.115])
 by fmsmga004.fm.intel.com with ESMTP; 08 Dec 2019 18:47:52 -0800
Subject: Re: [PATCH RESEND 4/4] target/i386: Add notes for versioned CPU models
To: Xiaoyao Li <xiaoyao.li@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20191202063233.28523-1-tao3.xu@intel.com>
 <20191202063233.28523-5-tao3.xu@intel.com>
 <689d3cc9-5325-1664-76fa-6f2a2b2b4c04@intel.com>
From: Tao Xu <tao3.xu@intel.com>
Message-ID: <4b703ba2-b395-9c7c-bb19-87590dd0716c@intel.com>
Date: Mon, 9 Dec 2019 10:47:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <689d3cc9-5325-1664-76fa-6f2a2b2b4c04@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/5/2019 4:44 PM, Xiaoyao Li wrote:
> On 12/2/2019 2:32 PM, Tao Xu wrote:
>> Add which features are added or removed in this version. Remove the
>> changed model-id in versioned CPU models.
>>
>> Signed-off-by: Tao Xu <tao3.xu@intel.com>
>> ---
>>    target/i386/cpu.c | 50 +++++++++++++++++++++++------------------------
>>    1 file changed, 25 insertions(+), 25 deletions(-)
>>
>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>> index 7b3bd6d4db..c82fbfd02e 100644
>> --- a/target/i386/cpu.c
>> +++ b/target/i386/cpu.c
> 
> [...]
> 
>> @@ -3141,6 +3133,7 @@ static X86CPUDefinition builtin_x86_defs[] = {
>>            .versions = (X86CPUVersionDefinition[]) {
>>                { .version = 1 },
>>                { .version = 2,
>> +              .note = "ARCH_CAPABILITIES",
> 
> Here ARCH_CAPABILITIES doesn't tell what bits in
> MSR_IA32_ARCH_CAPABILITIES this version has, which makes it meaningless.
> 
> Maybe
>          .note = "ARCH_CAPABLITIES(rdctl-no, ibrs-all, skip-l1dfl-vmentry, mds-no)",
> 
> is better?
> 

But it is too long for -cpu help, break the info into 2 lines.



