Received: from eggs.gnu.org ([2001:4830:134:3::10]:35803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gArZr-00021C-KA
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 03:09:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gArZn-00007H-Ls
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 03:09:39 -0400
References: <20181012002113.2452-1-philmd@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <ea92c33f-9d85-fbea-68a9-4554367e3542@redhat.com>
Date: Fri, 12 Oct 2018 09:09:29 +0200
MIME-Version: 1.0
In-Reply-To: <20181012002113.2452-1-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] gdbstub: Remove unused include
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org

On 2018-10-12 02:21, Philippe Mathieu-Daud=C3=A9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  gdbstub.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/gdbstub.c b/gdbstub.c
> index c8478de8f5..c4e4f9f082 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -20,7 +20,6 @@
>  #include "qapi/error.h"
>  #include "qemu/error-report.h"
>  #include "qemu/cutils.h"
> -#include "cpu.h"
>  #include "trace-root.h"
>  #ifdef CONFIG_USER_ONLY
>  #include "qemu.h"

Seems to work.

Tested-by: Thomas Huth <thuth@redhat.com>
