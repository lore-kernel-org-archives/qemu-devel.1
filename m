Received: from eggs.gnu.org ([2001:4830:134:3::10]:48409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fNhix-0003nA-9F
	for qemu-devel@nongnu.org; Tue, 29 May 2018 12:43:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fNhis-0004u2-Ch
	for qemu-devel@nongnu.org; Tue, 29 May 2018 12:43:51 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:45855)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fNhis-0004tq-7y
	for qemu-devel@nongnu.org; Tue, 29 May 2018 12:43:46 -0400
Received: by mail-qk0-x243.google.com with SMTP id c198-v6so11994507qkg.12
	for <qemu-devel@nongnu.org>; Tue, 29 May 2018 09:43:46 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180528061154.25367-1-f4bug@amsat.org>
	<CAFEAcA_ob6mHqfAAM9iAMae5vfxaYhmcqkk-gJH+s1mHuvFp8g@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <b658201f-146d-197e-3a61-36ba6a2d8aee@amsat.org>
Date: Tue, 29 May 2018 13:43:41 -0300
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_ob6mHqfAAM9iAMae5vfxaYhmcqkk-gJH+s1mHuvFp8g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH] hw/misc/unimp: Add
 create_unimplemented_subregion_device()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Alexey Korolev <akorolex@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>

On 05/29/2018 12:08 PM, Peter Maydell wrote:
> On 28 May 2018 at 07:11, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>> The create_unimplemented_device() function is very useful to
>> register unimplemented devices to the SysBus 'absolute' address.
>>
>> Some devices are modelled as container of memory subregions,
>> the subregions being mmio-mapped relatively to the container
>> base address.
>>
>> With these container devices, the current create_unimplemented_device()
>> does not work.
>> Add a function to remove the current limitation, and allow
>> containerized devices to use the helpful UnimplementedDevice.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>> I don't like the function name much, I first tried with
>> create_unimplemented_device_mr() :( Would it be cleaner renaming current
>> create_unimplemented_device() -> create_unimplemented_sysbus_device()?
>>
>> Also, is this useful to have this code inlined?
> 
> My experience has been that devices that want to map the
> unimplemented device into some other container probably
> also want to do in-place initialization rather than using
> qdev_create() -- eg hw/arm/iotkit.c which directly creates
> TYPE_UNIMPLEMENTED_DEVICEs which are embedded in its state
> struct.
> 
> It was always the intention that you can create a
> TYPE_UNIMPLEMENTED_DEVICE directly; create_unimplemented_device()
> is just a convenience wrapper.

OK.

> I'm not opposed to having another convenience wrapper here;
> but I'm not sure this is the right API for one (ie if it
> would be used in very many places).

Fair enough.

Thanks,

Phil.
