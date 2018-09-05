Received: from eggs.gnu.org ([2001:4830:134:3::10]:48312)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fxZLy-0007l5-CR
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 11:04:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fxZLv-0001Ib-KL
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 11:04:21 -0400
Date: Wed, 5 Sep 2018 17:04:08 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180905150408.GD4489@localhost.localdomain>
References: <20180828142626.GM122225@angien.pipo.sk>
	<20180903150311.GC14463@dhcp-200-186.str.redhat.com>
	<w51bm9dl81j.fsf@maestria.local.igalia.com>
	<20180904141730.GC3803@andariel.pipo.sk>
	<w515zzll3xy.fsf@maestria.local.igalia.com>
	<20180904150042.GE3803@andariel.pipo.sk>
	<20180904153436.GC4371@localhost.localdomain>
	<20180905123813.GF3803@andariel.pipo.sk>
	<eff7c4ef-9db7-2b80-b853-e68bf60f4a73@redhat.com>
	<20180905140238.GG3803@andariel.pipo.sk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mvpLiMfbWzRoNl4x"
Content-Disposition: inline
In-Reply-To: <20180905140238.GG3803@andariel.pipo.sk>
Subject: Re: [Qemu-devel] [PATCH 1/2] commit: Add top-node/base-node options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Krempa <pkrempa@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com


--mvpLiMfbWzRoNl4x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 05.09.2018 um 16:02 hat Peter Krempa geschrieben:
> On Wed, Sep 05, 2018 at 08:48:15 -0500, Eric Blake wrote:
> > On 09/05/2018 07:38 AM, Peter Krempa wrote:
> >=20
> > > block-commit is able to reopen the format layers and works as expecte=
d.
> > >=20
> > > Unfortunately though the 'read-only' option is actually useful as the
> > > curl-driver does not work without it:
> > >=20
> > > -blockdev {"driver":"http","url":"http://ftp.sjtu.edu.cn:80/ubuntu-cd=
/12.04/ubuntu-12.04.5-alternate-amd64.iso","node-name":"libvirt-2-storage",=
"discard":"unmap"}: curl block device does not support writes
> > >=20
> > > We obviously can encode that knowledge into libvirt but it will be ha=
rd
> > > to undo if qemu eventually supports writes in the curl driver.
> > >=20
> > > Which other protocol drivers don't support writes? in case we have to=
 go
> > > this way.
> >=20
> > When an NBD server exported an image as read-only, the NBD block client
> > cannot request write permissions.  But that's a runtime discovery proce=
ss,
> > not a limitation of the block driver itself.
>=20
> Hmmm, that's unfortunate. Because in some cases we don't know this fact
> upfront in libvirt and we also don't know whether an user might attempt
> to block-commit at some time.
>=20
> We probably do need a way to specify that we want
> 'read-write-if-possible' behaviour.

So after all, maybe we should try whether a read-only=3Dauto is possible,
which would reopen the image file on demand (depending on whether some
user of the node requested BLK_PERM_WRITE etc.)

Kevin

--mvpLiMfbWzRoNl4x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJbj/BoAAoJEH8JsnLIjy/WBaIP/jfC3+gxWSHpPb6lS9kv5yqg
n2lV9hYsNU6k5gNV46N1jdgvPcKYAUdWuq2HNsqkhBLQFXrvQ3Y1IUekvR+dN2Iv
BrtHMZLpWr0TUU9xr0n/A1M069MnPvbWVX9CzCHuTu4IwWeZQCKKDbU+UgpKyqdr
TDdycwIRaqAsnrilvQO89KW2jx3kv4iNmohh0crY7DGW9VpkNAFeW49W5Ylr76Um
UD+VZZq2S6bKUB5g6rAYbWxvEWzjmA7skJDxlOMXXGdBg2i6N68BPURfEqLfCGD8
bScWg2lfTEdPC4fLN7iPW5bT4q8lgac+oMFik1QpWPxmR2X8pYFU5w/kOGTkgGa4
pMzPJV4aGKnOI9eN6OoHYzh5hIvNqp/K8yeq2/uTrFAZP/z/WeQYFfY9cxojCTNp
EH8jfvrA6H5L17DS3lXQ1WosPIubdSeQsrdfKUwMwLy2LiJ/pCVs3d2b1m9t+1fZ
xJSHr4OuAVz6BGwstvMNe3n7addC/S6cSYer10gaa/bChs59Tvi9/gZtusf5lA31
UQ+JlBa62BEopCvx6cruKtEUcHo2hR8A/+RPpvZV6YjuxORXAmF9FU+kqz3ILobf
a4WvHAC4bI8IkwnLH30p1AHpEdTbFoA6RvI/mFm5PLMa2RyIRTvbmu0PYJviKpwR
JHUrpQRtRzhOsMuRxW/m
=jNmx
-----END PGP SIGNATURE-----

--mvpLiMfbWzRoNl4x--
