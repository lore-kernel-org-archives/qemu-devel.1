Received: from eggs.gnu.org ([2001:4830:134:3::10]:54277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ewWRS-0001s6-0b
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 13:13:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ewWRR-0002WK-23
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 13:13:25 -0400
Received: from mail-oi0-x235.google.com ([2607:f8b0:4003:c06::235]:46703)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ewWRQ-0002W4-SE
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 13:13:24 -0400
Received: by mail-oi0-x235.google.com with SMTP id x12so6307029oie.13
	for <qemu-devel@nongnu.org>; Thu, 15 Mar 2018 10:13:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <MWHPR21MB018983B74A652443B70680F19ED20@MWHPR21MB0189.namprd21.prod.outlook.com>
References: <20180313153458.26822-1-peter.maydell@linaro.org>
	<20180313153458.26822-9-peter.maydell@linaro.org>
	<MWHPR21MB018983B74A652443B70680F19ED20@MWHPR21MB0189.namprd21.prod.outlook.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Mar 2018 17:13:03 +0000
Message-ID: <CAFEAcA_9YQ4bSzHgM8yLAPtPZ2C70u13kTCLf4rHGPCBUgNiZA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 8/9] hw/arm/bcm2836: Hardcode correct CPU
 type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, Andrew Baumann <Andrew.Baumann@microsoft.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Pekka Enberg <penberg@iki.fi>, "patches@linaro.org" <patches@linaro.org>

On 13 March 2018 at 16:55, Andrew Baumann <Andrew.Baumann@microsoft.com> wrote:
>> From: Qemu-devel <qemu-devel-
>> bounces+andrew.baumann=microsoft.com@nongnu.org> On Behalf Of Peter
>> Maydell
>> Sent: Tuesday, 13 March 2018 08:35
>>
>> Now we have separate types for BCM2386 and BCM2387, we might as well
>> just hard-code the CPU type they use rather than having it passed
>> through as an object property. This then lets us put the initialization
>> of the CPU object in init rather than realize.

> What about the default_cpu_type field of MachineClass set in
> raspi[23]_machine_init? That seems irrelevant now...

Igor, can you help with this question? For a board that always
has one CPU type (because the real hardware only ever has
one SoC, and that SoC QOM object hard codes the CPU type)
does it still need to set the mc->default_cpu_type field in
its MachineClass, or does that become pointless ?

thanks
-- PMM
