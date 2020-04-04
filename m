Return-Path: <SRS0=dPN4=5U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9AE5C2BA16
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Apr 2020 08:23:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7E3A206B8
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Apr 2020 08:23:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7E3A206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKe57-0004XU-Qe
	for qemu-devel@archiver.kernel.org; Sat, 04 Apr 2020 04:23:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46620)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1jKe4G-00041k-Uj
 for qemu-devel@nongnu.org; Sat, 04 Apr 2020 04:22:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1jKe4F-0002R4-Cm
 for qemu-devel@nongnu.org; Sat, 04 Apr 2020 04:22:16 -0400
Received: from 10.mo173.mail-out.ovh.net ([46.105.74.148]:53055)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1jKe4F-0002NS-7G
 for qemu-devel@nongnu.org; Sat, 04 Apr 2020 04:22:15 -0400
Received: from player691.ha.ovh.net (unknown [10.110.103.211])
 by mo173.mail-out.ovh.net (Postfix) with ESMTP id BD5EA1362E2
 for <qemu-devel@nongnu.org>; Sat,  4 Apr 2020 10:22:12 +0200 (CEST)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player691.ha.ovh.net (Postfix) with ESMTPSA id 26A9911313B57;
 Sat,  4 Apr 2020 08:22:04 +0000 (UTC)
Subject: Re: [PATCH v2] ppc/pnv: Create BMC devices at machine init
To: Nathan Chancellor <natechancellor@gmail.com>
References: <20191121162340.11049-1-clg@kaod.org>
 <20200404071707.GA24708@ubuntu-m2-xlarge-x86>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <8d46dc9f-bc7e-b449-42f3-54d2d0f304b3@kaod.org>
Date: Sat, 4 Apr 2020 10:22:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200404071707.GA24708@ubuntu-m2-xlarge-x86>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 4878524299193191185
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrtdekgddtvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkpheptddrtddrtddrtddpkedvrdeigedrvdehtddrudejtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrheiledurdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.74.148
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Corey Minyard <cminyard@mvista.com>, qemu-devel@nongnu.org,
 Oliver O'Halloran <oohall@gmail.com>, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/4/20 9:17 AM, Nathan Chancellor wrote:
> Hi C=C3=A9dric,
>=20
> On Thu, Nov 21, 2019 at 05:23:40PM +0100, C=C3=A9dric Le Goater wrote:
>> The BMC of the OpenPOWER systems monitors the machine state using
>> sensors, controls the power and controls the access to the PNOR flash
>> device containing the firmware image required to boot the host.
>>
>> QEMU models the power cycle process, access to the sensors and access
>> to the PNOR device. But, for these features to be available, the QEMU
>> PowerNV machine needs two extras devices on the command line, an IPMI
>> BT device for communication and a BMC backend device:
>>
>>   -device ipmi-bmc-sim,id=3Dbmc0 -device isa-ipmi-bt,bmc=3Dbmc0,irq=3D=
10
>>
>> The BMC properties are then defined accordingly in the device tree and
>> OPAL self adapts. If a BMC device and an IPMI BT device are not
>> available, OPAL does not try to communicate with the BMC in any
>> manner. This is not how real systems behave.
>>
>> To be closer to the default behavior, create an IPMI BMC simulator
>> device and an IPMI BT device at machine initialization time. We loose
>> the ability to define an external BMC device but there are benefits:
>>
>>   - a better match with real systems,
>>   - a better test coverage of the OPAL code,
>>   - system powerdown and reset commands that work,
>>   - a QEMU device tree compliant with the specifications (*).
>>
>> (*) Still needs a MBOX device.
>>
>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>=20
> I just started testing QEMU v5.0.0-rc1 against the little Linux booting
> framework that I helped set up for ClangBuiltLinux and this commit has
> caused some problems because we specify the exact same devices as you
> note in the commit message:
>=20
> https://github.com/ClangBuiltLinux/boot-utils/blob/5d9d3f626940a6a176c0=
80717a367c1599f63680/boot-qemu.sh#L154-L155
>=20
> $ timeout 3m unbuffer qemu-system-ppc64 -device ipmi-bmc-sim,id=3Dbmc0 =
\
>                                         -device isa-ipmi-bt,bmc=3Dbmc0,=
irq=3D10 \
>                                         -L images/ppc64le/ \
>                                         -bios skiboot.lid \
>                                         -machine powernv \
>                                         -display none \
>                                         -initrd images/ppc64le/rootfs.c=
pio \
>                                         -kernel zImage.epapr \
>                                         -m 2G \
>                                         -serial mon:stdio
> qemu-system-ppc64: error creating device tree: node: FDT_ERR_EXISTS

sigh ...

> It seems to me like if the machine is silently creating these devices,

yes. It now does at the machine init time.

> it should just warn that the user is trying to create a device that
> already exists?=20

That is more complex because the machine only knows very late about=20
the user created devices, at reset time. We could check this specific
case (two sets of IPMI devices) and warn the user before exiting.=20

> If not, then I assume I will just need to hack up a check for QEMU=20
> 5.0.0+ and just not add those devices?=20

May be we can improve the behavior. See below.

> We use that script with QEMU 3.1.0 in our CI and I use it locally=20
> with QEMU 4.2.0 so universally getting rid of them doesn't seem=20
> logical.
>=20
> Curious for your thoughts on what to do and cheers,
A solution might be to tie theses default IPMI devices to=20
defaults_enabled(). Which means that to create a custom set of=20
devices you would need to use -nodefaults now. Would that be OK ? =20

Creating these devices at reset would be much easier but it is=20
considered a bad practice to do so.=20

Any other ideas ?=20

Thanks,

C.


