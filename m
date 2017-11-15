Received: from eggs.gnu.org ([2001:4830:134:3::10]:43733)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eExVh-0007Gs-Tc
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 08:13:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eExVd-0005k7-Qa
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 08:13:45 -0500
Received: from 9.mo1.mail-out.ovh.net ([178.32.108.172]:50908)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eExVd-0005j8-Kh
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 08:13:41 -0500
Received: from player795.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id 5E3E5A85E3
	for <qemu-devel@nongnu.org>; Wed, 15 Nov 2017 14:13:33 +0100 (CET)
References: <20171114122018.12204-1-joel@jms.id.au>
	<27983ce7-8de1-620f-ca06-ee4f92dab180@kaod.org>
	<CAFEAcA9udAJpnJVrkPcS9TrM5EAxPHn70tAjM5Bvr7HvUrqY=g@mail.gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <724beabe-ce0b-1b51-f902-041fe75db794@kaod.org>
Date: Wed, 15 Nov 2017 13:13:25 +0000
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9udAJpnJVrkPcS9TrM5EAxPHn70tAjM5Bvr7HvUrqY=g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3] hw/arm/aspeed: Unlock SCU when running
 kernel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Joel Stanley <joel@jms.id.au>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Andrew Jeffery <andrew@aj.id.au>

On 11/15/2017 11:56 AM, Peter Maydell wrote:
> On 15 November 2017 at 08:18, C=C3=A9dric Le Goater <clg@kaod.org> wrot=
e:
>> On 11/14/2017 01:20 PM, Joel Stanley wrote:
>>> The ASPEED hardware contains a lock register for the SCU that disable=
s
>>> any writes to the SCU when it is locked. The machine comes up with th=
e
>>> lock enabled, but on all known hardware u-boot will unlock it and lea=
ve
>>> it unlocked when loading the kernel.
>>>
>>> This means the kernel expects the SCU to be unlocked. When booting fr=
om
>>> an emulated ROM the normal u-boot unlock path is executed. Things don=
't
>>> go well when booting using the -kernel command line, as u-boot does n=
ot
>>> run first.
>>>
>>> Change behaviour so that when a kernel is passed to the machine, set =
the
>>> reset value of the SCU to be unlocked.
>>>
>>> Signed-off-by: Joel Stanley <joel@jms.id.au>
>>
>> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
>=20
> Thanks. Should this go into 2.11 ? It sounds like the kind of
> bugfix that ought to...

Yes. Please.

Thanks,

C.
