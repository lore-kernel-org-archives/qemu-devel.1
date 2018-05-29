Received: from eggs.gnu.org ([2001:4830:134:3::10]:52186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fNhwL-0008Rl-Mm
	for qemu-devel@nongnu.org; Tue, 29 May 2018 12:57:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fNhwH-0005xi-RL
	for qemu-devel@nongnu.org; Tue, 29 May 2018 12:57:41 -0400
Received: from 11.mo1.mail-out.ovh.net ([188.165.48.29]:52935)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fNhwH-0005wH-LB
	for qemu-devel@nongnu.org; Tue, 29 May 2018 12:57:37 -0400
Received: from player771.ha.ovh.net (unknown [10.109.122.68])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id D7358FF936
	for <qemu-devel@nongnu.org>; Tue, 29 May 2018 18:57:35 +0200 (CEST)
References: <20180529062838.20556-1-clg@kaod.org>
	<fac124fe-d816-1bb2-c8b3-d1a0213f968b@amsat.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <15666557-66b1-78e0-1062-b3a28ecaf580@kaod.org>
Date: Tue, 29 May 2018 18:57:30 +0200
MIME-Version: 1.0
In-Reply-To: <fac124fe-d816-1bb2-c8b3-d1a0213f968b@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 0/6] ftgmac100 and NC-SI
 enhancements for the Aspeed SoC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-arm@nongnu.org
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org

On 05/29/2018 02:34 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi C=C3=A9dric,
>=20
> On 05/29/2018 03:28 AM, C=C3=A9dric Le Goater wrote:
>> Hello,
>>
>> Here is a couple of enhancements and fixes for the ftgmac100 NIC used
>> on the Aspeed SoC. It includes VLAN and multicast support.
>>
>> Following is an assorted set of changes for the NC-SI backend also
>> used on the Aspeed SoC when soldered on OpenPOWER boards. These fix a
>> few problems found when running OpenBMC on aspeed QEMU machines.
>>
>> Thanks,
>>
>> C=C3=A9dric.
>>
>> C=C3=A9dric Le Goater (6):
>>   ftgmac100: compute maximum frame size depending on the protocol
>>   ftgmac100: add IEEE 802.1Q VLAN support
>>   net/ftgmac100: fix multicast hash routine
>>   slirp/ncsi: fix "Get Version ID" payload length
>>   slirp/ncsi: add a "Get Parameter" response
>>   slirp/ncsi: add checksum support
>=20
> Doesn't it make more sens to have slirp patches applied previous to the
> ftgmac100 model?

why ? They are not necessarily dependent.=20

C.

>=20
>>
>>  include/hw/net/ftgmac100.h |  7 +++++-
>>  hw/net/ftgmac100.c         | 59 +++++++++++++++++++++++++++++++++++--=
---------
>>  slirp/ncsi.c               | 54 +++++++++++++++++++++++++++++++++++++=
-----
>>  3 files changed, 99 insertions(+), 21 deletions(-)
>>
