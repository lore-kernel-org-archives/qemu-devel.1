Received: from eggs.gnu.org ([2001:4830:134:3::10]:39991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eMaf9-0004HL-4l
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 09:27:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eMaf5-0001eb-4h
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 09:27:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38568)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eMaf4-0001e9-QS
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 09:26:59 -0500
References: <20171206120217.11392-1-danielhb@linux.vnet.ibm.com>
	<20171206120217.11392-2-danielhb@linux.vnet.ibm.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d3550f4f-adc1-ff8e-5aa7-7b1c815f2c90@redhat.com>
Date: Wed, 6 Dec 2017 08:26:56 -0600
MIME-Version: 1.0
In-Reply-To: <20171206120217.11392-2-danielhb@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="6xDosgVOib8H7JGOdPuk1OFX4MP6ijRS9"
Subject: Re: [Qemu-devel] [PATCH 1/3] qmp: introduce
 query-wakeup-from-suspend-support command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, armbru@redhat.com, dgilbert@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6xDosgVOib8H7JGOdPuk1OFX4MP6ijRS9
From: Eric Blake <eblake@redhat.com>
To: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>,
 qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, armbru@redhat.com, dgilbert@redhat.com
Message-ID: <d3550f4f-adc1-ff8e-5aa7-7b1c815f2c90@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/3] qmp: introduce
 query-wakeup-from-suspend-support command
References: <20171206120217.11392-1-danielhb@linux.vnet.ibm.com>
 <20171206120217.11392-2-danielhb@linux.vnet.ibm.com>
In-Reply-To: <20171206120217.11392-2-danielhb@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/06/2017 06:02 AM, Daniel Henrique Barboza wrote:
> When issuing the qmp/hmp 'system_wakeup' command, what happens in a
> nutshell is:
>=20

> This patch implements a new QMP command called
> 'query-wakeup-from-suspend-support' that allows the caller to query
> if the guest supports wake up from suspend via system_wakeup. It
> goes over the subscribers of the wake up event and, if it's empty,
> it assumes that the guest does not support wake up from suspend
> (and thus, pm-suspend itself).
>=20
> This is the expected output of the command when running a x86 guest:
>=20
> {"execute" : "query-wakeup-from-suspend-support"}
> {"return": {"enabled": true}}

Do we really need a new command, or can we add it as an additional field
to an existing command (for example, in MachineInfo under
query-machines, or TargetInfo under query-target)?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--6xDosgVOib8H7JGOdPuk1OFX4MP6ijRS9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlon/jAACgkQp6FrSiUn
Q2ovwwf+Oc5fedsiCBiSE1dEaa7+fpwGHGk7KaftFN2f78f3Tqx6b/i4AkjtcMfz
kQR9nVLG1RyQ52+Qi9h5zvRLT6wjGPahsmQoJ05BOWL86jAc4rs7Qy0n+ycPSsqZ
qZiO6yjbkk6uIzTmIna2wDj6PZi4bkelxesbKcUdLY1WGOq+vvDQk2qVz4LzA9t0
7acm17qvzPLdso63AecaOx2ZKSm4uJ7qYL3tjnRe12LdUuJ2Hx4PZAfVSTaCa0Wq
D6jd4Le1qWT9J4CydkhFNaLnsXYHWPw1WCZZ1PqeT8YUEJM3/cljqI6RrZKzXR+w
mga3edls5Mbai8A1Dfxaow6pNhuFUw==
=9xoN
-----END PGP SIGNATURE-----

--6xDosgVOib8H7JGOdPuk1OFX4MP6ijRS9--
