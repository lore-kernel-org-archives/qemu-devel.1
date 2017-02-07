Received: from eggs.gnu.org ([2001:4830:134:3::10]:44836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1caznM-00050N-53
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 02:02:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1caznL-0005Dd-E4
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 02:02:32 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <87bmukmlau.fsf@dusky.pond.sub.org>
	<20170206132321.GB11987@noname.redhat.com>
	<877f53l4a5.fsf@dusky.pond.sub.org>
	<dfb6b59b-07b9-a3d1-66e8-8b09ec63d634@redhat.com>
	<87r33bfaso.fsf@dusky.pond.sub.org>
	<32fa6b2c-e1cb-1ac5-2707-22861e908e21@redhat.com>
Date: Tue, 07 Feb 2017 08:02:23 +0100
In-Reply-To: <32fa6b2c-e1cb-1ac5-2707-22861e908e21@redhat.com> (Paolo
	Bonzini's message of "Mon, 6 Feb 2017 22:52:21 +0100")
Message-ID: <87a89ya3gg.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] Non-flat command line option argument syntax
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 06/02/2017 19:12, Markus Armbruster wrote:
>>> QOM now supports class properties.  We can convert the wide majority of
>>> them, including qdev's "static" properties, to class properties.
>> 
>> Won't help object-add as long as dynamic properties remain.
>
> Well, only as long as dynamic properties remain necessary for classes
> that the user can create.

Correct.

>                            The main user of dynamic properties is
> children properties.

Converting dynamic properties into static ones is a good idea, because
it simplifies reasoning about properties.  I'm afraid it'll be a rather
tedious job, and only at its end we'll be able to see what dynamic
properties remain.

Making -object blind to dynamic properties is a restriction unless these
properties are of no use there.  We can't know that now.  If we get
there and know, we'll have to protect that state somehow.
