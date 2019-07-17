Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A106C76186
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 08:08:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5B182173B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 08:08:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5B182173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hneza-0001lQ-GU
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 04:08:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39239)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richardw.yang@linux.intel.com>) id 1hnezP-0001KV-Tv
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 04:08:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richardw.yang@linux.intel.com>) id 1hnezO-0002fD-Sw
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 04:08:39 -0400
Received: from mga02.intel.com ([134.134.136.20]:47807)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
 id 1hnezO-0002ZF-Kh
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 04:08:38 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 17 Jul 2019 01:08:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,273,1559545200"; d="scan'208";a="175644231"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
 by FMSMGA003.fm.intel.com with ESMTP; 17 Jul 2019 01:08:29 -0700
Date: Wed, 17 Jul 2019 16:08:05 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
To: Peter Xu <zhexu@redhat.com>
Message-ID: <20190717080805.GA15023@richard>
References: <20190717071114.14772-1-richardw.yang@linux.intel.com>
 <20190717071114.14772-3-richardw.yang@linux.intel.com>
 <20190717074311.GG30980@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190717074311.GG30980@xz-x1>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.20
Subject: Re: [Qemu-devel] [PATCH v2 2/2] test-bitmap: add test for bitmap_set
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

On Wed, Jul 17, 2019 at 03:43:11PM +0800, Peter Xu wrote:
>On Wed, Jul 17, 2019 at 03:11:14PM +0800, Wei Yang wrote:
>> Add a test for bitmap_set. There are three cases:
>> 
>>   * Both start and end is BITS_PER_LONG aligned
>>   * Only start is BITS_PER_LONG aligned
>>   * Only end is BITS_PER_LONG aligned
>> 
>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>
>Hi, Wei,
>
>Thanks for doing this.  I've got a few comments below.
>
>> ---
>>  tests/test-bitmap.c | 33 +++++++++++++++++++++++++++++++++
>>  1 file changed, 33 insertions(+)
>> 
>> diff --git a/tests/test-bitmap.c b/tests/test-bitmap.c
>> index cb7c5e462d..1f0123f604 100644
>> --- a/tests/test-bitmap.c
>> +++ b/tests/test-bitmap.c
>> @@ -59,12 +59,45 @@ static void check_bitmap_copy_with_offset(void)
>>      g_free(bmap3);
>>  }
>>  
>> +static void check_bitmap_set(void)
>> +{
>> +    unsigned long *bmap;
>> +
>> +    bmap = bitmap_new(BMAP_SIZE);
>
>Need to free this.
>

oops, you are right.

>> +
>> +    /* Both Aligned, set bits [BITS_PER_LONG, 2*BITS_PER_LONG] */
>> +    bitmap_set(bmap, BITS_PER_LONG, BITS_PER_LONG);
>> +    g_assert_cmpint(find_first_bit(bmap, BITS_PER_LONG), ==, BITS_PER_LONG);
>
>Can check all 1's set correctly.
>
>       g_assert_cmpuint(bmap[1], ==, -1ul);
>
>Can also make this at least across multiple long fields.
>

good suggestion

>> +    g_assert_cmpint(find_next_zero_bit(bmap, 2 * BITS_PER_LONG, BITS_PER_LONG),
>> +                    ==, 2 * BITS_PER_LONG);
>> +
>> +    bitmap_clear(bmap, 0, BMAP_SIZE);
>> +    /* End Aligned, set bits [BITS_PER_LONG - 5, 2*BITS_PER_LONG] */
>> +    bitmap_set(bmap, BITS_PER_LONG - 5, BITS_PER_LONG + 5);
>
>Same here.
>
>> +    g_assert_cmpint(find_first_bit(bmap, BITS_PER_LONG),
>> +                    ==, BITS_PER_LONG - 5);
>> +    g_assert_cmpint(find_next_zero_bit(bmap,
>> +                                       2 * BITS_PER_LONG, BITS_PER_LONG - 5),
>> +                    ==, 2 * BITS_PER_LONG);
>> +
>> +    bitmap_clear(bmap, 0, BMAP_SIZE);
>> +    /* Start Aligned, set bits [BITS_PER_LONG, 2*BITS_PER_LONG + 5] */
>> +    bitmap_set(bmap, BITS_PER_LONG, BITS_PER_LONG + 5);
>
>And here.
>
>> +    g_assert_cmpint(find_first_bit(bmap, BITS_PER_LONG),
>> +                    ==, BITS_PER_LONG);
>> +    g_assert_cmpint(find_next_zero_bit(bmap,
>> +                                       2 * BITS_PER_LONG + 5, BITS_PER_LONG),
>> +                    ==, 2 * BITS_PER_LONG + 5);
>> +}
>> +
>>  int main(int argc, char **argv)
>>  {
>>      g_test_init(&argc, &argv, NULL);
>>  
>>      g_test_add_func("/bitmap/bitmap_copy_with_offset",
>>                      check_bitmap_copy_with_offset);
>> +    g_test_add_func("/bitmap/bitmap_set",
>> +                    check_bitmap_set);
>
>Can at least do the same test to bitmap_set_atomic too, simply by
>allowing your helper test function to take a func pointer:
>
>void (*bmap_set_func)(unsigned long *map, long i, long len);
>
>Then call with both bitmap_set{_atomic}.
>

ok, let me take a look into this.

>Thanks,
>
>-- 
>Peter Xu

-- 
Wei Yang
Help you, Help me

