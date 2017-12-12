Received: from eggs.gnu.org ([2001:4830:134:3::10]:38291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eOgg5-0003S7-0C
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 04:16:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eOgg0-0005L3-2X
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 04:16:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45712)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eOgfz-0005Ke-Sm
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 04:16:36 -0500
Date: Tue, 12 Dec 2017 09:16:31 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171212091631.GE6089@stefanha-x1.localdomain>
References: <20171208105553.12249-1-pbonzini@redhat.com>
	<20171208105553.12249-3-pbonzini@redhat.com>
	<20171208153010.GD8998@stefanha-x1.localdomain>
	<43a3e41a-f6b2-dc43-f84d-53fa7efd0716@redhat.com>
	<20171211101620.GB13593@stefanha-x1.localdomain>
	<e01b6be6-62b4-2123-ba30-09ca27fd5048@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uCPdOCrL+PnN2Vxy"
Content-Disposition: inline
In-Reply-To: <e01b6be6-62b4-2123-ba30-09ca27fd5048@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/5] lock-guard: add scoped lock
 implementation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Emilio G . Cota" <cota@braap.org>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org


--uCPdOCrL+PnN2Vxy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2017 at 07:51:43AM -0600, Eric Blake wrote:
> On 12/11/2017 04:16 AM, Stefan Hajnoczi wrote:
>=20
> >>> I don't understand the need for the qemu_lock_guard_is_taken(&name)
> >>> condition, why not do the following?
> >>>
> >>>   for (QEMU_LOCK_GUARD(type, name, lock);
> >>>        ;
> >>>        qemu_lock_guard_unlock(&name))
> >>
> >> Because that would be an infinite loop. :)
> >=20
> > Sorry, I mean for (...; false; ...).  Is there any reason to do
> > qemu_lock_guard_is_taken(&name)?
>=20
> You need the loop to execute at least once ;)
>=20
> But I proposed an alternative that doesn't need is_taken, by:
>=20
> for (bool name##done =3D false, QEMU_LOCK_GUARD(type, name, lock);
>      ! name##done; name##done =3D true)
>=20
> if we still like the form that declares a for-loop scope.

Okay guys, for loops are hard.  I give up programming.

Stefan

--uCPdOCrL+PnN2Vxy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaL55vAAoJEJykq7OBq3PIH5EIALoz3Fij02/iGKZJlMdZxMNh
NpFSC/NG2LokpqE1zF/IW7YZyI77UMxew6KXYpGywH03UMj0VOmgcGVMzmzcALlQ
qtIHU+edVr1p7mi+91g8CRhXaBHiZ2UE6Ig/QKSw0BrBPrNQMulUwulpyGu0Es9t
R4APdlNZO6MkeS2e+lF7Vt/Ys8ewhs/JyZ2+cBk4RRdTQ34SyqLuGS1TESUuy523
EK3i6fS6bOT2hGll519miGiWkfSS2oCBhWoqNOpIIAzRGcWeAoq7xmle4Q+/vljg
mhBddlWJviERtBklvcUpSML2ApOapAXiouWdups7k5WwG1wt4tlUxuqxwkbdOJ8=
=pz0U
-----END PGP SIGNATURE-----

--uCPdOCrL+PnN2Vxy--
