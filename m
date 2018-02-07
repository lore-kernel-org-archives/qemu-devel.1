Received: from eggs.gnu.org ([2001:4830:134:3::10]:54357)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ejSNg-00054x-IP
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 11:15:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ejSNf-0005xK-Hf
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 11:15:32 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180207160302.15651-1-eblake@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <502805c5-e418-a27c-2a94-ae88c6efb12f@amsat.org>
Date: Wed, 7 Feb 2018 13:15:21 -0300
MIME-Version: 1.0
In-Reply-To: <20180207160302.15651-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] Drop unneeded system header includes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, armbru@redhat.com, Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>

On 02/07/2018 01:03 PM, Eric Blake wrote:
> <memory.h> is a non-standard obsolete header that was long ago
> replaced by <string.h>.
> 
> <malloc.h> is a non-standard header; it is not obsolete (we must
> use it for malloc_trim, for example), but generally should not
> be used in files that just need malloc() and friends, where
> <stdlib.h> is the standard header.
> 
> And since osdep.h already guarantees string.h and stdlib.h, we
> can drop these unusual system header includes as redundant
> rather than replacing them.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
> 
> Based-on: <20180207124009.12376-1-armbru@redhat.com>
> ([PULL 00/20] Miscellaneous patches for 2018-02-07)
> 
>  target/i386/hax-windows.h | 2 --
>  target/i386/hvf/x86_mmu.c | 1 -
>  2 files changed, 3 deletions(-)
> 
> diff --git a/target/i386/hax-windows.h b/target/i386/hax-windows.h
> index 004f8676949..20e2f85407b 100644
> --- a/target/i386/hax-windows.h
> +++ b/target/i386/hax-windows.h
> @@ -20,8 +20,6 @@
>  #ifndef TARGET_I386_HAX_WINDOWS_H
>  #define TARGET_I386_HAX_WINDOWS_H
> 
> -#include <memory.h>
> -#include <malloc.h>
>  #include <winioctl.h>
>  #include <windef.h>
> 
> diff --git a/target/i386/hvf/x86_mmu.c b/target/i386/hvf/x86_mmu.c
> index c6be2cca357..d5a0efe7188 100644
> --- a/target/i386/hvf/x86_mmu.c
> +++ b/target/i386/hvf/x86_mmu.c
> @@ -17,7 +17,6 @@
>   */
> 
>  #include "qemu/osdep.h"
> -#include <memory.h>
>  #include "panic.h"
>  #include "qemu-common.h"
>  #include "cpu.h"
> 
