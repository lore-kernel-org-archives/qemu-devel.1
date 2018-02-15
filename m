Received: from eggs.gnu.org ([2001:4830:134:3::10]:37474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emJCz-00008z-Gy
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 08:04:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emJCw-0001u6-9g
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 08:04:17 -0500
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:39111)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emJCw-0001tz-3p
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 08:04:14 -0500
Received: by mail-qt0-x243.google.com with SMTP id f4so11727331qtj.6
	for <qemu-devel@nongnu.org>; Thu, 15 Feb 2018 05:04:14 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <cover.1517532021.git.alistair.francis@xilinx.com>
	<fa1d4990d897f61dd748ad7f10f6b88435e6cb46.1517532021.git.alistair.francis@xilinx.com>
	<CAFEAcA_T4S8kU5GtatL+1Uos2oqBuYH-=GqhEWm=y3q4TmF+-w@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <422117c4-4d0b-5db8-9c2a-4e85e2502694@amsat.org>
Date: Thu, 15 Feb 2018 10:04:08 -0300
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_T4S8kU5GtatL+1Uos2oqBuYH-=GqhEWm=y3q4TmF+-w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 4/6] raspi: Specify the valid CPUs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Alistair Francis <alistair23@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>

Hi Peter,

On 02/15/2018 08:29 AM, Peter Maydell wrote:
> On 2 February 2018 at 00:42, Alistair Francis
> <alistair.francis@xilinx.com> wrote:
>> List all possible valid CPU options.
>>
>> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
>> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>
>> V5:
>>  - Use cpu_model names
>> V4:
>>  - Remove spaces
>> V3:
>>  - Add static property
>> V2:
>>  - Fix the indentation
>>
>>  hw/arm/raspi.c | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
>> index cd5fa8c3dc..745a880726 100644
>> --- a/hw/arm/raspi.c
>> +++ b/hw/arm/raspi.c
>> @@ -158,6 +158,11 @@ static void raspi2_init(MachineState *machine)
>>      setup_boot(machine, 2, machine->ram_size - vcram_size);
>>  }
>>
>> +static const char *raspi2_valid_cpus[] = {
>> +    "cortex-a7",
>> +    NULL
>> +};
> 
> Is this definitely right? Looking at the code, the raspi2 board
> creates a TYPE_BCM2836, and that creates cortex-a15 CPUs...

The BCM2836 use a cortex-a7 but this cpu was not available at the time
of this commit (bad5623690b) and was added later in dcf578ed8ce "The A7
is very similar to the A15."

I can prepare a patch for it to apply before this series.

> 
> thanks
> -- PMM
> 
