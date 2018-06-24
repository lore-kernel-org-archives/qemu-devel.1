Received: from eggs.gnu.org ([2001:4830:134:3::10]:39770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWw0g-00087t-Ek
	for qemu-devel@nongnu.org; Sat, 23 Jun 2018 23:48:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWw0a-0004A8-Dl
	for qemu-devel@nongnu.org; Sat, 23 Jun 2018 23:48:18 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180622134036.23182-1-f4bug@amsat.org>
	<20180622134036.23182-2-f4bug@amsat.org>
	<ceca80d5-7619-4afa-ce82-5870d7a235ad@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <3362ea05-5936-422e-5e67-dbe95207b93a@amsat.org>
Date: Sun, 24 Jun 2018 00:48:07 -0300
MIME-Version: 1.0
In-Reply-To: <ceca80d5-7619-4afa-ce82-5870d7a235ad@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v2 01/14] hw/input/pckbd: Use
 qemu_log_mask(GUEST_ERROR) instead of fprintf
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>

On 06/22/2018 04:24 PM, Thomas Huth wrote:
> On 22.06.2018 15:40, Philippe Mathieu-Daudé wrote:
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  hw/input/pckbd.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/input/pckbd.c b/hw/input/pckbd.c
>> index f33e3fc63d..26aeac2326 100644
>> --- a/hw/input/pckbd.c
>> +++ b/hw/input/pckbd.c
>> @@ -22,6 +22,7 @@
>>   * THE SOFTWARE.
>>   */
>>  #include "qemu/osdep.h"
>> +#include "qemu/log.h"
>>  #include "hw/hw.h"
>>  #include "hw/isa/isa.h"
>>  #include "hw/i386/pc.h"
>> @@ -308,7 +309,8 @@ static void kbd_write_command(void *opaque, hwaddr addr,
>>          /* ignore that */
>>          break;
>>      default:
>> -        fprintf(stderr, "qemu: unsupported keyboard cmd=0x%02x\n", (int)val);
>> +        qemu_log_mask(LOG_GUEST_ERROR,
>> +                      "unsupported keyboard cmd=0x%02lx\n", val);
> 
> Sorry for not spotting it in v1 already, but val is a uint64_t value, so
> you need PRIx64 as format string here, otherwise you'll get an error
> with 32-bit compilers.

Good catch.

Our last CI tested 32-bit arch is MXE Win32.
