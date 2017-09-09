Received: from eggs.gnu.org ([2001:4830:134:3::10]:39887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dqYln-0007Q4-Fb
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 01:57:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dqYli-0002m9-QC
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 01:57:31 -0400
Received: from 15.mo4.mail-out.ovh.net ([91.121.62.11]:53025)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1dqYli-0002kt-G8
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 01:57:26 -0400
Received: from player159.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id BEBE492DFD
	for <qemu-devel@nongnu.org>; Sat,  9 Sep 2017 07:57:23 +0200 (CEST)
References: <20170908143344.12960-1-clg@kaod.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <8abc073f-ae94-c6ac-e376-eafe855a813d@kaod.org>
Date: Sat, 9 Sep 2017 07:57:17 +0200
MIME-Version: 1.0
In-Reply-To: <20170908143344.12960-1-clg@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 0/3] spapr: XIVE and CAS fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>, Sam Bobroff <sam.bobroff@au1.ibm.com>

On 09/08/2017 04:33 PM, C=C3=A9dric Le Goater wrote:
> Hello,
>=20
> Here are a couple of fixes, one for the XIVE exploitation mode option
> bit which is clearly specified now and for one for the CAS generated
> resets.
>=20
> Last is a proposal to handle the rebuild of the device tree using a
> reset when the XIVE exploitation mode is negotiated with CAS.=20

I should have copied Sam on this topic for some insights.=20

Thanks,

C.=20


> The full tree is here:
>=20
>   https://github.com/legoater/qemu/commits/xive
>=20
> XIVE support for Linux is now merged in 4.14.
>=20
> Thanks,
>=20
> C.
>=20
> C=C3=A9dric Le Goater (3):
>   ppc/xive: fix OV5_XIVE_EXPLOIT bits
>   spapr: fix CAS-generated reset
>   spapr: generate a CAS reset for XIVE exploitation mode
>=20
>  hw/ppc/spapr.c              |  8 ++++++--
>  hw/ppc/spapr_hcall.c        | 13 +++++++++++++
>  include/hw/ppc/spapr_ovec.h |  3 ++-
>  3 files changed, 21 insertions(+), 3 deletions(-)
>=20
