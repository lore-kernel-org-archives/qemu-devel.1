Received: from eggs.gnu.org ([2001:4830:134:3::10]:59382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d3KZi-0003sE-AY
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 06:53:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d3KZd-0001FK-Kz
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 06:53:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57966)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d3KZd-0001Ez-EL
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 06:53:29 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <5900603E.4040606@huawei.com> (Hailiang Zhang's message of "Wed,
	26 Apr 2017 16:54:22 +0800")
References: <20170426073247.7441-1-quintela@redhat.com>
	<20170426073247.7441-2-quintela@redhat.com>
	<5900603E.4040606@huawei.com>
Reply-To: quintela@redhat.com
Date: Wed, 26 Apr 2017 12:53:23 +0200
Message-ID: <87shkvjv8c.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] ram: Split dirty bitmap by RAMBlock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Hailiang Zhang <zhang.zhanghailiang@huawei.com>
Cc: qemu-devel@nongnu.org, xuquan8@huawei.com, lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com

Hailiang Zhang <zhang.zhanghailiang@huawei.com> wrote:
> On 2017/4/26 15:32, Juan Quintela wrote:
>> Both the ram bitmap and the unsent bitmap are split by RAMBlock.
>>
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>>
>> --
>>
>> Fix compilation when DEBUG_POSTCOPY is enabled (thanks Hailiang)
>>
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> +    postcopy_chunk_hostpages_pass(ms, false, block, pds);
>> +
>> +    postcopy_discard_send_finish(ms, pds);
>>       return 0;
>
> It always return 0 here for postcopy_chunk_hostpages(), so change it to void ?


This was dave code.  I assume that he has in mind something where it can
fail?
>> +        /* Deal with TPS != HPS and huge pages */
>> +        ret = postcopy_chunk_hostpages(ms, block);
>> +        if (ret) {
>
> It will never go here, see above.

Yeap, I also noticed.

>> +        bitmap_or(unsentmap, unsentmap, bitmap, pages);
>>   #ifdef DEBUG_POSTCOPY
>> -    ram_debug_dump_bitmap(unsentmap, true);
>> +    	ram_debug_dump_bitmap(unsentmap, true, pages);
> Indent, you use tab here.

Fixed.

> Others look good to me.
>
> Reviewed-by: zhanghailiang <zhang.zhanghailiang@huawei.com>

Thanks.
