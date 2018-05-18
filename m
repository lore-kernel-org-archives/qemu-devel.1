Received: from eggs.gnu.org ([2001:4830:134:3::10]:58120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fJia7-0001zX-7c
	for qemu-devel@nongnu.org; Fri, 18 May 2018 12:50:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fJia6-00028N-BP
	for qemu-devel@nongnu.org; Fri, 18 May 2018 12:50:15 -0400
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:40776)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1fJia6-00027p-47
	for qemu-devel@nongnu.org; Fri, 18 May 2018 12:50:14 -0400
Received: by mail-lf0-x244.google.com with SMTP id u140-v6so2630691lff.7
	for <qemu-devel@nongnu.org>; Fri, 18 May 2018 09:50:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAHNT7NuzHBnWciihZz2KJnwHr3dWk60V-8t0wQoC9nmsBB1=Mg@mail.gmail.com>
References: <cover.1526342674.git.alistair.francis@wdc.com>
	<17b6d0aba8f00cf598c066de7aac478c32323415.1526342674.git.alistair.francis@wdc.com>
	<CAHNT7NuzHBnWciihZz2KJnwHr3dWk60V-8t0wQoC9nmsBB1=Mg@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 18 May 2018 09:49:42 -0700
Message-ID: <CAKmqyKNFinSRwkKzbEBpdc8=LhEU=-DA8At+Y1eX3ZJtui1Mvg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 4/7] hw/riscv/sifive_u: Set the soc
 device tree node as a simple-bus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>
Cc: Alistair Francis <alistair.francis@wdc.com>, QEMU Developers <qemu-devel@nongnu.org>

On Thu, May 17, 2018 at 7:12 PM, Michael Clark <mjc@sifive.com> wrote:
>
>
> On Tue, May 15, 2018 at 12:07 PM, Alistair Francis
> <alistair.francis@wdc.com> wrote:
>>
>> To allow Linux to ennumerate devices on the /soc/ node set it as a
>> "simple-bus".
>>
>> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
>
>
> Reviewed-by: Michael Clark <mjc@sifive.com>

Thanks Michael. This whole series has been reviewed now, can you
include it in your next pull request?

Alistair

>
>>
>> ---
>>  hw/riscv/sifive_u.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
>> index 3883d7ff9c..f438a72c27 100644
>> --- a/hw/riscv/sifive_u.c
>> +++ b/hw/riscv/sifive_u.c
>> @@ -97,7 +97,7 @@ static void create_fdt(SiFiveUState *s, const struct
>> MemmapEntry *memmap,
>>
>>      qemu_fdt_add_subnode(fdt, "/soc");
>>      qemu_fdt_setprop(fdt, "/soc", "ranges", NULL, 0);
>> -    qemu_fdt_setprop_string(fdt, "/soc", "compatible",
>> "ucbbar,spike-bare-soc");
>> +    qemu_fdt_setprop_string(fdt, "/soc", "compatible", "simple-bus");
>>      qemu_fdt_setprop_cell(fdt, "/soc", "#size-cells", 0x2);
>>      qemu_fdt_setprop_cell(fdt, "/soc", "#address-cells", 0x2);
>>
>> --
>> 2.17.0
>>
>
