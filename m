Received: from eggs.gnu.org ([2001:4830:134:3::10]:34506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fs0wD-0005vN-BL
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 03:18:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fs0w6-0003GT-U1
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 03:18:49 -0400
References: <20180821025104.19604-1-pavel.zbitskiy@gmail.com>
	<20180821025104.19604-2-pavel.zbitskiy@gmail.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <0f9cf43f-c8fb-9f15-8273-3a55956d3bab@redhat.com>
Date: Tue, 21 Aug 2018 09:18:40 +0200
MIME-Version: 1.0
In-Reply-To: <20180821025104.19604-2-pavel.zbitskiy@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/7] tests/tcg: add a simple s390x test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Zbitskiy <pavel.zbitskiy@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, cohuck@redhat.com, richard.henderson@linaro.org

On 21.08.2018 04:50, Pavel Zbitskiy wrote:
> Copied from alpha.
> 
> Signed-off-by: Pavel Zbitskiy <pavel.zbitskiy@gmail.com>
> ---
>  MAINTAINERS                     | 1 +
>  tests/tcg/s390x/Makefile.target | 3 +++
>  tests/tcg/s390x/hello-s390x.c   | 7 +++++++
>  3 files changed, 11 insertions(+)
>  create mode 100644 tests/tcg/s390x/Makefile.target
>  create mode 100644 tests/tcg/s390x/hello-s390x.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6902a568f4..27af17caa7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -253,6 +253,7 @@ S: Maintained
>  F: target/s390x/
>  F: hw/s390x/
>  F: disas/s390.c
> +F: tests/tcg/s390x/
>  L: qemu-s390x@nongnu.org
>  
>  SH4
> diff --git a/tests/tcg/s390x/Makefile.target b/tests/tcg/s390x/Makefile.target
> new file mode 100644
> index 0000000000..9f4076901f
> --- /dev/null
> +++ b/tests/tcg/s390x/Makefile.target
> @@ -0,0 +1,3 @@
> +VPATH+=$(SRC_PATH)/tests/tcg/s390x
> +CFLAGS+=-march=zEC12 -m64
> +TESTS+=hello-s390x
> diff --git a/tests/tcg/s390x/hello-s390x.c b/tests/tcg/s390x/hello-s390x.c
> new file mode 100644
> index 0000000000..3dc0a05f2b
> --- /dev/null
> +++ b/tests/tcg/s390x/hello-s390x.c
> @@ -0,0 +1,7 @@
> +#include <unistd.h>
> +
> +int main(void)
> +{
> +    write(1, "hello\n", 6);
> +    return 0;
> +}
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb
