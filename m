Received: from eggs.gnu.org ([2001:4830:134:3::10]:33656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ebpBo-0007Zc-2T
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 09:59:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ebpBi-0003H5-L1
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 09:59:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44170)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ebpBi-0003Fm-C0
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 09:59:38 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 39B03629C2
	for <qemu-devel@nongnu.org>; Wed, 17 Jan 2018 14:59:37 +0000 (UTC)
References: <20180117114430.19110-1-marcandre.lureau@redhat.com>
	<a9bc4b35-23b3-515f-9ba1-71f41a95b9e7@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <bacb3016-0470-a70d-881a-06a2b2555386@redhat.com>
Date: Wed, 17 Jan 2018 08:59:14 -0600
MIME-Version: 1.0
In-Reply-To: <a9bc4b35-23b3-515f-9ba1-71f41a95b9e7@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="EPENeRYbD1GYjJnRiiWDM2U5rIkIqte2c"
Subject: Re: [Qemu-devel] [PATCH] dump-guest-memory.py: fix python 2 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EPENeRYbD1GYjJnRiiWDM2U5rIkIqte2c
From: Eric Blake <eblake@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>
Message-ID: <bacb3016-0470-a70d-881a-06a2b2555386@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] dump-guest-memory.py: fix python 2 support
References: <20180117114430.19110-1-marcandre.lureau@redhat.com>
 <a9bc4b35-23b3-515f-9ba1-71f41a95b9e7@redhat.com>
In-Reply-To: <a9bc4b35-23b3-515f-9ba1-71f41a95b9e7@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/17/2018 08:18 AM, Laszlo Ersek wrote:
> On 01/17/18 12:44, Marc-Andr=C3=A9 Lureau wrote:
>> Python GDB support may use Python 2 or 3.
>>
>> Inferior.read_memory() may return a buffer with Python 2 or a
>> memoryview with Python 3 (see also
>> https://sourceware.org/gdb/onlinedocs/gdb/Inferiors-In-Python.html)
>>
>> The elf.add_vmcoreinfo_note() method expect a byte string, but Python =
2
>> buffer doesn't provide the tobyes() method. Wrap the read_memory()
>> result to a memoryview, available in Python 2.7. (if the return object=

>> is already a memoryview, this adds a useless identity view on top)
>=20
> OOP is awesome.
>=20
>>
>> Fixes a regression introduced with commit
>> d23bfa91b7789534d16ede6cb7d925bfac3f3c4c ("add vmcoreinfo").
>=20
> Do you want to CC stable? Commit d23bfa91b778 is part of v2.11.0.

Configure says we still support python 2.6; does this still work there?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--EPENeRYbD1GYjJnRiiWDM2U5rIkIqte2c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpfZMIACgkQp6FrSiUn
Q2rUdgf8D4g2Dc+KQylcLw4EJtemR4UwFeT/ux2dkbLdbPEQSCZXEIjVAKryEvR3
fBIc7MBFOsb9VT67VqTzYlY3YSwqAy88yXZ2uQ10hYZWHCQ/vRWafuzMElpra7Rt
nZGoxwpxqBFekWre70mb7upLevasezd4WfDuyhdSlFzIbYq65zTRzxtuQ99Ff7L+
J9esDrDbd6poYQgsprG0omIc3MzNk+SBYfb3K1olLHesTmOOx93yqUsKJUiT16aB
o3sGsNXxY4QwOc3qq+p63bv/QMcBztDmqxwlinFuC381GKu1ZtdwcD6AmQu9w/NT
4HH+mwJNnIqpOG6Jw7lJJsfvmM90qA==
=eki3
-----END PGP SIGNATURE-----

--EPENeRYbD1GYjJnRiiWDM2U5rIkIqte2c--
