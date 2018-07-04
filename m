Received: from eggs.gnu.org ([2001:4830:134:3::10]:42139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faiwc-0006L6-SJ
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 10:39:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faiwZ-0003CU-Lv
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 10:39:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58418 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1faiwZ-0003CB-HA
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 10:39:43 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180627204136.4177-1-zhangckid@gmail.com>
	<20180627204136.4177-13-zhangckid@gmail.com>
	<87po04d18b.fsf@dusky.pond.sub.org>
	<CAK3tnvJECLWx3H8wBTax+jEiObcq9gX0X8oqx94zXfY0jqbjbA@mail.gmail.com>
Date: Wed, 04 Jul 2018 16:39:41 +0200
In-Reply-To: <CAK3tnvJECLWx3H8wBTax+jEiObcq9gX0X8oqx94zXfY0jqbjbA@mail.gmail.com>
	(Zhang Chen's message of "Wed, 4 Jul 2018 20:25:54 +0800")
Message-ID: <87muv7f4k2.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH V9 12/20] qapi: Add new command to query
 colo status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Chen <zhangckid@gmail.com>
Cc: zhanghailiang <zhang.zhanghailiang@huawei.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Juan Quintela <quintela@redhat.com>, Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Zhang Chen <zhangckid@gmail.com> writes:

> On Tue, Jul 3, 2018 at 7:09 PM, Markus Armbruster <armbru@redhat.com> wrote:
>
>> Zhang Chen <zhangckid@gmail.com> writes:
>>
>> > Libvirt or other high level software can use this command query colo
>> status.
>> > You can test this command like that:
>> > {'execute':'query-colo-status'}
>> >
>> > Signed-off-by: Zhang Chen <zhangckid@gmail.com>
[...]
>> > diff --git a/qapi/migration.json b/qapi/migration.json
>> > index c24f114104..73c64686ec 100644
>> > --- a/qapi/migration.json
>> > +++ b/qapi/migration.json
>> > @@ -1248,6 +1248,40 @@
>> >  ##
>> >  { 'command': 'xen-colo-do-checkpoint' }
>> >
>> > +##
>> > +# @COLOStatus:
>> > +#
>> > +# The result format for 'query-colo-status'.
>> > +#
>> > +# @mode: COLO running mode. If COLO is running, this field will return
>> > +#        'primary' or 'secondary'.
>>
>> Please mention that @mode is "none" when COLO is not running.
>>
>
> OK.
>
>
>>
>> > +#
>> > +# @active: true if COLO is active.
>>
>> Please use consistent terminology: pick one of "COLO is running", "COLO
>> is active" and stick to it.  v8 had that here, v9 regressed.  Also use
>> this wording for the comment improvement I requested for PATCH 11.
>>
>> However, isn't @active redundant with @mode?
>>
>>
> I re-think about this and review the codes.
> The 'none' mode can cover this field, I will remove the @active in next
> version.

I like it.

> By the way, can you review the diagram patch as your comments?
> (have some action not related to qmp, so I just drew a general diagram.)

I need to find some time for it.  Do not hold the series until I do.
