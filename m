Received: from eggs.gnu.org ([2001:4830:134:3::10]:38925)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fEdhD-0000IN-RY
	for qemu-devel@nongnu.org; Fri, 04 May 2018 12:36:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fEdhA-00047s-Hg
	for qemu-devel@nongnu.org; Fri, 04 May 2018 12:36:35 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:35117)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fEdhA-00047X-DO
	for qemu-devel@nongnu.org; Fri, 04 May 2018 12:36:32 -0400
Received: by mail-qk0-x243.google.com with SMTP id b131so17088106qkg.2
	for <qemu-devel@nongnu.org>; Fri, 04 May 2018 09:36:32 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1525376963-79623-1-git-send-email-mst@redhat.com>
	<1525376963-79623-22-git-send-email-mst@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <8fd778a0-e178-3f9f-617c-2e4abb601b95@amsat.org>
Date: Fri, 4 May 2018 13:36:29 -0300
MIME-Version: 1.0
In-Reply-To: <1525376963-79623-22-git-send-email-mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 21/67] trace: use local path for local
 headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, peter.maydell@linaro.org

On 05/03/2018 04:50 PM, Michael S. Tsirkin wrote:
> When pulling in headers that are in the same directory as C file (as
> opposed to one in include/), we should use its relative path, without a
> directory. Directory based path works more or less by accident.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Can this be squashed with your 6/67?

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  trace/qmp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/trace/qmp.c b/trace/qmp.c
> index 756086c..ea99b00 100644
> --- a/trace/qmp.c
> +++ b/trace/qmp.c
> @@ -10,7 +10,7 @@
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
>  #include "qapi/qapi-commands-trace.h"
> -#include "trace/control.h"
> +#include "control.h"
>  
>  
>  static CPUState *get_cpu(bool has_vcpu, int vcpu, Error **errp)
> 
