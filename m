Received: from eggs.gnu.org ([2001:4830:134:3::10]:46565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dUl2v-0001wl-0M
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 22:37:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dUl2t-0007W3-T7
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 22:37:04 -0400
References: <1499674503-21551-1-git-send-email-kchamart@redhat.com>
	<1499674503-21551-2-git-send-email-kchamart@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <251c3898-8d5f-a799-318e-5ab0545220a3@redhat.com>
Date: Mon, 10 Jul 2017 21:36:50 -0500
MIME-Version: 1.0
In-Reply-To: <1499674503-21551-2-git-send-email-kchamart@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="4oL5GAmV3LStj5qSMHfInicluOBETkFn2"
Subject: Re: [Qemu-devel] [PATCH v6 1/2] bitmaps.md: Convert to rST;
 move it into 'interop' dir
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kashyap Chamarthy <kchamart@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, jsnow@redhat.com, berto@igalia.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4oL5GAmV3LStj5qSMHfInicluOBETkFn2
From: Eric Blake <eblake@redhat.com>
To: Kashyap Chamarthy <kchamart@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com,
 jsnow@redhat.com, berto@igalia.com
Message-ID: <251c3898-8d5f-a799-318e-5ab0545220a3@redhat.com>
Subject: Re: [PATCH v6 1/2] bitmaps.md: Convert to rST; move it into 'interop'
 dir
References: <1499674503-21551-1-git-send-email-kchamart@redhat.com>
 <1499674503-21551-2-git-send-email-kchamart@redhat.com>
In-Reply-To: <1499674503-21551-2-git-send-email-kchamart@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/10/2017 03:15 AM, Kashyap Chamarthy wrote:
> This is part of the on-going effort to convert QEMU upstream
> documentation syntax to reStructuredText (rST).
>=20
> The conversion to rST was done using:
>=20
>     $ pandoc -f markdown -t rst bitmaps.md -o bitmaps.rst
>=20
> Then, make a couple of small syntactical adjustments.  While at it,
> reword a statement to avoid ambiguity.  Addressing the feedback from
> this thread:
>=20
>     https://lists.nongnu.org/archive/html/qemu-devel/2017-06/msg05428.h=
tml
>=20
> Signed-off-by: Kashyap Chamarthy <kchamart@redhat.com>
> Reviewed-by: John Snow <jsnow@redhat.com>
> ---

> ---
>  docs/devel/bitmaps.md    | 505 ---------------------------------------=
---
>  docs/interop/bitmaps.rst | 555 +++++++++++++++++++++++++++++++++++++++=
++++++++

A shame that git rename detection doesn't see these as the same rough
contents, but not too bad. I'll just review the new text; if I point out
something that was pre-existing in the old text, it may be nicer to
split the cleanups into a separate followup patch, but I'm also okay if
they go in as part of this patch.

My review is less focused on the choices used in representing things in
rST and on the final display outcome, and more on the text itself
(grammar and such).

> +++ b/docs/interop/bitmaps.rst
> +
> +-  Dirty bitmaps can be created at any time and attached to any node
> +   (not just complete drives.)

Looks a bit nicer with '.' outside the sub-sentence '()'.

> +
> +.. contents::
> +
> +Dirty Bitmap Names
> +------------------
> +
> +-  A dirty bitmap's name is unique to the node, but bitmaps attached t=
o
> +   different nodes can share the same name.
> +
> +-  Dirty bitmaps created for internal use by QEMU may be anonymous and=

> +   have no name, but any user-created bitmaps may not be. There can be=


s/may not be/must have a name/


> +
> +-  This bitmap will have a default granularity that matches the cluste=
r
> +   size of its associated drive, if available, clamped to between [4Ki=
B,

s/clamped to/clamped/

> +   64KiB]. The current default for qcow2 is 64KiB.
> +
> +


> +-  QMP example response, highlighting one success and one failure:
> +
> +   -  Acknowledgement that the Transaction was accepted and jobs were
> +      launched:

US spelling prefers Acknowledgment, but I think you are okay because of
UK spelling.

Again, since these are probably pre-existing and just code motion, and
if you've gotten positive review of your use of rST, I'm fine with adding=
:

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--4oL5GAmV3LStj5qSMHfInicluOBETkFn2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZZDnCAAoJEKeha0olJ0Nq7RMH/0R3s/By8HvlPzFm9cox2/HU
g1G7fghFM6Wi8S76kuqUClxurRxQff2Bst2GkiQ60QnRZ776nAHUuKrAoMtuEz5V
EYj/Fbxf53ABZZmsCp39rwmEbV4VSSjY15XA7La7otetZYdQMUlxd0aNEAkS/dwz
UHDuiFBmSK2RLqG+lD0iYm05ZPmkcuzB2MTFeMzLO7CPvZbKi6yaWKLhSZ129U3Y
+VXARYd8GejqzhdYudbMGTiS1ElC80c3SY6avDov/Xht8UBsUmTzbw6Miu1uG2VL
NdffbRYgIOcSzUSaxYg6KatBSX4+G4FScECKip5xXBGdDDzezmvh2agngUhNSFw=
=6pyG
-----END PGP SIGNATURE-----

--4oL5GAmV3LStj5qSMHfInicluOBETkFn2--
