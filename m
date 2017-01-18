Received: from eggs.gnu.org ([2001:4830:134:3::10]:55685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cTkCj-0006np-8G
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 01:58:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cTkCi-0008CJ-I2
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 01:58:45 -0500
References: <1480926904-17596-1-git-send-email-zhang.zhanghailiang@huawei.com>
	<1480926904-17596-3-git-send-email-zhang.zhanghailiang@huawei.com>
	<082106be-a571-e98f-d1b6-a09ee36abb57@redhat.com>
From: Hailiang Zhang <zhang.zhanghailiang@huawei.com>
Message-ID: <587F1209.8030906@huawei.com>
Date: Wed, 18 Jan 2017 14:58:17 +0800
MIME-Version: 1.0
In-Reply-To: <082106be-a571-e98f-d1b6-a09ee36abb57@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC v2 2/6] replication: add shared-disk
 and shared-disk-id options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: xuquan8@huawei.com, kwolf@redhat.com, xiecl.fnst@cn.fujitsu.com, Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, wency@cn.fujitsu.com, mreitz@redhat.com, stefanha@redhat.com, pbonzini@redhat.com

On 2016/12/6 0:22, Eric Blake wrote:
> On 12/05/2016 02:35 AM, zhanghailiang wrote:
>> We use these two options to identify which disk is
>> shared
>>
>> Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
>> Signed-off-by: Wen Congyang <wency@cn.fujitsu.com>
>> Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
>> ---
>> v2:
>> - add these two options for BlockdevOptionsReplication to support
>>    qmp blockdev-add command.
>> - fix a memory leak found by Changlong
>> ---
>
>> +++ b/qapi/block-core.json
>> @@ -2232,12 +2232,19 @@
>>   #          node who owns the replication node chain. Must not be given in
>>   #          primary mode.
>>   #
>> +# @shared-disk-id: #optional The id of shared disk while in replication mode.
>> +#
>> +# @shared-disk: #optional To indicate whether or not a disk is shared by
>> +#               primary VM and secondary VM.
>
> Both of these need a '(since 2.9)' designation since they've missed 2.8,
> and could probably also use documentation on the default value assumed
> when the parameter is omitted.
>

OK, i will add it in next version, thanks.

>> +#
>>   # Since: 2.8
>>   ##
>>   { 'struct': 'BlockdevOptionsReplication',
>>     'base': 'BlockdevOptionsGenericFormat',
>>     'data': { 'mode': 'ReplicationMode',
>> -            '*top-id': 'str' } }
>> +            '*top-id': 'str',
>> +            '*shared-disk-id': 'str',
>> +            '*shared-disk': 'bool' } }
>>
>>   ##
>>   # @NFSTransport
>>
>
