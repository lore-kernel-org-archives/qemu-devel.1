Received: from eggs.gnu.org ([2001:4830:134:3::10]:36556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dtzb7-0001e3-IY
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 13:12:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dtzb2-0004mv-Vv
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 13:12:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56586)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dtzb2-0004mf-NB
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 13:12:36 -0400
References: <20170918163322.206581-1-borntraeger@de.ibm.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c83c066e-093a-fca5-6c47-9eff6cffc03d@redhat.com>
Date: Mon, 18 Sep 2017 12:12:31 -0500
MIME-Version: 1.0
In-Reply-To: <20170918163322.206581-1-borntraeger@de.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="VwCnkfR6hXWpHpJbnkkJEpPbRmkqjLA7c"
Subject: Re: [Qemu-devel] [PATCH] s390x/cpu: expose the guest crash
 information
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Jing Liu <liujbjl@linux.vnet.ibm.com>, qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VwCnkfR6hXWpHpJbnkkJEpPbRmkqjLA7c
From: Eric Blake <eblake@redhat.com>
To: Christian Borntraeger <borntraeger@de.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 Jing Liu <liujbjl@linux.vnet.ibm.com>, qemu-devel <qemu-devel@nongnu.org>,
 Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>
Message-ID: <c83c066e-093a-fca5-6c47-9eff6cffc03d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] s390x/cpu: expose the guest crash
 information
References: <20170918163322.206581-1-borntraeger@de.ibm.com>
In-Reply-To: <20170918163322.206581-1-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/18/2017 11:33 AM, Christian Borntraeger wrote:
> From: Jing Liu <liujbjl@linux.vnet.ibm.com>
>=20
> This patch is the s390 implementation of guest crash information, simil=
ar
> to commit d187e08dc4 ("i386/cpu: add crash-information QOM property") a=
nd
> the related commits. We will detect several crash reasons, with the
> "disabled wait" being the most important one, since this is used by all=

> s390 guests as a "panic like" notification.
>=20

> +
> +##
> +# @GuestPanicInformationKVMS390:
> +#
> +# KVM-S390 specific guest panic information (PSW)
> +#
> +# Since: 2.11
> +##
> +{'struct': 'GuestPanicInformationKVMS390',
> + 'data': { 'psw_mask': 'uint64',
> +           'psw_addr': 'uint64',

New interfaces should favor '-' over '_'; is there any reason we can't
name these 'psw-mask' and 'pws-addr'?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--VwCnkfR6hXWpHpJbnkkJEpPbRmkqjLA7c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlm//n8ACgkQp6FrSiUn
Q2r69gf/QMjn99nEOCwU4Epy5kmse9Y57M0YKY54wv2tQlJTf8EBxD8hV774Q6cx
dxbgDot4HDWTchF4LGYTkbv+MhK2Wry8DWXYpeUANmCrUYyUiuiqkQUhZMeo5Dds
LDFBHw4N3UuhTHtIhZfGoUSfp0K76nJcjEpYLEeFpIy2DwwfzxbrgMLwSdkL4wMd
uUdPwuQIizoaCuQi4sJ/2SI3X7XXzSb3OGEdVWvTy4SDRGwFL/XodOKCIp8rSugr
bDHXvcW6Ez10+dbc0Cye18NmsSy1orptOcK+ixwlBBt8EhR/W81KEC5RpKrj1rn4
B+fQBVSOJG11kfhHh67XfzALHM7y5g==
=J0Y9
-----END PGP SIGNATURE-----

--VwCnkfR6hXWpHpJbnkkJEpPbRmkqjLA7c--
