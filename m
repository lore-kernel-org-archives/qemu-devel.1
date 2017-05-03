Received: from eggs.gnu.org ([2001:4830:134:3::10]:48908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d5xJB-0002Oj-E8
	for qemu-devel@nongnu.org; Wed, 03 May 2017 12:39:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d5xJA-0001xC-Em
	for qemu-devel@nongnu.org; Wed, 03 May 2017 12:39:21 -0400
References: <1493816238-33120-1-git-send-email-imammedo@redhat.com>
	<1493816238-33120-24-git-send-email-imammedo@redhat.com>
	<20170503163543.GR3482@thinpad.lan.raisama.net>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5f71cfda-2a73-77e3-0bf7-85e2aed53811@redhat.com>
Date: Wed, 3 May 2017 11:39:10 -0500
MIME-Version: 1.0
In-Reply-To: <20170503163543.GR3482@thinpad.lan.raisama.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="lhfCCggt5jSkqBv6uUkQLmEV9JVLJumRN"
Subject: Re: [Qemu-devel] [PATCH v2 23/24] numa: add '-numa cpu,
 ...' option for property based node mapping
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Paolo Bonzini <pbonzini@redhat.com>, Shannon Zhao <zhaoshenglong@huawei.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lhfCCggt5jSkqBv6uUkQLmEV9JVLJumRN
From: Eric Blake <eblake@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jones <drjones@redhat.com>, David Gibson
 <david@gibson.dropbear.id.au>, Paolo Bonzini <pbonzini@redhat.com>,
 Shannon Zhao <zhaoshenglong@huawei.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>
Message-ID: <5f71cfda-2a73-77e3-0bf7-85e2aed53811@redhat.com>
Subject: Re: [PATCH v2 23/24] numa: add '-numa cpu,...' option for property
 based node mapping
References: <1493816238-33120-1-git-send-email-imammedo@redhat.com>
 <1493816238-33120-24-git-send-email-imammedo@redhat.com>
 <20170503163543.GR3482@thinpad.lan.raisama.net>
In-Reply-To: <20170503163543.GR3482@thinpad.lan.raisama.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/03/2017 11:35 AM, Eduardo Habkost wrote:

>> +
>> +        memset(&cpu, 0, sizeof(cpu));
>> +        cpu.has_node_id =3D object->u.cpu.has_node_id;
>> +        cpu.node_id =3D object->u.cpu.node_id;
>> +        cpu.has_socket_id =3D object->u.cpu.has_socket_id;
>> +        cpu.socket_id =3D object->u.cpu.socket_id;
>> +        cpu.has_core_id =3D object->u.cpu.has_core_id;
>> +        cpu.core_id =3D object->u.cpu.core_id;
>> +        cpu.has_thread_id =3D object->u.cpu.has_thread_id;
>> +        cpu.thread_id =3D object->u.cpu.thread_id;
>=20
> We don't have a way to avoid copying each field individually?
> Some visitor trick, maybe?
>=20
> Eric, Markus, Michael, do you have any suggestions?

Markus just added QAPI_CLONE_MEMBERS(), which sounds like what you want:

https://lists.gnu.org/archive/html/qemu-devel/2017-04/msg04867.html

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--lhfCCggt5jSkqBv6uUkQLmEV9JVLJumRN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZCgeuAAoJEKeha0olJ0NqJfIIAKao90LOyCfH9uPw+ovOQ47U
liLX8Hjs42ox2oZg348a8TN3xPpO1cXnjE7e7n6toCZAcm4nUFUf4ThUL4xdrFd3
qD6rujsM678A7mnnKvFBWh3gGLmxnNVz1Fm2But0S9BxQzvBycoZrg5S39YbMOZ8
c4IrtOtwf+jGr/gW2cNqt7MIIJbU4ELdSy1mmoVBHOM8C/jHooXGHZ+TppMFOebA
A2nu8uoyDM3+6ELS00tvx10rReaCLt0RwH1PKMJzJK5DyWwP0I4Wbg/F1ZJi3uJ2
I6E7yb53a9bO+GATGWTGrw6baVRtpl9cHwqyWTkKHrlzHfBxa6XscN5cmd8dUxk=
=d6MN
-----END PGP SIGNATURE-----

--lhfCCggt5jSkqBv6uUkQLmEV9JVLJumRN--
