Received: from eggs.gnu.org ([2001:4830:134:3::10]:35107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gMc9c-0006HH-5A
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 12:07:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gMc4K-0003EN-Pz
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 12:01:45 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:44257)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gMc4K-00037j-EN
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 12:01:40 -0500
Received: by mail-oi1-x241.google.com with SMTP id p82-v6so10914559oih.11
	for <qemu-devel@nongnu.org>; Tue, 13 Nov 2018 09:01:32 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20181113165247.4806-3-sameo@linux.intel.com>
References: <20181113165247.4806-1-sameo@linux.intel.com>
	<20181113165247.4806-3-sameo@linux.intel.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Nov 2018 17:01:11 +0000
Message-ID: <CAFEAcA-R51dyV7gtS+q-eLNn5LBJbSMKtQu4-N3p0c4mJrU8DA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 02/13] target: arm: Remove unused headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>

On 13 November 2018 at 16:52, Samuel Ortiz <sameo@linux.intel.com> wrote:
> From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Reviewed-by: Robert Bradford <robert.bradford@intel.com>
> Reviewed-by: Samuel Ortiz <sameo@linux.intel.com>
> ---
>  target/arm/helper.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 3d4e9c5c8a..27d9285e1e 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -12,13 +12,10 @@
>  #include "internals.h"
>  #include "exec/gdbstub.h"
>  #include "exec/helper-proto.h"
> -#include "qemu/host-utils.h"

This is for muldiv64().

>  #include "sysemu/arch_init.h"
>  #include "sysemu/sysemu.h"
> -#include "qemu/bitops.h"

This is for extract32() and friends.

>  #include "qemu/crc32c.h"
>  #include "exec/exec-all.h"
> -#include "exec/cpu_ldst.h"

This is for cpu_stl_data().

>  #include "arm_ldst.h"
>  #include <zlib.h> /* For crc32 */
>  #include "exec/semihost.h"

thanks
-- PMM
