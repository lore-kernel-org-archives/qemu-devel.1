Received: from eggs.gnu.org ([2001:4830:134:3::10]:45212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eCZwr-0004S2-3Q
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 18:39:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eCZwn-0002CE-4o
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 18:39:57 -0500
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:46532)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eCZwm-0002C4-W5
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 18:39:53 -0500
Received: by mail-qk0-x242.google.com with SMTP id o6so5595882qkh.3
	for <qemu-devel@nongnu.org>; Wed, 08 Nov 2017 15:39:52 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <cover.1510181732.git.alistair.francis@xilinx.com>
	<1dc70f25d82fc829cf85b9be45cb77d88d8f3af9.1510181732.git.alistair.francis@xilinx.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <143b2c67-4ebb-e8b6-bf4f-20db5a780768@amsat.org>
Date: Wed, 8 Nov 2017 20:39:49 -0300
MIME-Version: 1.0
In-Reply-To: <1dc70f25d82fc829cf85b9be45cb77d88d8f3af9.1510181732.git.alistair.francis@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 28/45] hw/nvram: Replace fprintf(stderr,
 "*\n" with error_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org
Cc: alistair23@gmail.com, armbru@redhat.com

On 11/08/2017 07:58 PM, Alistair Francis wrote:
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
> g_assert_not_reached().
> 
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> ---
> V3:
>  - Add g_assert_not_reached() in unused function
> V2:
>  - Split hw patch into individual directories
> 
>  hw/nvram/eeprom93xx.c | 5 +++--
>  hw/nvram/fw_cfg.c     | 5 +++--
>  2 files changed, 6 insertions(+), 4 deletions(-)
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

Sounds like funny english :)

>      exit(0);

Why not use g_assert_not_reached() for consistency?

>  
>      return 0;
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
> +    g_assert_not_reached();
>  
>      return 0;
>  }
> 
