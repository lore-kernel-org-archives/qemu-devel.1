Received: from eggs.gnu.org ([2001:4830:134:3::10]:32839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dKpkF-0008EN-Hn
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 13:36:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dKpkC-0006CI-ET
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 13:36:47 -0400
Received: from smtp1.ntua.gr ([2001:648:2000:de::183]:60945)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dKpkC-0006B5-3B
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 13:36:44 -0400
Date: Tue, 13 Jun 2017 20:35:55 +0300
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Message-ID: <20170613173555.y256hkw3o4uiuucm@postretch>
References: <20170608182113.nmxnvus26vplg5du@postretch>
	<20170612111543.GC5232@noname.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6h7ot3rfu6vf4pvb"
Content-Disposition: inline
In-Reply-To: <20170612111543.GC5232@noname.redhat.com>
Subject: Re: [Qemu-devel] [Proposal] I/O throttling through new -object
 interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Alberto Garcia <berto@igalia.com>


--6h7ot3rfu6vf4pvb
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 12, 2017 at 01:15:43PM +0200, Kevin Wolf wrote:
>Am 08.06.2017 um 20:21 hat Manos Pitsidianakis geschrieben:
>to maintain compatibility with the existing interfaces. We will have to
>automatically insert or remove new nodes if 'block_set_io_throttle' is
>used, but let's not extend it. It only makes things complicated.
>
>If people are using new features, they will be using new interfaces and
>we can make them use more natural syntax. For example, we can expect
>that they create throttle nodes manually (management tools always, human
>users at least for more complicated cases). What we may want is to
>update the settings of a throttle node at runtime (though inserting a
>new filter and then removing the old one could do the trick as well).
>
>If we want to change the settings of a throttle node, then I think the
>appropriate low-level interface is bdrv_reopen(). We need to figure out
>whether we can expose a full bdrv_reopen() on QMP or whether we need
>more specific commands. I'd prefer finally doing the "real thing" rather
>than adding more and more special-case commands to update nodes.

So basically, restrict our involvement in the graph with=20
'block_set_io_throttle', which will only deal with editing the node at=20
the top of the tree, just below BB? (Unless the group name instead of=20
device name is specified). Can the user sufficiently manage a complex=20
configuration on their own with existing interfaces (ie blockdev-add)? =20

>I maintain my stance that I express off-list, which is that query-block
>should _only_ display limits that belong to the throttle node that was
>internally created for satisfying a 'block_set_io_throttle' request on a
>BlockBackend.

Assuming the answer to my first question is yes, that will always be the=20
throttle node below the queried BB.

--6h7ot3rfu6vf4pvb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvy2VxhCrsoeMN1aIc2J8L2kN9xAFAllAInsACgkQc2J8L2kN
9xAr3g//dhCMjJv4TIugQ/a2Lc8z9zcyhep37BpSrouJtytsipBUQIps46wDXiBC
BbFMzNsvQj4rVhnier5zlPOpoBtLk9p/FaiC7H9SVSlYp8iQveBRK7HWfu6b/bNr
2zWfzjvtaWR0GApGFulCgGO77oTs8VnxCmMelXfBEGaU6nK2+TpwlakxGGeWrdgI
DTHY0zhkBWBskLG+zNe/QIhSCzkDO6t+ZuR8tGJiZu7vh1lrbWA6LGxpGFV8M/8B
zj2yek+YKy3Fnz+eDmQMeOVmM5Eq67+PzmS+CsCN4VTvJOP29j22baor7g+HliEi
rRQI3Nof2U3Mq1tARI8OJPTKTY9WXyktBHGgkSMidXDvF3yhEZ4DgBFG2O9AOZFD
iogfGcbEMDGDM5cE0RA1T4PxZq6ecsbcp7zM25Kjz+z4c9YXwWkBSRL/he125Eda
ky/D4FwQBLjtJW+WgyA2Z1LCuUea01A/5nH/chitA3atXALMYPTeft31W7mNgLab
IWWicy80AhmKi9cZodQw9qBrjWXBEpWlrqFZoe2jjGgcW+VPsjyPtlSVOVtacDgy
2Ly1BN0qyfYaSo0xv5VkgG23jFvnRLHyVYN3CHydb+kCbUt/mxcIO/0Lk1JM3JSy
o8EVUKSulYg94egqNYBI95DEFrQXAaepUKcUjNcdPXNc8iTlMro=
=lT0D
-----END PGP SIGNATURE-----

--6h7ot3rfu6vf4pvb--
