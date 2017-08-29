Received: from eggs.gnu.org ([2001:4830:134:3::10]:43892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dmmx5-0001Gc-AK
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 16:17:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dmmx2-00056Y-3R
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 16:17:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45270)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dmmx1-00056I-Py
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 16:17:32 -0400
References: <20170823083901.852-1-quintela@redhat.com>
	<20170823083901.852-3-quintela@redhat.com>
	<20170823115327.GC2648@work-vm>
	<bbe64c5c-8906-2bf9-92a8-8fda49100505@kaod.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6b5e898b-89d9-2323-5ca9-0cd212d39ec1@redhat.com>
Date: Tue, 29 Aug 2017 15:17:25 -0500
MIME-Version: 1.0
In-Reply-To: <bbe64c5c-8906-2bf9-92a8-8fda49100505@kaod.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="UW2ju4Kd1KBMFH6S6IdIXsGBqO8L0HUH4"
Subject: Re: [Qemu-devel] [PATCH 2/2] tests: Make acpid test compile
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>
Cc: lvivier@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UW2ju4Kd1KBMFH6S6IdIXsGBqO8L0HUH4
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Cc: lvivier@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org,
 peterx@redhat.com
Message-ID: <6b5e898b-89d9-2323-5ca9-0cd212d39ec1@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] tests: Make acpid test compile
References: <20170823083901.852-1-quintela@redhat.com>
 <20170823083901.852-3-quintela@redhat.com> <20170823115327.GC2648@work-vm>
 <bbe64c5c-8906-2bf9-92a8-8fda49100505@kaod.org>
In-Reply-To: <bbe64c5c-8906-2bf9-92a8-8fda49100505@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/28/2017 09:41 AM, C=C3=A9dric Le Goater wrote:
> On 08/23/2017 01:53 PM, Dr. David Alan Gilbert wrote:
>> * Juan Quintela (quintela@redhat.com) wrote:
>>> Compiler gets confused with the size of the struct, so move form
>>> g_new0() to g_malloc0().
>>>
>>> I *think* that the problem is in gcc (or glib for that matter), but
>>> the documentation of the g_new0 states that 1sts first argument is an=

>>> struct type, and uint32_t is not an struct type.
>>>
>>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>>> ---

>>> =20
>>>      /* get the addresses of the tables pointed by rsdt */
>>> -    tables =3D g_new0(uint32_t, tables_nr);
>>> +    tables =3D g_malloc0(sizeof(uint32_t) * tables_nr);
>>

> I fixed that one with :
>=20
> @@ -40,7 +40,7 @@ static uint32_t acpi_find_vgia(void)
>      AcpiRsdpDescriptor rsdp_table;
>      uint32_t rsdt;
>      AcpiRsdtDescriptorRev1 rsdt_table;
> -    int tables_nr;
> +    uint32_t tables_nr;

I like this one better (multiplication in g_malloc0() makes me worry
about overflow; using unsigned math to avoid the problem is nicer).  Are
we going to see a v2 of this patch series?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--UW2ju4Kd1KBMFH6S6IdIXsGBqO8L0HUH4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmly9UACgkQp6FrSiUn
Q2rkywf9ER5npAsQkfu3O9Jtpn/gfNNAajmSmoGgPKpbL/VV3+PzsS6vd25D3gNa
NwRgrCdXqDv1CY+K9GutipW4f7y4r4KrUu7KwxSkNW2gA/SWZaFTPPkAEtLtbN30
gttlJxSBukPrEDk/S7GgctJ4tSgP9O6mMwHDWW7IDiH0CN3LxekfyI7hsIae0sDX
JHQXXDmH2LWmYJwxbi0XjGr9CQ3szCBnIWUB3HjPFsguU4insDZTsUeXg6lK3Bqi
rDqI+1n3NHIt1fQfc20VMRZFWOroviin6spSAcwGOndmXoak7MuW1owPx30FJiMo
ELuT3JHyv8E/ga0EOhovuPvUyIj44A==
=SZ43
-----END PGP SIGNATURE-----

--UW2ju4Kd1KBMFH6S6IdIXsGBqO8L0HUH4--
