Return-Path: <SRS0=xsRN=VS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91129C76191
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jul 2019 17:27:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AC0720578
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jul 2019 17:27:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AC0720578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpFcQ-0001XB-FA
	for qemu-devel@archiver.kernel.org; Sun, 21 Jul 2019 13:27:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49385)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hpFcF-00016S-Ui
 for qemu-devel@nongnu.org; Sun, 21 Jul 2019 13:27:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hpFcE-00034R-Qe
 for qemu-devel@nongnu.org; Sun, 21 Jul 2019 13:27:19 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33620)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hpFcE-000338-KS
 for qemu-devel@nongnu.org; Sun, 21 Jul 2019 13:27:18 -0400
Received: by mail-wm1-f67.google.com with SMTP id h19so27158229wme.0
 for <qemu-devel@nongnu.org>; Sun, 21 Jul 2019 10:27:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/wBNoyHoZ6Lnuz16AO2uIuwxm9X8y5YTa+Xs8/C25IU=;
 b=j19CRVyhGc3TA2W+YHnWSHzswNskAHQZyPiD8OO7aPLnjCGofKw72dn6nn2RegXu1a
 9YQOFkibQfPBkHMD5igFzM60mDPiuLBvPcyqWJGQQ4j4U/FMezfUKTB7DM/fsBveSyVC
 kqqYoLxzcA/o3oN0aeqwsz9Ee6NgaaT55bQE7mR7ZWfdqukpdMjVVZX965jysMjhb+j/
 XaVt98e5rE0rfPmKWHf1SwWQAfxybeubuE6bai4bniWNF0rJyJI8osq+3+qzWyUnsF6w
 DbINZP+eG+I8+67xTPwZnrxQterDNbN3TVzIcHLqdA139OlCLoFtZF7ukMSk40taGS0+
 H4/g==
X-Gm-Message-State: APjAAAWJqbjAIwLiyGaIm+v6Q1XRfbAheImxPbsKzndR0hpfFZJvJxg5
 /bBpsLkNAWsU/ld+6X1A5ErzuA==
X-Google-Smtp-Source: APXvYqxIuGNd5Z9sxAkakGER1EnoV1H0EsvbQGdFKHllPCrNdL2eyyrhi+m4YG5orfvl1lrueTIaZA==
X-Received: by 2002:a7b:c1c1:: with SMTP id a1mr62575228wmj.31.1563730037040; 
 Sun, 21 Jul 2019 10:27:17 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:59c3:355d:cfd:35b0?
 ([2001:b07:6468:f312:59c3:355d:cfd:35b0])
 by smtp.gmail.com with ESMTPSA id y18sm35988864wmi.23.2019.07.21.10.27.14
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Sun, 21 Jul 2019 10:27:15 -0700 (PDT)
To: Wei Yang <richard.weiyang@gmail.com>,
 Wei Yang <richardw.yang@linux.intel.com>
References: <20190718010456.4234-1-richardw.yang@linux.intel.com>
 <20190718010456.4234-2-richardw.yang@linux.intel.com>
 <20190721003316.dosnhlbawuezpryb@master>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <796ed0ca-ecd7-9f18-71fa-59b94c403cbc@redhat.com>
Date: Sun, 21 Jul 2019 19:27:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190721003316.dosnhlbawuezpryb@master>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [PATCH v3 1/2] bitmap: get last word mask from nr
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
Cc: quintela@redhat.com, corentincj@iksaif.net, pl@kamp.de,
 qemu-devel@nongnu.org, peterx@redhat.com, kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21/07/19 02:33, Wei Yang wrote:
> On Thu, Jul 18, 2019 at 09:04:55AM +0800, Wei Yang wrote:
>> The value left in nr is the number of bits for the last word, which
>> could be calculate the last word mask directly.
>>
>> Remove the unnecessary size.
>>
> 
> May I ask why Patch 2 is picked up, but this one is not?

Tests are always good to have, this cleanup will wait for 4.2 but it's
in the queue.

Paolo

>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>>
>> ---
>> v2: refine bitmap_set_atomic too, suggested from Peter
>> ---
>> util/bitmap.c | 9 +++------
>> 1 file changed, 3 insertions(+), 6 deletions(-)
>>
>> diff --git a/util/bitmap.c b/util/bitmap.c
>> index 1753ff7f5b..5b15249796 100644
>> --- a/util/bitmap.c
>> +++ b/util/bitmap.c
>> @@ -160,7 +160,6 @@ int slow_bitmap_andnot(unsigned long *dst, const unsigned long *bitmap1,
>> void bitmap_set(unsigned long *map, long start, long nr)
>> {
>>     unsigned long *p = map + BIT_WORD(start);
>> -    const long size = start + nr;
>>     int bits_to_set = BITS_PER_LONG - (start % BITS_PER_LONG);
>>     unsigned long mask_to_set = BITMAP_FIRST_WORD_MASK(start);
>>
>> @@ -174,7 +173,7 @@ void bitmap_set(unsigned long *map, long start, long nr)
>>         p++;
>>     }
>>     if (nr) {
>> -        mask_to_set &= BITMAP_LAST_WORD_MASK(size);
>> +        mask_to_set &= BITMAP_LAST_WORD_MASK(nr);
>>         *p |= mask_to_set;
>>     }
>> }
>> @@ -182,7 +181,6 @@ void bitmap_set(unsigned long *map, long start, long nr)
>> void bitmap_set_atomic(unsigned long *map, long start, long nr)
>> {
>>     unsigned long *p = map + BIT_WORD(start);
>> -    const long size = start + nr;
>>     int bits_to_set = BITS_PER_LONG - (start % BITS_PER_LONG);
>>     unsigned long mask_to_set = BITMAP_FIRST_WORD_MASK(start);
>>
>> @@ -208,7 +206,7 @@ void bitmap_set_atomic(unsigned long *map, long start, long nr)
>>
>>     /* Last word */
>>     if (nr) {
>> -        mask_to_set &= BITMAP_LAST_WORD_MASK(size);
>> +        mask_to_set &= BITMAP_LAST_WORD_MASK(nr);
>>         atomic_or(p, mask_to_set);
>>     } else {
>>         /* If we avoided the full barrier in atomic_or(), issue a
>> @@ -221,7 +219,6 @@ void bitmap_set_atomic(unsigned long *map, long start, long nr)
>> void bitmap_clear(unsigned long *map, long start, long nr)
>> {
>>     unsigned long *p = map + BIT_WORD(start);
>> -    const long size = start + nr;
>>     int bits_to_clear = BITS_PER_LONG - (start % BITS_PER_LONG);
>>     unsigned long mask_to_clear = BITMAP_FIRST_WORD_MASK(start);
>>
>> @@ -235,7 +232,7 @@ void bitmap_clear(unsigned long *map, long start, long nr)
>>         p++;
>>     }
>>     if (nr) {
>> -        mask_to_clear &= BITMAP_LAST_WORD_MASK(size);
>> +        mask_to_clear &= BITMAP_LAST_WORD_MASK(nr);
>>         *p &= ~mask_to_clear;
>>     }
>> }
>> -- 
>> 2.17.1
>>
> 


