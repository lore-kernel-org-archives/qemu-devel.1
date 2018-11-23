Received: from eggs.gnu.org ([2001:4830:134:3::10]:55962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1gQ69r-0006xI-Tm
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 02:45:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1gQ69r-00018B-87
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 02:45:47 -0500
Date: Fri, 23 Nov 2018 08:45:33 +0100
From: Peter Krempa <pkrempa@redhat.com>
Message-ID: <20181123074533.GC7812@andariel.pipo.sk>
References: <1542912487-279165-1-git-send-email-andrey.shinkevich@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6zdv2QT/q3FMhpsV"
Content-Disposition: inline
In-Reply-To: <1542912487-279165-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 0/5] Discrad blocks during
 block-stream operation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com, vsementsov@virtuozzo.com, jcody@redhat.com, armbru@redhat.com, dgilbert@redhat.com, den@openvz.org, mreitz@redhat.com


--6zdv2QT/q3FMhpsV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 22, 2018 at 21:48:02 +0300, Andrey Shinkevich wrote:
> Hello everyone!
>=20
> The given feature discards blocks with copy-on-read operation while the
> streaming process runs. Adding the 'discard' argument to the QMP block-st=
ream
> command allows dropping a block in the backing chain after it has been co=
pied
> to the active layer. That will elude the block duplication in the interme=
diate
> backing file. It saves the disk space while external snapshots are being
> merged.

So you specifically want to merge the snapshot by pulling rather than
commiting? Do you have any specific reasons for that? I'm curious
because I plan to finally finish external snapshots in libvirt.

Allowing to pull into intermediate layers will be (or is?) very welcome
by libvirt since I plan to do external snapshot deletion/merging and
that will be greatly simplified by pulling.

On the other hand libvirt will not be able to always use 'discard' as
libvirt's API allows creating alternate histories for a VM and in such
case when merging a snapshot at a branching point we'll need to pull it
into multiple images. The 'discard' optimization can then be used only
with the last branch.

Libvirt's reasons for using 'block-stream' are mostly as it corresponds
to the operations necessary for not messing up the relationship between
the snapshot and which files on disk belong to it.

--6zdv2QT/q3FMhpsV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUn7DGLvflazX+2GwHGwCByjY1GoFAlv3sBsACgkQHGwCByjY
1GqBnxAAyMzwOBVM109pVAmZu89qMfv2kPIp+ahw4a3ujZny8CmwIARxyYZeArjj
jEG+olzoCU/fM/JI5sTC1X1hsTC0h/XJDLpiDy5/gdP2NhgBpzRGtqBrTL9VNO5P
7IOZFHG8Z+Rkf2vUXzx5y6wWVaueY4FSVcAk2+ITkcwqd36VufDWPwdOoku+vfpa
EG2AjT6UlEV8c7KgxhgQwGbBGYNc7t53FjShoZK+yEy3ftdl/ByZ0vrFhx0kyM5f
dB3w9qR0W8W/4f7tdWWRvwVvKc/aWGULm1nD3jbh9q2Q1IjGsJYZMEVZEl2GgwmI
GfRxqPwWOdf+d6XN01yELA4NQjbzUL2mJ9lHvjIldLsTkeyrHpgKebbkXJapmIUP
JHFBrbbxgrxyEPwFVY+PrJYJR8a8mlb+AzG35u8iU/PC4v0KLrduDmgMLDhelNIF
wKR7oAO6P75wMB1isbjbi1Zra772gn0g2zccNhjdw5u/wKWxuFnTO4q6QLkvkhJ9
HbjoexY4zzBpjl/2trcoXL5DUJG2xpZJ9Pg5pwQIx8RgPhF2Wge+5iYHF22OoMi9
KO2tIRudTeOSU+wBZ5zEKPTRNZb8A+hjfUUoag9gYORDFLI5NmiAjHID0ytVZx0L
mOH5iWQgUfOUal0d5qxUw+fPRuX/KfXodUv957OkgM88Sfj+W0c=
=QP5J
-----END PGP SIGNATURE-----

--6zdv2QT/q3FMhpsV--
