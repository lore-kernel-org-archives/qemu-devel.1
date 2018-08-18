Received: from eggs.gnu.org ([2001:4830:134:3::10]:40786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fqy9z-0007H0-7N
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 06:08:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fqy7T-0006vN-QZ
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 06:06:08 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:40544)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fqy7T-0006uS-JW
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 06:06:07 -0400
Received: by mail-oi0-x241.google.com with SMTP id w126-v6so18165450oie.7
	for <qemu-devel@nongnu.org>; Sat, 18 Aug 2018 03:06:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <3fbb1f6d-8615-f540-d902-67ea9026777b@amsat.org>
References: <20180809130115.28951-1-peter.maydell@linaro.org>
	<20180809130115.28951-9-peter.maydell@linaro.org>
	<3fbb1f6d-8615-f540-d902-67ea9026777b@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 18 Aug 2018 11:05:46 +0100
Message-ID: <CAFEAcA9_76xjs6cb223q0zCQyi3n67_-f8Ga+2yYRvXM73dk9Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

On 18 August 2018 at 01:37, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> w=
rote:
> On 08/09/2018 10:01 AM, Peter Maydell wrote:
>> The IoTKit does not have any Master Security Contollers itself,
>> but it does provide registers in the secure privilege control
>> block which allow control of MSCs in the external system.
>> Add support for these registers.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---

>>      case A_SECMSCINTEN:
>> -        qemu_log_mask(LOG_UNIMP,
>> -                      "IoTKit SecCtl S block write: "
>> -                      "unimplemented offset 0x%x\n", offset);
>
> Maybe:
>
>            if (value & ~0xffff) {
>                GUEST_ERROR(...)
>            }

We don't generally bother to log writes of raz bits as errors.


thanks
-- PMM
