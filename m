Received: from eggs.gnu.org ([2001:4830:134:3::10]:33975)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@zoho.com>) id 1eal8B-0000Ao-3C
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 11:27:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@zoho.com>) id 1eal87-0001Wy-W1
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 11:27:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44666)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@zoho.com>)
	id 1eal87-0001VB-Q8
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 11:27:31 -0500
Reply-To: marcel@redhat.com
References: <20180114104751.21965-1-mark.cave-ayland@ilande.co.uk>
	<20180114104751.21965-10-mark.cave-ayland@ilande.co.uk>
	<e4cb0bba-c6e0-0a38-7224-71738c3a7d5a@amsat.org>
From: Marcel Apfelbaum <marcel.apfelbaum@zoho.com>
Message-ID: <b0a9500a-6aae-2d2d-6a5e-0307e32fa23f@zoho.com>
Date: Sun, 14 Jan 2018 18:27:12 +0200
MIME-Version: 1.0
In-Reply-To: <e4cb0bba-c6e0-0a38-7224-71738c3a7d5a@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 09/11] pci: add trace-events support for
 hw/pci-host
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, atar4qemu@gmail.com
Cc: Marcel Apfelbaum <marcel@redhat.com>, qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>

On 14/01/2018 15:32, Philippe Mathieu-Daud=C3=A9 wrote:
> On 01/14/2018 07:47 AM, Mark Cave-Ayland wrote:
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Not sure this is worth a separate commit (I'd squash it in the next
> patch), still:

I agree, no need to add a new directory to the trace list
while we don't have a trace events file.

Thanks,
Marcel

> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> CC: Michael S. Tsirkin <mst@redhat.com>
>> CC: Marcel Apfelbaum <marcel@redhat.com>
>> ---
>>   Makefile.objs            | 1 +
>>   hw/pci-host/trace-events | 1 +
>>   2 files changed, 2 insertions(+)
>>   create mode 100644 hw/pci-host/trace-events
>>
>> diff --git a/Makefile.objs b/Makefile.objs
>> index c8b1bba593..6aa793ce4f 100644
>> --- a/Makefile.objs
>> +++ b/Makefile.objs
>> @@ -149,6 +149,7 @@ trace-events-subdirs +=3D hw/i386/xen
>>   trace-events-subdirs +=3D hw/9pfs
>>   trace-events-subdirs +=3D hw/ppc
>>   trace-events-subdirs +=3D hw/pci
>> +trace-events-subdirs +=3D hw/pci-host
>>   trace-events-subdirs +=3D hw/s390x
>>   trace-events-subdirs +=3D hw/vfio
>>   trace-events-subdirs +=3D hw/acpi
>> diff --git a/hw/pci-host/trace-events b/hw/pci-host/trace-events
>> new file mode 100644
>> index 0000000000..9284b1fbad
>> --- /dev/null
>> +++ b/hw/pci-host/trace-events
>> @@ -0,0 +1 @@
>> +# See docs/devel/tracing.txt for syntax documentation.
>>
