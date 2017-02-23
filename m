Received: from eggs.gnu.org ([2001:4830:134:3::10]:51098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cgi0V-0003vU-Vm
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 20:15:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cgi0S-0001me-NX
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 20:15:43 -0500
Received: from [45.249.212.187] (port=2983 helo=dggrg01-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cgi0S-0001l7-2a
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 20:15:40 -0500
References: <1487734936-43472-1-git-send-email-zhang.zhanghailiang@huawei.com>
	<1487734936-43472-6-git-send-email-zhang.zhanghailiang@huawei.com>
	<176b99f5-34fe-460d-8f23-1bb2ee94fa3a@redhat.com>
From: Hailiang Zhang <zhang.zhanghailiang@huawei.com>
Message-ID: <58AE37A1.5080908@huawei.com>
Date: Thu, 23 Feb 2017 09:15:13 +0800
MIME-Version: 1.0
In-Reply-To: <176b99f5-34fe-460d-8f23-1bb2ee94fa3a@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 05/15] COLO: Handle shutdown command for VM
 in COLO state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, dgilbert@redhat.com, zhangchen.fnst@cn.fujitsu.com
Cc: xuquan8@huawei.com, Paolo Bonzini <pbonzini@redhat.com>, xiecl.fnst@cn.fujitsu.com, lizhijian@cn.fujitsu.com

Hi Eric,

On 2017/2/22 23:35, Eric Blake wrote:
> On 02/21/2017 09:42 PM, zhanghailiang wrote:
>> If VM is in COLO FT state, we need to do some extra works before
>> starting normal shutdown process.
>>
>> Secondary VM will ignore the shutdown command if users issue it directly
>> to Secondary VM. COLO will capture shutdown command and after
>> shutdown request from user.
>>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
>> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
>> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> ---
>> v19:
>> - fix title and comment
>
> Did you miss putting v19 in the subject line?
>

Er, some patches of this series are split from previous
v18 version, but most patches of that series has been merged
into upstream, so that's why it has a tag here.
I think it is better to remove this comment instead of using
v19 tag for this series.

>
>> +++ b/qapi-schema.json
>> @@ -1157,12 +1157,14 @@
>>   #
>>   # @vmstate-loaded: VM's state has been loaded by SVM.
>>   #
>> +# @guest-shutdown: shutdown require from PVM to SVM
>
> maybe s/require/requested/ ?
>

Yes.

> Missing '(since 2.9)'
>

Will fix this in next version, thanks.

>> +#
>>   # Since: 2.8
>>   ##
>>   { 'enum': 'COLOMessage',
>>     'data': [ 'checkpoint-ready', 'checkpoint-request', 'checkpoint-reply',
>>               'vmstate-send', 'vmstate-size', 'vmstate-received',
>> -            'vmstate-loaded' ] }
>> +            'vmstate-loaded', 'guest-shutdown' ] }
>>
>
