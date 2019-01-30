Received: from eggs.gnu.org ([209.51.188.92]:58728)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gonGi-00019H-Lm
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 05:38:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gonGg-0005s8-Dp
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 05:38:56 -0500
From: Laurent Vivier <laurent@vivier.eu>
References: <20190104181208.7809-1-philmd@redhat.com>
	<20190104181208.7809-3-philmd@redhat.com>
	<77127630-f476-f134-30a9-9b2d1aaac36d@vivier.eu>
Message-ID: <9cfda75d-a1a6-5aa2-ee33-1b53a92a7b35@vivier.eu>
Date: Wed, 30 Jan 2019 11:38:01 +0100
MIME-Version: 1.0
In-Reply-To: <77127630-f476-f134-30a9-9b2d1aaac36d@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH v2 2/3] util/cutils: Move
 ctype macros to "cutils.h"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, qemu-trivial@nongnu.org, Richard Henderson <rth@twiddle.net>, Cornelia Huck <cohuck@redhat.com>, Markus Armbruster <armbru@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

On 30/01/2019 11:24, Laurent Vivier wrote:
> On 04/01/2019 19:12, Philippe Mathieu-Daudé wrote:
>> Introduced in cd390083ad1, these macros don't need to be in
>> a generic header.
>> Add documentation to justify their use.
>>
>> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>> v2: Fixed checkpatch warnings (tabs)
>> ---
>>  hw/core/bus.c              |  2 +-
>>  hw/core/qdev-properties.c  |  1 +
>>  hw/s390x/s390-virtio-ccw.c |  1 +
>>  hw/scsi/scsi-generic.c     |  2 +-
>>  include/qemu-common.h      | 16 ----------------
>>  include/qemu/cutils.h      | 25 +++++++++++++++++++++++++
>>  qapi/qapi-util.c           |  2 +-
>>  qobject/json-parser.c      |  1 -
>>  target/ppc/monitor.c       |  1 +
>>  ui/keymaps.c               |  1 +
>>  util/id.c                  |  2 +-
>>  util/readline.c            |  1 -
>>  12 files changed, 33 insertions(+), 22 deletions(-)
>>
>> diff --git a/hw/core/bus.c b/hw/core/bus.c
>> index 4651f24486..dceb144075 100644
>> --- a/hw/core/bus.c
>> +++ b/hw/core/bus.c
>> @@ -18,7 +18,7 @@
>>   */
>>  
>>  #include "qemu/osdep.h"
>> -#include "qemu-common.h"
>> +#include "qemu/cutils.h"
>>  #include "hw/qdev.h"
>>  #include "qapi/error.h"
>>  
>> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
>> index 943dc2654b..3bdebac361 100644
>> --- a/hw/core/qdev-properties.c
>> +++ b/hw/core/qdev-properties.c
>> @@ -1,4 +1,5 @@
>>  #include "qemu/osdep.h"
>> +#include "qemu/cutils.h"
>>  #include "net/net.h"
>>  #include "hw/qdev.h"
>>  #include "qapi/error.h"
>> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
>> index fd9d0b0542..ed23bb7b3a 100644
>> --- a/hw/s390x/s390-virtio-ccw.c
>> +++ b/hw/s390x/s390-virtio-ccw.c
>> @@ -11,6 +11,7 @@
>>   */
>>  
>>  #include "qemu/osdep.h"
>> +#include "qemu/cutils.h"
>>  #include "qapi/error.h"
>>  #include "cpu.h"
>>  #include "hw/boards.h"
>> diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
>> index 7237b4162e..86f65fd474 100644
>> --- a/hw/scsi/scsi-generic.c
>> +++ b/hw/scsi/scsi-generic.c
>> @@ -12,8 +12,8 @@
>>   */
>>  
>>  #include "qemu/osdep.h"
>> +#include "qemu/cutils.h"
>>  #include "qapi/error.h"
>> -#include "qemu-common.h"
>>  #include "qemu/error-report.h"
>>  #include "hw/scsi/scsi.h"
>>  #include "hw/scsi/emulation.h"
>> diff --git a/include/qemu-common.h b/include/qemu-common.h
>> index 760527294f..ed43ae286d 100644
>> --- a/include/qemu-common.h
>> +++ b/include/qemu-common.h
>> @@ -33,22 +33,6 @@ int qemu_main(int argc, char **argv, char **envp);
>>  void qemu_get_timedate(struct tm *tm, int offset);
>>  int qemu_timedate_diff(struct tm *tm);
>>  
>> -#define qemu_isalnum(c)		isalnum((unsigned char)(c))
>> -#define qemu_isalpha(c)		isalpha((unsigned char)(c))
>> -#define qemu_iscntrl(c)		iscntrl((unsigned char)(c))
>> -#define qemu_isdigit(c)		isdigit((unsigned char)(c))
>> -#define qemu_isgraph(c)		isgraph((unsigned char)(c))
>> -#define qemu_islower(c)		islower((unsigned char)(c))
>> -#define qemu_isprint(c)		isprint((unsigned char)(c))
>> -#define qemu_ispunct(c)		ispunct((unsigned char)(c))
>> -#define qemu_isspace(c)		isspace((unsigned char)(c))
>> -#define qemu_isupper(c)		isupper((unsigned char)(c))
>> -#define qemu_isxdigit(c)	isxdigit((unsigned char)(c))
>> -#define qemu_tolower(c)		tolower((unsigned char)(c))
>> -#define qemu_toupper(c)		toupper((unsigned char)(c))
>> -#define qemu_isascii(c)		isascii((unsigned char)(c))
>> -#define qemu_toascii(c)		toascii((unsigned char)(c))
>> -
>>  void *qemu_oom_check(void *ptr);
>>  
>>  ssize_t qemu_write_full(int fd, const void *buf, size_t count)
>> diff --git a/include/qemu/cutils.h b/include/qemu/cutils.h
>> index 9ee40470e3..644f2d75bd 100644
>> --- a/include/qemu/cutils.h
>> +++ b/include/qemu/cutils.h
>> @@ -3,6 +3,31 @@
>>  
>>  #include "qemu/fprintf-fn.h"
>>  
>> +/**
>> + * unsigned ctype macros:
>> + *
>> + * The standards require that the argument for these functions
>> + * is either EOF or a value that is representable in the type
>> + * unsigned char. If the argument is of type char, it must be
>> + * cast to unsigned char. This is what these macros do,
>> + * avoiding 'signed to unsigned' conversion warnings.
>> + */
>> +#define qemu_isalnum(c)     isalnum((unsigned char)(c))
>> +#define qemu_isalpha(c)     isalpha((unsigned char)(c))
>> +#define qemu_iscntrl(c)     iscntrl((unsigned char)(c))
>> +#define qemu_isdigit(c)     isdigit((unsigned char)(c))
>> +#define qemu_isgraph(c)     isgraph((unsigned char)(c))
>> +#define qemu_islower(c)     islower((unsigned char)(c))
>> +#define qemu_isprint(c)     isprint((unsigned char)(c))
>> +#define qemu_ispunct(c)     ispunct((unsigned char)(c))
>> +#define qemu_isspace(c)     isspace((unsigned char)(c))
>> +#define qemu_isupper(c)     isupper((unsigned char)(c))
>> +#define qemu_isxdigit(c)    isxdigit((unsigned char)(c))
>> +#define qemu_tolower(c)     tolower((unsigned char)(c))
>> +#define qemu_toupper(c)     toupper((unsigned char)(c))
>> +#define qemu_isascii(c)     isascii((unsigned char)(c))
>> +#define qemu_toascii(c)     toascii((unsigned char)(c))
>> +
>>  /**
>>   * pstrcpy:
>>   * @buf: buffer to copy string into
>> diff --git a/qapi/qapi-util.c b/qapi/qapi-util.c
>> index e9b266bb70..ea93ae05d9 100644
>> --- a/qapi/qapi-util.c
>> +++ b/qapi/qapi-util.c
>> @@ -11,8 +11,8 @@
>>   */
>>  
>>  #include "qemu/osdep.h"
>> +#include "qemu/cutils.h"
>>  #include "qapi/error.h"
>> -#include "qemu-common.h"
>>  
>>  const char *qapi_enum_lookup(const QEnumLookup *lookup, int val)
>>  {
>> diff --git a/qobject/json-parser.c b/qobject/json-parser.c
>> index 7a7ae9e8d1..06316f3a53 100644
>> --- a/qobject/json-parser.c
>> +++ b/qobject/json-parser.c
>> @@ -15,7 +15,6 @@
>>  #include "qemu/cutils.h"
>>  #include "qemu/unicode.h"
>>  #include "qapi/error.h"
>> -#include "qemu-common.h"
>>  #include "qapi/qmp/qbool.h"
>>  #include "qapi/qmp/qdict.h"
>>  #include "qapi/qmp/qlist.h"
>> diff --git a/target/ppc/monitor.c b/target/ppc/monitor.c
>> index 14915119fc..dbcb921231 100644
>> --- a/target/ppc/monitor.c
>> +++ b/target/ppc/monitor.c
>> @@ -22,6 +22,7 @@
>>   * THE SOFTWARE.
>>   */
>>  #include "qemu/osdep.h"
>> +#include "qemu/cutils.h"
>>  #include "cpu.h"
>>  #include "monitor/monitor.h"
>>  #include "monitor/hmp-target.h"
>> diff --git a/ui/keymaps.c b/ui/keymaps.c
>> index 085889b555..00b52a6db3 100644
>> --- a/ui/keymaps.c
>> +++ b/ui/keymaps.c
>> @@ -23,6 +23,7 @@
>>   */
>>  
>>  #include "qemu/osdep.h"
>> +#include "qemu/cutils.h"
>>  #include "keymaps.h"
>>  #include "sysemu/sysemu.h"
>>  #include "trace.h"
>> diff --git a/util/id.c b/util/id.c
>> index 6141352955..ca21a77522 100644
>> --- a/util/id.c
>> +++ b/util/id.c
>> @@ -11,7 +11,7 @@
>>   */
>>  
>>  #include "qemu/osdep.h"
>> -#include "qemu-common.h"
>> +#include "qemu/cutils.h"
>>  #include "qemu/id.h"
>>  
>>  bool id_wellformed(const char *id)
>> diff --git a/util/readline.c b/util/readline.c
>> index ec91ee0fea..f3d8b0698a 100644
>> --- a/util/readline.c
>> +++ b/util/readline.c
>> @@ -23,7 +23,6 @@
>>   */
>>  
>>  #include "qemu/osdep.h"
>> -#include "qemu-common.h"
>>  #include "qemu/readline.h"
>>  #include "qemu/cutils.h"
>>  
>>
> 
> Applied to my trivial-patches branch.

This patch breaks build:

  CC      riscv32-softmmu/target/riscv/cpu.o
.../qemu/target/riscv/cpu.c: In function 'riscv_isa_string':
.../qemu/target/riscv/cpu.c:378:20: error: implicit declaration of function 'qemu_tolower'; did you mean 'qemu_irq_lower'? [-Werror=implicit-function-declaration]
             *p++ = qemu_tolower(riscv_exts[i]);
                    ^~~~~~~~~~~~
                    qemu_irq_lower
.../qemu/target/riscv/cpu.c:378:20: error: nested extern declaration of 'qemu_tolower' [-Werror=nested-externs]
cc1: all warnings being treated as errors

I remove the series from the trivial-patches branch.

Thanks,
Laurent
