Received: from eggs.gnu.org ([2001:4830:134:3::10]:60831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d0ql0-0002xe-0G
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 10:39:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d0qku-0008JZ-Ba
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 10:38:58 -0400
Date: Wed, 19 Apr 2017 16:38:38 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170419143838.GD5826@noname.redhat.com>
References: <1492104214-29994-1-git-send-email-kwolf@redhat.com>
	<1492104214-29994-4-git-send-email-kwolf@redhat.com>
	<6d7af73d-2dc1-88ab-0f66-0fa84661dbb0@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tsOsTdHNUZQcU9Ye"
Content-Disposition: inline
In-Reply-To: <6d7af73d-2dc1-88ab-0f66-0fa84661dbb0@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/3] qemu-iotests: Test postcopy migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, quintela@redhat.com, dgilbert@redhat.com, stefanha@redhat.com, lvivier@redhat.com, qemu-devel@nongnu.org


--tsOsTdHNUZQcU9Ye
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 13.04.2017 um 20:44 hat Eric Blake geschrieben:
> On 04/13/2017 12:23 PM, Kevin Wolf wrote:
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  tests/qemu-iotests/181     | 117 +++++++++++++++++++++++++++++++++++++=
++++++++
> >  tests/qemu-iotests/181.out |  38 +++++++++++++++
> >  tests/qemu-iotests/group   |   1 +
> >  3 files changed, 156 insertions(+)
> >  create mode 100755 tests/qemu-iotests/181
> >  create mode 100644 tests/qemu-iotests/181.out
> >=20
>=20
> I don't see a 180.out mentioned on-list anywhere (but the choice of test
> number is not too serious).

It's used by this one: [PATCH 00/18] nbd: BLOCK_STATUS

> ./check -raw 181
>=20
>  =3D=3D=3D Write something on the source =3D=3D=3D
>=20
> +WARNING: Image format was not specified for 'TEST_DIR/t.raw' and
> probing guessed raw.
> +Automatically detecting the format is dangerous for raw images, write
> operations on block 0 will be restricted.
> +Specify the 'raw' format explicitly to remove the restrictions.
>=20
>=20
> You'll want to fix that.

Thanks for catching this, will fix.

> > +# Slow down migration so much that it definitely won't finish before w=
e can
> > +# switch to postcopy
> > +silent=3Dyes
> > +_send_qemu_cmd $src 'migrate_set_speed 4k' "(qemu)"
> > +_send_qemu_cmd $src 'migrate_set_capability postcopy-ram on' "(qemu)"
> > +_send_qemu_cmd $src "migrate -d unix:${MIG_SOCKET}" "(qemu)"
> > +_send_qemu_cmd $src 'migrate_start_postcopy' "(qemu)"
> > +
> > +QEMU_COMM_TIMEOUT=3D1 qemu_cmd_repeat=3D10 silent=3Dyes \
> > +    _send_qemu_cmd $src "info migrate" "completed\|failed"
> > +silent=3Dyes _send_qemu_cmd $src "" "(qemu)"
>=20
> Do we want to tell the source to go back to a higher migrate_set_speed
> once we know we are in postcopy mode?  But the test passed for me under
> -qcow2 in less than 2 seconds, on an unloaded machine, so hopefully even
> on a heavily loaded machine we aren't giving up due to timeouts.

After switching to postcopy mode, the limits aren't applied any more
anyway (because the running VM is actively waiting for the pages and we
don't want to stall it artificially).

Kevin

--tsOsTdHNUZQcU9Ye
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJY93ZuAAoJEH8JsnLIjy/WZdAP/iluBRKrDzYbJ3ZeF5cj3Aol
xDsOX7j7fdge0SKKCVEeHogqol+GT67/nrSZockpQL5YVt3tnyBCNLZUIxREb5j0
y5D8/MN8fif9coczSX1q6zMopD6Kh1LivseWCM045eHMzqHX6sXIuzhMAQVVeZKG
FAT76mrkjdpKYzlQoTh+PBehzBSeM6dIc0ivmWGQ8bNC6YQA3IBn5tOwEDVCaw8S
CG1VBQcUM0KbRjBVRp2C4xTWa5RoL0TljOEh4QRIu34nmpF4yn0H5QHdaLiSOcmf
YDBTSM25EFAJ+ElUmd1ioraskHlVX24JKtRKNggUP3X1M5ujQZXLvX7jUXwqaTUJ
dyvkibBePNDBRxi1gbrgD+MKWQOUdt+0MFGoFSshDg82Fjig8t7BGw+ozesDAE3y
eQvBb1RVI3J+GEhRVg0wkuzeznodY66rBfYMbRzGpXdmKP+YGHDag254vPExkIwe
XReCc/xTlsSOHXi00JhjouZQQIcIWQgvgkStIakLacWzAsay4uJnF+IqumCTI2FR
PgrhqcPggoeSgxyeL6vTFqqGRizryjAKJ9pedPEuUidperWRCBnLyVYkGuGGg+VF
PmyfttEqLLBexKFw/9KCtf/V17R4dK1xmAAok5Q90VvqbxjFzZ5uwSNT+oo5Iiki
IrTrcmk0WBGYlQQ63ULl
=OIbk
-----END PGP SIGNATURE-----

--tsOsTdHNUZQcU9Ye--
