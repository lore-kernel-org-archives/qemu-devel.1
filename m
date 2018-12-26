Received: from eggs.gnu.org ([208.118.235.92]:51373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gc8jj-0005r8-KI
	for qemu-devel@nongnu.org; Wed, 26 Dec 2018 07:56:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gc8jg-0007DW-Fh
	for qemu-devel@nongnu.org; Wed, 26 Dec 2018 07:56:35 -0500
Received: from mail-wm1-f44.google.com ([209.85.128.44]:52301)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gc8jg-0007BU-8c
	for qemu-devel@nongnu.org; Wed, 26 Dec 2018 07:56:32 -0500
Received: by mail-wm1-f44.google.com with SMTP id m1so14515417wml.2
	for <qemu-devel@nongnu.org>; Wed, 26 Dec 2018 04:56:31 -0800 (PST)
References: <20181226003722.31257-1-plaes@plaes.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <8d71a38b-f907-c959-0bb5-aed5b62f5652@redhat.com>
Date: Wed, 26 Dec 2018 13:56:28 +0100
MIME-Version: 1.0
In-Reply-To: <20181226003722.31257-1-plaes@plaes.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] qom: Include qemu/fprintf-fn.h in cpu.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Priit Laes <plaes@plaes.org>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org

On 12/26/18 1:37 AM, Priit Laes wrote:
> QOM cpu.h uses fprintf_function which requires Qemu's
> qemu/fprintf-fn.h header. Include it.
> 
> Signed-off-by: Priit Laes <plaes@plaes.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  include/qom/cpu.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/qom/cpu.h b/include/qom/cpu.h
> index 1396f53e5b..6d1ba53d72 100644
> --- a/include/qom/cpu.h
> +++ b/include/qom/cpu.h
> @@ -26,6 +26,7 @@
>  #include "exec/memattrs.h"
>  #include "qapi/qapi-types-run-state.h"
>  #include "qemu/bitmap.h"
> +#include "qemu/fprintf-fn.h"
>  #include "qemu/rcu_queue.h"
>  #include "qemu/queue.h"
>  #include "qemu/thread.h"
> 
