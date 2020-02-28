Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C9D9C3F2CE
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 01:11:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 495C22469D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 01:11:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 495C22469D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7UBn-00062n-A4
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 20:11:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46041)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Colin.Xu@intel.com>) id 1j7UB1-0005Vt-5O
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 20:10:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Colin.Xu@intel.com>) id 1j7UB0-0004VR-1M
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 20:10:51 -0500
Received: from mga05.intel.com ([192.55.52.43]:58881)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Colin.Xu@intel.com>)
 id 1j7UAw-0004Ph-Iz; Thu, 27 Feb 2020 20:10:46 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 27 Feb 2020 17:10:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,493,1574150400"; d="scan'208";a="232072922"
Received: from unknown (HELO [10.239.160.37]) ([10.239.160.37])
 by orsmga008.jf.intel.com with ESMTP; 27 Feb 2020 17:10:35 -0800
Subject: Re: [PATCH] MAINTAINERS: Add entry for Guest X86 HAXM CPUs
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, pbonzini@redhat.com
References: <20200226043204.67961-1-colin.xu@intel.com>
 <556a79eb-de83-0471-353f-b92423a77faa@redhat.com>
 <7509aa5c-aa6f-14e0-e641-6e70731e59d9@redhat.com>
From: Colin Xu <Colin.Xu@intel.com>
Message-ID: <999f796e-e1f4-7128-0a00-49fee2964a9f@intel.com>
Date: Fri, 28 Feb 2020 09:10:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <7509aa5c-aa6f-14e0-e641-6e70731e59d9@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, wenchao.wang@intel.com,
 hang.yuan@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020-02-27 16:00, Philippe Mathieu-Daudé wrote:
> On 2/27/20 8:56 AM, Philippe Mathieu-Daudé wrote:
>> Cc'ing qemu-trivial@
>>
>> On 2/26/20 5:32 AM, Colin Xu wrote:
>>> HAXM covers below files:
>>> include/sysemu/hax.h
>>> target/i386/hax-*
>>>
>>> Cc: Wenchao Wang <wenchao.wang@intel.com>
>>> Cc: Hang Yuan <hang.yuan@intel.com>
>>> Signed-off-by: Colin Xu <colin.xu@intel.com>
>>
>> Please keep the Acked-by/Reviewed-by tags:
>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg623832.html
>>
>> This patch already has:
>> Reviewed-by: Hang Yuan <hang.yuan@intel.com>
>>
>>> ---
>>>   MAINTAINERS | 10 ++++++++++
>>>   1 file changed, 10 insertions(+)
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 36d94c17a654..27727e2fac13 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -435,6 +435,16 @@ F: include/hw/block/dataplane/xen*
>>>   F: include/hw/xen/
>>>   F: include/sysemu/xen-mapcache.h
>>> +Guest CPU Cores (HAXM)
>>> +---------------------
>>> +X86 HAXM CPUs
>>> +M: Wenchao Wang <wenchao.wang@intel.com>
>>> +M: Colin Xu <colin.xu@intel.com>
>
> Maybe you can also link where to report HAXM issues:
>
> W: https://github.com/intel/haxm/issues
Indeed we need this. Thanks for point it out.
>
>>> +L: haxm-team@intel.com
>>> +S: Maintained
>>> +F: include/sysemu/hax.h
>>> +F: target/i386/hax-*
>>> +
>>>   Hosts
>>>   -----
>>>   LINUX
>>>
>
-- 
Best Regards,
Colin Xu


