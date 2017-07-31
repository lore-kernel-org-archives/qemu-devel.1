Received: from eggs.gnu.org ([2001:4830:134:3::10]:60608)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dc596-0004yy-T3
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 03:29:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dc596-0008O7-3l
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 03:29:44 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170725211523.3998-1-eblake@redhat.com>
	<20170725211523.3998-10-eblake@redhat.com>
	<20170728130538.GQ12364@stefanha-x1.localdomain>
	<3c27944c-bb18-a501-39b5-139059a4aa85@redhat.com>
	<307cae51-da45-4968-f6c9-4fa1ad4b22f8@redhat.com>
Date: Mon, 31 Jul 2017 09:29:35 +0200
In-Reply-To: <307cae51-da45-4968-f6c9-4fa1ad4b22f8@redhat.com> (Eric Blake's
	message of "Fri, 28 Jul 2017 11:37:25 -0500")
Message-ID: <878tj5awtc.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 09/12] tests/libqos/pci: Clean up string
 interpolation into QMP input
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, stefanha@redhat.com, qemu-devel@nongnu.org, "open list:virtio-blk" <qemu-block@nongnu.org>

Eric Blake <eblake@redhat.com> writes:

> On 07/28/2017 11:35 AM, Eric Blake wrote:
>>>> +    QObject *extra_args = qobject_from_jsonf("{ 'shm': '%s', 'size': '1M' }",
>>>> +                                             tmpshm);
>>>
>
>> Passing '%s' through qobject_from_jsonf() is generally wrong (it would
>> produce ''...'' instead of the intended '...').
>> 
>> Looks like something to fix on the next round.
>> 
>
> What's scary is that the testsuite didn't start failing.  That's not
> good; we'll want to figure out why the bug didn't impact the test.

Good idea.
