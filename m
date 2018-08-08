Received: from eggs.gnu.org ([2001:4830:134:3::10]:35806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fnHpe-00055Y-IW
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 02:20:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fnHpa-00027H-Fh
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 02:20:30 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:35989)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1fnHpa-00026s-8s
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 02:20:26 -0400
Received: by mail-pg1-x541.google.com with SMTP id h12-v6so591382pgs.3
	for <qemu-devel@nongnu.org>; Tue, 07 Aug 2018 23:20:26 -0700 (PDT)
References: <20180807091209.13531-1-xiaoguangrong@tencent.com>
	<20180807091209.13531-2-xiaoguangrong@tencent.com>
	<6fb46b1e-5cae-24ec-acd6-72ba562a5c05@redhat.com>
	<20180808035127.GD24415@xz-mi>
From: Xiao Guangrong <guangrong.xiao@gmail.com>
Message-ID: <21fc899c-f221-17a5-cd86-7a3810603178@gmail.com>
Date: Wed, 8 Aug 2018 14:20:17 +0800
MIME-Version: 1.0
In-Reply-To: <20180808035127.GD24415@xz-mi>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 01/10] migration: do not wait for free
 thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, dgilbert@redhat.com, wei.w.wang@intel.com, jiang.biao2@zte.com.cn, Xiao Guangrong <xiaoguangrong@tencent.com>



On 08/08/2018 11:51 AM, Peter Xu wrote:
> On Tue, Aug 07, 2018 at 08:29:54AM -0500, Eric Blake wrote:
>> On 08/07/2018 04:12 AM, guangrong.xiao@gmail.com wrote:
>>> From: Xiao Guangrong <xiaoguangrong@tencent.com>
>>>
>>> Instead of putting the main thread to sleep state to wait for
>>> free compression thread, we can directly post it out as normal
>>> page that reduces the latency and uses CPUs more efficiently
>>>
>>> A parameter, compress-wait-thread, is introduced, it can be
>>> enabled if the user really wants the old behavior
>>>
>>> Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
>>> ---
>>
>>> +++ b/qapi/migration.json
>>> @@ -462,6 +462,11 @@
>>>    # @compress-threads: Set compression thread count to be used in live migration,
>>>    #          the compression thread count is an integer between 1 and 255.
>>>    #
>>> +# @compress-wait-thread: Wait if no thread is free to compress the memory page
>>> +#          if it's enabled, otherwise, the page will be posted out immediately
>>> +#          in the main thread without compression. It's true on default.
>>> +#          (Since: 3.1)
>>
>> Grammar suggestion:
>>
>> @compress-wait-thread: Controls behavior when all compression threads are
>> currently busy. If true (default), wait for a free compression thread to
>> become available; otherwise, send the page uncompressed. (Since 3.1)
> 
> Eric's version seems better.  With that:

It's good to me too. Will apply Eric's suggestion in the next version.

> 
> Reviewed-by: Peter Xu <peterx@redhat.com>

Thank you, Peter and Eric.
