Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE19FC3F2D1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 12:06:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83CA02173E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 12:06:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83CA02173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8jqK-0005Od-N6
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 07:06:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39791)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tao3.xu@intel.com>) id 1j8jlW-00035D-5M
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 07:01:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tao3.xu@intel.com>) id 1j8jlU-0004Gj-HC
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 07:01:41 -0500
Received: from mga17.intel.com ([192.55.52.151]:49313)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1j8jlU-0004Es-78
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 07:01:40 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 02 Mar 2020 04:01:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,507,1574150400"; d="scan'208";a="273693797"
Received: from yli41-mobl1.ccr.corp.intel.com (HELO [10.249.199.10])
 ([10.249.199.10])
 by fmsmga002.fm.intel.com with ESMTP; 02 Mar 2020 04:01:35 -0800
Subject: Re: [PATCH v3 4/4] target/i386: Add notes for versioned CPU models
To: Eduardo Habkost <ehabkost@redhat.com>
References: <20200212081328.7385-1-tao3.xu@intel.com>
 <20200212081328.7385-5-tao3.xu@intel.com>
 <20200228215253.GB494511@habkost.net>
From: Tao Xu <tao3.xu@intel.com>
Message-ID: <e6ff4089-2500-1c31-44b7-97a30f9b73a3@intel.com>
Date: Mon, 2 Mar 2020 20:01:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200228215253.GB494511@habkost.net>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.151
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/29/2020 5:52 AM, Eduardo Habkost wrote:
> On Wed, Feb 12, 2020 at 04:13:28PM +0800, Tao Xu wrote:
>> Add which features are added or removed in this version. Remove the
>> changed model-id in versioned CPU models, to keep the model name
>> unchanged at /proc/cpuinfo inside the VM.
>>
>> Signed-off-by: Tao Xu <tao3.xu@intel.com>
>> ---
>>
>> Changes in v2:
>>      - correct the note of Cascadelake v3 (Xiaoyao)
>> ---
>>   target/i386/cpu.c | 54 ++++++++++++++++++++++-------------------------
>>   1 file changed, 25 insertions(+), 29 deletions(-)
>>
>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>> index 81a039beb6..739ef4ce91 100644
>> --- a/target/i386/cpu.c
>> +++ b/target/i386/cpu.c
>> @@ -2278,10 +2278,9 @@ static X86CPUDefinition builtin_x86_defs[] = {
>>               {
>>                   .version = 2,
>>                   .alias = "Nehalem-IBRS",
>> +                .note = "IBRS",
>>                   .props = (PropValue[]) {
>>                       { "spec-ctrl", "on" },
>> -                    { "model-id",
>> -                      "Intel Core i7 9xx (Nehalem Core i7, IBRS update)" },
>>                       { /* end of list */ }
> 
> Changing model-id is guest-visible, so we can't do this.  The
> same applies to the other models where model-id is being removed.
> 
> I suggest using the .note property only on the CPU model versions
> that don't have custom model-id set yet, or when existing
> information on model-id is incomplete.
> 
> For future CPU model versions, we can start using only .note and
> stop changing model-id.
> 

Got it,thanks!

