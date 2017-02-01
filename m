Received: from eggs.gnu.org ([2001:4830:134:3::10]:56607)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cZ3l9-0003Yt-Jb
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 17:52:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cZ3l6-0000Y5-HD
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 17:52:15 -0500
Date: Thu, 2 Feb 2017 09:27:39 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170201222739.GA13219@umbus.fritz.box>
References: <1485868319-16151-1-git-send-email-thuth@redhat.com>
	<1485868319-16151-2-git-send-email-thuth@redhat.com>
	<20170201001028.GA30639@umbus.fritz.box>
	<632092c8-aedf-c97b-8363-9a65ce86160e@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="45Z9DzgjV8m4Oswq"
Content-Disposition: inline
In-Reply-To: <632092c8-aedf-c97b-8363-9a65ce86160e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] ppc/kvm: Handle the "family" CPU via
 alias instead of registering new types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, Paolo Bonzini <pbonzini@redhat.com>, Bharata B Rao <bharata@linux.vnet.ibm.com>


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 01, 2017 at 08:39:47AM +0100, Thomas Huth wrote:
> On 01.02.2017 01:10, David Gibson wrote:
> > On Tue, Jan 31, 2017 at 02:11:58PM +0100, Thomas Huth wrote:
> >> When running with KVM on POWER, we are registering a "family" CPU
> >> type for the host CPU that we are running on. For example, on all
> >> POWER8-compatible hosts, we register a "POWER8" CPU type, so that
> >> you can always start QEMU with "-cpu POWER8" there, without the
> >> need to know whether you are running on a POWER8, POWER8E or POWER8NVL
> >> host machine.
> >> However, we also have a "POWER8" CPU alias in the ppc_cpu_aliases list
> >> (that is mainly useful for TCG). This leads to two cosmetical drawback=
s:
> >> If the user runs QEMU with "-cpu ?", we always claim that POWER8 is an
> >> "alias for POWER8_v2.0" - which is simply not true when running with
> >> KVM on POWER. And when using the 'query-cpu-definitions' QMP call,
> >> there are currently two entries for "POWER8", one for the alias, and
> >> one for the additional registered type.
> >> To solve the two problems, we should rather update the "family" alias
> >> instead of registering a new types. We then only have one "POWER8"
> >> CPU definition around, an alias, which also points to the right
> >> destination.
> >>
> >> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1396536
> >> Signed-off-by: Thomas Huth <thuth@redhat.com>
> >=20
> > Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> >=20
> > Updating the otherwise static table of aliases is kind of ugly, but
> > then so is registering an extra full type as we do now.
> >=20
> > Is this safe to apply without the follow up patch to vl.c.
>=20
> Yes. It fixes the problem with "query-cpu-definitions" already. You just
> need the other patch to get the output of "-cpu ?" right, too.

Great.  Applied to ppc-for-2.9.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--45Z9DzgjV8m4Oswq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYkmDYAAoJEGw4ysog2bOS4XoQANOewViVivsJCq8dVMfryXHn
g6+RTEKb4lvH39T/wSO6UIVjSqWmPLGapSg8RlzDkvsEa+tSVfCyXf5oOA9HiDgU
aM3kliWl0juUKfhpbv2OnVxPXzb7js5EvNjTcaQE4V9hmqvow6O18x2b1w5tHnNn
wqjZ2AMS71j9I17NGlMYpGFXsNuZcY6Qhxbphi1P1rJWeXeVN7oa0sVU4QvfddYl
4TWHbm+ZTtzkkErnC4/TKX2FIYO7vXi9+RHrSla6M+ez4Xyt0Zx4ajcS9vjtBG+6
wAGyWXT8BKD39VCDC24j+CqwwONvgqDJRkhv098G0asyHOjG2vJK4ObP0gmOdHVW
Tuc2nwdbkG5t7/bFuqwnOPehOQBUtDRS5e8cFqeZpCWm3kf/rVEFMxDwmMcdkhqg
QlJ/x3z+dFRtQkiIBKJbyQorZsLEFzudzzmEF9S1kvnfQ6E1aImvxqUN85CIJ8IF
r/1BPv/WsWtzRhOu5OBrwFdl4/dN3nC0nYgdmb0i8ErPfM0NsCbU44QD0F/UewxG
3o8PRAlTTijS2AlXKOb0DXSKT2q1yR61rNlyq8BN44cbnwx+1lnltyqkuK1KCSXE
sM3dxDow3hd7AovHxg561brzo01hIV7KMa4u5MrdqRK8w4ZVZaQFLz0CeSQyXFF3
rw7qpbYfWUiEwyKxUoUG
=7HYI
-----END PGP SIGNATURE-----

--45Z9DzgjV8m4Oswq--
