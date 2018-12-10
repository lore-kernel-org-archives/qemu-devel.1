Received: from eggs.gnu.org ([2001:4830:134:3::10]:51338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gWO2g-0000K5-Sl
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 11:04:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gWNql-0006Av-I7
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 10:52:07 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38774)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gWNql-0006AU-97
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 10:52:03 -0500
Received: by mail-wr1-f65.google.com with SMTP id v13so11007961wrw.5
	for <qemu-devel@nongnu.org>; Mon, 10 Dec 2018 07:52:03 -0800 (PST)
References: <20181207165103.3992-1-philmd@redhat.com>
	<20181207165103.3992-2-philmd@redhat.com>
	<5877a477-9f86-00e4-fce7-87485d54533e@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a47fb35b-85c5-0084-0a4a-cba2498cebd3@redhat.com>
Date: Mon, 10 Dec 2018 16:51:58 +0100
MIME-Version: 1.0
In-Reply-To: <5877a477-9f86-00e4-fce7-87485d54533e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/4] tests: Remove unused include
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Corey Minyard <minyard@acm.org>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>

On 12/10/18 3:55 PM, Laszlo Ersek wrote:
> On 12/07/18 17:51, Philippe Mathieu-Daudé wrote:
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>>  tests/acpi-utils.c | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/tests/acpi-utils.c b/tests/acpi-utils.c
>> index 41dc1ea9b4..297af55d39 100644
>> --- a/tests/acpi-utils.c
>> +++ b/tests/acpi-utils.c
>> @@ -15,7 +15,6 @@
>>  #include "qemu/osdep.h"
>>  #include <glib/gstdio.h>
>>  #include "qemu-common.h"
>> -#include "hw/smbios/smbios.h"
>>  #include "qemu/bitmap.h"
>>  #include "acpi-utils.h"
>>  #include "boot-sector.h"
>>
> 
> Opinions vary whether empty commit message bodies are good style or not.
> Personally I prefer to put at least one sentence in there, even if it
> only repeats the subject line. Up to subsystem maintainers to decide I
> guess.

OK, understood.

> 
> With the commit message updated, or not:
> 
> Reviewed-by: Laszlo Ersek <lersek@redhat.com>

Thanks!
