Received: from eggs.gnu.org ([2001:4830:134:3::10]:44715)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dmowz-0001As-DB
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 18:25:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dmowy-0005c5-HP
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 18:25:37 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170829204934.9039-1-jsnow@redhat.com>
	<20170829204934.9039-10-jsnow@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a11b6aca-c941-f45c-31d7-203dbe6507fe@amsat.org>
Date: Tue, 29 Aug 2017 19:24:51 -0300
MIME-Version: 1.0
In-Reply-To: <20170829204934.9039-10-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 9/9] AHCI: remove DPRINTF macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: eblake@redhat.com, qemu-devel@nongnu.org

On 08/29/2017 05:49 PM, John Snow wrote:
> Signed-off-by: John Snow <jsnow@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   hw/ide/ahci.c | 9 ---------
>   1 file changed, 9 deletions(-)
> 
> diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
> index 2e75f9b..57bb59d 100644
> --- a/hw/ide/ahci.c
> +++ b/hw/ide/ahci.c
> @@ -34,17 +34,8 @@
>   #include "hw/ide/pci.h"
>   #include "hw/ide/ahci_internal.h"
>   
> -#define DEBUG_AHCI 0
>   #include "trace.h"
>   
> -#define DPRINTF(port, fmt, ...) \
> -do { \
> -    if (DEBUG_AHCI) { \
> -        fprintf(stderr, "ahci: %s: [%d] ", __func__, port); \
> -        fprintf(stderr, fmt, ## __VA_ARGS__); \
> -    } \
> -} while (0)
> -
>   static void check_cmd(AHCIState *s, int port);
>   static int handle_cmd(AHCIState *s, int port, uint8_t slot);
>   static void ahci_reset_port(AHCIState *s, int port);
> 
