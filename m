Received: from eggs.gnu.org ([2001:4830:134:3::10]:52176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eEwJU-0005ph-4p
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 06:57:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eEwJT-0003R9-ID
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 06:57:04 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:43154)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eEwJT-0003QH-AY
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 06:57:03 -0500
Received: by mail-wr0-x242.google.com with SMTP id 4so20276098wrt.0
	for <qemu-devel@nongnu.org>; Wed, 15 Nov 2017 03:57:02 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <27983ce7-8de1-620f-ca06-ee4f92dab180@kaod.org>
References: <20171114122018.12204-1-joel@jms.id.au>
	<27983ce7-8de1-620f-ca06-ee4f92dab180@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 15 Nov 2017 11:56:41 +0000
Message-ID: <CAFEAcA9udAJpnJVrkPcS9TrM5EAxPHn70tAjM5Bvr7HvUrqY=g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: Joel Stanley <joel@jms.id.au>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Andrew Jeffery <andrew@aj.id.au>

On 15 November 2017 at 08:18, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> On 11/14/2017 01:20 PM, Joel Stanley wrote:
>> The ASPEED hardware contains a lock register for the SCU that disables
>> any writes to the SCU when it is locked. The machine comes up with the
>> lock enabled, but on all known hardware u-boot will unlock it and leave
>> it unlocked when loading the kernel.
>>
>> This means the kernel expects the SCU to be unlocked. When booting from
>> an emulated ROM the normal u-boot unlock path is executed. Things don't
>> go well when booting using the -kernel command line, as u-boot does not
>> run first.
>>
>> Change behaviour so that when a kernel is passed to the machine, set the
>> reset value of the SCU to be unlocked.
>>
>> Signed-off-by: Joel Stanley <joel@jms.id.au>
>
> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

Thanks. Should this go into 2.11 ? It sounds like the kind of
bugfix that ought to...

-- PMM
