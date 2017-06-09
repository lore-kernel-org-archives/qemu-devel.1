Received: from eggs.gnu.org ([2001:4830:134:3::10]:59926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dJNNq-0000m9-2W
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 13:07:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dJNNp-0006FK-2P
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 13:07:38 -0400
References: <1497009003-25794-1-git-send-email-kwolf@redhat.com>
	<1497009003-25794-4-git-send-email-kwolf@redhat.com>
	<8514d36e-1bc6-567f-4f10-9e8584b9eed0@redhat.com>
	<20170609125831.GD4462@noname.redhat.com>
	<ea981c62-61c5-8870-3ba2-8469f8c4fa5f@redhat.com>
	<20170609155543.GF4462@noname.redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <dbbdb7cb-979e-581d-2e54-12ba02780d06@redhat.com>
Date: Fri, 9 Jun 2017 12:07:29 -0500
MIME-Version: 1.0
In-Reply-To: <20170609155543.GF4462@noname.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="4dN3krOavu4BIfGD0Gsj7EwhXdKMUHKWN"
Subject: Re: [Qemu-devel] [PATCH 3/3] qemu-iotests: Test exiting qemu with
 running job
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4dN3krOavu4BIfGD0Gsj7EwhXdKMUHKWN
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org
Message-ID: <dbbdb7cb-979e-581d-2e54-12ba02780d06@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/3] qemu-iotests: Test exiting qemu with
 running job
References: <1497009003-25794-1-git-send-email-kwolf@redhat.com>
 <1497009003-25794-4-git-send-email-kwolf@redhat.com>
 <8514d36e-1bc6-567f-4f10-9e8584b9eed0@redhat.com>
 <20170609125831.GD4462@noname.redhat.com>
 <ea981c62-61c5-8870-3ba2-8469f8c4fa5f@redhat.com>
 <20170609155543.GF4462@noname.redhat.com>
In-Reply-To: <20170609155543.GF4462@noname.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/09/2017 10:55 AM, Kevin Wolf wrote:

>>
>> These belong in comments in the test proper, because it is not obvious=

>> otherwise.  But with comments added (so someone debugging a theoretica=
l
>> test failure down the road knows what they are up against),
>=20
> # Note that the reference output intentionally includes the 'offset' fi=
eld in
> # BLOCK_JOB_CANCELLED events for all of the following block jobs. They =
are
> # predictable and any change in the offsets would hint at a bug in the =
job
> # throttling code.
> #
> # In order to achieve these predictable offsets, all of the following t=
ests
> # use speed=3D65536. Each job will perform exactly one iteration before=
 it has
> # to sleep at least for a second, which is plenty of time for the 'quit=
' QMP
> # command to be received (after receiving the command, the rest runs
> # synchronously, so jobs can arbitrarily continue or complete).
> #
> # The buffer size for commit and streaming is 512k (waiting for 8 secon=
ds after
> # the first request), for active commit and mirror it's large enough to=
 cover
> # the full 4M, and for backup it's the qcow2 cluster size, which we kno=
w is
> # 64k. As all of these are at least as large as the speed, we are sure =
that the
> # offset doesn't advance after the first iteration before qemu exits.
>=20
> Does this look okay?

Yes, that looks fine.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--4dN3krOavu4BIfGD0Gsj7EwhXdKMUHKWN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZOtXRAAoJEKeha0olJ0NqnY0H/jW95ivDuQJyNyDklqFPKg3L
VaaYxf+y4F/cqK9/GATUc3rmBZxLUCA9R4+TKVba33k26RiViWI0UDT8RI70VG4y
U5urVRnM9XAv9TJsMa29tk1ofK3ioqDxDVRwd/HshRrl8jG0p22MzFIYMeM3EjBw
9eXbJ13zjhbVTlXUMwTmjXbagQDfYthPnwjwcQFT/l5yLAPcqM3FuSgMQqKOtLlx
dd98g8uvy30PFipDqzZWFxuXLxdlwvLQusGLknRr7Q3wKt4si7S5GsS45SD9KjAN
GXrCIqU9XmsyZyko0bIAT+IfHSvn2JW9ytmn6pc/uGkdvDk9V/18Clz9kP5mA9k=
=4ZV5
-----END PGP SIGNATURE-----

--4dN3krOavu4BIfGD0Gsj7EwhXdKMUHKWN--
