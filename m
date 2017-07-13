Received: from eggs.gnu.org ([2001:4830:134:3::10]:33625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dVSST-0001Td-T1
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 20:58:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dVSSP-0005ak-Nc
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 20:58:21 -0400
Date: Thu, 13 Jul 2017 10:57:40 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170713005740.GR4083@umbus.fritz.box>
References: <20170712055317.26225-1-david@gibson.dropbear.id.au>
	<8b7aefb2-66e3-bc2b-ce13-11b130c85ce4@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kJZGYML2m3vFaueA"
Content-Disposition: inline
In-Reply-To: <8b7aefb2-66e3-bc2b-ce13-11b130c85ce4@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCHv2 0/8] spapr: DRC cleanups (part
 VI)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Cc: mdroth@linux.vnet.ibm.com, groug@kaod.org, lvivier@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, sjitindarsingh@gmail.com, bharata@linux.vnet.ibm.com


--kJZGYML2m3vFaueA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 12, 2017 at 10:48:38AM -0300, Daniel Henrique Barboza wrote:
> The dreaded Libvirt hotplug-migrate-hotunplug scenario is working nicely.

Good to hear.

> device_add when the machine is in RUN_STATE_PRELAUNCH (-S) still doesn't
> work but it is expected - as discussed in "[RFC drcVI PATCH] spapr: reset
> DRCs
> on migration pre_load=E2=80=8B", this scenario can't be fixed solely by t=
his DRC
> cleanup.

Hmm.. what's the exact test case you're using here?  The prelaunch
case I tried _did_ work (queueing the event during prelaunch, then
completing the hotplug sequence once the guest had booted).

> Given that we'll review the DT code sometime in the future I guess we can
> postpone the fix for device_adding in pre-launch for that time.
>=20
>=20
> Tested-by: Daniel Barboza <danielhb@linux.vnet.ibm.com>
>=20
> On 07/12/2017 02:53 AM, David Gibson wrote:
> > This sixth set of DRC cleanup patches is a complete rework of DRC
> > state management.  We stop tracking some unnecessary things, and
> > change the basic state representation to a simpler and more robust
> > model.
> >=20
> > Many of the patches in this set "break" migration from earlier git
> > snapshots, but not from any released qemu version.  The previous
> > migration stream format had multiple problems, so better to fix them
> > now, before 2.10 is out.
> >=20
> > Although there are certainly more things that can be improved in the
> > DRC system, with this series we should have a solid foundation for
> > migrating DRCs - the state trasferred is about as minimal and well
> > defined as it's possible to be.
> >=20
> > Changes since v1:
> >    * Rebased onto current tree
> >    * Added cleanup to unplug path
> >    * Added restriction of DR-indicator to physical DRCs
> >    * Included revised version of Laurent's patch to correctly handle
> >      things "hot" plugged before incoming migration
> >=20
> > David Gibson (7):
> >    spapr: Remove 'awaiting_allocation' DRC flag
> >    spapr: Simplify unplug path
> >    spapr: Refactor spapr_drc_detach()
> >    spapr: Cleanups relating to DRC awaiting_release field
> >    spapr: Consolidate DRC state variables
> >    spapr: Remove sPAPRConfigureConnectorState sub-structure
> >    spapr: Implement DR-indicator for physical DRCs only
> >=20
> > Laurent Vivier (1):
> >    spapr: Treat devices added before inbound migration as coldplugged
> >=20
> >   hw/ppc/spapr.c             |  89 +++-------
> >   hw/ppc/spapr_drc.c         | 399 ++++++++++++++++++++++++------------=
---------
> >   hw/ppc/spapr_pci.c         |  17 +-
> >   hw/ppc/trace-events        |   3 +-
> >   include/hw/ppc/spapr_drc.h |  74 ++++++---
> >   5 files changed, 301 insertions(+), 281 deletions(-)
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--kJZGYML2m3vFaueA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZZsWEAAoJEGw4ysog2bOSgpEQAIm2rmndyPjo20deys4f/JJZ
dbTtAF37YvBoJs64R7DTJZn4VRr/E0YlI9ZSz3uw+LgM/cAjHX4yY1EK6+Vn0YjM
R70XWgo9PcSKUOPtrs+VjOLunGgdIyJykMCwQiuppVbWF3eJIZRr7LV36CUfmad/
gWMZP4OH3801QnGXoblwrTcu1Jt8WxrgWFKtDMejWGJxMj3CY36BY4MMG+w3pfT2
GZlNcjqrtlZmVKjkyBzzhQm6deDoXfgS4CNWQANFqog0A/Yq88DAEuIrB2fY7TKl
R3sRsN5HsGiW1dt1W0Z78/ciU59LltC0VCPHVsdWUCSzP4croRb6eLH39Nz5mZDI
DDMQXJBGz5gT5kogm+6HY0OpLqHQwomu5o2bSSbUY8zlfTfAHABSjOOslCLRsE6Q
/LFw20i0vuzKojkOeEyBsMxHJy3hNwsE8h0zH2VYQT/pFb9YrwVRZZFxCUavY6Gn
yzlkde2PgyYBLs6Oqv62Li3H3vk3TPoCBPOODd57jQt6tmwy0Pj/lHOJbhMEk59j
gD/xkYTUfbWGxZZCEDhdOhBoj9gChv007/uEDPYYfEJ4QGPWwH4NqOprFRp2gDrv
WHmEXa3wq7jG/zXeEqzCpSjFmiZ/f0hmDFnbnEner8HWrbpRrnOqcXyhvGNJFYhZ
SkvFtytVj6J89/LOeQgY
=ijnB
-----END PGP SIGNATURE-----

--kJZGYML2m3vFaueA--
