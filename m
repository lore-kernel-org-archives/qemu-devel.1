Received: from eggs.gnu.org ([2001:4830:134:3::10]:56394)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1fS4M1-000067-FA
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 13:42:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1fS4M0-000284-6G
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 13:42:13 -0400
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:37697)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zhangckid@gmail.com>) id 1fS4Lz-00027N-SH
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 13:42:12 -0400
Received: by mail-wr0-x236.google.com with SMTP id d8-v6so18018816wro.4
	for <qemu-devel@nongnu.org>; Sun, 10 Jun 2018 10:42:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <8ed3dcba-d574-7b08-9f82-4e8d61c2245c@redhat.com>
References: <20180603050546.6827-1-zhangckid@gmail.com>
	<20180603050546.6827-12-zhangckid@gmail.com>
	<8ed3dcba-d574-7b08-9f82-4e8d61c2245c@redhat.com>
From: Zhang Chen <zhangckid@gmail.com>
Date: Mon, 11 Jun 2018 01:42:10 +0800
Message-ID: <CAK3tnv+2U8hi=i1=dZCH162WijRiUF_BtoWfP+039L+trbuaRQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH V8 11/17] qapi: Add new command to query
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
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Jason Wang <jasowang@redhat.com>, Markus Armbruster <armbru@redhat.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Li Zhijian <lizhijian@cn.fujitsu.com>

On Tue, Jun 5, 2018 at 6:23 AM, Eric Blake <eblake@redhat.com> wrote:

> On 06/03/2018 12:05 AM, Zhang Chen wrote:
>
>> Libvirt or other high level software can use this command query colo
>> status.
>> You can test this command like that:
>> {'execute':'query-colo-status'}
>>
>> Signed-off-by: Zhang Chen <zhangckid@gmail.com>
>> ---
>>
>
> +++ b/qapi/migration.json
>> @@ -1231,6 +1231,40 @@
>>   ##
>>   { 'command': 'xen-colo-do-checkpoint' }
>>   +##
>> +# @COLOStatus:
>> +#
>> +# The result format for 'query-colo-status'.
>> +#
>> +# @mode: COLO running mode. If COLO is running, this field will return
>> +#        'primary' or 'secodary'.
>>
>
> s/secodary/secondary/
>
> +#
>> +# @colo-running: true if COLO is running.
>> +#
>> +# @reason: describes the reason for the COLO exit.
>> +#
>> +# Since: 2.13
>>
>
> 3.0
>
> +##
>> +{ 'struct': 'COLOStatus',
>> +  'data': { 'mode': 'COLOMode', 'colo-running': 'bool', 'reason':
>> 'COLOExitReason' } }
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
>> +# <- { "return": { "mode": "primary", "colo-running": true, "reason":
>> "request" } }
>> +#
>> +# Since: 2.13
>>
>
> 3.0


Oh, I can't see the new Qemu plan...

Thank you for the reminder.
Zhang Chen



>
>
> +##
>> +{ 'command': 'query-colo-status',
>> +  'returns': 'COLOStatus' }
>> +
>>   ##
>>   # @migrate-recover:
>>   #
>>
>>
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
>
