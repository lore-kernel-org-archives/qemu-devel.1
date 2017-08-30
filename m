Received: from eggs.gnu.org ([2001:4830:134:3::10]:59981)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1dn9q0-0000re-Mi
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 16:43:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1dn9px-0007Ok-Gf
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 16:43:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51390)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1dn9px-0007Oe-6u
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 16:43:45 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 309CD285A8
	for <qemu-devel@nongnu.org>; Wed, 30 Aug 2017 20:43:44 +0000 (UTC)
References: <20170830113319.6749-1-quintela@redhat.com>
	<20170830113319.6749-3-quintela@redhat.com>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <3e72d12b-2af1-a713-29a0-4832ef47474a@redhat.com>
Date: Wed, 30 Aug 2017 16:43:36 -0400
MIME-Version: 1.0
In-Reply-To: <20170830113319.6749-3-quintela@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Lx2AfGeRUdJpn38ot1QD0vg5mmsrs7QAT"
Subject: Re: [Qemu-devel] [PATCH v2 2/2] tests: Make vmgenid test compile
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: lvivier@redhat.com, pbonzini@redhat.com, dgilbert@redhat.com, peterx@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Lx2AfGeRUdJpn38ot1QD0vg5mmsrs7QAT
From: Cleber Rosa <crosa@redhat.com>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: lvivier@redhat.com, pbonzini@redhat.com, dgilbert@redhat.com,
 peterx@redhat.com
Message-ID: <3e72d12b-2af1-a713-29a0-4832ef47474a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/2] tests: Make vmgenid test compile
References: <20170830113319.6749-1-quintela@redhat.com>
 <20170830113319.6749-3-quintela@redhat.com>
In-Reply-To: <20170830113319.6749-3-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 08/30/2017 07:33 AM, Juan Quintela wrote:
> Just make sure that nr_tables is size_t not int.
>=20
> Suggested-by: C=C3=A9dric Le Goater <clg@kaod.org>
> Signed-off-by: Juan Quintela <quintela@redhat.com>
>=20
> --
>=20
> Drop the s/g_new0/g_malloc0/ change.
> ---
>  tests/vmgenid-test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tests/vmgenid-test.c b/tests/vmgenid-test.c
> index 3d5c1c3615..bcd3d7ec07 100644
> --- a/tests/vmgenid-test.c
> +++ b/tests/vmgenid-test.c
> @@ -40,7 +40,7 @@ static uint32_t acpi_find_vgia(void)
>      AcpiRsdpDescriptor rsdp_table;
>      uint32_t rsdt;
>      AcpiRsdtDescriptorRev1 rsdt_table;
> -    int tables_nr;
> +    size_t tables_nr;
>      uint32_t *tables;
>      AcpiTableHeader ssdt_table;
>      VgidTable vgid_table;
>=20

Tested-by: Cleber Rosa <crosa@redhat.com>


--Lx2AfGeRUdJpn38ot1QD0vg5mmsrs7QAT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAlmnI3kACgkQZX6NM6Xy
CfMZDw/+OC9u0es5KZNOmieZpHT9d2UTghy5WMMhManiPqkbrMRBqjUenhW28JPW
YvaKCe2OTUEvq5l0JnusCmQHbMFcBEt+FqLZSdgFca8aZPu4TjM7DQJBE/FZUrJI
AgoOJwQKA9JELYcLbwalCZfqJB7musMLYtgqFFBmAwHgnDQsU4hpzukU+LqMABG/
0VpDUDmb2GhwLJ4DBg1cPG8KqEkxTAf1v/ZkbSAF4Hl7gyn6Zpv6vau2Jh5O9PZi
Bce1Wy/GJeZGXfnzV+ZJT9Jyvs1MDHNqW1a7pow6DsoS+p0zYe/E46pujIH6MzEG
YgHg6HQ2UCsBY+EGhyNcD67ve4tC75OZDDw50AUJCH6MjgJhCtIBa5OpDed4Fzyv
L+4cjiNg5C3k277KgX7t1Uq4xDdLdK9uNAF/aIKrSZdWzHY9rpi1ln7OZS/ivlTt
vH5vC0rOKBXDJ21OgvWiFpWrg+bYniQIOJdQu9SydF0Lddh3uqRikZLouRnerCvo
u12UbJDSmXk3eT098uwMSGUo5ZKPLN8vc121VMndco98vzc0NBgg3xprZKaFDBGu
Cz42gQQnGmk91+3cVvyjVrfhuEr9xi472AR9i+k/uHzbL+FLwm/T++24VKGKxW/w
+23Tsse9yeEn8gPzpm+B64zfv3HN38tUAK0bkHQ06ZXBZ7UIaFs=
=oeht
-----END PGP SIGNATURE-----

--Lx2AfGeRUdJpn38ot1QD0vg5mmsrs7QAT--
