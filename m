Received: from eggs.gnu.org ([2001:4830:134:3::10]:57539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1ebvFs-0003Ry-8R
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 16:28:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1ebvFp-0005mV-2M
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 16:28:20 -0500
Message-ID: <1516224472.31850.193.camel@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 18 Jan 2018 08:27:52 +1100
In-Reply-To: <2226ed5e-f666-8060-2edd-998d2f5107ed@kaod.org>
References: <20171209084338.29395-1-clg@kaod.org>
	<20171209084338.29395-3-clg@kaod.org>
	<20171220050947.GC5981@umbus.fritz.box>
	<1513815126.2743.34.camel@kernel.crashing.org>
	<6768575f-27e0-1277-3e7e-56ec44298e6a@kaod.org>
	<1513896817.2743.63.camel@kernel.crashing.org>
	<683d0912-ad48-927c-8235-5358417be44c@kaod.org>
	<1516187433.31850.189.camel@kernel.crashing.org>
	<2226ed5e-f666-8060-2edd-998d2f5107ed@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 02/19] spapr: introduce a skeleton for
 the XIVE interrupt controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>

On Wed, 2018-01-17 at 15:39 +0100, C=C3=A9dric Le Goater wrote:
> Migration is a problem. We will need both backend QEMU objects to be=20
> available anyhow if we want to migrate. So we are back to the current=20
> solution creating both QEMU objects but we can try to defer some of the=
=20
> KVM inits and create the KVM device on demand at CAS time.

Do we have a way to migrate a piece of info from the machine *first*
that indicate what type of XICS/XIVE to instanciate ?

> The next problem is the ICP object that currently needs the KVM device=20
> fd to connect the vcpus ... So, we will need to change that also.=20
> That is probably the biggest problem today. We need a way to disconnect=
=20
> the vpcu from the KVM device and see how we can defer the connection.
> I need to make sure this is possible, I can check that without XIVE

Ben.
