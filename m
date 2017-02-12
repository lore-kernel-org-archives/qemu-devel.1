Received: from eggs.gnu.org ([2001:4830:134:3::10]:36005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1cd0FR-0005Sz-26
	for qemu-devel@nongnu.org; Sun, 12 Feb 2017 14:55:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1cd0FM-0003o9-6W
	for qemu-devel@nongnu.org; Sun, 12 Feb 2017 14:55:49 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:35781)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1cd0FL-0003nj-Rn
	for qemu-devel@nongnu.org; Sun, 12 Feb 2017 14:55:44 -0500
Received: by mail-wr0-x242.google.com with SMTP id o16so21329792wra.2
	for <qemu-devel@nongnu.org>; Sun, 12 Feb 2017 11:55:42 -0800 (PST)
Reply-To: marcel@redhat.com
References: <cover.1486285434.git.ben@skyportsystems.com>
	<a0d502ddafd0bb57633d863c8b2d89693ad5b06f.1486285434.git.ben@skyportsystems.com>
	<20170206182941-mutt-send-email-mst@kernel.org>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <9124f4d8-f4a2-b7b4-9187-e52785cf55ef@gmail.com>
Date: Sun, 12 Feb 2017 21:55:37 +0200
MIME-Version: 1.0
In-Reply-To: <20170206182941-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 08/10] PC: Support dynamic sysbus on
 pc_i440fx
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, ben@skyportsystems.com
Cc: imammedo@redhat.com, lersek@redhat.com, qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.a@redhat.com>

On 02/06/2017 06:31 PM, Michael S. Tsirkin wrote:
> On Sun, Feb 05, 2017 at 01:12:03AM -0800, ben@skyportsystems.com wrote:
>> From: Ben Warren <ben@skyportsystems.com>
>>
>> This allows pc_i440fx-based machines to add new devices such as
>> VM Generation ID directly to the sysbus.
>>
>> Signed-off-by: Ben Warren <ben@skyportsystems.com>
>

Hi,

> Only point is, we might have to add more flags like
> cannot_instantiate_with_device_add_yet
> to a bunch of devices.
>
> Marcel, you did a similar thing for q35, can you
> take a look here as well pls?
>

The change is a must because the new vmgenid device
is a sysbus device and QEMU will not allow it without
marking explicitly that i440fx supports sysbus device.

As you already mentioned, we need to make sure that
all sysbus devices that can be added to the PC machines
are marked with "cannot_instantiate_with_device_add_yet".

Sadly I see no easy way, but going manually over each one...

Thanks,
Marcel

>> ---
>>  hw/i386/pc_piix.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
>> index 9f102aa..c8ad99c 100644
>> --- a/hw/i386/pc_piix.c
>> +++ b/hw/i386/pc_piix.c
>> @@ -435,6 +435,7 @@ static void pc_i440fx_machine_options(MachineClass *m)
>>      m->hot_add_cpu = pc_hot_add_cpu;
>>      m->default_machine_opts = "firmware=bios-256k.bin";
>>      m->default_display = "std";
>> +    m->has_dynamic_sysbus = true;
>>  }
>>
>>  static void pc_i440fx_2_9_machine_options(MachineClass *m)
>> --
>> 2.7.4
>
