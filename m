Received: from eggs.gnu.org ([2001:4830:134:3::10]:50894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1chSBP-0005Xf-R5
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 21:34:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1chSBM-0007gR-OE
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 21:34:03 -0500
Received: from [59.151.112.132] (port=10359 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1chSBM-0007dr-Cf
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 21:34:00 -0500
References: <1487920971-16519-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<1487920971-16519-3-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<1d6cbd92-1699-3d11-7a24-63e888bb0e29@redhat.com>
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Message-ID: <2b97f1bf-47d1-4396-b49c-0c26be149757@cn.fujitsu.com>
Date: Sat, 25 Feb 2017 10:33:18 +0800
MIME-Version: 1.0
In-Reply-To: <1d6cbd92-1699-3d11-7a24-63e888bb0e29@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V9 2/2] Add a new qmp command to do
 checkpoint, query xen replication status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu devel <qemu-devel@nongnu.org>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Markus Armbruster <armbru@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>
Cc: zhangchen.fnst@cn.fujitsu.com, Jason Wang <jasowang@redhat.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, "eddie . dong" <eddie.dong@intel.com>, bian naimeng <biannm@cn.fujitsu.com>, Wen Congyang <wencongyang@gmail.com>



On 02/25/2017 01:27 AM, Eric Blake wrote:
> On 02/24/2017 01:22 AM, Zhang Chen wrote:
>> We can call this qmp command to do checkpoint outside of qemu.
>> Xen colo will need this function.
>>
>> Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
>> Signed-off-by: Wen Congyang <wencongyang@gmail.com>
>> ---
>>   migration/colo.c | 23 +++++++++++++++++++++++
>>   qapi-schema.json | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 72 insertions(+)
>>
>> +++ b/qapi-schema.json
>> @@ -5931,6 +5931,55 @@
>>     'data': { 'enable': 'bool', 'primary': 'bool', '*failover' : 'bool' } }
>>   
>>   ##
>> +# @ReplicationStatus:
>> +#
>> +# The result format for 'query-xen-replication-status'.
>> +#
>> +# @error: true to error, false to normal.
> Maybe:
>
> true if an error happened, false if replication is normal
>
> Maintainer could touch that up during application, so it doesn't
> necessarily require a v10.

Maintainer may be very busy, I will do this fix in V10.

>
>> +##
>> +# @query-xen-replication-status:
>> +#
>> +# Query replication status while the vm is running.
>> +#
>> +# Returns: A @ReplicationResult object showing the status.
>> +#
>> +# Example:
>> +#
>> +# -> { "execute": "query-xen-replication-status" }
>> +# <- { "return": [ { "error": false },
>> +#                  { "error": true } ] }
> This example is bogus.  The command does NOT return an array.  It is
> sufficient to use:
>
> { "return": { "error": false } }
>
> but if you want, you could instead do:
>
> { "return": { "error": true, "desc": "..." } }
>
> but if you do that, please be sure that desc matches an actual error
> code that could occur, and not something made up.
>
> If all you do is fix the example with the simpler "error":false (and
> maybe the maintainer is okay doing that), then you can add:
> Reviewed-by: Eric Blake <eblake@redhat.com>

I will fix the example in V10, and which maintainer can pick up this patch?

Thanks
Zhang Chen


-- 
Thanks
Zhang Chen
