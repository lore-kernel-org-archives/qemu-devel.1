Received: from eggs.gnu.org ([2001:4830:134:3::10]:37878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cwNAX-0000rW-1m
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 02:14:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cwNAS-0003ap-3M
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 02:14:49 -0400
Received: from 6.mo179.mail-out.ovh.net ([46.105.56.76]:38053)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cwNAR-0003aQ-Tc
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 02:14:44 -0400
Received: from player716.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id 6F178332EA
	for <qemu-devel@nongnu.org>; Fri,  7 Apr 2017 08:14:42 +0200 (CEST)
References: <1491396106-26376-1-git-send-email-clg@kaod.org>
	<1491396106-26376-5-git-send-email-clg@kaod.org>
	<20170406042318.GA12179@umbus>
	<6e24736f-5a64-ea4a-f9bb-6ebed5acca4a@kaod.org>
	<1491470207.4166.107.camel@kernel.crashing.org>
	<9a5826c0-5940-f668-fbef-f90f277408e0@kaod.org>
	<1491480116.4166.108.camel@kernel.crashing.org>
	<78f1dc04-9c48-1870-9fdc-ff872fecd0de@kaod.org>
	<1491515614.4166.126.camel@kernel.crashing.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <7dce9c3b-1cb2-3cec-5f55-51849ca313d0@kaod.org>
Date: Fri, 7 Apr 2017 08:14:36 +0200
MIME-Version: 1.0
In-Reply-To: <1491515614.4166.126.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 04/06/2017 11:53 PM, Benjamin Herrenschmidt wrote:
> On Thu, 2017-04-06 at 14:35 +0200, C=C3=A9dric Le Goater wrote:
>> but real HW (2 sockets OpenPOWER systems, garrison and firestone)
>> does=20
>> not expose the LPC bus on the second chip, should we do so in qemu ?
>=20
> It's not so much HW as it it HostBoot. Not a huge deal.

So let's have QEMU populate the second LPC bus without the "primary"
prop then. It's a different approach than hostboot, but it's good for
testing anyhow.

Thanks,

C.=20
