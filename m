Received: from eggs.gnu.org ([2001:4830:134:3::10]:51582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fMKLo-0005tK-A3
	for qemu-devel@nongnu.org; Fri, 25 May 2018 17:34:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fMKLn-00079E-Gm
	for qemu-devel@nongnu.org; Fri, 25 May 2018 17:34:16 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:36957)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fMKLn-00078c-Cr
	for qemu-devel@nongnu.org; Fri, 25 May 2018 17:34:15 -0400
Received: by mail-qk0-x244.google.com with SMTP id j12-v6so1799907qkk.4
	for <qemu-devel@nongnu.org>; Fri, 25 May 2018 14:34:15 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1527266793-301361-1-git-send-email-mst@redhat.com>
	<1527266793-301361-11-git-send-email-mst@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <b40f758c-48e3-fb25-a7fa-9f45fd575707@amsat.org>
Date: Fri, 25 May 2018 18:34:11 -0300
MIME-Version: 1.0
In-Reply-To: <1527266793-301361-11-git-send-email-mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 10/20] rocker: drop an unused include
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Jiri Pirko <jiri@resnulli.us>, peter.maydell@linaro.org, Jason Wang <jasowang@redhat.com>

On 05/25/2018 01:47 PM, Michael S. Tsirkin wrote:
> We don't use net/clients.h, drop that include.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/net/rocker/rocker_fp.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/hw/net/rocker/rocker_fp.c b/hw/net/rocker/rocker_fp.c
> index 27b17c8..4aa7da7 100644
> --- a/hw/net/rocker/rocker_fp.c
> +++ b/hw/net/rocker/rocker_fp.c
> @@ -15,7 +15,6 @@
>   */
>  
>  #include "qemu/osdep.h"
> -#include "net/clients.h"
>  #include "qapi/qapi-types-rocker.h"
>  #include "rocker.h"
>  #include "rocker_hw.h"
> 
