Received: from eggs.gnu.org ([2001:4830:134:3::10]:58541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXdPE-0002Kn-Sj
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 21:04:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXdPA-0007MY-N0
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 21:04:00 -0400
References: <CAOASepMWrxm0OxvuzeujfVK8JN-UzKCXtaz2vJRgGno=8CSMqQ@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5e542ce6-4192-4590-163e-de54002d74dd@redhat.com>
Date: Tue, 18 Jul 2017 20:03:51 -0500
MIME-Version: 1.0
In-Reply-To: <CAOASepMWrxm0OxvuzeujfVK8JN-UzKCXtaz2vJRgGno=8CSMqQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="eA8elaO5C5QDSp6f9fr7oCGNji8FQOdEV"
Subject: Re: [Qemu-devel] [PATCH] Update references of "struct ucontext" to
 "ucontext_t"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nathaniel McCallum <npmccallum@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, raj.khem@gmail.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--eA8elaO5C5QDSp6f9fr7oCGNji8FQOdEV
From: Eric Blake <eblake@redhat.com>
To: Nathaniel McCallum <npmccallum@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, raj.khem@gmail.com
Message-ID: <5e542ce6-4192-4590-163e-de54002d74dd@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] Update references of "struct ucontext" to
 "ucontext_t"
References: <CAOASepMWrxm0OxvuzeujfVK8JN-UzKCXtaz2vJRgGno=8CSMqQ@mail.gmail.com>
In-Reply-To: <CAOASepMWrxm0OxvuzeujfVK8JN-UzKCXtaz2vJRgGno=8CSMqQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/18/2017 07:58 PM, Nathaniel McCallum wrote:
> Glibc used to have:
>=20
>    typedef struct ucontext { ... } ucontext_t;
>=20
> Glibc now has:
>=20
>    typedef struct ucontext_t { ... } ucontext_t;
>=20
> However, Qemu used "struct ucontext" in declarations. This is a
> private name and compatiblity cannot be guaranteed. This patch
> updates Qemu to only use the standardized type name.
>=20
> Signed-off-by: Nathaniel McCallum <npmccallum@redhat.com>
> ---

Looks like this duplicates:
https://lists.gnu.org/archive/html/qemu-devel/2017-06/msg06508.html

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--eA8elaO5C5QDSp6f9fr7oCGNji8FQOdEV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAllur/cACgkQp6FrSiUn
Q2rZsQgAoMAVDlZtgCeHp9/KKP8dHOzclxhWz13oOdW0F16pQP+pAIxbVTbTmWYP
xhZK3ukxSL99a5uPHt0P73UkMMlMrmsZb6scLkOe9NKgDbC067HRVzoQWEF+db3A
1KOczTJuCjfFL9q+ngd6fxCmbmicyNC+PKKPy4eeFYV6CKnVCfWa4nhqthKa6Eg4
5rQUFVut8QIHWEgDxXqtH1K6y+SHgRr8bYIMy+ZfgJ1fT5FvCcp9ylW4U42ffsaY
dw1NFHhdaj7zjZfgNdqeXk7JqTlYC6Y8htWoP3E4d2P7veWd2PKlGWOEpKJzP1W2
IJBYDkUuHk0hwYAbkdBgSErRaNVZDw==
=/6Wj
-----END PGP SIGNATURE-----

--eA8elaO5C5QDSp6f9fr7oCGNji8FQOdEV--
