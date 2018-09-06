Received: from eggs.gnu.org ([2001:4830:134:3::10]:45738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fxx1L-0000lW-0Y
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 12:20:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fxx1K-0007Kw-Aw
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 12:20:38 -0400
References: <20180906055736.20256-1-mark.cave-ayland@ilande.co.uk>
	<20180906055736.20256-2-mark.cave-ayland@ilande.co.uk>
	<0223f14f-ab9a-f593-afc0-b87549d94482@redhat.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <32117dc7-495a-ec8c-233c-a2a15cbf431e@ilande.co.uk>
Date: Thu, 6 Sep 2018 17:20:22 +0100
MIME-Version: 1.0
In-Reply-To: <0223f14f-ab9a-f593-afc0-b87549d94482@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/3] scsi: move lsi53c895a structures and
 defines into separate lsi53c895a.h file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, pbonzini@redhat.com, famz@redhat.com, hpoussin@reactos.org, rth@twiddle.net, peter.maydell@linaro.org, armbru@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org

On 06/09/18 12:52, Thomas Huth wrote:

> On 2018-09-06 07:57, Mark Cave-Ayland wrote:
>> There is also one small change to the new header file which is the addition
>> of the previously missing LSI53C810 define.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> ---
>>  hw/scsi/lsi53c895a.c         | 116 +-----------------------------------
>>  include/hw/scsi/lsi53c895a.h | 137 +++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 138 insertions(+), 115 deletions(-)
>>  create mode 100644 include/hw/scsi/lsi53c895a.h
> [...]
>> diff --git a/include/hw/scsi/lsi53c895a.h b/include/hw/scsi/lsi53c895a.h
>> new file mode 100644
>> index 0000000000..d80cb78c69
>> --- /dev/null
>> +++ b/include/hw/scsi/lsi53c895a.h
>> @@ -0,0 +1,137 @@
>> +/*
>> + * QEMU LSI53C895A SCSI Host Bus Adapter emulation
>> + *
>> + * Copyright (c) 2006 CodeSourcery.
>> + * Written by Paul Brook
>> + *
>> + * This code is licensed under the LGPL.
>> + */
>> +
>> +#ifndef LSI_H
>> +#define LSI_H
>> +
>> +#include "qemu/osdep.h"
> 
> Please don't include osdep.h from a header, that should only be done
> from .c files.

Ah yes, my mistake (obviously it was a cut/paste from the .c file).

I wonder if this is something to teach checkpatch about?


ATB,

Mark.
