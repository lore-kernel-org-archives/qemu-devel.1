Received: from eggs.gnu.org ([2001:4830:134:3::10]:44212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1drlFR-0003yH-TM
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 09:29:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1drlFN-0008Sn-HH
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 09:29:05 -0400
References: <20170911172022.4738-1-eblake@redhat.com>
	<20170911172022.4738-11-eblake@redhat.com>
	<65cb854d-5915-dc23-cb5d-0d8b5cecb6ea@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d893ea51-b083-9c3c-9f9f-f8d7a519dfda@redhat.com>
Date: Tue, 12 Sep 2017 08:28:49 -0500
MIME-Version: 1.0
In-Reply-To: <65cb854d-5915-dc23-cb5d-0d8b5cecb6ea@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="NLFwP5WSMR7R7UXFiTsAvbFQ9mj8ajjT6"
Subject: Re: [Qemu-devel] [PATCH v7 10/38] libqos: Move/rename
 qpci_unplug_acpi_device_test() to pci.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, pbonzini@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, Jason Wang <jasowang@redhat.com>, Amit Shah <amit@kernel.org>, "open list:virtio-blk" <qemu-block@nongnu.org>, Laurent Vivier <lvivier@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NLFwP5WSMR7R7UXFiTsAvbFQ9mj8ajjT6
From: Eric Blake <eblake@redhat.com>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, pbonzini@redhat.com,
 Stefan Hajnoczi <stefanha@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Amit Shah <amit@kernel.org>, "open list:virtio-blk" <qemu-block@nongnu.org>,
 Laurent Vivier <lvivier@redhat.com>
Message-ID: <d893ea51-b083-9c3c-9f9f-f8d7a519dfda@redhat.com>
Subject: Re: [PATCH v7 10/38] libqos: Move/rename
 qpci_unplug_acpi_device_test() to pci.c
References: <20170911172022.4738-1-eblake@redhat.com>
 <20170911172022.4738-11-eblake@redhat.com>
 <65cb854d-5915-dc23-cb5d-0d8b5cecb6ea@redhat.com>
In-Reply-To: <65cb854d-5915-dc23-cb5d-0d8b5cecb6ea@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/12/2017 02:29 AM, Thomas Huth wrote:
> On 11.09.2017 19:19, Eric Blake wrote:
>> Commit 2f8b2767 originally added qpci_plug_device_test() and
>> qpci_unplug_acpi_device_test() as a pair, both in pci-pc.c.
>> Later, commit cf716b31 moved one half of the pair to pci.c
>> when adding PPC64 support.  Keep the implementations of the
>> two functions together, and shorten the name to
>> qpci_unplug_device_test(), since all callers use the two
>> functions in tandem.
>>

>=20
> No, that's a bad idea. ACPI and that outb() is clearly something
> specific to x86, so this should not reside in pci.c but in pci-pc.c
>=20
> We might be able to unify this - I've had a similar patch here:
>=20
>  https://patchwork.kernel.org/patch/9905031/
>=20
> ... but I think this needs some more careful thinking and discussion, s=
o
> I'd suggest that you remove this from your already huge patch series fo=
r
> now and we fix it later instead.

Okay, I'm fine dropping this patch, and can base my respin on top of
your cleanup instead.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--NLFwP5WSMR7R7UXFiTsAvbFQ9mj8ajjT6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlm34REACgkQp6FrSiUn
Q2raYQf+KV5D0j51tMJV1KV4UV3PPPKXzVT32fBC9PIi5sfIsiPjde6RLN8WmB8e
J6jekUJkRXQPfUpuHpJrQ7C+Mv/4VcVqdnEKbKKt1qlR0xPnpX6O8v21VT0BR5zB
FVh9KzHorgARNxSsikFmp8uN7LPVE7RZ0aiyVJVxtIgcxt1bO58rDhbNc7JmN/VM
NOPzOpvDX4jTTBSQCu3m1r0T+oYVFm2GgWps26rXg++AnaWiz6dQH4TayqbA+Rdh
bS3d6rvZpj2i5OmM05MkQ9fkiOt2wh6aj7Wi18y7MdxKF5CWrksye06YaTbYFuQ5
q2RF1HmYAMiVKrPe9R66VacV33CaEQ==
=qva5
-----END PGP SIGNATURE-----

--NLFwP5WSMR7R7UXFiTsAvbFQ9mj8ajjT6--
