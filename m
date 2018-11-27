Received: from eggs.gnu.org ([2001:4830:134:3::10]:54808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gRdyL-0006Li-Rh
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 09:04:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gRdyI-0003LI-K2
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 09:04:17 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36269)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gRdyI-0003F2-Cx
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 09:04:14 -0500
Received: by mail-wr1-f65.google.com with SMTP id t3so22818781wrr.3
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 06:04:14 -0800 (PST)
References: <154332389387.541746.8099441653585015043.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
	<154332392916.541746.3772338098005086592.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
	<2ed1d297-abd8-8d33-fb9a-f89e2bfb3cff@redhat.com>
	<20181127145258.606bf412@bahia.ttt.fr.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f1a45a72-7d98-7b6e-6643-39748120b8b4@redhat.com>
Date: Tue, 27 Nov 2018 15:03:47 +0100
MIME-Version: 1.0
In-Reply-To: <20181127145258.606bf412@bahia.ttt.fr.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-4.0 3/9] ppc405_boards: use g_new(T,
 n) instead of g_malloc(sizeof(T) * n)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On 27/11/18 14:52, Greg Kurz wrote:
> On Tue, 27 Nov 2018 14:41:53 +0100
> Philippe Mathieu-Daudé <philmd@redhat.com> wrote:
> 
>> On 27/11/18 14:05, Greg Kurz wrote:
>>> Because it is a recommended coding practice (see HACKING).
>>>
>>> Signed-off-by: Greg Kurz <groug@kaod.org>
>>> ---
>>>  hw/ppc/ppc405_boards.c |    4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/hw/ppc/ppc405_boards.c b/hw/ppc/ppc405_boards.c
>>> index 3be3fe4432b4..f35b412c88dd 100644
>>> --- a/hw/ppc/ppc405_boards.c
>>> +++ b/hw/ppc/ppc405_boards.c
>>> @@ -149,7 +149,7 @@ static void ref405ep_init(MachineState *machine)
>>>      MemoryRegion *bios;
>>>      MemoryRegion *sram = g_new(MemoryRegion, 1);
>>>      ram_addr_t bdloc;
>>> -    MemoryRegion *ram_memories = g_malloc(2 * sizeof(*ram_memories));
>>> +    MemoryRegion *ram_memories = g_new(MemoryRegion, 2);
>>>      hwaddr ram_bases[2], ram_sizes[2];
>>>      target_ulong sram_size;
>>>      long bios_size;
>>> @@ -446,7 +446,7 @@ static void taihu_405ep_init(MachineState *machine)
>>>      qemu_irq *pic;
>>>      MemoryRegion *sysmem = get_system_memory();
>>>      MemoryRegion *bios;
>>> -    MemoryRegion *ram_memories = g_malloc(2 * sizeof(*ram_memories));
>>> +    MemoryRegion *ram_memories = g_new(MemoryRegion, 2);
>>>      MemoryRegion *ram = g_malloc0(sizeof(*ram));  
>>
>> Why not change both lines here?
>>
>>        MemoryRegion *ram = g_new0(MemoryRegion, 1);
>>
> 
> Because HACKING says:
> 
> Declarations like T *v = g_malloc(sizeof(*v)) are acceptable, though.

Yes, I agree, but it is weird to have 2 similar lines and only change 1,
for code consistency I'd change both...

> 
> but if there's a consensus on fixing these as well, I'll happily do
> it :)
> 
>>>      hwaddr ram_bases[2], ram_sizes[2];
>>>      long bios_size;
>>>
>>>   
> 
