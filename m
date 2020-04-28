Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E487C83002
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 02:46:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50A43206D9
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 02:46:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50A43206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTGGS-0004cY-EH
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 22:46:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43392)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <colin.xu@intel.com>) id 1jTGFM-0002ib-Va
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 22:45:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <colin.xu@intel.com>) id 1jTGFK-0001lf-Pb
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 22:45:20 -0400
Received: from mga07.intel.com ([134.134.136.100]:21464)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <colin.xu@intel.com>)
 id 1jTGFJ-0001es-78
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 22:45:18 -0400
IronPort-SDR: MsI4W505do4GwZ/GerHL16j0QSCRnHZJTkwPd7ustL+gBMCfg0MIrdyX83n4s2IGFKbgonUqDo
 0PJVX66veYbA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Apr 2020 19:45:06 -0700
IronPort-SDR: FMH1HFRo+m9uZu2ifHnAtsWjogP0FXJl1heQYsmpvJaIa3RJZJEg6TwRv5j+2Y92kNMgEK7qbl
 OZeoERt0yXvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,326,1583222400"; d="scan'208";a="367355816"
Received: from unknown (HELO coxu-arch-shz) ([10.239.160.120])
 by fmsmga001.fm.intel.com with ESMTP; 27 Apr 2020 19:45:05 -0700
Date: Tue, 28 Apr 2020 10:45:04 +0800 (CST)
From: Colin Xu <colin.xu@intel.com>
X-X-Sender: coxu_arch@coxu-arch-shz
To: Colin Xu <Colin.Xu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2] [Qemu-devel] target/i386: HAX: Enable ROM/ROM device
 memory region support
In-Reply-To: <54b6f6c0-6419-2bc2-c915-9c7a83ab8dea@intel.com>
Message-ID: <alpine.LNX.2.22.419.2004281043520.5289@coxu-arch-shz>
References: <1585538712-28300-1-git-send-email-hang.yuan@linux.intel.com>
 <54b6f6c0-6419-2bc2-c915-9c7a83ab8dea@intel.com>
User-Agent: Alpine 2.22 (LNX 419 2020-04-12)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=134.134.136.100; envelope-from=colin.xu@intel.com;
 helo=mga07.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/27 22:45:07
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Received-From: 134.134.136.100
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
Cc: "hang.yuan@linux.intel.com" <hang.yuan@linux.intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Wang,
 Wenchao" <wenchao.wang@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Hi Paolo,

Would you please queue this one?
--
Best Regards,
Colin Xu

On Mon, 30 Mar 2020, Colin Xu wrote:

> Looks good to me.
>
> Reviewed-by: Colin Xu <colin.xu@intel.com>
>
> On 2020-03-30 11:25, hang.yuan@linux.intel.com wrote:
>> From: Hang Yuan <hang.yuan@linux.intel.com>
>>
>> Add ROM and ROM device memory region support in HAX. Their memory region is
>> read only and write access will generate EPT violation. The violation will be
>> handled in the HAX kernel with the following patch.
>>
>> https://github.com/intel/haxm/commit/33ceea09a1655fca12c47f1e112b1d269357ff28
>>
>> v2: fix coding style problems
>>
>> Signed-off-by: Hang Yuan <hang.yuan@linux.intel.com>
>> ---
>>   target/i386/hax-mem.c | 11 ++++-------
>>   1 file changed, 4 insertions(+), 7 deletions(-)
>>
>> diff --git a/target/i386/hax-mem.c b/target/i386/hax-mem.c
>> index 6bb5a24917..a8bfd37977 100644
>> --- a/target/i386/hax-mem.c
>> +++ b/target/i386/hax-mem.c
>> @@ -175,13 +175,10 @@ static void hax_process_section(MemoryRegionSection *section, uint8_t flags)
>>       uint64_t host_va;
>>       uint32_t max_mapping_size;
>>
>> -    /* We only care about RAM and ROM regions */
>> -    if (!memory_region_is_ram(mr)) {
>> -        if (memory_region_is_romd(mr)) {
>> -            /* HAXM kernel module does not support ROMD yet  */
>> -            warn_report("Ignoring ROMD region 0x%016" PRIx64 "->0x%016" PRIx64,
>> -                        start_pa, start_pa + size);
>> -        }
>> +    /* We only care about RAM/ROM regions and ROM device */
>> +    if (memory_region_is_rom(mr) || (memory_region_is_romd(mr))) {
>> +        flags |= HAX_RAM_INFO_ROM;
>> +    } else if (!memory_region_is_ram(mr)) {
>>           return;
>>       }
>>
>
> -- 
> Best Regards,
> Colin Xu
>
>
>

