Received: from eggs.gnu.org ([2001:4830:134:3::10]:33741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1ch8Vl-0007kZ-5m
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 00:33:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1ch8Vi-0002UM-1H
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 00:33:45 -0500
Received: from [59.151.112.132] (port=56808 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1ch8Vh-0002Tc-Lg
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 00:33:41 -0500
References: <1487834070-31374-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<1487834070-31374-3-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<0f7cd737-e851-1e1f-2fe7-0ac969e0f86b@redhat.com>
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Message-ID: <0dede21e-7f2e-2231-5f65-3f5f7877557d@cn.fujitsu.com>
Date: Fri, 24 Feb 2017 13:33:01 +0800
MIME-Version: 1.0
In-Reply-To: <0f7cd737-e851-1e1f-2fe7-0ac969e0f86b@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V8 2/2] Add a new qmp command to do
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



On 02/23/2017 11:34 PM, Eric Blake wrote:
> On 02/23/2017 01:14 AM, Zhang Chen wrote:
>> We can call this qmp command to do checkpoint outside of qemu.
>> Xen colo will need this function.
>>
>> Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
>> Signed-off-by: Wen Congyang <wencongyang@gmail.com>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
> You made a substantial change to this patch since v7 in response to my
> comments; when you do that, it's best to remove the R-b to make sure I
> re-review the changes and am still happy with them.

OK, I will remove the R-b in next version.

>
>> ---
>>   migration/colo.c | 23 +++++++++++++++++++++++
>>   qapi-schema.json | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 71 insertions(+)
>>
>>   ##
>> +# @ReplicationStatus:
>> +#
>> +# The result format for 'query-xen-replication-status'.
>> +#
>> +# @status: true to error, false to normal.
> This is now a poor name for the parameter.  Please rename it; probably
> to @error (if you want to keep true meaning a problem has been
> detected), or to @okay (if you want to invert the sense, and @desc is
> only present when @okay is false).

I will rename it to "@error" in next version.

>
>> +#
>> +# @desc: #optional the human readable error description string, when
>> +#        @status is 'true'.
>> +#
>> +# Since: 2.9
>> +##
>> +{ 'struct': 'ReplicationStatus',
>> +  'data': { 'status': 'bool', '*desc': 'str' } }
>> +
>> +##
>> +# @query-xen-replication-status:
>> +#
>> +# Query replication status while the vm is running.
>> +#
>> +# Returns: A @ReplicationResult objects showing the status.
> s/objects/object/

I got it.

>
>> +#
>> +# Example:
>> +#
>> +# -> { "execute": "query-xen-replication-status" }
>> +# <- { "return": { "status": "normal" } }
> This example is now wrong.
>
> You'll need a v9.

Yes, I will send the V9 later.

Thanks
Zhang Chen

>

-- 
Thanks
Zhang Chen
