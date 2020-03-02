Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5583EC3F2D1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 01:39:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CEDE24699
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 01:39:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CEDE24699
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8a3O-0003qN-6I
	for qemu-devel@archiver.kernel.org; Sun, 01 Mar 2020 20:39:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52257)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Colin.Xu@intel.com>) id 1j8a2M-0003IT-AL
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 20:38:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Colin.Xu@intel.com>) id 1j8a2L-0002gE-9I
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 20:38:26 -0500
Received: from mga05.intel.com ([192.55.52.43]:23348)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Colin.Xu@intel.com>)
 id 1j8a2H-0002ae-Ou; Sun, 01 Mar 2020 20:38:21 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 01 Mar 2020 17:38:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,506,1574150400"; d="scan'208";a="386114239"
Received: from unknown (HELO [10.239.160.52]) ([10.239.160.52])
 by orsmga004.jf.intel.com with ESMTP; 01 Mar 2020 17:38:10 -0800
Subject: Re: [PATCH V2] MAINTAINERS: Add entry for Guest X86 HAXM CPUs
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 philmd@redhat.com
References: <20200228012046.6629-1-colin.xu@intel.com>
 <9c32d7c2-d8af-45c6-4578-34c79bd7a2a0@redhat.com>
From: Colin Xu <Colin.Xu@intel.com>
Message-ID: <e6db0da6-6e18-cb9e-1fce-f4de4bb82e8a@intel.com>
Date: Mon, 2 Mar 2020 09:38:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <9c32d7c2-d8af-45c6-4578-34c79bd7a2a0@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.43
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
Reply-To: Colin.Xu@intel.com
Cc: qemu-trivial@nongnu.org, wenchao.wang@intel.com, hang.yuan@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020-02-28 19:00, Paolo Bonzini wrote:
> On 28/02/20 02:20, Colin Xu wrote:
>> HAXM covers below files:
>> include/sysemu/hax.h
>> target/i386/hax-*
>>
>> V2: Add HAXM github page for wiki and issue tracking.
>>
>> Cc: Wenchao Wang <wenchao.wang@intel.com>
>> Cc: Hang Yuan <hang.yuan@intel.com>
>> Reviewed-by: Hang Yuan <hang.yuan@intel.com>
>> Signed-off-by: Colin Xu <colin.xu@intel.com>
>> ---
>>   MAINTAINERS | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index df1786db3207..c45f1421eab5 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -435,6 +435,17 @@ F: include/hw/block/dataplane/xen*
>>   F: include/hw/xen/
>>   F: include/sysemu/xen-mapcache.h
>>   
>> +Guest CPU Cores (HAXM)
>> +---------------------
>> +X86 HAXM CPUs
>> +M: Wenchao Wang <wenchao.wang@intel.com>
>> +M: Colin Xu <colin.xu@intel.com>
>> +L: haxm-team@intel.com
>> +W: https://github.com/intel/haxm/issues
>> +S: Maintained
>> +F: include/sysemu/hax.h
>> +F: target/i386/hax-*
>> +
>>   Hosts
>>   -----
>>   LINUX
>>
> Queued, thanks.
>
> Paolo
Thanks a lot!

-- 
Best Regards,
Colin Xu


