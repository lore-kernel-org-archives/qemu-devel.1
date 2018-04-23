Received: from eggs.gnu.org ([2001:4830:134:3::10]:50860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fAZiL-0004QE-Na
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 07:32:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fAZiH-0003Cc-Jl
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 07:32:57 -0400
Received: from 17.mo4.mail-out.ovh.net ([46.105.41.16]:46223)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fAZiH-0003Bd-An
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 07:32:53 -0400
Received: from player737.ha.ovh.net (unknown [10.109.105.55])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 7239F1685B1
	for <qemu-devel@nongnu.org>; Mon, 23 Apr 2018 13:32:51 +0200 (CEST)
References: <20180423101433.17759-1-clg@kaod.org>
	<CAFEAcA_1q4+kKunX6_d9N3+6tUFGJRRc5biqn5TqDDmh09-kiw@mail.gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <e2d6b0b9-2402-4c34-305e-ae61ebe10df4@kaod.org>
Date: Mon, 23 Apr 2018 13:32:46 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_1q4+kKunX6_d9N3+6tUFGJRRc5biqn5TqDDmh09-kiw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] timer/aspeed: fix vmstate version id
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Andrew Jeffery <andrew@aj.id.au>

On 04/23/2018 12:29 PM, Peter Maydell wrote:
> On 23 April 2018 at 11:14, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>> commit 1d3e65aa7ac5 ("hw/timer: Add value matching support to
>> aspeed_timer") increased the vmstate version of aspeed.timer because
>> the state had changed, but it also bumped the version of the
>> VMSTATE_STRUCT_ARRAY under the aspeed.timerctrl which did not need to.
>>
>> Change back this version to fix migration.
>>
>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>=20
> Thanks, applied to target-arm.next.
>=20
>>  To test on a 'palmetto-bmc' board, download the latest built OpenBMC
>>  flash image :
>>
>>    wget https://openpower.xyz/job/openbmc-build/distro=3Dubuntu,target=
=3Dpalmetto/lastSuccessfulBuild/artifact/deploy/images/palmetto/flash-pal=
metto
>>
>>  start two instances of QEMU with :
>>
>>    qemu-system-arm -m 512 -M palmetto-bmc -drive file=3D./flash-palmet=
to,format=3Draw,if=3Dmtd -serial mon:stdio -nographic -nodefaults
>=20
> Thanks also for the test image -- I'll add it to the collection I have.

for a romulus-bmc machine, which uses a ARM1176 CPU, you can download thi=
s
image :

   https://openpower.xyz/job/openbmc-build/distro=3Dubuntu,target=3Dromul=
us/lastSuccessfulBuild/artifact/deploy/images/romulus/flash-romulus

but migration fails :

  qemu-system-arm: error while loading state for instance 0x0 of device '=
cpu'

There seems to be an issue while reading the CPACR reg.


> PS: there seems to be something odd up with the DNS for openpower.xyz:
>=20
> $ host openpower.xyz
> openpower.xyz has address 146.20.65.228
> ;; connection timed out; no servers could be reached

indeed. hmm, I will report.

Thanks,

C.=20

> (also manifests as wget pausing for several seconds before starting
> the download).
>=20
> thanks
> -- PMM
>=20
