Received: from eggs.gnu.org ([2001:4830:134:3::10]:44948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fhrvr-0006s2-CJ
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 03:40:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fhrvo-0008J2-1U
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 03:40:31 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:45387)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1fhrvn-0008Il-LO
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 03:40:27 -0400
Received: by mail-pf1-x444.google.com with SMTP id i26-v6so646241pfo.12
	for <qemu-devel@nongnu.org>; Tue, 24 Jul 2018 00:40:27 -0700 (PDT)
References: <20180719121520.30026-1-xiaoguangrong@tencent.com>
	<20180719121520.30026-2-xiaoguangrong@tencent.com>
	<2ad95481-76bd-22ec-4d79-aa39c950db56@redhat.com>
From: Xiao Guangrong <guangrong.xiao@gmail.com>
Message-ID: <6a4d48c6-edae-36bf-e8e8-853ed02ee805@gmail.com>
Date: Tue, 24 Jul 2018 15:40:18 +0800
MIME-Version: 1.0
In-Reply-To: <2ad95481-76bd-22ec-4d79-aa39c950db56@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 1/8] migration: do not wait for free
 thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, dgilbert@redhat.com, peterx@redhat.com, wei.w.wang@intel.com, jiang.biao2@zte.com.cn, Xiao Guangrong <xiaoguangrong@tencent.com>



On 07/24/2018 02:36 AM, Eric Blake wrote:
> On 07/19/2018 07:15 AM, guangrong.xiao@gmail.com wrote:
>> From: Xiao Guangrong <xiaoguangrong@tencent.com>
>>
>> Instead of putting the main thread to sleep state to wait for
>> free compression thread, we can directly post it out as normal
>> page that reduces the latency and uses CPUs more efficiently
>>
>> A parameter, compress-wait-thread, is introduced, it can be
>> enabled if the user really wants the old behavior
>>
>> Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
>> ---
>>   hmp.c                 |  8 ++++++++
>>   migration/migration.c | 21 +++++++++++++++++++++
>>   migration/migration.h |  1 +
>>   migration/ram.c       | 45 ++++++++++++++++++++++++++-------------------
>>   qapi/migration.json   | 23 ++++++++++++++++++-----
>>   5 files changed, 74 insertions(+), 24 deletions(-)
>>
> 
>> +++ b/qapi/migration.json
>> @@ -462,6 +462,11 @@
>>   # @compress-threads: Set compression thread count to be used in live migration,
>>   #          the compression thread count is an integer between 1 and 255.
>>   #
>> +# @compress-wait-thread: Wait if no thread is free to compress the memory page
>> +#          if it's enabled, otherwise, the page will be posted out immediately
>> +#          in the main thread without compression. It's off on default.
>> +#          (Since: 3.0)
> 
> Is this a bug fix? It's awfully late in the release cycle to be adding new features; is this something that we can live without until 3.1?
> 

It's performance improvement, i think it is not urgent. :)
