Received: from eggs.gnu.org ([2001:4830:134:3::10]:55472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cineV-0005fc-8c
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 14:41:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cineS-0003tb-2f
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 14:41:39 -0500
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:33689)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cineR-0003sD-VL
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 14:41:36 -0500
Received: by mail-qk0-x244.google.com with SMTP id n186so5308220qkb.0
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 11:41:34 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1488271971-12624-1-git-send-email-thuth@redhat.com>
	<2bdeedaa-294f-5395-680f-ffb912ecfe74@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <129de652-322c-7722-f8c9-bbb193980acc@amsat.org>
Date: Tue, 28 Feb 2017 16:41:30 -0300
MIME-Version: 1.0
In-Reply-To: <2bdeedaa-294f-5395-680f-ffb912ecfe74@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] hw/core/null-machine: Print error message
 when using the -kernel parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

On 02/28/2017 10:17 AM, Marcel Apfelbaum wrote:
> On 02/28/2017 10:52 AM, Thomas Huth wrote:
>> If the user currently tries to use the -kernel parameter, simply nothing
>> happens, and the user might get confused that there is nothing loaded
>> to memory, but also no error message has been issued. Since there is no
>> real generic way to load a kernel on all CPU types (but on some targets,
>> the generic loader can be used instead), issue an appropriate error
>> message here now to avoid the possible confusion.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  hw/core/null-machine.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/hw/core/null-machine.c b/hw/core/null-machine.c
>> index 27c8369..864832d 100644
>> --- a/hw/core/null-machine.c
>> +++ b/hw/core/null-machine.c
>> @@ -40,6 +40,12 @@ static void machine_none_init(MachineState *mch)
>>          memory_region_allocate_system_memory(ram, NULL, "ram",
>> mch->ram_size);
>>          memory_region_add_subregion(get_system_memory(), 0, ram);
>>      }
>> +
>> +    if (mch->kernel_filename) {
>> +        error_report("The -kernel parameter is not supported "
>> +                     "(use the generic 'loader' device instead).");
>> +        exit(1);
>> +    }
>>  }
>>
>>  static void machine_none_machine_init(MachineClass *mc)
>>
>
>
> Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>
> Thanks,
> Marcel
>
