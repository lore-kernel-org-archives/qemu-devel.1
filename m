Received: from eggs.gnu.org ([2001:4830:134:3::10]:47605)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dlGET-0004gB-8a
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 11:09:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dlGEP-00087S-7V
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 11:09:13 -0400
References: <20170824153345.2244-1-stefanha@redhat.com>
	<440320ce-5bd1-bb3d-fedd-2e2ed00f1f19@redhat.com>
	<CAJSP0QVse1f9S8ZmXsysfaT85mCSCtzsufAOHx38KZ250NVbEA@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8d1501f2-d545-dbcf-9482-d993fd16a021@redhat.com>
Date: Fri, 25 Aug 2017 10:08:48 -0500
MIME-Version: 1.0
In-Reply-To: <CAJSP0QVse1f9S8ZmXsysfaT85mCSCtzsufAOHx38KZ250NVbEA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="sq9cDOAoEvoIe0hEDmVMVxmB5aLeJpOc1"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 0/3] nbd-client: enter
 read_reply_co during init to avoid crash
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu block <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sq9cDOAoEvoIe0hEDmVMVxmB5aLeJpOc1
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel
 <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu block <qemu-block@nongnu.org>
Message-ID: <8d1501f2-d545-dbcf-9482-d993fd16a021@redhat.com>
Subject: Re: [Qemu-block] [PATCH 0/3] nbd-client: enter read_reply_co during
 init to avoid crash
References: <20170824153345.2244-1-stefanha@redhat.com>
 <440320ce-5bd1-bb3d-fedd-2e2ed00f1f19@redhat.com>
 <CAJSP0QVse1f9S8ZmXsysfaT85mCSCtzsufAOHx38KZ250NVbEA@mail.gmail.com>
In-Reply-To: <CAJSP0QVse1f9S8ZmXsysfaT85mCSCtzsufAOHx38KZ250NVbEA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/24/2017 11:05 AM, Stefan Hajnoczi wrote:
> On Thu, Aug 24, 2017 at 4:52 PM, Eric Blake <eblake@redhat.com> wrote:
>> On 08/24/2017 10:33 AM, Stefan Hajnoczi wrote:
>>> See Patch 1 for the segfault fix.  Patches 2 & 3 add qemu-iotests cov=
erage.
>>>
>>> This is a rare crash that we'll probably only see in testing.  It onl=
y seems to
>>> happen with UNIX domain sockets.
>>
>> Rare enough that I don't think it is 2.10-rc4 material.  I'll review,
>> and if I don't find anything needing a respin, I'll add it to my NBD
>> queue for 2.11.
>=20
> Great.  This is 2.11 material.

Hmm - I wonder if https://bugs.launchpad.net/qemu/+bug/1712818 is
related to this.  I really don't want to delay 2.10 further (downstream
distros can backport fixes) - but comment 3 stating that crashes are
less frequent but still possible with -rc4 is not good.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--sq9cDOAoEvoIe0hEDmVMVxmB5aLeJpOc1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmgPYAACgkQp6FrSiUn
Q2oxqwf9G8FsulpSabu0ExFKU21at9voBlJk+lu++HrQhIK4dDhsKS/kQrbAgxOD
EC9OUkLt4uXeW5aQTSTl0KjX+Vo2s6H+3Plyf5k16viwvdV/zsjEW6bEj//L69I2
59rXHzfASbA7bWGJ98r2DGTe5TB0ufz7duxyP7x1DcsR5yjY4tcO/JMXfhMINMz9
RvjqH1oN/pOhjedfmjRJUhfX5se7cT9E/NyXnFPhm4JTRFFNPEE2LYf4CdgAhxA1
nasuY2BwJZ5EQIxG17IxUl+BA5WUY/XWjy/vGw7HJaPSz6HyylYmwBUj2EVrrcpV
a2WXVJcfaeqOqzw+T5BUtHPD8taalw==
=LBac
-----END PGP SIGNATURE-----

--sq9cDOAoEvoIe0hEDmVMVxmB5aLeJpOc1--
