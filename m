Received: from eggs.gnu.org ([2001:4830:134:3::10]:53801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dCdaz-0006Tz-C7
	for qemu-devel@nongnu.org; Sun, 21 May 2017 23:01:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dCdaw-0005X2-Cc
	for qemu-devel@nongnu.org; Sun, 21 May 2017 23:01:21 -0400
Date: Mon, 22 May 2017 12:36:32 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170522023632.GJ30246@umbus.fritz.box>
References: <1495172439-1504-1-git-send-email-bharata@linux.vnet.ibm.com>
	<1495172439-1504-2-git-send-email-bharata@linux.vnet.ibm.com>
	<20170519073303.GK12284@umbus.fritz.box>
	<b39e67c9-f7e7-9277-56e5-8e0769efc15d@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ed/6oDxOLijJh8b0"
Content-Disposition: inline
In-Reply-To: <b39e67c9-f7e7-9277-56e5-8e0769efc15d@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH v2 1/4] migration: Introduce
 unregister_savevm_live()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: Bharata B Rao <bharata@linux.vnet.ibm.com>, rnsastry@linux.vnet.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, sam.bobroff@au1.ibm.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>


--ed/6oDxOLijJh8b0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 19, 2017 at 03:14:35PM +0200, Laurent Vivier wrote:
> On 19/05/2017 09:33, David Gibson wrote:
> > On Fri, May 19, 2017 at 11:10:36AM +0530, Bharata B Rao wrote:
> >> Introduce a new function unregister_savevm_live() to unregister the vm=
state
> >> handlers registered via register_savevm_live().
> >>
> >> register_savevm() allocates SaveVMHandlers while register_savevm_live()
> >> gets passed with SaveVMHandlers. During unregistration, we  want to
> >> free SaveVMHandlers in the former case but not free in the latter case.
> >> Hence this new API is needed to differentiate this.
> >>
> >> This new API will be needed by PowerPC to unregister the HTAB savevm
> >> handlers.
> >>
> >> Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
> >=20
> > Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> >=20
> > I could take this through my tree, but it would need an ACK from Dave
> > Gilbert or Juan Quintela.
>=20
> I cc: them for that.

Dave, Juan: his is fairly urgent, since it's a prereq for (sanely)
fixing a migration bug.  Please let me know what I can do to expedite
review.

>=20
> Just a comment on the patch.
>=20
> Instead of introducing a new function, perhaps we can homogenize the use
> of register_savevm() by always providing a SaveVMHandlers pointer and
> never a couple of (SaveStateHandler, LoadStateHandler) so the
> unregister_save() has never to free se->ops?

Sounds reasonable to me.  Again, Dave?  Juan?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ed/6oDxOLijJh8b0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZIk6wAAoJEGw4ysog2bOSAiQP/j22R0ZZ7itkJlh5QflsJniT
2catZYbfTvCRieRnr6W9TUDDU09SbVHYH4oDGu2r8HZwgJumwZyPUhEQhMQ+WihW
k8HJ2o5kOq3FO1T89l62shNDUO/cIDlISHuXehCw5BRrTbDoApmB604CeO3dcWKZ
W3SJcN0jKovmugAUayCwB9ylsJkE2nbx/sT5dAds2jomMy+wT0bICo+5dXBhPmmz
66egjhx3RVsQdjz3ePF0rF8ImVJEvYd1QXNzxe6uKnZK21b3MyXDBnmYtDxrWL0N
/r6g0a9csX4WsQSqpx6+S8RcBOt1Y3CUygX+gvTgCvtNoLkdm9Zcg9cAmJNvtSbJ
Z0f0sIj8ZGiy9yOEYQcpBr424wKJ/sQ44uPVqOSJaaO6t+xRLakHPVZw3zjyAdtN
we3ktwuACUgc5uurOHuHJz3y8IYLwE1DilnC9aCnARt71BQwmLH8ta4OcMo4bR5l
R4Mb7/HfRo+HrsJJTJpo2iLqol98TzXLeNV4v2cxLUchk6QO+8rlMzM3OGVk7/pO
nHgYq5F38YlQnBV2FUARezGxOvycY0tALgDcwAMbPBQFAOwYy8HuGXGmoVGva1kC
RfHiF7YK5Vg7eUyWrYkZJmIrWI1XDETWZpm0Wk36ockZ7x4KplGUmRptDo6gNNMR
0JBkz+2BkpAIBlh7rbsv
=CWMj
-----END PGP SIGNATURE-----

--ed/6oDxOLijJh8b0--
