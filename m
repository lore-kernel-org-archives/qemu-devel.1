Received: from eggs.gnu.org ([2001:4830:134:3::10]:33330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1euvtF-0000aL-Gu
	for qemu-devel@nongnu.org; Sun, 11 Mar 2018 03:59:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1euvtE-0007WK-AI
	for qemu-devel@nongnu.org; Sun, 11 Mar 2018 03:59:33 -0400
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:40602)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zhangckid@gmail.com>) id 1euvtD-0007Vw-Vi
	for qemu-devel@nongnu.org; Sun, 11 Mar 2018 03:59:32 -0400
Received: by mail-wm0-x230.google.com with SMTP id t6so10625753wmt.5
	for <qemu-devel@nongnu.org>; Sat, 10 Mar 2018 23:59:31 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <0fa05445-5342-7e29-12dc-d3ac1d86ec99@redhat.com>
References: <1520716927-17068-1-git-send-email-zhangckid@gmail.com>
	<1520716927-17068-12-git-send-email-zhangckid@gmail.com>
	<0fa05445-5342-7e29-12dc-d3ac1d86ec99@redhat.com>
From: Zhang Chen <zhangckid@gmail.com>
Date: Sun, 11 Mar 2018 15:59:30 +0800
Message-ID: <CAK3tnvLtyDrYTL4MKVzjjGksJNybzaUr+6Woq016ESTsj-pJww@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH V5 11/17] qapi: Add new command to query
 colo status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Jason Wang <jasowang@redhat.com>, Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@cn.fujitsu.com>

On Sun, Mar 11, 2018 at 5:33 AM, Eric Blake <eblake@redhat.com> wrote:

> On 03/10/2018 03:22 PM, Zhang Chen wrote:
>
>> Libvirt or other high level sofware can use this command query colo
>> status.
>>
>
> s/sofware/software/


>
> You can test this command like that:
>> {'execute':'query-colo-status'}
>>
>> Signed-off-by: Zhang Chen <zhangckid@gmail.com>
>> ---
>>   migration/colo.c    | 35 +++++++++++++++++++++++++++++++++++
>>   qapi/migration.json | 35 +++++++++++++++++++++++++++++++++++
>>   2 files changed, 70 insertions(+)
>>
>>
> +++ b/qapi/migration.json
>> @@ -1201,3 +1201,38 @@
>>   # Since: 2.9
>>   ##
>>   { 'command': 'xen-colo-do-checkpoint' }
>> +
>> +##
>> +# @COLOStatus:
>> +#
>> +# The result format for 'query-colo-status'.
>> +#
>> +# @mode: which COLO mode the VM was in when it exited.
>> +#        true is primary mode, false is secondary mode.
>>
>
> Eww. Why not make this an enum ("primary", "secondary") instead of having
> to remember what true means?


>
> +#
>> +# @colo_running: if true means COLO running well, otherwise COLO have
>> done.
>>
>
> New interfaces should use '-' rather than '_' as the separator; this
> should be 'colo-running'
>
> +#
>> +# @reason: describes the reason for the COLO exit.
>> +#          true is error, false is user request.
>>
>
> Again, would an enum ("error", "user") be nicer than a bool?  It is also
> more extensible if you add a third reason down the road.
>
> +#
>> +# Since: 2.12
>> +##
>> +{ 'struct': 'COLOStatus',
>> +  'data': { 'mode': 'bool', 'colo_running': 'bool', 'reason': 'bool' } }
>> +
>> +##
>> +# @query-colo-status:
>> +#
>> +# Query COLO status while the vm is running.
>> +#
>> +# Returns: A @COLOStatus object showing the status.
>> +#
>> +# Example:
>> +#
>> +# -> { "execute": "query-colo-status" }
>> +# <- { "return": { "colo_running": "true", "mode": "true", "reason":
>> "true" } }
>>
>
> Inconsistent with your declaration above; if these are truly declared
> 'bool', then the example should be (with the spelling fix, but not fixing
> where you should have been using enums instead of bools):
>
> { "return": { "colo-running": true, "mode": true, "reason": true } }
>
> We're awfully close to soft freeze, and this is a new feature - which
> maintainer will be trying to get this polished and into the tree in time?



Maybe Paolo or David?  CC paolo and David, any comments about this series?

I have addressed all comments about this patch and sent the PATCH V6,
Thanks your comments and please review it.

Thanks
Zhang Chen




>
>
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
>
