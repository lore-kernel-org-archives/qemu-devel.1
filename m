Received: from eggs.gnu.org ([209.51.188.92]:34805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hEHXh-0001w3-4X
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 14:01:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hEHXd-0000Rd-6q
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 14:01:49 -0400
References: <20190401140903.19186-1-eblake@redhat.com>
	<20190401140903.19186-8-eblake@redhat.com>
	<22c4f9fa-a740-0d01-7b45-c802817f4f6c@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1b8e1af8-cde5-75d5-a4d4-a0b6d56e6608@redhat.com>
Date: Wed, 10 Apr 2019 13:01:38 -0500
MIME-Version: 1.0
In-Reply-To: <22c4f9fa-a740-0d01-7b45-c802817f4f6c@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="8n8u6I1ehrjWNfSgI7SYBycbTXmXXogK0"
Subject: Re: [Qemu-devel] [Qemu-block] [PULL 07/14] iotests: Add 241 to test
 NBD on unaligned images
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "open list:Block layer core" <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8n8u6I1ehrjWNfSgI7SYBycbTXmXXogK0
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>
Message-ID: <1b8e1af8-cde5-75d5-a4d4-a0b6d56e6608@redhat.com>
Subject: Re: [Qemu-block] [PULL 07/14] iotests: Add 241 to test NBD on
 unaligned images
References: <20190401140903.19186-1-eblake@redhat.com>
 <20190401140903.19186-8-eblake@redhat.com>
 <22c4f9fa-a740-0d01-7b45-c802817f4f6c@redhat.com>
In-Reply-To: <22c4f9fa-a740-0d01-7b45-c802817f4f6c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 4/10/19 12:45 PM, Max Reitz wrote:
> On 01.04.19 16:08, Eric Blake wrote:
>> Add a test for the NBD client workaround in the previous patch.  It's
>> not really feasible for an iotest to assume a specific tracing engine,=

>> so we can't really probe trace_nbd_parse_blockstatus_compliance to see=

>> if the server was fixed vs. whether the client just worked around the
>> server (other than by rearranging order between code patches and this
>> test). But having a successful exchange sure beats the previous state
>> of an error message. Since format probing can change alignment, we can=

>> use that as an easy way to test several configurations.
>>
>> Not tested yet, but worth adding to this test in future patches: an
>> NBD server that can advertise a non-sector-aligned size (such as
>> nbdkit) causes qemu as the NBD client to misbehave when it rounds the
>> size up and accesses beyond the advertised size. Qemu as NBD server
>> never advertises a non-sector-aligned size (since bdrv_getlength()
>> currently rounds up to sector boundaries); until qemu can act as such
>> a server, testing that flaw will have to rely on external binaries.
>>

>> +++ b/tests/qemu-iotests/241.out

>> +=3D=3D=3D Exporting unaligned raw image, forced server sector alignme=
nt =3D=3D=3D
>> +
>> +WARNING: Image format was not specified for '/home/eblake/qemu/tests/=
qemu-iotests/scratch/t.raw' and probing guessed raw.
>> +         Automatically detecting the format is dangerous for raw imag=
es, write operations on block 0 will be restricted.
>> +         Specify the 'raw' format explicitly to remove the restrictio=
ns.
>=20
> Is there a patch for this already?

Oh shoot. I saw the complaint about the hard-coded path needing a
filter, and still failed to fix it in time for 4.0-rc3. Not a driver for
-rc4 on its own, but if we have something else pop up that mandates
-rc4, I'll get that fix in.

Will post shortly...

>=20
> Also, I planned to reply to the original patch =E2=80=93 but where is i=
t?  The
> latest version I can see on the list is v3, and that only has seven
> lines in the reference output.  Well, the difference would explain why
> Vladimir would give a Tested-by to a test that clearly will not run on
> his machine.

Yeah, this line in the commit message is evidence of my botching things:

> [eblake: add forced-512 alignment, and nbdkit reproducer comment]

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--8n8u6I1ehrjWNfSgI7SYBycbTXmXXogK0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlyuL4IACgkQp6FrSiUn
Q2q7pAf/S13b2Nt/gvgjp96NtHWUI0kH8BcvzRYjCgmE4jQjt9rrVdQsjracpjyj
1x4xC62YNtYLEmLutU3fU+z6S/o1brtkz0mnddcb3XZWtMGg6RJECFa2R1muVKcu
B3t3lcW6QhsSdpcXm2hDI5k3idljpEPVmN2LuWrkg7anCHnAfnajmCZC9Hi6+t+W
+ZU0PorW9p6/4q75PlwcvDwC9Dz3cY/WZ0R/eQXaiSZEACMM5yulAvO2jz3IZ72P
V1pkKGgZTsnihCPVHtEqh1Z2hPISC8bAj1N0+lXlA+JkjZCmdo9Ht4/shqOawMf+
N0WofQer42WNBstR3AwwD+HsV6Hptg==
=f6sx
-----END PGP SIGNATURE-----

--8n8u6I1ehrjWNfSgI7SYBycbTXmXXogK0--
