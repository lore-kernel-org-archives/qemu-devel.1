Received: from eggs.gnu.org ([2001:4830:134:3::10]:45856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1d5aAG-000538-By
	for qemu-devel@nongnu.org; Tue, 02 May 2017 11:56:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1d5aAF-0004DX-Ho
	for qemu-devel@nongnu.org; Tue, 02 May 2017 11:56:36 -0400
Date: Tue, 2 May 2017 16:56:20 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170502155620.GB26628@stefanha-x1.localdomain>
References: <20170427215821.19397-1-eblake@redhat.com>
	<20170427215821.19397-7-eblake@redhat.com>
	<87a871nd7j.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aM3YZ0Iwxop3KEKx"
Content-Disposition: inline
In-Reply-To: <87a871nd7j.fsf@dusky.pond.sub.org>
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
To: Markus Armbruster <armbru@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Alexander Graf <agraf@suse.de>, Josh Durgin <jdurgin@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Fam Zheng <famz@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, "open list:Block layer core" <qemu-block@nongnu.org>, "Richard W.M. Jones" <rjones@redhat.com>, Stefan Weil <sw@weilnetz.de>, Jeff Cody <jcody@redhat.com>, Peter Lieven <pl@kamp.de>, Max Reitz <mreitz@redhat.com>, Alberto Garcia <berto@igalia.com>, Gerd Hoffmann <kraxel@redhat.com>, "open list:X86" <xen-devel@lists.xenproject.org>, Anthony Perard <anthony.perard@citrix.com>, Paolo Bonzini <pbonzini@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Richard Henderson <rth@twiddle.net>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>


--aM3YZ0Iwxop3KEKx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 28, 2017 at 10:33:36AM +0200, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
>=20
> > We now have macros in place to make it less verbose to add a scalar
> > to QDict and QList, so use them.  To make this patch smaller to
> > review, a couple of subdirectories were done in earlier patches.
>=20
> Scratch the last sentence.  Can do on commit.
>=20
> > Patch created mechanically via:
> >   spatch --sp-file scripts/coccinelle/qobject.cocci \
> >     --macro-file scripts/cocci-macro-file.h --dir . --in-place
> > then touched up manually to fix a couple of '?:' back to original
> > spacing, as well as avoiding a long line in monitor.c.
> >
> > Signed-off-by: Eric Blake <eblake@redhat.com>
> > Reviewed-by: Markus Armbruster <armbru@redhat.com>
> >
> > ---
> > v5: rebase to master (Coccinelle found a couple new spots), squash 3
> > patches into 1, adjust R-b to only list Markus (while there were other
> > reviews on the pre-squashed patches, Markus was the only one on all 3)
>=20
> The block: part had
>=20
>     Acked-by: Richard W.M. Jones <rjones@redhat.com>
>     Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>     Reviewed-by: Alberto Garcia <berto@igalia.com>
>=20
> The tests and qobject parts had
>=20
>     Reviewed-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
>=20
> Richard, Stefan, Alberto, Philippe, let me know if you'd like me to
> convert your R-by of parts to an Acked-by of the combined patch.  Feel
> free to review the combined patch, of course.

Please keep my R-by, I have reviewed again.

--aM3YZ0Iwxop3KEKx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZCKwkAAoJEJykq7OBq3PIX8kIAKf/G8wxa6w+mSYZhC4RbqYn
gOJoa0nOyxI+B7IUyfGVS1AXd5VRlxoGGlIvelPIrusdIb0RXrp4BZBX+pvgWcEE
RPCMotSVQb0ZfM00OThoaLjQudRNhdM00/ZLpFm7aJmDHOnqdhKg5ccU3KE/GAoZ
kzAWy23gNmhIJ7DYXL/8Q7rVWAm09CuI8FUIRyqMUHpONB+SbqnjPpV58BhkW8nM
GKd4tKlCkW4xCXy10/N1EhoFYaBn7ZsrJL3oF+kiEBmyzo/0M6R8Cr3DQLAW1K9h
vQFDEVkkXIV5OpIYDRJhunW/JC5Yb3nNdTZbCE+bDJT61NJ4xwyRvaw5/M7iQh8=
=jsgW
-----END PGP SIGNATURE-----

--aM3YZ0Iwxop3KEKx--
