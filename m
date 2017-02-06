Received: from eggs.gnu.org ([2001:4830:134:3::10]:57116)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1canmT-0001im-DE
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 13:12:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1canmS-0004Fr-DM
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 13:12:49 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <87bmukmlau.fsf@dusky.pond.sub.org>
	<20170206132321.GB11987@noname.redhat.com>
	<877f53l4a5.fsf@dusky.pond.sub.org>
	<dfb6b59b-07b9-a3d1-66e8-8b09ec63d634@redhat.com>
Date: Mon, 06 Feb 2017 19:12:39 +0100
In-Reply-To: <dfb6b59b-07b9-a3d1-66e8-8b09ec63d634@redhat.com> (Paolo
	Bonzini's message of "Mon, 6 Feb 2017 18:38:43 +0100")
Message-ID: <87r33bfaso.fsf@dusky.pond.sub.org>
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

> On 06/02/2017 16:36, Markus Armbruster wrote:
>> Example: QOM properties and object-add, qom-set, qom-get
>> 
>> QOM properties are created at run-time.  They cannot be fixed at
>> compile-time *by design*.  I always hated that part of the design, but I
>> was assured we absolutely need that much rope^Wflexibility.
>
> QOM now supports class properties.  We can convert the wide majority of
> them, including qdev's "static" properties, to class properties.

Won't help object-add as long as dynamic properties remain.  I'd welcome
such a conversion anyway.
