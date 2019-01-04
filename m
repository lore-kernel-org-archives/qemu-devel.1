Received: from eggs.gnu.org ([208.118.235.92]:34603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gfVuK-0003xf-FX
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 15:17:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gfVuH-0005Xt-68
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 15:17:28 -0500
References: <20190104181208.7809-1-philmd@redhat.com>
	<20190104181208.7809-4-philmd@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <349cd87b-0526-30b8-d9cd-0eee537ab5a4@redhat.com>
Date: Fri, 4 Jan 2019 14:17:14 -0600
MIME-Version: 1.0
In-Reply-To: <20190104181208.7809-4-philmd@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ovPHYZvWjj0WMrppWv1Y6vY58dY7WfNiU"
Subject: Re: [Qemu-devel] [PATCH v2 3/3] util/cutils: Move function
 documentations to the header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, qemu-trivial@nongnu.org, Cornelia Huck <cohuck@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Markus Armbruster <armbru@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Paolo Bonzini <pbonzini@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, Richard Henderson <rth@twiddle.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ovPHYZvWjj0WMrppWv1Y6vY58dY7WfNiU
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 David Hildenbrand <david@redhat.com>, qemu-trivial@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefano Garzarella
 <sgarzare@redhat.com>, Richard Henderson <rth@twiddle.net>
Message-ID: <349cd87b-0526-30b8-d9cd-0eee537ab5a4@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/3] util/cutils: Move function
 documentations to the header
References: <20190104181208.7809-1-philmd@redhat.com>
 <20190104181208.7809-4-philmd@redhat.com>
In-Reply-To: <20190104181208.7809-4-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/4/19 12:12 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Many functions have documentation before the implementation in
> cutils.c. Since we expect documentation around the prototype
> declaration in headers, move the comments in cutils.h.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  include/qemu/cutils.h | 224 ++++++++++++++++++++++++++++++++++++++++++=

>  util/cutils.c         | 185 ----------------------------------
>  2 files changed, 224 insertions(+), 185 deletions(-)

I find documentation in .c files slightly easier to use (you can then
read the code right below to see if the documentation is still
accurate); but as we had an inconsistent mix, I'm also okay with your
patch consolidating all the documentation to one of the two files,
rather than the bad mix of half-and-half.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--ovPHYZvWjj0WMrppWv1Y6vY58dY7WfNiU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEY3OaSlgimHGqKqRv3g5py3orov0FAlwvv0oACgkQ3g5py3or
ov1/8gf8DOeTEAae/7Z0+naf9nIxiQr4KaMa7lEAD5J1lPumjYmcjLY8Xm5r6g2g
vVNilsHfenfdoVgk25op5eS0j03/FRu3aY++iVaVYRmERvL+sCPcjFq5zaAePg+d
GFByjBH9c9qrtrijN+nwBjKGnCj2IR7Ik18lNKSx30gzjsT7UJMQ6DLKVGTn4D4p
zDKBeGvz33NGOQ/iBFSYmLBsewyJvWAw6s6MibeJlJT6S1sxK+eLbcOw0lk6UE9M
780zYBMXtS3mtGM29GokFhI72RSzp7VlvMwF3vQtMnAVZtvS/Ac2dauVrsyskCWf
KyNN5Xwv3CDiM01nkAobDY5rpgUBjA==
=w43k
-----END PGP SIGNATURE-----

--ovPHYZvWjj0WMrppWv1Y6vY58dY7WfNiU--
