Received: from eggs.gnu.org ([2001:4830:134:3::10]:39360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cyg0d-0000NR-0h
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 10:46:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cyg0b-0003UJ-NA
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 10:46:07 -0400
References: <20170412204641.GA15762@localhost.localdomain>
	<f5bf12f4-e4fd-87c7-a714-e412cee63e36@redhat.com>
	<20170412222251.GB15762@localhost.localdomain>
	<20170412235420.GB8607@lemon>
	<20170413011109.GC15762@localhost.localdomain>
	<c74d2b7d-d185-53ba-9bf9-8cf976d8f684@redhat.com>
	<20170413143959.GE13387@stefanha-x1.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <53e4fffa-2e35-daff-0bbc-13d8992c9e90@redhat.com>
Date: Thu, 13 Apr 2017 09:45:49 -0500
MIME-Version: 1.0
In-Reply-To: <20170413143959.GE13387@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Vsa7B2a0G041knCb1CWpfSQfUtGcMhNgA"
Subject: Re: [Qemu-devel] Regression from 2.8: stuck in bdrv_drain()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kwolf@redhat.com, peter.maydell@linaro.org, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org, Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Vsa7B2a0G041knCb1CWpfSQfUtGcMhNgA
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kwolf@redhat.com, peter.maydell@linaro.org, Fam Zheng <famz@redhat.com>,
 qemu-block@nongnu.org, Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org,
 John Snow <jsnow@redhat.com>
Message-ID: <53e4fffa-2e35-daff-0bbc-13d8992c9e90@redhat.com>
Subject: Re: [Qemu-devel] Regression from 2.8: stuck in bdrv_drain()
References: <20170412204641.GA15762@localhost.localdomain>
 <f5bf12f4-e4fd-87c7-a714-e412cee63e36@redhat.com>
 <20170412222251.GB15762@localhost.localdomain> <20170412235420.GB8607@lemon>
 <20170413011109.GC15762@localhost.localdomain>
 <c74d2b7d-d185-53ba-9bf9-8cf976d8f684@redhat.com>
 <20170413143959.GE13387@stefanha-x1.localdomain>
In-Reply-To: <20170413143959.GE13387@stefanha-x1.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/13/2017 09:39 AM, Stefan Hajnoczi wrote:
> On Thu, Apr 13, 2017 at 01:45:55PM +0800, Paolo Bonzini wrote:
>>
>>
>> On 13/04/2017 09:11, Jeff Cody wrote:
>>>> It didn't make it into 2.9-rc4 because of limited time. :(
>>>>
>>>> Looks like there is no -rc5, we'll have to document this as a known =
issue.
>>>> Users should "block-job-complete/cancel" as soon as possible to avoi=
d such a
>>>> hang.
>>>
>>> I'd argue for including a fix for 2.9, since this is both a regressio=
n, and
>>> a hard lock without possible recovery short of restarting the QEMU pr=
ocess.
>>
>> It is a bit of a corner case (and jobs on I/O thread are relatively ra=
re
>> too), so maybe it's not worth delaying 2.9.  It has been delayed alrea=
dy
>> quite a bit.  Another reason I think I prefer to wait is to ensure tha=
t
>> we have an entry in qemu-iotests to avoid the future regression.
>=20
> I also think this does not require delaying the release:
>=20
> 1. It needs to be marked as a known issue in the release notes.
> 2. Let's roll the 2.9.1 stable release within a month of 2.9.0.
>=20
> If both conditions are met then very few end users will be exposed to
> the problem.  I hope libvirt will create IOThreads by default soon but
> for the time being it is not a widely used configuration.

Also, is it something that can be avoided by not doing a system_reset
while a block job is still running? Libvirt can be taught to block reset
while a job has still not been finished, if needs be.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Vsa7B2a0G041knCb1CWpfSQfUtGcMhNgA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY748dAAoJEKeha0olJ0NqlKgIAJ5hUE4j43WJ2PgIfTxzGw8C
58vgeee/qpkuB9vfLXNf7zeYFXndadjqGSuCweGV9jCxEfdOEQiCmVjiQ2Acxx5+
MlwMlygpBPUo8pkU088WE8Q/syXrOFmnIlNDdJ8Gyot+4XpEaCuRb5pFGJ1KvNp5
/XRY8Ypg3UqNRZk0bvoj3Z2NLaNGb+huYqlWCybRiD/lnMeWmv14b+y8Sff6zMbg
LtwvHwa/UIlqOICfK8u59rEk8fA4hZ7hZnQlJ++rTSLZ5S7ZPSzNeYk0SEnGOmos
3npBNYftzDaSI2hhuiz1RvbsOc4sdK/LROG1+lJDYuhgubzlxzZcnk5lRMBuz2A=
=Gbw0
-----END PGP SIGNATURE-----

--Vsa7B2a0G041knCb1CWpfSQfUtGcMhNgA--
