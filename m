Received: from eggs.gnu.org ([2001:4830:134:3::10]:47060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fqJEl-0003kF-0M
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 10:26:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fqJEk-0006D9-Cd
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 10:26:54 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:33508)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fqJEk-0006Cm-7B
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 10:26:54 -0400
Received: by mail-oi0-x243.google.com with SMTP id 8-v6so8364569oip.0
	for <qemu-devel@nongnu.org>; Thu, 16 Aug 2018 07:26:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <07bdb32f-fcd2-c9d1-23ea-388d256e240e@steffen-goertz.de>
References: <20180803052137.10602-1-joel@jms.id.au>
	<20180803052137.10602-4-joel@jms.id.au>
	<CAFEAcA9o8JE-ZE3SLBTFrrNCgtJ85L6T7opPZnd0pJaZVkRdVA@mail.gmail.com>
	<07bdb32f-fcd2-c9d1-23ea-388d256e240e@steffen-goertz.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Aug 2018 15:26:33 +0100
Message-ID: <CAFEAcA_OuWRBT8c2kT9vibrwi1bN0p2RUbzJXDd39h6_RO9C_g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 3/3] arm: Add BBC micro:bit machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Steffen_G=C3=B6rtz?= <mail@steffen-goertz.de>
Cc: Joel Stanley <joel@jms.id.au>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Jim Mussared <jim.mussared@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>, =?UTF-8?Q?Steffen_G=C3=B6rtz?= <contrib@steffen-goertz.de>, Julia Suvorova <jusual@mail.ru>

On 16 August 2018 at 15:19, Steffen G=C3=B6rtz <mail@steffen-goertz.de> wro=
te:
>
>>> +
>>> +    arm_m_profile_load_kernel(ARM_CPU(first_cpu), machine->kernel_file=
name,
>>> +            NRF51_SOC(soc)->flash_size);
>>> +}
>>> +
>>> +static void microbit_machine_init(MachineClass *mc)
>>> +{
>>> +    mc->desc =3D "BBC micro:bit";
>>> +    mc->init =3D microbit_init;
>>> +    mc->max_cpus =3D 1;
>>> +}
>>> +DEFINE_MACHINE("microbit", microbit_machine_init);
>>
>> Your subclass of TYPE_MACHINE has extra state, so it can't
>> use DEFINE_MACHINE (which creates a subclass whose instance_size
>> is the same as the parent TYPE_MACHINE). You need to do this
>> longhand:
>>
>
> Hi Peter,
>
> this is covered in <20180811090836.4024-1-contrib@steffen-goertz.de>

So it is. This patch is wrong though, so the fix needs to be
made by folding the relevant changes into this patch, not as
a separate commit later.

PS: you don't really need a header file for the machine's
struct, because nothing except the machine's .c file will
ever need to include it.

thanks
-- PMM
