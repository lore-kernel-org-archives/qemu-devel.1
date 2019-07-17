Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57CA0C76188
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 02:47:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F5492173B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 02:47:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F5492173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnZyR-0005qo-7g
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 22:47:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56859)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richardw.yang@linux.intel.com>) id 1hnZyE-0005QP-Kb
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 22:47:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richardw.yang@linux.intel.com>) id 1hnZyD-0007iP-IR
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 22:47:06 -0400
Received: from mga12.intel.com ([192.55.52.136]:3153)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
 id 1hnZyD-0007hJ-9H
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 22:47:05 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 16 Jul 2019 19:47:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,272,1559545200"; d="scan'208";a="167834476"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
 by fmsmga008.fm.intel.com with ESMTP; 16 Jul 2019 19:47:01 -0700
Date: Wed, 17 Jul 2019 10:46:37 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
To: Peter Xu <zhexu@redhat.com>
Message-ID: <20190717024637.GA17163@richard>
References: <20190717012902.23958-1-richardw.yang@linux.intel.com>
 <20190717015910.GD30980@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190717015910.GD30980@xz-x1>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.136
Subject: Re: [Qemu-devel] [RESEND][PATCH] bitmap: get last word mask from nr
 directly
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
Cc: quintela@redhat.com, corentincj@iksaif.net, pl@kamp.de,
 qemu-devel@nongnu.org, kraxel@redhat.com, pbonzini@redhat.com,
 Wei Yang <richardw.yang@linux.intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 17, 2019 at 09:59:10AM +0800, Peter Xu wrote:
>On Wed, Jul 17, 2019 at 09:29:02AM +0800, Wei Yang wrote:
>> The value left in nr is the number of bits for the last word, which
>> could be calculate the last word mask directly.
>
>Is it true even if start does not align to BITS_PER_LONG?
>

Yes. Let me see how to explain this.

When you look into the definition of BITMAP_LAST_WORD_MASK, it takes the
number of total bits and give the number of bits in last word. While the value
matters for the input is the number of last word. This means the following
equation stands

  BITMAP_LAST_WORD_MASK(size) == BITMAP_FIRST_WORD_MASK(size % BITS_PER_LONG)

Now let look at the calculation for nr. In each iteration, nr will be
truncated to be aligned to BITS_PER_LONG. So when we exit the loop, nr keeps
the number of bits in last word.

So we can leverage the result, no matter the start is aligned or not.

>> 
>> Remove the unnecessary size.
>> 
>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>> ---
>> resend with wider audience
>> ---
>>  util/bitmap.c | 6 ++----
>>  1 file changed, 2 insertions(+), 4 deletions(-)
>> 
>> diff --git a/util/bitmap.c b/util/bitmap.c
>> index cb618c65a5..5aa60b8717 100644
>> --- a/util/bitmap.c
>> +++ b/util/bitmap.c
>> @@ -160,7 +160,6 @@ int slow_bitmap_andnot(unsigned long *dst, const unsigned long *bitmap1,
>>  void bitmap_set(unsigned long *map, long start, long nr)
>>  {
>>      unsigned long *p = map + BIT_WORD(start);
>> -    const long size = start + nr;
>>      int bits_to_set = BITS_PER_LONG - (start % BITS_PER_LONG);
>>      unsigned long mask_to_set = BITMAP_FIRST_WORD_MASK(start);
>>  
>> @@ -174,7 +173,7 @@ void bitmap_set(unsigned long *map, long start, long nr)
>>          p++;
>>      }
>>      if (nr) {
>> -        mask_to_set &= BITMAP_LAST_WORD_MASK(size);
>> +        mask_to_set &= BITMAP_LAST_WORD_MASK(nr);
>>          *p |= mask_to_set;
>>      }
>>  }
>> @@ -221,7 +220,6 @@ void bitmap_set_atomic(unsigned long *map, long start, long nr)
>>  void bitmap_clear(unsigned long *map, long start, long nr)
>>  {
>>      unsigned long *p = map + BIT_WORD(start);
>> -    const long size = start + nr;
>>      int bits_to_clear = BITS_PER_LONG - (start % BITS_PER_LONG);
>>      unsigned long mask_to_clear = BITMAP_FIRST_WORD_MASK(start);
>>  
>> @@ -235,7 +233,7 @@ void bitmap_clear(unsigned long *map, long start, long nr)
>>          p++;
>>      }
>>      if (nr) {
>> -        mask_to_clear &= BITMAP_LAST_WORD_MASK(size);
>> +        mask_to_clear &= BITMAP_LAST_WORD_MASK(nr);
>>          *p &= ~mask_to_clear;
>>      }
>>  }
>> -- 
>> 2.17.1
>> 
>
>Regards,
>
>-- 
>Peter Xu

-- 
Wei Yang
Help you, Help me

