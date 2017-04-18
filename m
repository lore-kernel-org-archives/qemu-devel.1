Received: from eggs.gnu.org ([2001:4830:134:3::10]:57964)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d0YyB-0002zK-Kr
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 15:39:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d0YyA-0005Zn-QE
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 15:39:23 -0400
References: <815765cfcea726c7a4cc619c4f6c3bedb47f16b9.1492537347.git.jcody@redhat.com>
	<e649d1d3-6310-6607-22fe-82fc961d53c4@redhat.com>
	<20170418193129.GJ5704@localhost.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c0a0816b-9ff9-a285-dbe1-c5b4f78e6ee4@redhat.com>
Date: Tue, 18 Apr 2017 14:39:12 -0500
MIME-Version: 1.0
In-Reply-To: <20170418193129.GJ5704@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="UbmdEAF17PcUX33dPeJ69q2HK1RiQMGar"
Subject: Re: [Qemu-devel] [PATCH v2 for-2.10 1/1] qemu-iotests:
 _cleanup_qemu must be called on exit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UbmdEAF17PcUX33dPeJ69q2HK1RiQMGar
From: Eric Blake <eblake@redhat.com>
To: Jeff Cody <jcody@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com,
 mreitz@redhat.com
Message-ID: <c0a0816b-9ff9-a285-dbe1-c5b4f78e6ee4@redhat.com>
Subject: Re: [PATCH v2 for-2.10 1/1] qemu-iotests: _cleanup_qemu must be
 called on exit
References: <815765cfcea726c7a4cc619c4f6c3bedb47f16b9.1492537347.git.jcody@redhat.com>
 <e649d1d3-6310-6607-22fe-82fc961d53c4@redhat.com>
 <20170418193129.GJ5704@localhost.localdomain>
In-Reply-To: <20170418193129.GJ5704@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/18/2017 02:31 PM, Jeff Cody wrote:
> On Tue, Apr 18, 2017 at 01:44:43PM -0500, Eric Blake wrote:
>> On 04/18/2017 12:45 PM, Jeff Cody wrote:
>>> For the tests that use the common.qemu functions for running a QEMU
>>> process, _cleanup_qemu must be called in the exit function.
>>>
>>> If it is not, if the qemu process aborts, then not all of the droppin=
gs
>>> are cleaned up (e.g. pidfile, fifos).
>>>

>>
>> Looks like you missed (at least?) 063
>>
>=20
> I did miss 156.  But unless I am missing something, 063 does not use
> common.qemu...

Good point. 063 does litter, even on success, however:

$ rm -rf scratch/
$ ./check -raw 063
=2E..
$ ls scratch/
t.raw.raw1

One idea presented in an earlier thread was that common.rc should create
a subdirectory per test (rather than all tests sharing scratch/), and
then common.rc itself install the cleanup hook that wipes out the entire
subdirectory (or maybe even add a command-line option to ./check to
suppress wiping when it is desirable to debug a test failure by seeing
the droppings left behind).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--UbmdEAF17PcUX33dPeJ69q2HK1RiQMGar
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY9mtgAAoJEKeha0olJ0Nq7iUH/0Jc0YlnwUd6jEgnzi7/gqqz
Lazg4eytrIvWs8A8l3QLdZ5hGKaGsVomyQmxOh5p/C9ud92En4LdJA1HFHnEC5Rs
0plKqEekxXtXvDa97ap8y4QvPyOLv5PcA3JYqxhEdxd1Hk3VPBgtmr/RRDqj3o9t
USBiBZkYo68BUegr9hbCZDYN5JqZXK829u2ytojDPbfXCvShWLAG1YCGq86zFiM4
NfMwOishUCLeCqbi+eUnHOv6RKcTHGN9YCFDpyd/odOQC6xF9xIX1hRNdJWbDD5c
sMdUKO8XzxD2pd4DGurv4WmHDmJJDMDmLY4sVtiQOUAU2cyc1y6YqkuKo7TwfXY=
=q/IO
-----END PGP SIGNATURE-----

--UbmdEAF17PcUX33dPeJ69q2HK1RiQMGar--
