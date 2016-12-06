Received: from eggs.gnu.org ([2001:4830:134:3::10]:33056)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cEHPM-0005yJ-2g
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 10:11:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cEHPL-0000BA-2C
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 10:11:52 -0500
References: <1480973521-28945-1-git-send-email-jcody@redhat.com>
	<20161206100457.GI12630@stefanha-x1.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f8b4793b-9125-289b-43f4-ac2a98086ae8@redhat.com>
Date: Tue, 6 Dec 2016 09:11:41 -0600
MIME-Version: 1.0
In-Reply-To: <20161206100457.GI12630@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="rvb5XSBVtWTsDbxg1S9rgF1mQLgSnMNOi"
Subject: Re: [Qemu-devel] [Qemu-block] [PULL for-2.8 0/3] Block patches for
 -rc3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>, Jeff Cody <jcody@redhat.com>
Cc: peter.maydell@linaro.org, Prasanna Kumar Kalever <prasanna.kalever@redhat.com>, stefanha@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rvb5XSBVtWTsDbxg1S9rgF1mQLgSnMNOi
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>, Jeff Cody <jcody@redhat.com>
Cc: peter.maydell@linaro.org,
 Prasanna Kumar Kalever <prasanna.kalever@redhat.com>, stefanha@redhat.com,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Message-ID: <f8b4793b-9125-289b-43f4-ac2a98086ae8@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PULL for-2.8 0/3] Block patches for
 -rc3
References: <1480973521-28945-1-git-send-email-jcody@redhat.com>
 <20161206100457.GI12630@stefanha-x1.localdomain>
In-Reply-To: <20161206100457.GI12630@stefanha-x1.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/06/2016 04:04 AM, Stefan Hajnoczi wrote:

>>
>> Prasanna Kumar Kalever (3):
>>   block/gluster: fix QMP to match debug option
>>   block/nfs: fix QMP to match debug option
>>   qemu-doc: update gluster protocol usage guide
>>
>>  block/gluster.c      | 38 ++++++++++++++++-----------------
>>  block/nfs.c          |  4 ++--
>>  qapi/block-core.json |  8 +++----
>>  qemu-doc.texi        | 59 +++++++++++++++++++++++++++++++++++++++----=
---------
>>  qemu-options.hx      | 25 ++++++++++++++++++++--
>>  5 files changed, 93 insertions(+), 41 deletions(-)
>=20
> BlockdevOptionsGluster.debug(-level) does not have "Added in 2.8" so I
> had to dig through git-blame(1) to verify that it was indeed added in
> the current release cycle.

Then that implies we should add yet one more patch that adds the
appropriate versioning information to all the gluster fields added for
2.8.  My reviewed-by was given on the assumption that debug was in 2.7
and that this was a break from 2.7 behavior, but that we already KNOW
we're breaking blockdev-add between 2.7 and 2.8; while your argument is
that there is no backwards incompatibility because it was not in 2.7 to
begin with.  I think both reasons are indeed acceptable, but it also
means that my reason was flawed because of the incomplete documentation.

>=20
> In the future please make sure all QAPI changes are marked by version.

Indeed, and I try to flag it in my reviews as often as I notice it.

> If there tricky changes you can include a statement showing you are
> aware of QAPI backwards compatibility ("These new options were added in=

> the 2.8 release cycle and can therefore still be changed without
> breaking backward compatibility").  This will make me confident that
> you've checked the QAPI changes.
>=20
> Thanks, applied to my staging tree:
> https://github.com/stefanha/qemu/commits/staging
>=20
> Stefan
>=20

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--rvb5XSBVtWTsDbxg1S9rgF1mQLgSnMNOi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYRtUtAAoJEKeha0olJ0NqbYIH/jcf7pUaSJIcZ1kAEhW6c45x
nkk1cbuP4F1cfmKy0G8O0bAQVm/JjSji9agj6tu30vQFmK5crs7aqhlh97Bypwti
Uh5LkuNpApoO0ygtjCaim7Gu15o04l83t3OFShjDpVRkTX+knmMJuIgb9/XTl1XX
Lfr6xAO/+M03czvd6d5AbAJWTzgwfyxgfzDvuqgAJ3Kz4ziVEuSY6mypZGNeGztl
WPCsV4pKebk34Y86H5jDhsKMLFHVD2KNxmcyxjssiv7wLTgw8o57qMuJZzB3qmNh
lj8tzgmNTUfFvQ0x2m2NdXDHkDbElaZnVRHhnYhQBUmo0ybGDYYneUiOeLvuqy4=
=/ec5
-----END PGP SIGNATURE-----

--rvb5XSBVtWTsDbxg1S9rgF1mQLgSnMNOi--
