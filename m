Received: from eggs.gnu.org ([2001:4830:134:3::10]:49474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1dV2ak-0007LQ-GS
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 17:21:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1dV2ah-0004xn-C0
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 17:21:10 -0400
Message-ID: <1499808035.2865.27.camel@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 12 Jul 2017 07:20:35 +1000
In-Reply-To: <c6d3bf29-9d5e-6b1c-f3b0-282fd16ec39f@kaod.org>
References: <1499274819-15607-1-git-send-email-clg@kaod.org>
	<1499274819-15607-4-git-send-email-clg@kaod.org>
	<20170710102655.GE4083@umbus.fritz.box>
	<9a7a16a0-f14f-bc65-d503-e2aee028633f@kaod.org>
	<1499720443.2865.15.camel@kernel.crashing.org>
	<57c22926-8ac9-1251-aba9-590b344673c6@kaod.org>
	<20170711132751.GJ4083@umbus.fritz.box>
	<c6d3bf29-9d5e-6b1c-f3b0-282fd16ec39f@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 03/26] target/ppc/POWER9: add
 POWERPC_EXCP_POWER9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
Cc: Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On Tue, 2017-07-11 at 15:52 +0200, C=C3=A9dric Le Goater wrote:
>=20
> > Just as we could build a POWER9 with XICS in qemu, we could build a=20
> > POWER8 with XIVE.
>=20
> That might be the case with a POWER9 running in POWER8 compat mode.=20
> I need to check.=20

Yes. In "compat" mode (or more generally if the guest doesn't advertize
support for native XIVE, whether it's in compat or native P9 mode is
irrelevant in fact), we provide the old hcalls and effectively need to
instantiate a XICS in qemu (KVM will exploit the XIVE under the hood
but will make it look like a XICS to qemu ioctl's as well).

Cheers,
Ben.

> Thanks,
>=20
> C.=20
>=20
>=20
> > > > > > Now.. I could imagine the POWER9 having a different core mode=
l that
> > > > > > came along with XIVE, but I can't see this new model being us=
ed for
> > > > > > anything anywhere in the rest of the series.
> > > > >=20
> > > > > See patch 26. But, maybe, I am taking a shortcut and we need an=
other
> > > > > family of flags.=20
> > > >=20
> > > > Or just some kind of enum for the interrupt controller, how do we=
 do
> > > > with OpenPIC vs. XICS already ? Old POWER3 had OpenPIC.
> > >=20
> > > AFAICT, we don't have such a CPU in QEMU/ppc.
> >=20
> > More to the point we don't have any machine type for those old POWER3
> > setups.
> >=20
> > > We could use some extra flag to change the ICS behavior. The path I=
 am
> > > taking duplicates the ICS code but in real, we only need to change =
the
> > > irq handlers.=20
> > >=20
> > > Thanks,
> > >=20
> > > C.=20
> > >=20
