Received: from eggs.gnu.org ([2001:4830:134:3::10]:49347)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dc4D5-0008VD-QQ
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 02:29:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dc4D1-0000hq-HE
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 02:29:47 -0400
Date: Mon, 31 Jul 2017 14:58:21 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170731045821.GE2652@umbus.fritz.box>
References: <150100547373.27487.3154210751350595400.stgit@bahia>
	<150100578691.27487.8944448515009831240.stgit@bahia>
	<20170728040257.GI3098@umbus.fritz.box>
	<c3750e7d-47af-4cd4-9121-73d8d8d0f81e@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OaZoDhBhXzo6bW1J"
Content-Disposition: inline
In-Reply-To: <c3750e7d-47af-4cd4-9121-73d8d8d0f81e@redhat.com>
Subject: Re: [Qemu-devel] [for-2.11 PATCH 24/26] spapr: allow guest to
 update the XICS phandle
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>


--OaZoDhBhXzo6bW1J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 28, 2017 at 08:20:57AM +0200, Thomas Huth wrote:
> On 28.07.2017 06:02, David Gibson wrote:
> > On Tue, Jul 25, 2017 at 08:03:06PM +0200, Greg Kurz wrote:
> >> The "phandle" property of the XICS node is referenced by the "interrup=
t-map"
> >> property of each PHB node. This is used by the guest OS to setup IRQs =
for
> >> all PCI devices.
> >>
> >> QEMU uses an arbitrary value (0x1111) for this phandle, but SLOF conve=
rts
> >> this value to a SLOF specific one, which is then presented to the gues=
t OS.
> >>
> >> This patches introduces the new KVMPPC_H_UPDATE_PHANDLE hcall, which i=
s used
> >> by SLOF to communicate the patched phandle value back to QEMU. This va=
lue
> >> is then cached and preserved accross migration until machine reset.
> >>
> >> This is required to be able to support PHB hotplug.
> >>
> >> Note, that SLOF already has some code to call KVMPPC_H_RTAS_UPDATE, so=
 we
> >> have to introduce its number even if QEMU currently doesn't implement =
it.
> >>
> >> Suggested-by: Thomas Huth <thuth@redhat.com>
> >> Signed-off-by: Greg Kurz <groug@kaod.org>
> >=20
> > Ugh.  I really, really hope we can avoid this, though I don't
> > immediately see how.  Having to have two way communication between
> > qemu and SLOF about the device tree contents just seems like opening
> > the door to endless complexities.
> >=20
> > This is basically a consequence of the fact that both qemu and partly
> > responsible for constructing the device tree for the guest, and that's
> > not easy to avoid.
> >=20
> > Hrm.. Thomas, I know it's not really the OF way, but would it be
> > feasible to change SLOF to use the phandles as supplied by qemu rather
> > than creating its own?
>=20
> I don't see a way to do this in an easy, clean, reasonable way. SLOF
> uses pointers to internal structures as phandles all over the place. You
> likely can't replace that so easily without rewriting half of the whole
> device tree related code in SLOF, I guess...

Dang, that's what I suspected.

Just to be clear the phandles are used directly as raw pointers?
There's not even some lookup macro we could change?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--OaZoDhBhXzo6bW1J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAll+uOgACgkQbDjKyiDZ
s5KvXg//VvEmfy5WkRPRWu3VAw1GfrZn24jUVAmUgeH9Guf9QLV9YNRcUm66vHc/
LP4fl3augDWghWuJJU2/wyMqElW7gwJb+CmsLYwWaNoRDW9yNbQk3Ay6aG51do9I
9YM8SoylYNvVNqIDcKPv6TRfoeEeKtW3XVx6kqydn7iWo+kdFE8qTEkZzzCrXTnL
S2XXbQTIA8pFxNo21tK6NhIcW7zNhi06f1CC/9sKqIiAHj7a0ZoCNPFHeKIjqv0t
n3//NFfnBBK9V+cxTAnMJARuacrVtDlSpzcl+7QJ8RtbU3tFGBkWBynoFLpRhJMD
v/W+RKkemKkENnrkTxijUYnj+Lg1CGHkDesuI5ujl/wAYKGno46/ZjiwEeJt3rN1
Td71fr0LV7x+XHsmY7aNGrtLrVXVzENI3l8dpDF4rYveTjlHl1WpIVyr0285a4+r
PkpJj6X9cUodIcinO4COLE17y2P1U8xR3Zp9GZv0Y/3TBMTmL1QqVuVjFtMpFrpw
OgeMLCezy5xjbUj1zTzMHXO572HImEjtKrNiYuKU2IYcnGtUWNWbnSo8YFFfjVik
LHKv64EvEC0FUAFtqj3prw5E6JHbRBTnmoUGywqwTUracCkdc7BTEeLXmwS2By9Q
ykTmNOiXH5TjardDo5VCme+s5VbTpGeMry13Es5k8YdCeKblACU=
=7BO7
-----END PGP SIGNATURE-----

--OaZoDhBhXzo6bW1J--
