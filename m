Received: from eggs.gnu.org ([2001:4830:134:3::10]:44332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mail@steffen-goertz.de>) id 1fqJ7a-0002Ue-8b
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 10:19:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mail@steffen-goertz.de>) id 1fqJ7U-0000VH-RH
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 10:19:30 -0400
References: <20180803052137.10602-1-joel@jms.id.au>
	<20180803052137.10602-4-joel@jms.id.au>
	<CAFEAcA9o8JE-ZE3SLBTFrrNCgtJ85L6T7opPZnd0pJaZVkRdVA@mail.gmail.com>
From: =?UTF-8?Q?Steffen_G=c3=b6rtz?= <mail@steffen-goertz.de>
Message-ID: <07bdb32f-fcd2-c9d1-23ea-388d256e240e@steffen-goertz.de>
Date: Thu, 16 Aug 2018 16:19:06 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9o8JE-ZE3SLBTFrrNCgtJ85L6T7opPZnd0pJaZVkRdVA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 3/3] arm: Add BBC micro:bit machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Joel Stanley <joel@jms.id.au>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Jim Mussared <jim.mussared@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>, =?UTF-8?Q?Steffen_G=c3=b6rtz?= <contrib@steffen-goertz.de>, Julia Suvorova <jusual@mail.ru>


>> +
>> +    arm_m_profile_load_kernel(ARM_CPU(first_cpu), machine->kernel_filename,
>> +            NRF51_SOC(soc)->flash_size);
>> +}
>> +
>> +static void microbit_machine_init(MachineClass *mc)
>> +{
>> +    mc->desc = "BBC micro:bit";
>> +    mc->init = microbit_init;
>> +    mc->max_cpus = 1;
>> +}
>> +DEFINE_MACHINE("microbit", microbit_machine_init);
> 
> Your subclass of TYPE_MACHINE has extra state, so it can't
> use DEFINE_MACHINE (which creates a subclass whose instance_size
> is the same as the parent TYPE_MACHINE). You need to do this
> longhand:
> 

Hi Peter,

this is covered in <20180811090836.4024-1-contrib@steffen-goertz.de>

Steffen
