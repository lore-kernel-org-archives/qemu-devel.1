Received: from eggs.gnu.org ([209.51.188.92]:53982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1h2dOq-0002Yl-M9
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 09:56:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1h2dOp-0007UE-WF
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 09:56:32 -0500
References: <20190308013222.12524-1-philmd@redhat.com>
	<20190308013222.12524-3-philmd@redhat.com>
	<e95c7422-c52e-2105-e314-ea19778f8d8c@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <18d16b8e-01b3-2bc1-be98-67329e4437cc@vivier.eu>
Date: Sat, 9 Mar 2019 15:54:38 +0100
MIME-Version: 1.0
In-Reply-To: <e95c7422-c52e-2105-e314-ea19778f8d8c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [Qemu-ppc] [PATCH v2 02/18]
 hw/i386: Remove unused include
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 08/03/2019 12:32, Thomas Huth wrote:
> On 08/03/2019 02.32, Philippe Mathieu-Daudé wrote:
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>> v2: Drop files that do use fw_cfg (Michael):
>> - hw/i386/acpi-build.c
>> - hw/i386/pc.c
>> ---
>>  hw/acpi/piix4.c | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
>> index 8fd25a5926..7b98121070 100644
>> --- a/hw/acpi/piix4.c
>> +++ b/hw/acpi/piix4.c
>> @@ -28,7 +28,6 @@
>>  #include "sysemu/sysemu.h"
>>  #include "qapi/error.h"
>>  #include "qemu/range.h"
>> -#include "hw/nvram/fw_cfg.h"
>>  #include "exec/address-spaces.h"
>>  #include "hw/acpi/piix4.h"
>>  #include "hw/acpi/pcihp.h"
>>
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 

Applied to my trivial-patches branch.

Thanks,
Laurent
