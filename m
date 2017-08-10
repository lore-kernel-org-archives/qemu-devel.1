Received: from eggs.gnu.org ([2001:4830:134:3::10]:60264)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dfqTp-0001Pb-Ob
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 12:38:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dfqTk-0007Lf-Su
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 12:38:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35150)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dfqTk-0007LT-Lj
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 12:38:36 -0400
References: <1502367921-17730-1-git-send-email-armbru@redhat.com>
	<1502367921-17730-3-git-send-email-armbru@redhat.com>
	<b0769260-8342-8a90-8a1e-d6545e0c64a1@redhat.com>
	<87efsj8jn5.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e373532b-3c09-f893-1e9a-e40e4e82866a@redhat.com>
Date: Thu, 10 Aug 2017 18:38:32 +0200
MIME-Version: 1.0
In-Reply-To: <87efsj8jn5.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, el13635@mail.ntua.gr

On 10/08/2017 18:36, Markus Armbruster wrote:
>>> +    while (!QSIMPLEQ_EMPTY(&oo_queue)) {
>>> +        ObjectOptionsQueueEntry *e = QSIMPLEQ_FIRST(&oo_queue);
>>> +
>>> +        QSIMPLEQ_REMOVE_HEAD(&oo_queue, entry);
>>> +        qapi_free_ObjectOptions(e->oo);
>>> +        g_free(e);
>>> +    }
>> Why not free the queue entry in object_create, and assert here that it's
>> empty?
> 
> Assumes object_create_delayed(TYPE) == !object_create_initial(TYPE),
> which is the case.  Fewer assumptions is good.  Less code is also good.
> Pick your goodness, please :)

I think the assumption is not that object_create_delayed(TYPE) ==
!object_create_initial(TYPE), but rather that all -object options are
dealt with (and they shouldn't be dealt more than once).  It's a
reasonable assumption, methinks. :)

Paolo
