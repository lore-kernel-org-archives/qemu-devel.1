Received: from eggs.gnu.org ([2001:4830:134:3::10]:45790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cYChS-0001K7-DX
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 09:12:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cYChO-00086p-FY
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 09:12:54 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:32835)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cYChO-000859-95
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 09:12:50 -0500
Received: by mail-wm0-x243.google.com with SMTP id v77so16416366wmv.0
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 06:12:50 -0800 (PST)
Date: Mon, 30 Jan 2017 14:12:46 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170130141246.GE2118@stefanha-x1.localdomain>
References: <1485436265-12573-1-git-send-email-thuth@redhat.com>
	<1485436265-12573-2-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VUDLurXRWRKrGuMn"
Content-Disposition: inline
In-Reply-To: <1485436265-12573-2-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 1/5] checkpatch: add a check for utf-8
 in commit logs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>


--VUDLurXRWRKrGuMn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 26, 2017 at 02:11:01PM +0100, Thomas Huth wrote:
> This patch is a port of the following commit from the Linux kernel:
>=20
> commit 15662b3e8644905032c2e26808401a487d4e90c1
> Author: Joe Perches <joe@perches.com>
> Date:   Mon Oct 31 17:13:12 2011 -0700
>=20
>     checkpatch: add a --strict check for utf-8 in commit logs
>=20
>     Some find using utf-8 in commit logs inappropriate.
>=20
>     Some patch commit logs contain unintended utf-8 characters when doing
>     things like copy/pasting compilation output.
>=20
>     Look for the start of any commit log by skipping initial lines that l=
ook
>     like email headers and "From: " lines.
>=20
>     Stop looking for utf-8 at the first signature line.
>=20
>     Signed-off-by: Joe Perches <joe@perches.com>
>     Suggested-by: Andrew Morton <akpm@linux-foundation.org>
>     Cc: Andy Whitcroft <apw@shadowen.org>
>     Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>     Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  scripts/checkpatch.pl | 30 ++++++++++++++++++++++++++----
>  1 file changed, 26 insertions(+), 4 deletions(-)

This patch prevents including names with non-ASCII characters in the
commit description.  Some people care about the proper spelling of their
names.

Allowing UTF-8 in Signed-off-by and other headers isn't enough.

--VUDLurXRWRKrGuMn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYj0neAAoJEJykq7OBq3PI3g4IAKrRps+9pIbgrpInodSMBxOb
CPb4rBSnkjYqRJZVXyxeuc2o5+fK6iwTqG+fWDm55+XWoqMsRGg+SnkumYVrQmdc
GCRVAdWwcJ7faK6NUUCnsf4AkVBtYYsQunzDhL5ldLAGVEsgQvyb2itLmyWsfYWj
nsvD/s461Xjv8o6mVfe7aSI7n16RR2qXeVGVSeGV0F8vSrl7fFEKlV0O0Cg7MaPK
Omt8i6V2ir219mESEGNrXtLZGLWT3dFEDBDj6z2Uy87ufHRAHKWeHVs7SPwUJVps
1LYih9RFHiYcK2gUWN1RcnnwsUcANy+4aJ6jSm45Ywyj1/qyHQpx2MgXxMuLEGE=
=uGfW
-----END PGP SIGNATURE-----

--VUDLurXRWRKrGuMn--
