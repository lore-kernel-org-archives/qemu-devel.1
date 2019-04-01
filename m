Received: from eggs.gnu.org ([209.51.188.92]:58409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hAwWA-0006dZ-Vl
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 08:58:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hAwW9-0003WV-TL
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 08:58:26 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33782)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hAwW9-0003Tl-JE
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 08:58:25 -0400
Received: by mail-wm1-f67.google.com with SMTP id z6so15484113wmi.0
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 05:58:24 -0700 (PDT)
References: <20190316223918.11917-1-philmd@redhat.com>
	<20190316223918.11917-5-philmd@redhat.com>
	<5a2ff30e-1aee-4c40-6b92-065b2ec94f0c@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <571d8410-b549-afe6-ba47-998fb5a2e7c4@redhat.com>
Date: Mon, 1 Apr 2019 14:58:07 +0200
MIME-Version: 1.0
In-Reply-To: <5a2ff30e-1aee-4c40-6b92-065b2ec94f0c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 4/5] hw/mips/Kconfig: Fulong 2e board
 requires ati-vga display device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Helge Deller <deller@gmx.de>, Cornelia Huck <cohuck@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Eduardo Habkost <ehabkost@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, David Gibson <david@gibson.dropbear.id.au>, Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>

On 3/25/19 6:04 AM, Thomas Huth wrote:
> On 16/03/2019 23.39, Philippe Mathieu-Daudé wrote:
>> This fixes when configuring with --without-default-devices:
>>
>>   $ qemu-system-mips64el -M fulong2e --nodefaults -bios /dev/null
>>   qemu-system-mips64el: Unknown device 'ati-vga' for bus 'PCI'
>>   Aborted (core dumped)
>>
>>   (gdb) bt
>>   #1  0x00007ffff5a11895 in __GI_abort () at abort.c:79
>>   #2  0x00005555558768d3 in qdev_create (bus=bus@entry=0x5555562664b0, name=name@entry=0x555555b24efb "ati-vga") at hw/core/qdev.c:131
>>   #3  0x00005555558d15e1 in pci_create_multifunction (bus=bus@entry=0x5555562664b0, devfn=devfn@entry=-1, multifunction=multifunction@entry=false, name=name@entry=0x555555b24efb "ati-vga") at hw/pci/pci.c:2104
>>   #4  0x00005555558d1a7a in pci_create (bus=bus@entry=0x5555562664b0, devfn=devfn@entry=-1, name=name@entry=0x555555b24efb "ati-vga") at hw/pci/pci.c:2121
>>   #5  0x0000555555763081 in mips_fulong2e_init (machine=<optimized out>) at hw/mips/mips_fulong2e.c:352
>>   #6  0x000055555587e23b in machine_run_board_init (machine=0x5555560b2000) at hw/core/machine.c:1030
>>
>> Fixes: 862b4a291dc
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>>  default-configs/mips64el-softmmu.mak | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/default-configs/mips64el-softmmu.mak b/default-configs/mips64el-softmmu.mak
>> index 8b255efc54..a67c9517a2 100644
>> --- a/default-configs/mips64el-softmmu.mak
>> +++ b/default-configs/mips64el-softmmu.mak
>> @@ -6,6 +6,8 @@ CONFIG_RC4030=y
>>  CONFIG_DP8393X=y
>>  CONFIG_DS1225Y=y
>>  CONFIG_FULONG=y
>> +CONFIG_ATI_VGA=y
>> +CONFIG_RTL8139_PCI=y
> 
> You should mention RTL8139_PCI in the patch description, too. Also, does

Oops I missed that when squashing from v1 (Thanks Paolo for fixing it!).

> it make sense to fix this while your other Kconfig-for-mips patches have
> not been merged yet? (I don't expect --without-default-devices working
> without those patches)

Well this was breaking 'make check-unit'.

> 
>  Thomas
> 
