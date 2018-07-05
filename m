Received: from eggs.gnu.org ([2001:4830:134:3::10]:48751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fb6JG-0005Uv-VP
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 11:36:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fb6JD-000071-QP
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 11:36:42 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:33898)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fb6JD-00006p-Kd
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 11:36:39 -0400
Received: by mail-qt0-x244.google.com with SMTP id m13-v6so7453680qth.1
	for <qemu-devel@nongnu.org>; Thu, 05 Jul 2018 08:36:39 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180704153919.12432-1-f4bug@amsat.org>
	<20180704153919.12432-5-f4bug@amsat.org>
	<CAFEAcA-mhvAxF4bG3Zxx_w57Rkf4xnpTBuPrjekNzEK1vB0j9Q@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <ceb3a31b-f7d5-70fb-c02a-798ec446d881@amsat.org>
Date: Thu, 5 Jul 2018 12:36:33 -0300
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-mhvAxF4bG3Zxx_w57Rkf4xnpTBuPrjekNzEK1vB0j9Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 4/8] xen: Remove useless casts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Laurent Vivier <laurent@vivier.eu>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Anthony Perard <anthony.perard@citrix.com>, "open list:X86" <xen-devel@lists.xenproject.org>, Stefano Stabellini <sstabellini@kernel.org>, QEMU Developers <qemu-devel@nongnu.org>

On 07/05/2018 07:16 AM, Peter Maydell wrote:
> On 4 July 2018 at 16:39, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>> Patch created mechanically by rerunning:
>>
>>   $  spatch --sp-file scripts/coccinelle/typecast.cocci \
>>             --macro-file scripts/cocci-macro-file.h \
>>             --dir . --in-place
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  hw/xen/xen_pt_config_init.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/xen/xen_pt_config_init.c b/hw/xen/xen_pt_config_init.c
>> index aee31c62bb..55a83333f2 100644
>> --- a/hw/xen/xen_pt_config_init.c
>> +++ b/hw/xen/xen_pt_config_init.c
>> @@ -543,7 +543,7 @@ static int xen_pt_exp_rom_bar_reg_write(XenPCIPassthroughState *s,
>>  {
>>      XenPTRegInfo *reg = cfg_entry->reg;
>>      XenPTRegion *base = NULL;
>> -    PCIDevice *d = (PCIDevice *)&s->dev;
>> +    PCIDevice *d = &s->dev;
> 
> This line of code is odd even without the cast. XenPCIPassthroughState*
> is a QOM object (TYPE_XEN_PT_DEVICE) which is a subclass of TYPE_PCI_DEVICE,
> so the standard way to get the PCIDevice pointer for s would be
>   PCIDevice *d = PCI_DEVICE(s);

You have eagle eyes...

Thanks for your review :)

Phil.
