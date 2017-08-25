Received: from eggs.gnu.org ([2001:4830:134:3::10]:47552)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dlEyR-0007Ri-6W
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 09:48:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dlEyM-0005aB-Bl
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 09:48:35 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170808183306.27474-1-jsnow@redhat.com>
	<20170808183306.27474-10-jsnow@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <7c1d941f-61fe-03a0-4317-791a2d0d025f@amsat.org>
Date: Fri, 25 Aug 2017 10:48:25 -0300
MIME-Version: 1.0
In-Reply-To: <20170808183306.27474-10-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 9/9] AHCI: remove DPRINTF macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org

On 08/08/2017 03:33 PM, John Snow wrote:
> Signed-off-by: John Snow <jsnow@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   hw/ide/ahci.c | 9 ---------
>   1 file changed, 9 deletions(-)
> 
> diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
> index 1a4d4db..ce2010c 100644
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
