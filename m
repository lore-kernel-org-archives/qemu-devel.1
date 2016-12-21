Received: from eggs.gnu.org ([2001:4830:134:3::10]:52505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cJap6-0005kv-Sm
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 01:56:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cJap3-00065C-Qz
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 01:56:24 -0500
Received: from [59.151.112.132] (port=44884 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cJap2-000635-T9
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 01:56:21 -0500
References: <1481856403-23599-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<1481856403-23599-3-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<7b040d96-15b8-4102-432f-0fb5c3454d79@redhat.com>
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Message-ID: <0b0990d4-4040-3a51-1790-edce9a31a8d3@cn.fujitsu.com>
Date: Wed, 21 Dec 2016 14:56:19 +0800
MIME-Version: 1.0
In-Reply-To: <7b040d96-15b8-4102-432f-0fb5c3454d79@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.9 V4 2/2] Add a new qmp command to do
 checkpoint, get replication error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu devel <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>
Cc: Li Zhijian <lizhijian@cn.fujitsu.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, "eddie . dong" <eddie.dong@intel.com>, Bian Naimeng <biannm@cn.fujitsu.com>, Changlong Xie <xiecl.fnst@cn.fujitsu.com>, Wen Congyang <wencongyang@gmail.com>



On 12/20/2016 10:42 PM, Eric Blake wrote:
> On 12/15/2016 08:46 PM, Zhang Chen wrote:
>> We can call this qmp command to do checkpoint outside of qemu.
>> Like Xen colo need this function.
>>
>> Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
>> Signed-off-by: Wen Congyang <wencongyang@gmail.com>
>> ---
>>   docs/qmp-commands.txt | 24 ++++++++++++++++++++++++
>>   migration/colo.c      | 10 ++++++++++
>>   qapi-schema.json      | 22 ++++++++++++++++++++++
>>   3 files changed, 56 insertions(+)
>>
>>   
>> +void qmp_xen_get_replication_error(Error **errp)
>> +    {
>> +        replication_get_error_all(errp);
>> +    }
> Is this trying to cause a replication error, or is it trying to collect
> status on whether an error has occurred? The name 'get' usually implies
> a query that does not change state, but a query usually needs some way
> to return what was queried back to the user, so a void function with no
> parameters other than error is odd (either the command succeeds because
> there was no error, or the command fails with an error message because
> the query had something to get?).

Make sense, this command trying to collect status on whether
an error has occurred, and the "replication_get_error_all(errp)"
is always succeeds. So, Can you suggest to me the right name?


>
>
>> +++ b/qapi-schema.json
>> @@ -4695,6 +4695,28 @@
>>     'data': { 'enable': 'bool', 'primary': 'bool', '*failover' : 'bool' } }
>>   
>>   ##
>> +# @xen-get-replication-error
>> +#
>> +# Get replication error that occurs when the vm is running.
>> +#
>> +# Returns: nothing.
>> +#
>> +# Since: 2.9
>> +##
>> +{ 'command': 'xen-get-replication-error' }
> So I don't think this is the right name for its signature, but I don't
> know what you are trying to accomplish with this command to suggest the
> right name.

This interface is called to check if error happened in replication.

Thanks
Zhang Chen


>> +
>> +##
>> +# @xen-do-checkpoint
>> +#
>> +# Do checkpoint.
>> +#
>> +# Returns: nothing.
>> +#
>> +# Since: 2.9
>> +##
>> +{ 'command': 'xen-do-checkpoint' }
> This one is probably okay.
>
>

-- 
Thanks
Zhang Chen
