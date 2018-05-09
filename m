Received: from eggs.gnu.org ([2001:4830:134:3::10]:46089)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fGHmT-0007ea-QA
	for qemu-devel@nongnu.org; Wed, 09 May 2018 01:36:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fGHmP-0000eJ-Hv
	for qemu-devel@nongnu.org; Wed, 09 May 2018 01:36:49 -0400
Received: from mail-qt0-x22b.google.com ([2607:f8b0:400d:c0d::22b]:38831)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fGHmP-0000dT-CA
	for qemu-devel@nongnu.org; Wed, 09 May 2018 01:36:45 -0400
Received: by mail-qt0-x22b.google.com with SMTP id m9-v6so23430629qtb.5
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 22:36:45 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180309153654.13518-1-f4bug@amsat.org>
	<20180309153654.13518-6-f4bug@amsat.org>
	<CAFEAcA8jPcjk+sj0FVE8P5dA82GdNDNr-Zg_7T6PGqufr2157A@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <29fbc549-c4d5-5e27-48ae-dbd377f2ba77@amsat.org>
Date: Wed, 9 May 2018 02:36:39 -0300
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8jPcjk+sj0FVE8P5dA82GdNDNr-Zg_7T6PGqufr2157A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 5/8] sdcard: Implement the UHS-I
 SWITCH_FUNCTION entries (Spec v3)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Alistair Francis <alistair@alistair23.me>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, QEMU Developers <qemu-devel@nongnu.org>

Hi Peter,

On 03/09/2018 02:03 PM, Peter Maydell wrote:
> On 9 March 2018 at 15:36, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
[...]
>>  static void sd_function_switch(SDState *sd, uint32_t arg)
>>  {
>> -    int i, mode, new_func;
>> -    mode = !!(arg & 0x80000000);
>> -
>> -    sd->data[0] = 0x00;                /* Maximum current consumption */
>> -    sd->data[1] = 0x01;
>> -    sd->data[2] = 0x80;                /* Supported group 6 functions */
>> -    sd->data[3] = 0x01;
[...]
>> +
>> +    stw_be_p(sd->data + 0, 0x0001);     /* Maximum current consumption */
> 
> Previously we were writing 0x00, 0x01 to the first 2 bytes of data;
> now we will write 0x01, 0x00. Are you sure that's right ? I guess
> it's the difference between claiming 1mA and 256mA.

Using stw_be_p() we still write [0x00, 0x01] (16-bit big endian), is
this correct?
