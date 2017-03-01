Received: from eggs.gnu.org ([2001:4830:134:3::10]:39856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1civKj-0000aV-86
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 22:53:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1civKh-00039j-Ik
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 22:53:45 -0500
Date: Wed, 1 Mar 2017 13:52:27 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170301025227.GJ12571@umbus.fritz.box>
References: <20161222052212.49006-1-aik@ozlabs.ru>
	<20161222052212.49006-2-aik@ozlabs.ru>
	<20170102233423.GH12761@umbus.fritz.box>
	<36816bd7-9fc5-17a1-b5c2-1bfd0ece7988@ozlabs.ru>
	<396ef8ef-78b2-8ec9-e4d6-b45b05daa93b@redhat.com>
	<20170210004151.GQ27610@umbus.fritz.box>
	<65ea0f7e-7b4e-94df-491e-2ee15498a9bb@ozlabs.ru>
	<20170301010614.GF12571@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MzdA25v054BPvyZa"
Content-Disposition: inline
In-Reply-To: <20170301010614.GF12571@umbus.fritz.box>
Subject: Re: [Qemu-devel] [PATCH qemu 1/2] exec, kvm,
 target-ppc: Move getrampagesize() to common code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--MzdA25v054BPvyZa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 01, 2017 at 12:06:14PM +1100, David Gibson wrote:
> On Tue, Feb 28, 2017 at 07:12:53PM +1100, Alexey Kardashevskiy wrote:
> > On 10/02/17 11:41, David Gibson wrote:
> > > On Thu, Feb 09, 2017 at 12:48:19PM +0100, Paolo Bonzini wrote:
> > >>
> > >>
> > >> On 09/02/2017 06:43, Alexey Kardashevskiy wrote:
> > >>> On 03/01/17 10:34, David Gibson wrote:
> > >>>> On Thu, Dec 22, 2016 at 04:22:11PM +1100, Alexey Kardashevskiy wro=
te:
> > >>>>> getrampagesize() returns the largest supported page size and main=
ly
> > >>>>> used to know if huge pages are enabled.
> > >>>>>
> > >>>>> However is implemented in target-ppc/kvm.c and not available
> > >>>>> in TCG or other architectures.
> > >>>>>
> > >>>>> This renames and moves gethugepagesize() to mmap-alloc.c where
> > >>>>> fd-based analog of it is already implemented. This renames and mo=
ves
> > >>>>> getrampagesize() to exec.c as it seems to be the common place for
> > >>>>> helpers like this.
> > >>>>>
> > >>>>> This first user for it is going to be a spapr-pci-host-bridge whi=
ch
> > >>>>> needs to know the largest RAM page size so the guest could try
> > >>>>> using bigger IOMMU pages to save memory.
> > >>>>>
> > >>>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> > >>>>
> > >>>> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> > >>>>
> > >>>> Seems sensible to me, but I'm not comfortable merging this via my =
tree
> > >>>> since it touches such core code.  Probably should go via Paolo.
> > >>>
> > >>> Paolo, ping?
> > >>
> > >> It's just code movement, go ahead.
> > >=20
> > > Ok, I've merged this in my tree.
> >=20
> >=20
> > I cannot find it in any public tree, where did it go?
>=20
> Bother, I thought I'd applied it, but I seem to have mislaid it.  Can
> you resend it to me please.

So, I manage to dig this up from my archives, but it doesn't seem to
apply properly on the current tree.  The actual merge conflicts were
easy to resolve, but then it doesn't compile.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--MzdA25v054BPvyZa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYtjdpAAoJEGw4ysog2bOSLTQP/1qOSOnefmXcJOq95nez4bRS
UnyWZ4EKiL+4zuZAWVGYShkYtql+CYIg6zJaDRdfBtKgyzRHj3vKvX+XQud6N/g+
EI4U2bWtqXk/MVx7KQfqJVxTroyQNW0ida5/KUtPxBQqb9yq7sOnQG7NlqPwqUJz
OMYys/ZwEabiszjaqc96llimG25/5pa+wy8lX5Z+US8z0S7VV/zyh1IHWixf1L0R
gf162TmWpcLXuHzS9Ukh/wb8y3lgJhegrAuXh78YVnYs+K4O3KN0XLb3PFHPOH2h
5UJPraR+iNwCsAONb4/i6tlf7k5W2lbyCP9I0PbWRI5RCrjqafpM9dx3Qn9Ty4D4
9WYZewQuMnb73jEtmuOtQHrS5K9CgsyClulzMkqmg72O+nC2k8I0lgR13KrG7sCl
JEd68deutHOkt9uz0GIDXJxsFwaiwtGB/UkVqw2I9d1212h4jAUA9x6B6/gMJpQI
YGnqAQyQdmGvIyVAremg8PAc83eMHzcSZx+uTt78duWA0GGRrsI+sqA7PpZRZtCP
MujIAUY+R2Zd9COVlduMoHrysQ2ssrrqJE5icqgvV+5kZe0HmxdfligfLdqX09d9
PKjqKAaHeQwXsql7YHikuuP8Reqe3SLEwbOSEZP6ns9Ro5ogo+E05qy3l4SSw8lh
gL/Xc9duK+aWeZiGppCg
=MOuF
-----END PGP SIGNATURE-----

--MzdA25v054BPvyZa--
