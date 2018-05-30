Received: from eggs.gnu.org ([2001:4830:134:3::10]:51377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fNtd8-000069-Of
	for qemu-devel@nongnu.org; Wed, 30 May 2018 01:26:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fNtd5-0006ef-Kr
	for qemu-devel@nongnu.org; Wed, 30 May 2018 01:26:38 -0400
Received: from 17.mo1.mail-out.ovh.net ([87.98.179.142]:45627)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fNtd5-0006dw-FC
	for qemu-devel@nongnu.org; Wed, 30 May 2018 01:26:35 -0400
Received: from player786.ha.ovh.net (unknown [10.109.122.61])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id 60712FFDB2
	for <qemu-devel@nongnu.org>; Wed, 30 May 2018 07:26:33 +0200 (CEST)
References: <20180529062838.20556-1-clg@kaod.org>
	<fac124fe-d816-1bb2-c8b3-d1a0213f968b@amsat.org>
	<15666557-66b1-78e0-1062-b3a28ecaf580@kaod.org>
	<b83a5cd3-5918-e063-86ef-c65f1d44641e@amsat.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <9c347664-ef30-b407-f3f8-14390121a9a5@kaod.org>
Date: Wed, 30 May 2018 07:26:27 +0200
MIME-Version: 1.0
In-Reply-To: <b83a5cd3-5918-e063-86ef-c65f1d44641e@amsat.org>
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

On 05/30/2018 05:04 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 05/29/2018 01:57 PM, C=C3=A9dric Le Goater wrote:
>> On 05/29/2018 02:34 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>>> Hi C=C3=A9dric,
>>>
>>> On 05/29/2018 03:28 AM, C=C3=A9dric Le Goater wrote:
>>>> Hello,
>>>>
>>>> Here is a couple of enhancements and fixes for the ftgmac100 NIC use=
d
>>>> on the Aspeed SoC. It includes VLAN and multicast support.
>>>>
>>>> Following is an assorted set of changes for the NC-SI backend also
>>>> used on the Aspeed SoC when soldered on OpenPOWER boards. These fix =
a
>>>> few problems found when running OpenBMC on aspeed QEMU machines.
>>>>
>>>> Thanks,
>>>>
>>>> C=C3=A9dric.
>>>>
>>>> C=C3=A9dric Le Goater (6):
>>>>   ftgmac100: compute maximum frame size depending on the protocol
>>>>   ftgmac100: add IEEE 802.1Q VLAN support
>>>>   net/ftgmac100: fix multicast hash routine
>>>>   slirp/ncsi: fix "Get Version ID" payload length
>>>>   slirp/ncsi: add a "Get Parameter" response
>>>>   slirp/ncsi: add checksum support
>>>
>>> Doesn't it make more sens to have slirp patches applied previous to t=
he
>>> ftgmac100 model?
>>
>> why ? They are not necessarily dependent.=20
>=20
> OK, no worries.
>=20

bah, I will just resend two distinct series one for 'slirp'=20
and one for 'net'.

C. =20
