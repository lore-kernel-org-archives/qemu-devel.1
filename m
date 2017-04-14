Received: from eggs.gnu.org ([2001:4830:134:3::10]:37660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cyuzF-0007IG-Jv
	for qemu-devel@nongnu.org; Fri, 14 Apr 2017 02:45:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cyuzB-00053E-N1
	for qemu-devel@nongnu.org; Fri, 14 Apr 2017 02:45:41 -0400
Received: from 9.mo178.mail-out.ovh.net ([46.105.75.45]:46131)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cyuzB-00051a-An
	for qemu-devel@nongnu.org; Fri, 14 Apr 2017 02:45:37 -0400
Received: from player715.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id 20E703105A
	for <qemu-devel@nongnu.org>; Fri, 14 Apr 2017 08:45:34 +0200 (CEST)
References: <1492076514-28821-1-git-send-email-clg@kaod.org>
	<196d16bd-09ad-bdf2-7c41-63e6d8697874@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <283d2bbe-056d-a3d6-d9fb-99dbae3863b5@kaod.org>
Date: Fri, 14 Apr 2017 08:45:27 +0200
MIME-Version: 1.0
In-Reply-To: <196d16bd-09ad-bdf2-7c41-63e6d8697874@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 0/5] FTGMAC100 nic model for the Aspeed
 SoCs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Dmitry Fleytman <dmitry@daynix.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Jan Kiszka <jan.kiszka@siemens.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org

On 04/14/2017 08:26 AM, Jason Wang wrote:
>=20
>=20
> On 2017=E5=B9=B404=E6=9C=8813=E6=97=A5 17:41, C=C3=A9dric Le Goater wro=
te:
>> Hi,
>>
>> The Aspeed SoCs AST2400 and AST2500 have two FTGMAC100 ethernet
>> controllers. This serie proposes a model for this device and a way to
>> customize the bit definitions which are slightly different from the
>> Faraday definitions.
>>
>> The last patch adds a fake NC-SI (Network Controller Sideband
>> Interface) backend to pretend a NIC is being managed. This is only
>> usable with the slirp stack.
>>
>> The model has been tested on the 'palmetto', 'romulus' and
>> 'ast2500-evb' machines using different implementations of the Linux
>> driver and with U-Boot.  It has been stressed with iperf.
>>
>> Thanks,
>>
>> C.
>>
>> C=C3=A9dric Le Goater (5):
>>    hw/net: add MII definitions
>>    net: add FTGMAC100 support
>>    net/ftgmac100: add a 'aspeed' property
>>    aspeed: add a FTGMAC100 nic
>>    slirp: add a fake NC-SI backend
>>
>>   default-configs/arm-softmmu.mak |    1 +
>>   hw/arm/aspeed_soc.c             |   21 +
>>   hw/net/Makefile.objs            |    1 +
>>   hw/net/ftgmac100.c              | 1016 +++++++++++++++++++++++++++++=
++++++++++
>>   include/hw/arm/aspeed_soc.h     |    2 +
>>   include/hw/net/ftgmac100.h      |   64 +++
>>   include/hw/net/mii.h            |   71 ++-
>>   include/net/eth.h               |    1 +
>>   slirp/Makefile.objs             |    2 +-
>>   slirp/ncsi-pkt.h                |  418 ++++++++++++++++
>>   slirp/ncsi.c                    |   78 +++
>>   slirp/slirp.c                   |    4 +
>>   slirp/slirp.h                   |    3 +
>>   13 files changed, 1663 insertions(+), 19 deletions(-)
>>   create mode 100644 hw/net/ftgmac100.c
>>   create mode 100644 include/hw/net/ftgmac100.h
>>   create mode 100644 slirp/ncsi-pkt.h
>>   create mode 100644 slirp/ncsi.c
>>
>=20
> Want to merge but looks like patch 2 does not apply cleanly on qemu mas=
ter.

ah. I will check that. Anyhow I have improved the fake NC-SI model. So I =
will=20
send a v3.=20

Thanks,

C.=20
