Received: from eggs.gnu.org ([2001:4830:134:3::10]:60482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d7zMk-0005mO-Nn
	for qemu-devel@nongnu.org; Tue, 09 May 2017 03:15:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d7zMj-0004HG-P6
	for qemu-devel@nongnu.org; Tue, 09 May 2017 03:15:26 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170427215821.19397-1-eblake@redhat.com>
	<20170427215821.19397-7-eblake@redhat.com>
	<87a871nd7j.fsf@dusky.pond.sub.org>
	<w51zien1k1t.fsf@maestria.local.igalia.com>
Date: Tue, 09 May 2017 09:14:55 +0200
In-Reply-To: <w51zien1k1t.fsf@maestria.local.igalia.com> (Alberto Garcia's
	message of "Mon, 08 May 2017 16:48:30 +0200")
Message-ID: <8737ce33io.fsf@dusky.pond.sub.org>
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
To: Alberto Garcia <berto@igalia.com>
Cc: Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Josh Durgin <jdurgin@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Fam Zheng <famz@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, "open list:Block layer core" <qemu-block@nongnu.org>, "Richard W.M.
	Jones" <rjones@redhat.com>, Stefan Weil <sw@weilnetz.de>, Jeff Cody <jcody@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Peter Lieven <pl@kamp.de>, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Anthony Perard <anthony.perard@citrix.com>, "open
	list:X86" <xen-devel@lists.xenproject.org>, Max Reitz <mreitz@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Richard Henderson <rth@twiddle.net>

Alberto Garcia <berto@igalia.com> writes:

> On Fri 28 Apr 2017 10:33:36 AM CEST, Markus Armbruster wrote:
>>> v5: rebase to master (Coccinelle found a couple new spots), squash 3
>>> patches into 1, adjust R-b to only list Markus (while there were other
>>> reviews on the pre-squashed patches, Markus was the only one on all 3)
>>
>> The block: part had
>>
>>     Acked-by: Richard W.M. Jones <rjones@redhat.com>
>>     Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>>     Reviewed-by: Alberto Garcia <berto@igalia.com>
>>
>> The tests and qobject parts had
>>
>>     Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>
>> Richard, Stefan, Alberto, Philippe, let me know if you'd like me to
>> convert your R-by of parts to an Acked-by of the combined patch.  Feel
>> free to review the combined patch, of course.
>
> You can keep my R-by, I just reviewed the combined patch.

Done.  Thanks!
