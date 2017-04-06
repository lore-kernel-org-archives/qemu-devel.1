Received: from eggs.gnu.org ([2001:4830:134:3::10]:32778)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1cwFMh-0008Rd-Iy
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 17:54:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1cwFMc-0004iQ-OO
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 17:54:51 -0400
Message-ID: <1491515650.4166.127.camel@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 07 Apr 2017 07:54:10 +1000
In-Reply-To: <5e61337a-135c-9574-993f-de00fab26777@kaod.org>
References: <1491396106-26376-1-git-send-email-clg@kaod.org>
	<1491396106-26376-4-git-send-email-clg@kaod.org>
	<20170406020256.GA1991@umbus.fritz.box>
	<5e61337a-135c-9574-993f-de00fab26777@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 03/21] ppc/pnv: Add support for POWER8+ LPC
 Controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On Thu, 2017-04-06 at 14:44 +0200, C=C3=A9dric Le Goater wrote:
> May be we could move that under the LPC object even if it is not
> strictly
> correct from a HW pov ?=C2=A0

I'm not fan of this. It's really not part of the LPC controller and
it's specific to a certain crop of P8 machines.

Cheers,
Ben.
