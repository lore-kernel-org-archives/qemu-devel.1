Received: from eggs.gnu.org ([2001:4830:134:3::10]:59353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1e4oxK-0005Os-Kd
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 10:04:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1e4oxI-0000fb-1S
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 10:04:22 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:6693
	helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1e4oxH-0000fF-MF
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 10:04:19 -0400
References: <1505985788-10436-1-git-send-email-douly.fnst@cn.fujitsu.com>
	<20171018122124.4bb4748c@nial.brq.redhat.com>
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Message-ID: <4930aa2c-4a10-bc5c-bd77-cf0c368b9cea@cn.fujitsu.com>
Date: Wed, 18 Oct 2017 22:04:05 +0800
MIME-Version: 1.0
In-Reply-To: <20171018122124.4bb4748c@nial.brq.redhat.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3] NUMA: Enable adding NUMA node implicitly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, Takao Indoh <indou.takao@jp.fujitsu.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Izumi Taku <izumi.taku@jp.fujitsu.com>, David Hildenbrand <david@redhat.com>, f4bug@amsat.org, Alistair Francis <alistair23@gmail.com>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

Hi Igor,

>> diff --git a/vl.c b/vl.c
>> index 9bb5058..d083b4d 100644
>> --- a/vl.c
>> +++ b/vl.c
>> @@ -4665,7 +4665,11 @@ int main(int argc, char **argv, char **envp)
>>      default_drive(default_floppy, snapshot, IF_FLOPPY, 0, FD_OPTS);
>>      default_drive(default_sdcard, snapshot, IF_SD, 0, SD_OPTS);
>>
>> -    parse_numa_opts(current_machine);
>> +    current_machine->ram_size = ram_size;
>> +    current_machine->maxram_size = maxram_size;
>> +    current_machine->ram_slots = ram_slots;
>> +
>> +    parse_numa_opts(current_machine, ram_slots);
>>
>>      if (qemu_opts_foreach(qemu_find_opts("mon"),
>>                            mon_init_func, NULL, NULL)) {
>> @@ -4710,9 +4714,6 @@ int main(int argc, char **argv, char **envp)
>>      replay_checkpoint(CHECKPOINT_INIT);
>>      qdev_machine_init();
>>
>> -    current_machine->ram_size = ram_size;
>> -    current_machine->maxram_size = maxram_size;
>> -    current_machine->ram_slots = ram_slots;
>>      current_machine->boot_order = boot_order;
>>      current_machine->cpu_model = cpu_model;
> it should be safe to move parse_numa_opts(current_machine) here
>

Yes, Indeed!

I have modified and tested this, It's good. will change in the next
version.

Thanks,
	dou.

>
>
>
>
>
