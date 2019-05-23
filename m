Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25BDDC282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 13:22:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD0FB21019
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 13:22:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD0FB21019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36108 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTnfz-00016V-3E
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 09:22:31 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hTnJX-0006Ob-Li
	for qemu-devel@nongnu.org; Thu, 23 May 2019 08:59:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hTnJW-0004P3-Kh
	for qemu-devel@nongnu.org; Thu, 23 May 2019 08:59:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37444)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>)
	id 1hTnJW-0004OY-EB; Thu, 23 May 2019 08:59:18 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B0AC47E423;
	Thu, 23 May 2019 12:59:14 +0000 (UTC)
Received: from [10.36.116.197] (ovpn-116-197.ams2.redhat.com [10.36.116.197])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 562E668363;
	Thu, 23 May 2019 12:59:09 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: Richard Henderson <rth@twiddle.net>,
	Richard Henderson <richard.henderson@linaro.org>
References: <20190515203112.506-1-david@redhat.com>
	<20190515203112.506-2-david@redhat.com>
	<b3611279-15c4-f9b7-2a91-051ac6431b2c@linaro.org>
	<44d7ddb4-040f-6778-7439-043b94e354ec@redhat.com>
	<0935643f-941f-5883-c481-8ac18d57c98d@linaro.org>
	<1f6001a2-e1d3-2b6f-e84a-8b9963302a3c@redhat.com>
	<CAFXwXr=YzSuVa9wMKAczhojU+sK5zzPqpWOaJXDLovLNcmkYqg@mail.gmail.com>
	<db392f3c-2bb2-6e16-ebe8-3175ef7859f4@redhat.com>
	<9b00d53e-d676-7d19-cab6-7fb7a6715d1e@twiddle.net>
	<273c1e4f-3216-78aa-508e-b063c0612854@redhat.com>
	<1c3a49f8-56bd-1577-60a4-7c29ca1c0d83@twiddle.net>
	<8ea05b5e-9d8d-f514-7336-8d7637188009@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
	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
	SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <968a70bb-c025-235f-2914-ecb4142ae79b@redhat.com>
Date: Thu, 23 May 2019 14:59:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <8ea05b5e-9d8d-f514-7336-8d7637188009@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Thu, 23 May 2019 12:59:14 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v1 1/5] s390x/tcg: Implement VECTOR FIND
 ANY ELEMENT EQUAL
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Thomas Huth <thuth@redhat.com>, qemu-s390x <qemu-s390x@nongnu.org>,
	Cornelia Huck <cohuck@redhat.com>,
	"qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 23.05.19 14:34, David Hildenbrand wrote:
> On 23.05.19 14:27, Richard Henderson wrote:
>> On 5/23/19 3:50 AM, David Hildenbrand wrote:
>>> /*
>>>  * Returns the number of bits composing one element.
>>>  */
>>> static uint8_t get_element_bits(uint8_t es)
>>> {
>>>     return (1 << es) * BITS_PER_BYTE;
>>> }
>>>
>>> /*
>>>  * Returns the bitmask for a single element.
>>>  */
>>> static uint64_t get_single_element_mask(uint8_t es)
>>> {
>>>     return -1ull >> (64 - get_element_bits(es));
>>> }
>>>
>>> /*
>>>  * Returns the bitmask for a single element (excluding the MSB).
>>>  */
>>> static uint64_t get_single_element_lsbs_mask(uint8_t es)
>>> {
>>>     return -1ull >> (65 - get_element_bits(es));
>>> }
>>>
>>> /*
>>>  * Returns the bitmasks for multiple elements (excluding the MSBs).
>>>  */
>>> static uint64_t get_element_lsbs_mask(uint8_t es)
>>> {
>>>     return dup_const(es, get_single_element_lsbs_mask(es));
>>> }
>>>
>>> static int vfae(void *v1, const void *v2, const void *v3, bool in,
>>>                 bool rt, bool zs, uint8_t es)
>>> {
>>>     const uint64_t mask = get_element_lsbs_mask(es);
>>>     const int bits = get_element_bits(es);
>>>     uint64_t a0, a1, b0, b1, e0, e1, t0, t1, z0, z1;
>>>     uint64_t first_zero = 16;
>>>     uint64_t first_equal;
>>>     int i;
>>>
>>>     a0 = s390_vec_read_element64(v2, 0);
>>>     a1 = s390_vec_read_element64(v2, 1);
>>>     b0 = s390_vec_read_element64(v3, 0);
>>>     b1 = s390_vec_read_element64(v3, 1);
>>>     e0 = 0;
>>>     e1 = 0;
>>>     /* compare against equality with every other element */
>>>     for (i = 0; i < 64; i += bits) {
>>>         t0 = i ? rol64(b0, i) : b0;
>>>         t1 = i ? rol64(b1, i) : b1;
>>>         e0 |= zero_search(a0 ^ t0, mask);
>>>         e0 |= zero_search(a0 ^ t1, mask);
>>>         e1 |= zero_search(a1 ^ t0, mask);
>>>         e1 |= zero_search(a1 ^ t1, mask);
>>>     }
>>
>> I don't see that this is doing what you want.  You're shifting one element of B
>> down, but not broadcasting it so that it is compared against every element of A.
>>
>> I'd expect something like
>>
>> 	t0 = dup_const(es, b0 >> i);
>> 	t1 = dup_const(es, b1 >> i);
>>
>> (I also don't see what rol is getting you that shift doesn't.)
> 
> Let's assume
> 
> a0 = [0, 1, 2, 3]
> a1 = [4, 5, 6, 7]
> 
> b0 = [8, 8, 8, 4]
> b1 = [8, 8, 8, 8]
> 
> What I would check is
> 
> First iteration
> 
> a0 == [8, 8, 8, 4] -> no match
> a0 == [8, 8, 8, 8] -> no match
> a1 == [8, 8, 8, 4] -> no match
> a1 == [8, 8, 8, 8] -> no match
> 
> Second iteration
> 
> a0 == [8, 8, 4, 8] -> no match
> a0 == [8, 8, 8, 8] -> no match
> a1 == [8, 8, 4, 8]
> a1 == [8, 8, 8, 8] -> no match
> 
> ...
> 
> Last iteration
> 
> a0 == [4, 8, 8, 8] -> no match
> a0 == [8, 8, 8, 8] -> no match
> a1 == [4, 8, 8, 8] -> match in first element
> a1 == [8, 8, 8, 8] -> no match
> 
> What am i missing?
> 
> 

I guess I can simplify to

t0 = rol64(b0, i);
t1 = rol64(b1, i);

My approach: Compare all elements of B at a time
Your approach: Compare a single element of B at a time

If I'm not wrong, it boils down to to whether

rol64() or dup_const(es, b0 >> i) is faster ;)

-- 

Thanks,

David / dhildenb

