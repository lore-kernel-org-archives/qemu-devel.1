Received: from eggs.gnu.org ([2001:4830:134:3::10]:57255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d5adg-0006RE-Oc
	for qemu-devel@nongnu.org; Tue, 02 May 2017 12:27:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d5adf-0007kY-Oy
	for qemu-devel@nongnu.org; Tue, 02 May 2017 12:27:00 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170427215821.19397-1-eblake@redhat.com>
	<20170427215821.19397-7-eblake@redhat.com>
	<87a871nd7j.fsf@dusky.pond.sub.org>
	<20170502155620.GB26628@stefanha-x1.localdomain>
Date: Tue, 02 May 2017 18:26:44 +0200
In-Reply-To: <20170502155620.GB26628@stefanha-x1.localdomain> (Stefan
	Hajnoczi's message of "Tue, 2 May 2017 16:56:20 +0100")
Message-ID: <87bmrbcji3.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 06/10] qobject: Use simpler QDict/QList
 scalar insertion macros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Gerd Hoffmann <kraxel@redhat.com>, Josh Durgin <jdurgin@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Alberto Garcia <berto@igalia.com>, "open list:Block layer core" <qemu-block@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, Anthony Perard <anthony.perard@citrix.com>, "open list:X86" <xen-devel@lists.xenproject.org>, Fam Zheng <famz@redhat.com>, Stefan Weil <sw@weilnetz.de>, Peter Lieven <pl@kamp.de>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>, Alexander Graf <agraf@suse.de>, "Richard W.M. Jones" <rjones@redhat.com>, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Stefan Hajnoczi <stefanha@redhat.com> writes:

> On Fri, Apr 28, 2017 at 10:33:36AM +0200, Markus Armbruster wrote:
>> Eric Blake <eblake@redhat.com> writes:
>>=20
>> > We now have macros in place to make it less verbose to add a scalar
>> > to QDict and QList, so use them.  To make this patch smaller to
>> > review, a couple of subdirectories were done in earlier patches.
>>=20
>> Scratch the last sentence.  Can do on commit.
>>=20
>> > Patch created mechanically via:
>> >   spatch --sp-file scripts/coccinelle/qobject.cocci \
>> >     --macro-file scripts/cocci-macro-file.h --dir . --in-place
>> > then touched up manually to fix a couple of '?:' back to original
>> > spacing, as well as avoiding a long line in monitor.c.
>> >
>> > Signed-off-by: Eric Blake <eblake@redhat.com>
>> > Reviewed-by: Markus Armbruster <armbru@redhat.com>
>> >
>> > ---
>> > v5: rebase to master (Coccinelle found a couple new spots), squash 3
>> > patches into 1, adjust R-b to only list Markus (while there were other
>> > reviews on the pre-squashed patches, Markus was the only one on all 3)
>>=20
>> The block: part had
>>=20
>>     Acked-by: Richard W.M. Jones <rjones@redhat.com>
>>     Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>>     Reviewed-by: Alberto Garcia <berto@igalia.com>
>>=20
>> The tests and qobject parts had
>>=20
>>     Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>=20
>> Richard, Stefan, Alberto, Philippe, let me know if you'd like me to
>> convert your R-by of parts to an Acked-by of the combined patch.  Feel
>> free to review the combined patch, of course.
>
> Please keep my R-by, I have reviewed again.

Gladly.  Thanks!
