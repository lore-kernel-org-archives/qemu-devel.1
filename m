Received: from eggs.gnu.org ([2001:4830:134:3::10]:51287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dcxmE-0006Me-4e
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 13:49:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dcxmB-0000rI-1e
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 13:49:46 -0400
References: <150169525609.4634.10414517308328488237.stgit@bahia.lan>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0e3dd38b-66dd-7e70-2dc2-e30f26a83ae7@redhat.com>
Date: Wed, 2 Aug 2017 12:49:37 -0500
MIME-Version: 1.0
In-Reply-To: <150169525609.4634.10414517308328488237.stgit@bahia.lan>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="BF1EclntdpJL4kxBAbKNQDRTf87ff7sK3"
Subject: Re: [Qemu-devel] [PATCH] ppc: fix double-free in cpu_post_load()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BF1EclntdpJL4kxBAbKNQDRTf87ff7sK3
From: Eric Blake <eblake@redhat.com>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Message-ID: <0e3dd38b-66dd-7e70-2dc2-e30f26a83ae7@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] ppc: fix double-free in cpu_post_load()
References: <150169525609.4634.10414517308328488237.stgit@bahia.lan>
In-Reply-To: <150169525609.4634.10414517308328488237.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/02/2017 12:34 PM, Greg Kurz wrote:
> When running nested with KVM PR, ppc_set_compat() fails and QEMU crashe=
s
> because of "double free or corruption (!prev)". The crash happens becau=
se
> error_report_err() has already called error_free().
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  target/ppc/machine.c |    1 -
>  1 file changed, 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
> diff --git a/target/ppc/machine.c b/target/ppc/machine.c
> index f578156dd411..abe0a1cdf021 100644
> --- a/target/ppc/machine.c
> +++ b/target/ppc/machine.c
> @@ -239,7 +239,6 @@ static int cpu_post_load(void *opaque, int version_=
id)
>          ppc_set_compat(cpu, cpu->compat_pvr, &local_err);
>          if (local_err) {
>              error_report_err(local_err);
> -            error_free(local_err);
>              return -1;
>          }
>      } else
>=20
>=20
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--BF1EclntdpJL4kxBAbKNQDRTf87ff7sK3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmCELEACgkQp6FrSiUn
Q2r3Twf9GNF6CSn2gyuFRMUiEzv9NH5tQ2HFO2PsEJB/RtZvdlCYWkGnMXqF/Rk5
E3ODYwyDppo7A7crmjRQnVm1KmBdfO5Fhs22edOEmLqgGhjz8/4is2eMi1n945in
k0EKvKMnGX3ljh7hmnGkGc33TSXPkABpVNRpzBwbWJfy7NxSXPCYP8euD2vZBbzE
iK9XstYtpigri2oag3OmsCo70lP1ZfxISWg7we2ceF0MdK1wObsjO3aUwGMIMylE
5JmvnxGcftL4aPCcbR9/K56nRV1lWuJ0tQEJzKzZNFKLCKZ0GPIkawBIPCRb64KR
VEtepoUM6USHwTRrvCQLNN+kvsAjnQ==
=Pk2R
-----END PGP SIGNATURE-----

--BF1EclntdpJL4kxBAbKNQDRTf87ff7sK3--
