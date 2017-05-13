Received: from eggs.gnu.org ([2001:4830:134:3::10]:34687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d9f90-000277-2N
	for qemu-devel@nongnu.org; Sat, 13 May 2017 18:04:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d9f8w-0006Qn-VQ
	for qemu-devel@nongnu.org; Sat, 13 May 2017 18:04:10 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:33757)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d9f8w-0006Qa-Q6
	for qemu-devel@nongnu.org; Sat, 13 May 2017 18:04:06 -0400
Received: by mail-qk0-x242.google.com with SMTP id o85so12398570qkh.0
	for <qemu-devel@nongnu.org>; Sat, 13 May 2017 15:04:06 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170513015449.24061-1-n54@gmx.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <91e1cbd3-88e6-2b7a-c4e4-824c54f34c52@amsat.org>
Date: Sat, 13 May 2017 19:04:02 -0300
MIME-Version: 1.0
In-Reply-To: <20170513015449.24061-1-n54@gmx.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] libvixl: Correct ordering of includes and
 fix NetBSD build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kamil Rytarowski <n54@gmx.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, claudio.fontana@huawei.com

Hi Kamil,

I think it is safer to add it in disas/libvixl/Makefile.objs where 
QEMU_CFLAGS are tuned for libvixl.
This way you don't need to modify upstream libvixl.

Regards,

Phil.

On 05/12/2017 10:54 PM, Kamil Rytarowski wrote:
> The __STDC_CONSTANT_MACROS symbol must be defined before including
> directly or indirectly <stdint.h> in order to get support for macros
> for integer constants like INT8_C().
>
> The vixl/globals.h headers defines __STDC_CONSTANT_MACROS and must be
> included before other system headers.
>
> This change fixes build failures on NetBSD.
>
> Signed-off-by: Kamil Rytarowski <n54@gmx.com>
> ---
>  disas/libvixl/vixl/a64/disasm-a64.cc | 2 +-
>  disas/libvixl/vixl/utils.h           | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/disas/libvixl/vixl/a64/disasm-a64.cc b/disas/libvixl/vixl/a64/disasm-a64.cc
> index 7a58a5c087..fc87306893 100644
> --- a/disas/libvixl/vixl/a64/disasm-a64.cc
> +++ b/disas/libvixl/vixl/a64/disasm-a64.cc
> @@ -24,8 +24,8 @@
>  // OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
>  // OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
>
> -#include <cstdlib>
>  #include "vixl/a64/disasm-a64.h"
> +#include <cstdlib>
>
>  namespace vixl {
>
> diff --git a/disas/libvixl/vixl/utils.h b/disas/libvixl/vixl/utils.h
> index 5ab134e240..17034addbc 100644
> --- a/disas/libvixl/vixl/utils.h
> +++ b/disas/libvixl/vixl/utils.h
> @@ -27,10 +27,10 @@
>  #ifndef VIXL_UTILS_H
>  #define VIXL_UTILS_H
>
> -#include <string.h>
> -#include <cmath>
>  #include "vixl/globals.h"
>  #include "vixl/compiler-intrinsics.h"
> +#include <string.h>
> +#include <cmath>
>
>  namespace vixl {
>
>
