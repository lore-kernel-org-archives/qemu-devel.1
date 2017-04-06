Received: from eggs.gnu.org ([2001:4830:134:3::10]:38681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cw6e3-0002kz-6e
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 08:36:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cw6dx-0000ER-GG
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 08:36:11 -0400
Received: from 6.mo2.mail-out.ovh.net ([87.98.165.38]:48960)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cw6dx-0000Do-9h
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 08:36:05 -0400
Received: from player731.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id B6F8C79B8D
	for <qemu-devel@nongnu.org>; Thu,  6 Apr 2017 14:36:03 +0200 (CEST)
References: <1491396106-26376-1-git-send-email-clg@kaod.org>
	<1491396106-26376-5-git-send-email-clg@kaod.org>
	<20170406042318.GA12179@umbus>
	<6e24736f-5a64-ea4a-f9bb-6ebed5acca4a@kaod.org>
	<1491470207.4166.107.camel@kernel.crashing.org>
	<9a5826c0-5940-f668-fbef-f90f277408e0@kaod.org>
	<1491480116.4166.108.camel@kernel.crashing.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <78f1dc04-9c48-1870-9fdc-ff872fecd0de@kaod.org>
Date: Thu, 6 Apr 2017 14:35:57 +0200
MIME-Version: 1.0
In-Reply-To: <1491480116.4166.108.camel@kernel.crashing.org>
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

On 04/06/2017 02:01 PM, Benjamin Herrenschmidt wrote:
> On Thu, 2017-04-06 at 13:50 +0200, C=C3=A9dric Le Goater wrote:
>>
>> So, looking at hostboot, the lower level firmware, I think the
>> initial=20
>> patch is more in sync with it :=20
>>
>>    https://github.com/open-power/hostboot/blob/master-p8/src/usr/devt
>> ree/bld_devtree.C#L1038
>>
>> David, can we keep it as it is ? I will change the commit log which
>> is a bit fuzzy.=20
>=20
> Note that OPAL should be happy to have multiple LPCs in the DT as long
> as one of them has the "primary" property in the node to tell it that's
> where the UART etc... are.

yes, that works also :=20

[    0.024439731,5] LPC: LPC[000]: Initialized, access via XSCOM @0xb0020
[    0.024499074,5] LPC: LPC[001]: Initialized, access via XSCOM @0xb0020
[    0.024517962,5] LPC: LPC: Default bus on chip 0x0

but real HW (2 sockets OpenPOWER systems, garrison and firestone) does=20
not expose the LPC bus on the second chip, should we do so in qemu ?=20

Thanks,

C.=20
