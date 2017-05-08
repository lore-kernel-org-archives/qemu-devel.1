Received: from eggs.gnu.org ([2001:4830:134:3::10]:40702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1d7jxo-0000qa-Jt
	for qemu-devel@nongnu.org; Mon, 08 May 2017 10:48:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1d7jxm-0008Nl-1R
	for qemu-devel@nongnu.org; Mon, 08 May 2017 10:48:40 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <87a871nd7j.fsf@dusky.pond.sub.org>
References: <20170427215821.19397-1-eblake@redhat.com>
	<20170427215821.19397-7-eblake@redhat.com>
	<87a871nd7j.fsf@dusky.pond.sub.org>
Date: Mon, 08 May 2017 16:48:30 +0200
Message-ID: <w51zien1k1t.fsf@maestria.local.igalia.com>
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
To: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Alexander Graf <agraf@suse.de>, Josh Durgin <jdurgin@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Fam Zheng <famz@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, "open list:Block layer core" <qemu-block@nongnu.org>, "Richard W.M. Jones" <rjones@redhat.com>, Stefan Weil <sw@weilnetz.de>, Jeff Cody <jcody@redhat.com>, Peter Lieven <pl@kamp.de>, Max Reitz <mreitz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "open
	list:X86" <xen-devel@lists.xenproject.org>, Anthony Perard <anthony.perard@citrix.com>, Paolo Bonzini <pbonzini@redhat.com>, "Dr.
	David Alan Gilbert" <dgilbert@redhat.com>, Richard Henderson <rth@twiddle.net>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

On Fri 28 Apr 2017 10:33:36 AM CEST, Markus Armbruster wrote:
>> v5: rebase to master (Coccinelle found a couple new spots), squash 3
>> patches into 1, adjust R-b to only list Markus (while there were other
>> reviews on the pre-squashed patches, Markus was the only one on all 3)
>
> The block: part had
>
>     Acked-by: Richard W.M. Jones <rjones@redhat.com>
>     Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>     Reviewed-by: Alberto Garcia <berto@igalia.com>
>
> The tests and qobject parts had
>
>     Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>
> Richard, Stefan, Alberto, Philippe, let me know if you'd like me to
> convert your R-by of parts to an Acked-by of the combined patch.  Feel
> free to review the combined patch, of course.

You can keep my R-by, I just reviewed the combined patch.

Berto
