Received: from eggs.gnu.org ([2001:4830:134:3::10]:43841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1cw3Xa-00070e-4A
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 05:17:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1cw3XW-0005Or-VR
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 05:17:18 -0400
Message-ID: <1491470207.4166.107.camel@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 06 Apr 2017 19:16:47 +1000
In-Reply-To: <6e24736f-5a64-ea4a-f9bb-6ebed5acca4a@kaod.org>
References: <1491396106-26376-1-git-send-email-clg@kaod.org>
	<1491396106-26376-5-git-send-email-clg@kaod.org>
	<20170406042318.GA12179@umbus>
	<6e24736f-5a64-ea4a-f9bb-6ebed5acca4a@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 04/21] ppc/pnv: enable only one LPC bus
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

On Thu, 2017-04-06 at 11:06 +0200, C=C3=A9dric Le Goater wrote:
> The object will be initialized which raises some concern because we don=
't=C2=A0
> have the chip id at the moment but the object is still valid in some wa=
y.=C2=A0
> I think I need to remove it from the list of children of the chip or us=
e=C2=A0
> a pointer instead.

Well... so it exists on all chips. All chips have an LPC controller...

Whether firmware enables it and whether it's connected to anything is a
 system issue.

Cheers,
Ben.
