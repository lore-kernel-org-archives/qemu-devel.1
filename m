Received: from eggs.gnu.org ([2001:4830:134:3::10]:43555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ezCTA-0000jH-Qi
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 22:30:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ezCT7-0001Yf-Ms
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 22:30:16 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:41117)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ezCT7-0001YX-BN
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 22:30:13 -0400
Received: by mail-qk0-x244.google.com with SMTP id s78so11459138qkl.8
	for <qemu-devel@nongnu.org>; Thu, 22 Mar 2018 19:30:13 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180322180940.8253-1-jcmvbkbc@gmail.com>
	<20180322180940.8253-4-jcmvbkbc@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <26b65a16-3ac7-1191-98aa-421e06957d7f@amsat.org>
Date: Thu, 22 Mar 2018 23:30:02 -0300
MIME-Version: 1.0
In-Reply-To: <20180322180940.8253-4-jcmvbkbc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 3/3] target/xtensa/import_core.sh: fix
 #include <xtensa-isa.h>
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Filippov <jcmvbkbc@gmail.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

On 03/22/2018 03:09 PM, Max Filippov wrote:
> Change #include <xtensa-isa.h> to #include "xtensa-isa.h" in imported
> files to make references to local files consistent.
> 
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  target/xtensa/import_core.sh | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/target/xtensa/import_core.sh b/target/xtensa/import_core.sh
> index 58a42987d853..af6c6104792d 100755
> --- a/target/xtensa/import_core.sh
> +++ b/target/xtensa/import_core.sh
> @@ -33,6 +33,7 @@ tar -xf "$OVERLAY" -O binutils/xtensa-modules.c | \
>          -e '/^uint32 \*bypass_entry(int i)/,/}/d' \
>          -e '/^#include "ansidecl.h"/d' \
>          -e '/^Slot_[a-zA-Z0-9_]\+_decode (const xtensa_insnbuf insn)/,/^}/s/^  return 0;$/  return XTENSA_UNDEFINED;/' \
> +        -e 's/#include <xtensa-isa.h>/#include "xtensa-isa.h"/' \
>      > "$TARGET"/xtensa-modules.inc.c
>  
>  cat <<EOF > "${TARGET}.c"
> 
