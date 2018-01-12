Received: from eggs.gnu.org ([2001:4830:134:3::10]:44792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ea2DW-0001Z5-GA
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 11:30:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ea2DS-0002Rl-C0
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 11:30:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40874)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ea2DS-0002RT-3f
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 11:30:02 -0500
References: <1515609318-1897-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1515609318-1897-2-git-send-email-stefanb@linux.vnet.ibm.com>
	<CAJ+F1C+wFaPWov+sM_UveO92s3tEUDxo1OzSKyMGyS1tRqm+2Q@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b1b83637-12cc-04d6-689f-c1d1759e810a@redhat.com>
Date: Fri, 12 Jan 2018 10:29:52 -0600
MIME-Version: 1.0
In-Reply-To: <CAJ+F1C+wFaPWov+sM_UveO92s3tEUDxo1OzSKyMGyS1tRqm+2Q@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ITYEnZ4LD1o3nwN1LPoCak88izACgNNkC"
Subject: Re: [Qemu-devel] [RFC PATCH 1/3] tpm: Implement virtual memory
 device for TPM PPI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: kevin@koconnor.net, QEMU <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ITYEnZ4LD1o3nwN1LPoCak88izACgNNkC
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: kevin@koconnor.net, QEMU <qemu-devel@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <b1b83637-12cc-04d6-689f-c1d1759e810a@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 1/3] tpm: Implement virtual memory device
 for TPM PPI
References: <1515609318-1897-1-git-send-email-stefanb@linux.vnet.ibm.com>
 <1515609318-1897-2-git-send-email-stefanb@linux.vnet.ibm.com>
 <CAJ+F1C+wFaPWov+sM_UveO92s3tEUDxo1OzSKyMGyS1tRqm+2Q@mail.gmail.com>
In-Reply-To: <CAJ+F1C+wFaPWov+sM_UveO92s3tEUDxo1OzSKyMGyS1tRqm+2Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/12/2018 08:55 AM, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Wed, Jan 10, 2018 at 7:35 PM, Stefan Berger
> <stefanb@linux.vnet.ibm.com> wrote:
>> Implement a virtual memory device for the TPM physical
>> presence interface. The memory is located at 0xffff0000
>> and used by ACPI to send messages to the firmware (BIOS).
>>
>> This device should be used by all TPM interfaces on x86 and
>> can be added through by calling tpm_ppi_init_io().
>>

>> +#define DEBUG_PPI 1
>=20
> to be switched to 0
>=20
>> +
>> +#define DPRINTF(fmt, ...) do { \
>> +    if (DEBUG_PPI) { \
>> +        printf(fmt, ## __VA_ARGS__); \
>> +    } \
>> +} while (0);

Also, this falls foul of my pending patch to forbid trailing semicolons
in do/while(0) macros:
https://lists.gnu.org/archive/html/qemu-devel/2017-12/msg00246.html

But even though it is not a trace point, at least you made sure -Wformat
will avoid bit-rotting debug statements.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--ITYEnZ4LD1o3nwN1LPoCak88izACgNNkC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpY4oAACgkQp6FrSiUn
Q2oQagf9EIRaKteUc7T7lE4IAGhrYjbL8WKtNMjl8t9iUEiUfUQEleqJ4mUSTe75
VzJAAe4bhceq9H16Yo1iQTeTEC2sff/kcI0zqidf7Va8Fnbfv9E7naFgPOOqrf+m
2xQvI9DdgmvIm12lW7VSYWl7KJxfXXw8GoATE0vJZZDsj3v+Y5iIUG6OLy3f2Zw+
Bru2fXDI/XOTBEGfDeziYoblQuRpXevS+1lT7TafpMauqFkDyGnC762W2LR5hxbi
uR2tjMC5Z1wlRL9uPtSQY965mRd6z1+alX/0x7dWui5R5QKzRH5md70f+ctWnTiM
9FU8ihQ6rAzA94aBoOTlMX07EYj+iA==
=3Lhv
-----END PGP SIGNATURE-----

--ITYEnZ4LD1o3nwN1LPoCak88izACgNNkC--
