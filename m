Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42F17C4360C
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 01:03:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F70D207FF
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 01:03:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F70D207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJom9-000645-83
	for qemu-devel@archiver.kernel.org; Sun, 13 Oct 2019 21:03:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34600)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richardw.yang@linux.intel.com>) id 1iJokx-0005Ql-Ch
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 21:02:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richardw.yang@linux.intel.com>) id 1iJokw-0001xZ-5H
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 21:02:39 -0400
Received: from mga17.intel.com ([192.55.52.151]:18951)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
 id 1iJokv-0001wJ-T9; Sun, 13 Oct 2019 21:02:38 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 13 Oct 2019 18:02:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,294,1566889200"; d="scan'208";a="188880033"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
 by orsmga008.jf.intel.com with ESMTP; 13 Oct 2019 18:01:58 -0700
Date: Mon, 14 Oct 2019 09:01:42 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 1/2] cpu: use ROUND_UP() to define xxx_PAGE_ALIGN
Message-ID: <20191014010142.GA29752@richard>
References: <20191013021145.16011-1-richardw.yang@linux.intel.com>
 <20191013021145.16011-2-richardw.yang@linux.intel.com>
 <41a924dc-f91b-c03b-4f82-570757105798@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41a924dc-f91b-c03b-4f82-570757105798@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
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
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
Cc: fam@euphon.net, mst@redhat.com, mark.cave-ayland@ilande.co.uk,
 qemu-devel@nongnu.org, kraxel@redhat.com, den@openvz.org,
 qemu-block@nongnu.org, quintela@redhat.com, armbru@redhat.com,
 pasic@linux.ibm.com, borntraeger@de.ibm.com, marcandre.lureau@redhat.com,
 ehabkost@redhat.com, sw@weilnetz.de, dgilbert@redhat.com,
 yuval.shaia@oracle.com, alex.williamson@redhat.com, stefanha@redhat.com,
 pbonzini@redhat.com, david@gibson.dropbear.id.au, kwolf@redhat.com,
 cohuck@redhat.com, qemu-s390x@nongnu.org, mreitz@redhat.com,
 qemu-ppc@nongnu.org, Wei Yang <richardw.yang@linux.intel.com>,
 imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Oct 13, 2019 at 11:56:35AM -0400, Richard Henderson wrote:
>On 10/12/19 10:11 PM, Wei Yang wrote:
>> Use ROUND_UP() to define, which is a little bit easy to read.
>> 
>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>> ---
>>  include/exec/cpu-all.h | 7 +++----
>>  1 file changed, 3 insertions(+), 4 deletions(-)
>> 
>> diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
>> index ad9ab85eb3..255bb186ac 100644
>> --- a/include/exec/cpu-all.h
>> +++ b/include/exec/cpu-all.h
>> @@ -220,7 +220,7 @@ extern int target_page_bits;
>>  
>>  #define TARGET_PAGE_SIZE (1 << TARGET_PAGE_BITS)
>>  #define TARGET_PAGE_MASK ~(TARGET_PAGE_SIZE - 1)
>> -#define TARGET_PAGE_ALIGN(addr) (((addr) + TARGET_PAGE_SIZE - 1) & TARGET_PAGE_MASK)
>> +#define TARGET_PAGE_ALIGN(addr) ROUND_UP((addr), TARGET_PAGE_SIZE)
>>  
>>  /* Using intptr_t ensures that qemu_*_page_mask is sign-extended even
>>   * when intptr_t is 32-bit and we are aligning a long long.
>> @@ -228,9 +228,8 @@ extern int target_page_bits;
>>  extern uintptr_t qemu_host_page_size;
>>  extern intptr_t qemu_host_page_mask;
>>  
>> -#define HOST_PAGE_ALIGN(addr) (((addr) + qemu_host_page_size - 1) & qemu_host_page_mask)
>> -#define REAL_HOST_PAGE_ALIGN(addr) (((addr) + qemu_real_host_page_size - 1) & \
>> -                                    qemu_real_host_page_mask)
>> +#define HOST_PAGE_ALIGN(addr) ROUND_UP((addr), qemu_host_page_size)
>> +#define REAL_HOST_PAGE_ALIGN(addr) ROUND_UP((addr), qemu_real_host_page_size)
>
>
>No, please.
>
>(1) The compiler does not know that qemu_*host_page_size is a power of 2, and
>will generate a real division at runtime.  The same is true for
>TARGET_PAGE_SIZE when TARGET_PAGE_BITS_VARY.
>

Confused

The definition of ROUND_UP is:

#define ROUND_UP(n, d) (((n) + (d) - 1) & -(0 ? (n) : (d)))

Why it will do division? This will be expanded to the same form as the
original code, if my understanding is correct. Would you mind telling me more?

>(2) The first hunk conflicts with an in-flight patch of mine:
>
>https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg04526.html
>
>
>r~

-- 
Wei Yang
Help you, Help me

