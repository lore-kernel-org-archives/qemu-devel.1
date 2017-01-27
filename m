Received: from eggs.gnu.org ([2001:4830:134:3::10]:39738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cX7Lh-0001jV-7C
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 09:17:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cX7Lf-0006Wu-5g
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 09:17:57 -0500
Received: from mail-ua0-x235.google.com ([2607:f8b0:400c:c08::235]:34056)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cX7Le-0006W7-W1
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 09:17:55 -0500
Received: by mail-ua0-x235.google.com with SMTP id 35so205786709uak.1
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 06:17:54 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <87wpdg8uec.fsf@linaro.org>
References: <1484247815-15279-1-git-send-email-peter.maydell@linaro.org>
	<1484247815-15279-2-git-send-email-peter.maydell@linaro.org>
	<87wpdg8uec.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Jan 2017 14:17:33 +0000
Message-ID: <CAFEAcA_ihju_3vZmPtbhxkSoc+dj+cghwXQnQFAAi2XEsw+ixQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/3] stellaris: Document memory map and
 which SoC devices are unimplemented
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

On 27 January 2017 at 14:11, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
>> Add a comment documenting the memory map of the SoC devices and which
>> are not implemented.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>>  hw/arm/stellaris.c | 31 +++++++++++++++++++++++++++++++
>>  1 file changed, 31 insertions(+)
>>
>> diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
>> index 794a3ad..204502a 100644
>> --- a/hw/arm/stellaris.c
>> +++ b/hw/arm/stellaris.c
>> @@ -1220,6 +1220,37 @@ static void stellaris_init(const char *kernel_fil=
ename, const char *cpu_model,
>>          0x40024000, 0x40025000, 0x40026000};
>>      static const int gpio_irq[7] =3D {0, 1, 2, 3, 4, 30, 31};
>>
>> +    /* Memory map of SoC devices:
>
> Can we at least have the title of the document these came from for
> future reference?

Good idea; it's
Stellaris LM3S6965 Microcontroller Data Sheet (rev H)

thanks
-- PMM
