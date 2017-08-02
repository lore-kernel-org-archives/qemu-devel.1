Received: from eggs.gnu.org ([2001:4830:134:3::10]:47238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dd1JY-0004VA-2D
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 17:36:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dd1JU-0000cS-57
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 17:36:24 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:36873)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dd1JU-0000bc-0L
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 17:36:20 -0400
Received: by mail-qt0-x241.google.com with SMTP id d10so5890265qtb.4
	for <qemu-devel@nongnu.org>; Wed, 02 Aug 2017 14:36:19 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170802201512.29142-1-crosa@redhat.com>
	<20170802201512.29142-2-crosa@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c9d1d353-855e-40fe-9f43-aecd9d4c34db@amsat.org>
Date: Wed, 2 Aug 2017 18:36:16 -0300
MIME-Version: 1.0
In-Reply-To: <20170802201512.29142-2-crosa@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/6] tests/tcg/test_path.c: include
 utils/bufferiszero.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org

Hi Cleber,

On 08/02/2017 05:15 PM, Cleber Rosa wrote:
> Which contains one specific function used by iov.c.
> 
> Without this, "make -C tests/tcg test_path" (and consequently
> "make -C tests/tcg" or simply "make test") fails quite early.
> 
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>   tests/tcg/test_path.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tests/tcg/test_path.c b/tests/tcg/test_path.c
> index 1c29bce..74dbdaf 100644
> --- a/tests/tcg/test_path.c
> +++ b/tests/tcg/test_path.c
> @@ -3,6 +3,7 @@
>   #include "util/cutils.c"
>   #include "util/hexdump.c"
>   #include "util/iov.c"
> +#include "util/bufferiszero.c"

This fixes the build, however why not take this opportunity to fix it 
through the Makefile instead of including .c?

Regards,

Phil.

>   #include "util/path.c"
>   #include "util/qemu-timer-common.c"
>   #include <stdarg.h>
> 
