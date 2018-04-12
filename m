Received: from eggs.gnu.org ([2001:4830:134:3::10]:39498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f6eSd-0002rQ-4V
	for Qemu-devel@nongnu.org; Thu, 12 Apr 2018 11:48:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f6eSZ-0004qZ-Vs
	for Qemu-devel@nongnu.org; Thu, 12 Apr 2018 11:48:31 -0400
References: <815919ea-1087-9567-9b81-d445aeacb102@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d779ce89-248a-b965-9a48-c3b3c761b790@redhat.com>
Date: Thu, 12 Apr 2018 10:48:18 -0500
MIME-Version: 1.0
In-Reply-To: <815919ea-1087-9567-9b81-d445aeacb102@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="SUpmmkX5AzMmsZlbexovFmhdONjim2jnx"
Subject: Re: [Qemu-devel] Withdrawn: Tweak the NBD_OPT_SET_META_CONTEXT
 layout
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Qemu-devel@nongnu.org" <Qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>, nbd list <nbd@other.debian.org>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Wouter Verhelst <w@uter.be>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SUpmmkX5AzMmsZlbexovFmhdONjim2jnx
From: Eric Blake <eblake@redhat.com>
To: "Qemu-devel@nongnu.org" <Qemu-devel@nongnu.org>,
 qemu block <qemu-block@nongnu.org>, nbd list <nbd@other.debian.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Wouter Verhelst <w@uter.be>
Message-ID: <d779ce89-248a-b965-9a48-c3b3c761b790@redhat.com>
Subject: Re: [Qemu-devel] Withdrawn: Tweak the NBD_OPT_SET_META_CONTEXT layout
References: <815919ea-1087-9567-9b81-d445aeacb102@redhat.com>
In-Reply-To: <815919ea-1087-9567-9b81-d445aeacb102@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/31/2018 07:24 AM, Eric Blake wrote:
> As mentioned in earlier email threads, I experimented with an
> alternative layout to the structs sent across the wire during
> NBD_OPT_{LIST,SET}_META_CONTEXT, on the grounds that having the
> namespace and leaf-name combined into one string that requires further
> parsing on each end is not as nice as having two separate fields.=C2=A0=
 I'm
> replying to this mail with two RFC patches, one for the NBD spec, and
> one for the qemu implementation.
>=20
> If we like the idea, this has to go into qemu 2.12, so we have less tha=
n
> a week.=C2=A0 Or, we can ignore the RFC, keep qemu the way it is curren=
tly
> coded, and when it is released, it will be time to promote the NBD
> extension-blockstatus to current as there will be an existing
> implementation to be interoperable with.

As I got no comments, and as qemu is now frozen hard at 2.12-rc3, it is
officially too late to change the format sent over the wire; qemu's
implementation will be the reference implementation, and for nbd.git,
I'll be promoting extension-blockstatus to the master branch once qemu
2.12 is officially released.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--SUpmmkX5AzMmsZlbexovFmhdONjim2jnx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrPf8IACgkQp6FrSiUn
Q2rGcAf+M+zVTjWoAvAyEz5FOyIsGRUljFJGuLqBsDvoentvb5/xUFw2C8pTu0Ky
iHjyu4zfSeVdlwB8dQw72RdWjYVv1vQ1Qzjo8VcwV4DGr1gNBgBMfH2j74uVmF+T
SHlARTlgrnNQIs36ySOBmeUvEgwofLw9gLAtxAxwhChI0M3QXg7izeaqhnPjZHBU
l62jfSuzc6ug6xe+PvTbCPUcPXDBeuot9YnOJI5vSiyMJDawq5aJSrgFlhyqbhl2
bT20+Lyu3bJAG0ah6A+sshPX8io/BfU+C7uHN+XwvOVXxmZoQl2uCjhNBXrHxSdq
FmPsFY6+urmGgFT7X+nWPX1aDlckQQ==
=vM4F
-----END PGP SIGNATURE-----

--SUpmmkX5AzMmsZlbexovFmhdONjim2jnx--
