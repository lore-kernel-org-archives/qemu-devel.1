Received: from eggs.gnu.org ([2001:4830:134:3::10]:50503)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fLPpv-0004Cw-Iu
	for qemu-devel@nongnu.org; Wed, 23 May 2018 05:13:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fLPps-0004hk-9k
	for qemu-devel@nongnu.org; Wed, 23 May 2018 05:13:35 -0400
Received: from 15.mo1.mail-out.ovh.net ([188.165.38.232]:37744)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fLPps-0004h1-4N
	for qemu-devel@nongnu.org; Wed, 23 May 2018 05:13:32 -0400
Received: from player714.ha.ovh.net (unknown [10.109.105.17])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id 59776FBDBA
	for <qemu-devel@nongnu.org>; Wed, 23 May 2018 11:13:30 +0200 (CEST)
References: <20180522173713.26282-1-peter.maydell@linaro.org>
	<d8c13782-48b1-0975-ee2c-0d2ec2eecebe@kaod.org>
	<CAFEAcA_3P-JEsiz_3ZdVhG2kcQ+Y3yOAufLQtHknuzufRosANQ@mail.gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <013774a0-6ec4-7a37-79c7-d3068b4cc5bc@kaod.org>
Date: Wed, 23 May 2018 11:13:25 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_3P-JEsiz_3ZdVhG2kcQ+Y3yOAufLQtHknuzufRosANQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] Correct CPACR reset value for v7 cores
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

On 05/22/2018 09:26 PM, Peter Maydell wrote:
> On 22 May 2018 at 20:06, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>> On 05/22/2018 07:37 PM, Peter Maydell wrote:
>>> This is sufficient that a save-and-reload while the romulus-bmc
>>> machine is in the bootloader will work. On the other hand if
>>> I do a save-and-reload after the kernel has started booting
>>> then we get the classic "guest hang after reload", so some
>>> state is still not being transferred somewhere (probably in
>>> a device in the machine model?)
>>
>> I see the problem. Bizarre.
>=20
> Usually it means that something in the path from timer device
> through to the CPU has failed to save-and-reload the state
> that it needs to, so that when the timer fires post-reload
> it doesn't actually cause a CPU interrupt. You can probably
> debug by putting a breakpoint on whatever looks like a likely
> timer device's 'set the irq line' function and stepping
> through to figure out what's happening.

OK. I will take a look.

What is bizarre is that the romulus-bmc and the palmetto-bmc
machines use the same timer controller model and the same Linux=20
driver. So only the CPU type would differ.
=20
> (You're not using trustzone, are you? I know of a bug with
> migration of cpus with TZ enabled which I'm probably going to
> look at later this week)

The PSR is :

	PSR=3D20000093 --C- A S svc32

'S' for secure. Is that also trustzone ?

Thanks,

C.=20
