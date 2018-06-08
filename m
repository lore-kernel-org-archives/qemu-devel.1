Received: from eggs.gnu.org ([2001:4830:134:3::10]:56937)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fRIbn-0000Na-5Q
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 10:43:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fRIbm-0005Nk-D0
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 10:43:19 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180607180641.874-1-f4bug@amsat.org>
	<CAFEAcA9N9XyQrU9Y1XmgLDU9viUB1+U8iQH5QguAkxzqop4piw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <4d519668-0f79-80c9-ceef-9fe531c76c1f@amsat.org>
Date: Fri, 8 Jun 2018 11:43:09 -0300
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9N9XyQrU9Y1XmgLDU9viUB1+U8iQH5QguAkxzqop4piw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v2 0/7] sdcard: cleanup the
 SD_SPEC version
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Igor Mitsyanko <i.mitsyanko@gmail.com>, Alistair Francis <alistair@alistair23.me>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Paul Brook <paul@codesourcery.com>, Paolo Bonzini <pbonzini@redhat.com>

On 06/08/2018 09:14 AM, Peter Maydell wrote:
> On 7 June 2018 at 19:06, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>> Since v2:
>> - heavy documentation improvements
>> - squashed previous 3+4 "add spec_version property default to v2" for atomicity
>> - SSI/SD patch downgraded to RFC
>> - added Alistair R-b tags
> 
>> Philippe Mathieu-Daudé (7):
>>   sdcard: Update the Configuration Register (SCR) to Spec Version 1.10
>>   sdcard: Allow commands valid in SPI mode
>>   sdcard: Add a 'spec_version' property, default to Spec v2.00
>>   sdcard: Disable SEND_IF_COND (CMD8) for Spec v1
>>   sdcard: Reflect when the Spec v3 is supported in the Config Register (SCR)
>>   sdcard: Disable CMD19/CMD23 for Spec v2
>>   hw/sd/ssi-sd: Force cards connected in SPI mode to use Spec v1.10
> 
> Hi; I've applied patches 1-6 to target-arm.next. 7 I had a
> question about.

Thanks!
