Received: from eggs.gnu.org ([2001:4830:134:3::10]:33866)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fnbOD-0007bp-KS
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 23:13:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fnbOA-0002OU-GI
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 23:13:29 -0400
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:37672)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1fnbOA-0002Ny-9u
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 23:13:26 -0400
Received: by mail-pl0-x242.google.com with SMTP id d5-v6so1919173pll.4
	for <qemu-devel@nongnu.org>; Wed, 08 Aug 2018 20:13:26 -0700 (PDT)
References: <20180807091209.13531-1-xiaoguangrong@tencent.com>
	<20180807091209.13531-11-xiaoguangrong@tencent.com>
	<20180808061230.GI24415@xz-mi>
From: Xiao Guangrong <guangrong.xiao@gmail.com>
Message-ID: <40696b07-5663-5c6d-28a6-7d354f0e45cb@gmail.com>
Date: Thu, 9 Aug 2018 11:13:17 +0800
MIME-Version: 1.0
In-Reply-To: <20180808061230.GI24415@xz-mi>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 10/10] migration: show the statistics of
 compression
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, dgilbert@redhat.com, wei.w.wang@intel.com, jiang.biao2@zte.com.cn, eblake@redhat.com, Xiao Guangrong <xiaoguangrong@tencent.com>



On 08/08/2018 02:12 PM, Peter Xu wrote:
> On Tue, Aug 07, 2018 at 05:12:09PM +0800, guangrong.xiao@gmail.com wrote:
> 
> [...]
> 
>> @@ -1602,6 +1614,26 @@ static void migration_update_rates(RAMState *rs, int64_t end_time)
>>               rs->xbzrle_cache_miss_prev) / page_count;
>>           rs->xbzrle_cache_miss_prev = xbzrle_counters.cache_miss;
>>       }
>> +
>> +    if (migrate_use_compression()) {
>> +        compression_counters.busy_rate = (double)(compression_counters.busy -
>> +            rs->compress_thread_busy_prev) / page_count;
> 
> So this is related to the previous patch - I still doubt its
> correctness if page_count is the host pages count rather than the
> guest pages'.  Other than that the patch looks good to me.

I think i can treat it as your Reviewed-by boldly. :)
