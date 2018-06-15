Received: from eggs.gnu.org ([2001:4830:134:3::10]:35021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fTmE1-0002xk-2U
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 06:45:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fTmE0-0001tM-8z
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 06:45:01 -0400
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:43487)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fTmE0-0001sn-2C
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 06:45:00 -0400
Received: by mail-ot0-x241.google.com with SMTP id i19-v6so10472531otk.10
	for <qemu-devel@nongnu.org>; Fri, 15 Jun 2018 03:44:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAKmqyKOm6O_Tj1Bru9DpQN_uWsHQ+V1Jh2cN3EzwMCFOu=hOUg@mail.gmail.com>
References: <20180611171518.3390-1-clg@kaod.org>
	<bfdc313f-f8b0-77a5-e87b-cc9c75f8e110@kaod.org>
	<CAKmqyKOm6O_Tj1Bru9DpQN_uWsHQ+V1Jh2cN3EzwMCFOu=hOUg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Jun 2018 11:44:38 +0100
Message-ID: <CAFEAcA_PzsfgA-QeSPb7qRnNnbuFe2A9ZwUuF9KNyf_hENzcwA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] m25p80: add support for two bytes WRSR for
 Macronix chips
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair23@gmail.com>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, QEMU Developers <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Qemu-block <qemu-block@nongnu.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alistair Francis <alistair@alistair23.me>, Max Reitz <mreitz@redhat.com>

On 11 June 2018 at 23:03, Alistair Francis <alistair23@gmail.com> wrote:
> On Mon, Jun 11, 2018 at 10:18 AM, C=C3=A9dric Le Goater <clg@kaod.org> wr=
ote:
>> On 06/11/2018 07:15 PM, C=C3=A9dric Le Goater wrote:
>>> On Macronix chips, two bytes can written to the WRSR. First byte will
>>> configure the status register and the second the configuration
>>> register. It is important to save the configuration value as it
>>> contains the dummy cycle setting when using dual or quad IO mode.
>>>
>>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>
> Acked-by: Alistair Francis <alistair.francis@wdc.com>



Applied to target-arm.next, thanks.

-- PMM
