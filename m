Received: from eggs.gnu.org ([2001:4830:134:3::10]:53020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cw5wY-0007m2-M4
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 07:51:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cw5wT-0002jR-Ll
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 07:51:14 -0400
Received: from 4.mo2.mail-out.ovh.net ([87.98.172.75]:49489)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cw5wT-0002iY-G5
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 07:51:09 -0400
Received: from player731.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 08B817BDAB
	for <qemu-devel@nongnu.org>; Thu,  6 Apr 2017 13:51:06 +0200 (CEST)
References: <1491396106-26376-1-git-send-email-clg@kaod.org>
	<1491396106-26376-5-git-send-email-clg@kaod.org>
	<20170406042318.GA12179@umbus>
	<6e24736f-5a64-ea4a-f9bb-6ebed5acca4a@kaod.org>
	<1491470207.4166.107.camel@kernel.crashing.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <9a5826c0-5940-f668-fbef-f90f277408e0@kaod.org>
Date: Thu, 6 Apr 2017 13:50:59 +0200
MIME-Version: 1.0
In-Reply-To: <1491470207.4166.107.camel@kernel.crashing.org>
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

On 04/06/2017 11:16 AM, Benjamin Herrenschmidt wrote:
> On Thu, 2017-04-06 at 11:06 +0200, C=C3=A9dric Le Goater wrote:
>> The object will be initialized which raises some concern because we do=
n't=20
>> have the chip id at the moment but the object is still valid in some w=
ay.=20
>> I think I need to remove it from the list of children of the chip or u=
se=20
>> a pointer instead.
>=20
> Well... so it exists on all chips. All chips have an LPC controller...
>=20
> Whether firmware enables it and whether it's connected to anything is a
>  system issue.

So, looking at hostboot, the lower level firmware, I think the initial=20
patch is more in sync with it :=20

   https://github.com/open-power/hostboot/blob/master-p8/src/usr/devtree/=
bld_devtree.C#L1038

David, can we keep it as it is ? I will change the commit log which is=20
a bit fuzzy.=20

Cheers,

C.=20
