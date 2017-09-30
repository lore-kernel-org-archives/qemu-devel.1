Received: from eggs.gnu.org ([2001:4830:134:3::10]:54212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dyBbZ-00060c-OJ
	for qemu-devel@nongnu.org; Sat, 30 Sep 2017 02:50:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dyBbW-0000u4-M3
	for qemu-devel@nongnu.org; Sat, 30 Sep 2017 02:50:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45784)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dyBbW-0000tQ-Bt
	for qemu-devel@nongnu.org; Sat, 30 Sep 2017 02:50:26 -0400
References: <cover.1506730372.git.alistair.francis@xilinx.com>
	<6a3d7c62809b37ab0db03611643e9b581d7c7dd5.1506730372.git.alistair.francis@xilinx.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <5cb1fadb-aeac-a219-b0f7-e15bcd8b6591@redhat.com>
Date: Sat, 30 Sep 2017 08:50:21 +0200
MIME-Version: 1.0
In-Reply-To: <6a3d7c62809b37ab0db03611643e9b581d7c7dd5.1506730372.git.alistair.francis@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 29/47] hw/nvram: Replace fprintf(stderr,
 "*\n" with error_report()
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org
Cc: alistair23@gmail.com, armbru@redhat.com
List-ID: <qemu-devel.nongnu.org>

On 30.09.2017 02:16, Alistair Francis wrote:
> Replace a large number of the fprintf(stderr, "*\n" calls with
> error_report(). The functions were renamed with these commands and then
> compiler issues where manually fixed.
> 
> find ./* -type f -exec sed -i \
>     'N;N;N;N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N;N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>     {} +
> find ./* -type f -exec sed -i \
>     'N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>     {} +
> 
> Some lines where then manually tweaked to pass checkpatch.
> 
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> ---
> V2:
>  - Split hw patch into individual directories
> 
>  hw/nvram/eeprom93xx.c | 5 +++--
>  hw/nvram/fw_cfg.c     | 4 ++--
>  2 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/nvram/eeprom93xx.c b/hw/nvram/eeprom93xx.c
> index 2fd0e3c29f..5cad031eba 100644
> --- a/hw/nvram/eeprom93xx.c
> +++ b/hw/nvram/eeprom93xx.c
> @@ -36,6 +36,7 @@
>   */
>  
>  #include "qemu/osdep.h"
> +#include "qemu/error-report.h"
>  #include "hw/hw.h"
>  #include "hw/nvram/eeprom93xx.h"
>  
> @@ -105,8 +106,8 @@ static int get_uint16_from_uint8(QEMUFile *f, void *pv, size_t size,
>  static int put_unused(QEMUFile *f, void *pv, size_t size, VMStateField *field,
>                        QJSON *vmdesc)
>  {
> -    fprintf(stderr, "uint16_from_uint8 is used only for backwards compatibility.\n");
> -    fprintf(stderr, "Never should be used to write a new state.\n");
> +    error_report("uint16_from_uint8 is used only for backwards compatibility.");
> +    error_report("Never should be used to write a new state.");
>      exit(0);
>  
>      return 0;
> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
> index e3bd626b8c..cf9a816c0e 100644
> --- a/hw/nvram/fw_cfg.c
> +++ b/hw/nvram/fw_cfg.c
> @@ -515,8 +515,8 @@ static int get_uint32_as_uint16(QEMUFile *f, void *pv, size_t size,
>  static int put_unused(QEMUFile *f, void *pv, size_t size, VMStateField *field,
>                        QJSON *vmdesc)
>  {
> -    fprintf(stderr, "uint32_as_uint16 is only used for backward compatibility.\n");
> -    fprintf(stderr, "This functions shouldn't be called.\n");
> +    error_report("uint32_as_uint16 is only used for backward compatibility.");
> +    error_report("This functions shouldn't be called.");
>  
>      return 0;
>  }
> 

Looking at that code, it sounds like we should rather drop the error
printing here and use g_assert_not_reached() instead?

 Thomas
