Received: from eggs.gnu.org ([2001:4830:134:3::10]:33506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gKpOV-0003t8-Do
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 13:51:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gKpOR-0008Tz-4E
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 13:51:07 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:35695)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gKpOO-0008P9-U8
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 13:51:01 -0500
Received: by mail-pf1-x442.google.com with SMTP id v9-v6so7400433pff.2
	for <qemu-devel@nongnu.org>; Thu, 08 Nov 2018 10:50:52 -0800 (PST)
Date: Thu, 08 Nov 2018 10:50:50 -0800 (PST)
In-Reply-To: <CAKmqyKOXRVE_9fvrXMTXgtruV=UndnBC2oPPS7Qowqt=aqWP1g@mail.gmail.com>
From: Palmer Dabbelt <palmer@sifive.com>
Message-ID: <mhng-3b5fe601-654c-4aba-b678-62dc8898cef7@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for 3.1 v1 1/1] hw/riscv/virt: Free the
 test device tree node name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: alistair23@gmail.com
Cc: Alistair Francis <Alistair.Francis@wdc.com>, qemu-devel@nongnu.org, qemu-riscv@nongnu.org

On Thu, 08 Nov 2018 10:37:28 PST (-0800), alistair23@gmail.com wrote:
> On Wed, Nov 7, 2018 at 6:38 PM Palmer Dabbelt <palmer@sifive.com> wrote:
>>
>> On Wed, 07 Nov 2018 13:51:45 PST (-0800), Alistair Francis wrote:
>> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
>> > ---
>> >  hw/riscv/virt.c | 1 +
>> >  1 file changed, 1 insertion(+)
>> >
>> > diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
>> > index 4a137a503c..2b38f89070 100644
>> > --- a/hw/riscv/virt.c
>> > +++ b/hw/riscv/virt.c
>> > @@ -240,6 +240,7 @@ static void *create_fdt(RISCVVirtState *s, const struct MemmapEntry *memmap,
>> >      qemu_fdt_setprop_cells(fdt, nodename, "reg",
>> >          0x0, memmap[VIRT_TEST].base,
>> >          0x0, memmap[VIRT_TEST].size);
>> > +    g_free(nodename);
>> >
>> >      nodename = g_strdup_printf("/uart@%lx",
>> >          (long)memmap[VIRT_UART0].base);
>> > --
>> > 2.19.1
>>
>> Thanks.  I got a bit behind this week so I didn't send the pre-PR, but I indent
>> to send a PR tomorrow.  That PR currently only contains this patch.
>
> There should be two patches. One for spike and one for the virt machine.

Oh, sorry about that -- I thought they were the same patch!

Peter: let me know if you want me to submit a new copy of this PR with both 
patches or a follow-on PR.  Sorry for the noise!
