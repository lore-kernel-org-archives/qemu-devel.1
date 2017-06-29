Received: from eggs.gnu.org ([2001:4830:134:3::10]:36237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dQdqV-00064K-6S
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 14:07:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dQdqS-0004A6-0Z
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 14:07:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44766)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dQdqR-00049e-OM
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 14:07:11 -0400
References: <1498759215-25382-1-git-send-email-stefanb@linux.vnet.ibm.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <52874c12-d5ff-518e-a796-3f8de2714fca@redhat.com>
Date: Thu, 29 Jun 2017 13:07:05 -0500
MIME-Version: 1.0
In-Reply-To: <1498759215-25382-1-git-send-email-stefanb@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ggnmJflttxgW7E4FUKh3PaxXlXoGA3auQ"
Subject: Re: [Qemu-devel] [PATCH] specs: Describe the TPM support in QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: lersek@redhat.com, javierm@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ggnmJflttxgW7E4FUKh3PaxXlXoGA3auQ
From: Eric Blake <eblake@redhat.com>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: lersek@redhat.com, javierm@redhat.com
Message-ID: <52874c12-d5ff-518e-a796-3f8de2714fca@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] specs: Describe the TPM support in QEMU
References: <1498759215-25382-1-git-send-email-stefanb@linux.vnet.ibm.com>
In-Reply-To: <1498759215-25382-1-git-send-email-stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/29/2017 01:00 PM, Stefan Berger wrote:
> This patch adds a description of the current TPM support in QEMU
> to the specs.
>=20
> Several public specs are referenced via their landing page on the
> trustedcomputinggroup.org website.
>=20
> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> ---
>  docs/specs/tpm.txt | 98 ++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
>  1 file changed, 98 insertions(+)
>  create mode 100644 docs/specs/tpm.txt

> +
> +QEMU files related to TPM TIS interfaceL

s/interfaceL/interface:/


> +
> +Since the host's TPM device will already be initialize by the host's f=
irmware,

s/initialize/initialized/

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--ggnmJflttxgW7E4FUKh3PaxXlXoGA3auQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZVUHJAAoJEKeha0olJ0NqJoUIAJLLOkt2JTR4rzUDYPKvkNf9
jN6BZGZ7h5rsUA9HmuNME0wrY4ObZdES9jTDJNFHaOAyGhmpOIZGV7nwF6dvPU9H
yR8JURnUjp54OYju5OJ2WWkKvBLTeg86NdAdOK6wdfKCmgjWXB5fzzyTbJo95kK+
Hz05pndUzTOQehcff48+nw42qqdKPYbQQXHUtA4Dtzc31r/r6v7ylmhuqSDzucrG
F/cmqzzQ8MY9eXqVp8qapII0lQ1Lf+di1zJAheQ+L63H2GVWr8V/qXkNEHbLOxcR
Ou/x5qGTkYU+HYmuK5p5AzOnAIMrUCaMJRH34pDAU6L769Z6G47QfteuhjWo3FU=
=Jp0x
-----END PGP SIGNATURE-----

--ggnmJflttxgW7E4FUKh3PaxXlXoGA3auQ--
