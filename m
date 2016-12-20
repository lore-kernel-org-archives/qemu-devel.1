Received: from eggs.gnu.org ([2001:4830:134:3::10]:55681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cJH1u-0001Gw-Em
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 04:48:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cJH1q-000877-FC
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 04:48:18 -0500
Received: from mail-wj0-x241.google.com ([2a00:1450:400c:c01::241]:33866)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cJH1q-00086j-9U
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 04:48:14 -0500
Received: by mail-wj0-x241.google.com with SMTP id xy5so26824746wjc.1
	for <qemu-devel@nongnu.org>; Tue, 20 Dec 2016 01:48:14 -0800 (PST)
Date: Tue, 20 Dec 2016 09:48:10 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20161220094810.GD5602@stefanha-x1.localdomain>
References: <1a3a7aef-55f1-11b6-b33f-621979cbb59f@profihost.ag>
	<1383290552.4515122.1481729638569.JavaMail.zimbra@oxygem.tv>
	<32c0e94e-8beb-03f3-2605-46225500e6ad@profihost.ag>
	<464605215.4528644.1481784392571.JavaMail.zimbra@oxygem.tv>
	<ba2e2786-a7ba-5ad9-86ef-aae1c4def034@profihost.ag>
	<20161219110346.GC17374@stefanha-x1.localdomain>
	<549beab5-be5b-f8dc-ff3a-a7ce483324e3@profihost.ag>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VMt1DrMGOVs3KQwf"
Content-Disposition: inline
In-Reply-To: <549beab5-be5b-f8dc-ff3a-a7ce483324e3@profihost.ag>
Subject: Re: [Qemu-devel] any known virtio-net regressions in Qemu 2.7?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: Alexandre DERUMIER <aderumier@odiso.com>, qemu-devel <qemu-devel@nongnu.org>, power-management@lists.fedoraproject.org, jskarvad@redhat.com


--VMt1DrMGOVs3KQwf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 19, 2016 at 07:37:30PM +0100, Stefan Priebe - Profihost AG wrot=
e:
> Am 19.12.2016 um 12:03 schrieb Stefan Hajnoczi:
> > On Fri, Dec 16, 2016 at 10:00:36PM +0100, Stefan Priebe - Profihost AG =
wrote:
> >>
> >> Am 15.12.2016 um 07:46 schrieb Alexandre DERUMIER:
> >>> does rollbacking the kernel to previous version fix the problem ?
> >>
> >> The culprit is the used tuned agent from Redhat
> >> (https://github.com/redhat-performance/tuned). The used profile
> >> virtual-host results in these problems. Stopping tuned or using another
> >> profile like throughput-performance everything is fine again.
> >=20
> > Interesting discovery.  Have you filed a bug report about it?
>=20
> As we're not using RHEL, nor CentOS i didn't expect this to make sense
> ;-) I just believed that something in the kernel changed.

I see.  At least the tuned maintainers are aware of it now.  If others
report the same problem maybe it can be solved.

Thanks!

Stefan

> >> after upgrading a cluster OS, Qemu, ... i'm experiencing slow and
> >> volatile network speeds inside my VMs.
> >>
> >> Currently I've no idea what causes this but it's related to the host
> >> upgrades. Before i was running Qemu 2.6.2.
> >>
> >> I'm using virtio for the network cards.
> >=20
> > Stefan
> >=20

--VMt1DrMGOVs3KQwf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYWP5aAAoJEJykq7OBq3PIoBwH/1v0wfO1IJLba946D0NXLf/f
GTFN5T/aBwBaikHp9l+HWqFU7FBpzSIsYC9nvFFmbKuBgknUH72fsTJxUw6iNLBw
XY9Q1nbs/gh2aYFDrKcE5sjbrFuBfKjgA5aLbTSD7Zv3Cq4T872+cw89N8ZWtZv8
LyXTyglFkS4V5UQ6D+svYww7a6IhUQ+paxHCSt6qRWbBIRXwUKE05oxy912RI0Sm
CuQYsVZiNKqBp/NRvLNTVbPND/t3oliHhK7ZRjfz7KWQ7b8DuMHcOifrnILM+7my
Apg/YssOPHta2/LkbLxGjjXO7AYz+VHI9qQ/DpCUcyWMm78gjDnTtSZ6H3B++u8=
=137i
-----END PGP SIGNATURE-----

--VMt1DrMGOVs3KQwf--
