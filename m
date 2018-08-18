Received: from eggs.gnu.org ([2001:4830:134:3::10]:36668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fr3Rc-00017h-9w
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 11:47:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fr3NW-0006qL-FW
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 11:43:07 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180809130115.28951-1-peter.maydell@linaro.org>
	<20180809130115.28951-9-peter.maydell@linaro.org>
	<3fbb1f6d-8615-f540-d902-67ea9026777b@amsat.org>
	<CAFEAcA9_76xjs6cb223q0zCQyi3n67_-f8Ga+2yYRvXM73dk9Q@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <b226de86-f209-24b8-84ee-a262b4558705@amsat.org>
Date: Sat, 18 Aug 2018 12:42:56 -0300
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9_76xjs6cb223q0zCQyi3n67_-f8Ga+2yYRvXM73dk9Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 08/16] hw/misc/iotkit-secctl:
 Wire up registers for controlling MSCs
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

On 08/18/2018 07:05 AM, Peter Maydell wrote:
> On 18 August 2018 at 01:37, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>> On 08/09/2018 10:01 AM, Peter Maydell wrote:
>>> The IoTKit does not have any Master Security Contollers itself,
>>> but it does provide registers in the secure privilege control
>>> block which allow control of MSCs in the external system.
>>> Add support for these registers.
>>>
>>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>>> ---
> 
>>>      case A_SECMSCINTEN:
>>> -        qemu_log_mask(LOG_UNIMP,
>>> -                      "IoTKit SecCtl S block write: "
>>> -                      "unimplemented offset 0x%x\n", offset);
>>
>> Maybe:
>>
>>            if (value & ~0xffff) {
>>                GUEST_ERROR(...)
>>            }
> 
> We don't generally bother to log writes of raz bits as errors.

Yes I know, and this shouldn't make sens for an well publicly documented
device/board as this IoT Kit.

But you would be surprised by some proprietary firmwares or libraries
provided by some companies...
I have been surprised modeling the Hercules TMS570 series from TI, they
provide a datasheet with the register/bits for the embedded Flash
(F021), and a library/API to access this flash, however when I ran
firmwares linked with their flash library I noticed they access
undocumented bits to restrict^H^H^H^H^configure their flash, and I had
to model those undocumented bits to allow the firmware to continue
further and boot.

So not needed for this model, but it may be sometime useful ;)

Regards,

Phil.
