Received: from eggs.gnu.org ([2001:4830:134:3::10]:54952)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fSCaM-0005Ee-DA
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 22:29:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fSCaL-0002FY-MM
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 22:29:34 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180611011501.10235-1-f4bug@amsat.org>
	<20180611011501.10235-34-f4bug@amsat.org>
	<20180611051748-mutt-send-email-mst@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <176ffaf5-69fb-82db-f579-6db8aac3169d@amsat.org>
Date: Sun, 10 Jun 2018 23:29:27 -0300
MIME-Version: 1.0
In-Reply-To: <20180611051748-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 33/40] hw/i386: Use the IEC binary
 prefix definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-trivial@nongnu.org, Stefan Weil <sw@weilnetz.de>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>

On 06/10/2018 11:18 PM, Michael S. Tsirkin wrote:
> On Sun, Jun 10, 2018 at 10:14:54PM -0300, Philippe Mathieu-Daudé wrote:
>> @@ -1392,11 +1393,11 @@ void pc_memory_init(PCMachineState *pcms,
>>          }
>>  
>>          machine->device_memory->base =
>> -            ROUND_UP(0x100000000ULL + pcms->above_4g_mem_size, 1ULL << 30);
>> +            ROUND_UP(0x100000000ULL + pcms->above_4g_mem_size, GiB);
>>  
> 
> 
> For some reason, GiB got special treatment. Why not 1* GiB?

Oops I didn't notice, I really prefer "1 * GiB" too.
