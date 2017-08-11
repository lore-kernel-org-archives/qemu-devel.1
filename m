Received: from eggs.gnu.org ([2001:4830:134:3::10]:40656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dg3JS-00087Y-KH
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 02:20:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dg3JP-0006Nc-Fs
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 02:20:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35812)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dg3JP-0006NG-AD
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 02:20:47 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1502367921-17730-1-git-send-email-armbru@redhat.com>
	<1502367921-17730-3-git-send-email-armbru@redhat.com>
	<b0769260-8342-8a90-8a1e-d6545e0c64a1@redhat.com>
	<87efsj8jn5.fsf@dusky.pond.sub.org>
	<e373532b-3c09-f893-1e9a-e40e4e82866a@redhat.com>
Date: Fri, 11 Aug 2017 08:20:44 +0200
In-Reply-To: <e373532b-3c09-f893-1e9a-e40e4e82866a@redhat.com> (Paolo
	Bonzini's message of "Thu, 10 Aug 2017 18:38:32 +0200")
Message-ID: <874lte62wz.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 2/2] vl: Partial support for non-scalar
 properties with -object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, el13635@mail.ntua.gr

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 10/08/2017 18:36, Markus Armbruster wrote:
>>>> +    while (!QSIMPLEQ_EMPTY(&oo_queue)) {
>>>> +        ObjectOptionsQueueEntry *e = QSIMPLEQ_FIRST(&oo_queue);
>>>> +
>>>> +        QSIMPLEQ_REMOVE_HEAD(&oo_queue, entry);
>>>> +        qapi_free_ObjectOptions(e->oo);
>>>> +        g_free(e);
>>>> +    }
>>> Why not free the queue entry in object_create, and assert here that it's
>>> empty?
>> 
>> Assumes object_create_delayed(TYPE) == !object_create_initial(TYPE),
>> which is the case.  Fewer assumptions is good.  Less code is also good.
>> Pick your goodness, please :)
>
> I think the assumption is not that object_create_delayed(TYPE) ==
> !object_create_initial(TYPE), but rather that all -object options are
> dealt with (and they shouldn't be dealt more than once).  It's a
> reasonable assumption, methinks. :)

Okay.
