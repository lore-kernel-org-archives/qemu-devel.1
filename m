Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 580EBC432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 10:01:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 285722073F
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 10:01:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 285722073F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXjHQ-0000J8-9i
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 05:01:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39333)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iXjGD-0007c6-P2
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 05:00:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iXjGC-0001yZ-6l
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 05:00:25 -0500
Received: from 3.mo173.mail-out.ovh.net ([46.105.34.1]:33266)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iXjGA-0001xg-2N
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 05:00:24 -0500
Received: from player168.ha.ovh.net (unknown [10.109.159.69])
 by mo173.mail-out.ovh.net (Postfix) with ESMTP id 5412812330E
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2019 11:00:18 +0100 (CET)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player168.ha.ovh.net (Postfix) with ESMTPSA id 7206EC4495AE;
 Thu, 21 Nov 2019 10:00:13 +0000 (UTC)
Subject: Re: [PATCH 0/5] ppc/pnv: fix Homer/Occ mappings on multichip systems
To: Balamuruhan S <bala24@linux.ibm.com>
References: <20191119175056.32518-1-bala24@linux.ibm.com>
 <779f2a3b-62d2-62e9-674c-b2b53bf26da0@kaod.org>
 <20191121091123.GG14854@dhcp-9-120-236-104.in.ibm.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <2155b5ed-0d17-7e5d-ba98-156311e68468@kaod.org>
Date: Thu, 21 Nov 2019 11:00:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191121091123.GG14854@dhcp-9-120-236-104.in.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 6931602780127660864
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudehvddguddvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdqfffguegfifdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucffohhmrghinhepghhithhhuhgsrdgtohhmpdhoiihlrggsshdrohhrghenucfkpheptddrtddrtddrtddpledtrdejiedrhedtrddvvdefnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhduieekrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedt
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.34.1
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, groug@kaod.org,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21/11/2019 10:11, Balamuruhan S wrote:
> On Wed, Nov 20, 2019 at 08:46:30AM +0100, C=C3=A9dric Le Goater wrote:
>> Hello,
>>
>> On 19/11/2019 18:50, Balamuruhan S wrote:
>>> Hi All,
>>>
>>> PowerNV fails to boot in multichip systems due to some misinterpretat=
ion
>>> and mapping in Homer/Occ device models, this patchset fixes the
>>> following,
>>>
>>>  - Homer size is 4MB per chip and Occ common area size is 8MB
>>>  - Bar masks are used to calculate sizes of Homer/Occ in skiboot so
>>>    return appropriate value
>>>  - Occ common area is in BAR 3 on Power8 but wrongly mapped to BAR 2
>>>    currently
>>>  - OCC common area is shared across chips and should be mapped only o=
nce
>>>    for multichip systems
>>
>> The first thing to address is the HOMER XSCOM region.=20
>>
>> Introduce an empty skeleton for P8 and P9 with different mem ops hande=
rs
>> because the registers have a different layout. From there, add the sup=
port
>> for the different PBA* regs and move them out from the default XSCOM
>> handlers. That should fix most of the current problems and it will pro=
vide=20
>> a nice framework for future extensions.
>=20
> sure, I will work on it.
>=20
>>
>> Why not add the associated HOMER MMIO region while we are it ? the PBA
>> registers have all the definitions we need and it will gives us access
>> to the pstate table.
>=20
> so, idea is to have HOMER MMIO for us to use it accessing pstate table =
/ data
> and HOMER XSCOM for homer associated xscom access for PBA* registers to
> P8 and P9 respectively.

yes.=20

>> Second is the OCC region. Do we need a XSCOM *or* a MMIO region ? This=
 is=20
>> not clear. Please check skiboot. I think a MMIO region should be enoug=
h
>> because this is how sensor data from the OCC is accessed.
>=20
> Okay, I will do the change for OCC to use MMIO, and will check skiboot
> for making it better.
>=20
>>
>> On that topic, we could define properties on the PnvOCC model for each=
=20
>> sensor and tune the value from the QEMU monitor. It really shouldn't b=
e
>> too complex.
>=20
> How can we tune value from QEMU monitor ? This is new to me and will
> need to check it. I remember you have advised this with the error
> injection framework patches and Rashmica's patch that provides way to
> use Qemu monitor to feed data, but I need to do some study.


See Joel's patch which has a simple example : =20

   patchwork.ozlabs.org/patch/1196519

It simply generates object properties :=20


+    for (led =3D 0; led < s->nr_leds; led++) {
+        char *name;
+
+        name =3D g_strdup_printf("led%d", led);
+        object_property_add(obj, name, "bool", pca9552_get_led, pca9552_=
set_led,
+                            NULL, NULL, NULL);
+    }

with defined get and set accessors.=20

We could do the same for the OCC sensors with a table describing the=20
sensor layout. Accessors would just simply update the table. we could
even trigger the OCC interrupt if needed.

This is the initial table :

  https://github.com/open-power/occ/blob/master/src/occ_405/sensor/sensor=
_info.c

Linux should be able to grab the values through hwmon just as on real HW.
This is the case today for the DTS.

>>
>> Also the same address is used, we should only map it once but we need=20
>> to invent something to know from which chip it is accessed.
>=20
> This is something need to check how real hardware handles it while
> accessing shared occ region from different chip and think how to make i=
t
> for us.

Yes. I suppose there is some chip id in the powerbus message.

C.

 =20
>=20
> Thanks a lot!
>=20
> -- Bala
>=20
>>
>>
>> C.
>>
>>
>>>
>>> Request for your review and suggestions to make it better. I would li=
ke to
>>> thank Cedric for his time and help to figure out the issues.
>>>
>>> Balamuruhan S (5):
>>>   hw/ppc/pnv: incorrect homer and occ common area size
>>>   hw/ppc/pnv_xscom: PBA bar mask values are incorrect with homer/occ
>>>     sizes
>>>   hw/ppc/pnv_xscom: Power8 occ common area is in PBA BAR 3
>>>   hw/ppc/pnv_xscom: occ common area to be mapped only once
>>>   hw/ppc/pnv_xscom: add PBA BARs for Power8 slw image
>>>
>>>  hw/ppc/pnv_occ.c     |  2 +-
>>>  hw/ppc/pnv_xscom.c   | 37 +++++++++++++++++++++++++++----------
>>>  include/hw/ppc/pnv.h | 12 ++++++++----
>>>  3 files changed, 36 insertions(+), 15 deletions(-)
>>>
>>
>=20


