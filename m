Received: from eggs.gnu.org ([2001:4830:134:3::10]:37322)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d3HXF-0005AA-5y
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 03:38:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d3HXA-0006QU-VM
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 03:38:49 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3527
	helo=dggrg01-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d3HXA-0006OX-BL
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 03:38:44 -0400
References: <1492849558-17540-1-git-send-email-zhang.zhanghailiang@huawei.com>
	<1492849558-17540-6-git-send-email-zhang.zhanghailiang@huawei.com>
	<3333f034-0fd2-875f-fbfc-a2c0eda1f09a@redhat.com>
From: Hailiang Zhang <zhang.zhanghailiang@huawei.com>
Message-ID: <59004E6C.50000@huawei.com>
Date: Wed, 26 Apr 2017 15:38:20 +0800
MIME-Version: 1.0
In-Reply-To: <3333f034-0fd2-875f-fbfc-a2c0eda1f09a@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 05/18] COLO: Handle shutdown command for
 VM in COLO state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: lizhijian@cn.fujitsu.com, xiecl.fnst@cn.fujitsu.com, zhangchen.fnst@cn.fujitsu.com, quintela@redhat.com, Paolo Bonzini <pbonzini@redhat.com>

On 2017/4/24 22:51, Eric Blake wrote:
> On 04/22/2017 03:25 AM, zhanghailiang wrote:
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
>> +++ b/qapi-schema.json
>> @@ -1187,12 +1187,14 @@
>>   #
>>   # @vmstate-loaded: VM's state has been loaded by SVM.
>>   #
>> +# @guest-shutdown: shutdown requested from PVM to SVM. (Since 2.9)
> You missed 2.9. Please fix this to state 2.10.

OK, will fix in next version, thanks.

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
