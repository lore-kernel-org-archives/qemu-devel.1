Received: from eggs.gnu.org ([2001:4830:134:3::10]:57853)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eEOb4-0005FR-Th
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 18:57:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eEOb3-0008F5-Td
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 18:56:59 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <cover.1510612380.git.alistair.francis@xilinx.com>
	<83aa5da9c3f6220edf68b49c6f16bf84108616ab.1510612380.git.alistair.francis@xilinx.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <e7e93010-6a95-3c11-1ccc-a3e009b2a5a7@amsat.org>
Date: Mon, 13 Nov 2017 20:56:47 -0300
MIME-Version: 1.0
In-Reply-To: <83aa5da9c3f6220edf68b49c6f16bf84108616ab.1510612380.git.alistair.francis@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH v5 17/29] hw/nvram: Replace
 fprintf(stderr, "*\n" with error_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: alistair23@gmail.com, armbru@redhat.com

On 11/13/2017 07:35 PM, Alistair Francis wrote:
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
> Some of the message in put_unused() was removed and replaced with
> g_assert_not_reached() and some of the messages were updated.
> 
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> ---
> V3:
>  - Add g_assert_not_reached() in unused function
> V2:
>  - Split hw patch into individual directories
> 
>  hw/nvram/eeprom93xx.c | 7 ++++---
>  hw/nvram/fw_cfg.c     | 5 +++--
>  2 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/nvram/eeprom93xx.c b/hw/nvram/eeprom93xx.c
> index 2fd0e3c29f..6ffce745ae 100644
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
> @@ -105,9 +106,9 @@ static int get_uint16_from_uint8(QEMUFile *f, void *pv, size_t size,
>  static int put_unused(QEMUFile *f, void *pv, size_t size, VMStateField *field,
>                        QJSON *vmdesc)
>  {
> -    fprintf(stderr, "uint16_from_uint8 is used only for backwards compatibility.\n");
> -    fprintf(stderr, "Never should be used to write a new state.\n");
> -    exit(0);
> +    error_report("uint16_from_uint8 is used only for backwards compatibility.");
> +    error_report("It should never be used to write a new state.");
> +    g_assert_not_reached();
>  
>      return 0;
>  }
> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
> index 753ac0e4ea..1c66052f1f 100644
> --- a/hw/nvram/fw_cfg.c
> +++ b/hw/nvram/fw_cfg.c
> @@ -518,8 +518,9 @@ static int get_uint32_as_uint16(QEMUFile *f, void *pv, size_t size,
>  static int put_unused(QEMUFile *f, void *pv, size_t size, VMStateField *field,
>                        QJSON *vmdesc)
>  {
> -    fprintf(stderr, "uint32_as_uint16 is only used for backward compatibility.\n");
> -    fprintf(stderr, "This functions shouldn't be called.\n");
> +    error_report("uint32_as_uint16 is only used for backward compatibility.");

> +

Maybe Michael can remove this extra line, anyway:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> +    g_assert_not_reached();
>  
>      return 0;
>  }
> 
