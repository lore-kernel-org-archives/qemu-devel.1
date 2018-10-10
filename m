Received: from eggs.gnu.org ([2001:4830:134:3::10]:37059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gAD7H-0006eb-RQ
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 07:57:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gAD7C-0007ey-TH
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 07:57:27 -0400
Received: from 1.mo179.mail-out.ovh.net ([178.33.111.220]:41292)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gAD7C-0007c0-Kd
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 07:57:22 -0400
Received: from player690.ha.ovh.net (unknown [10.109.143.220])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id 3EC08103173
	for <qemu-devel@nongnu.org>; Wed, 10 Oct 2018 13:57:15 +0200 (CEST)
References: <20180928135003.8650-1-clg@kaod.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <e6e6fff6-8983-e97a-073b-e8fb906e13cf@kaod.org>
Date: Wed, 10 Oct 2018 13:57:11 +0200
MIME-Version: 1.0
In-Reply-To: <20180928135003.8650-1-clg@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 00/11] net: convert SysBus init method to a
 realize method
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

Hello,

On 9/28/18 3:49 PM, C=C3=A9dric Le Goater wrote:
> Hello,
>=20
> Here is my take to the SysBus init to realize method conversion. I
> picked the /net directory and did them all. Also added a couple of
> reset methods in separate patches.
>=20
> make check tested

Do we have enough review for this series ? if so, may be it could
go through Jason's tree ?

Thanks,

C.
=20
> C=C3=A9dric Le Goater (11):
>   net: etraxfs_eth: convert SysBus init method to a realize method
>   net: etraxfs_eth: add a reset method
>   net: lan9118: convert SysBus init method to a realize method
>   net: lance: convert SysBus init method to a realize method
>   net: milkymist_minimac2: convert SysBus init method to a realize
>     method
>   net: mipsnet: convert SysBus init method to a realize method
>   net: opencores_eth: convert SysBus init method to a realize method
>   net: smc91c111: convert SysBus init method to a realize method
>   net: stellaris_enet: convert SysBus init method to a realize method
>   net: stellaris_enet: add a reset method
>   net: xgmac: convert SysBus init method to a realize method
>=20
>  hw/net/etraxfs_eth.c        | 23 ++++++++++++++---------
>  hw/net/lan9118.c            | 24 ++++++++++--------------
>  hw/net/lance.c              |  8 +++-----
>  hw/net/milkymist-minimac2.c |  9 +++------
>  hw/net/mipsnet.c            |  9 +++------
>  hw/net/opencores_eth.c      |  8 +++-----
>  hw/net/smc91c111.c          | 22 +++++++++-------------
>  hw/net/stellaris_enet.c     | 15 +++++++--------
>  hw/net/xgmac.c              |  9 +++------
>  9 files changed, 55 insertions(+), 72 deletions(-)
>=20
