Received: from eggs.gnu.org ([2001:4830:134:3::10]:48930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fG2CY-0004PK-1m
	for qemu-devel@nongnu.org; Tue, 08 May 2018 08:58:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fG2CU-0001sQ-3R
	for qemu-devel@nongnu.org; Tue, 08 May 2018 08:58:42 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:45035)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fG2CT-0001sJ-VF
	for qemu-devel@nongnu.org; Tue, 08 May 2018 08:58:38 -0400
Received: by mail-qt0-x242.google.com with SMTP id d3-v6so40760304qtp.11
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 05:58:37 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1525376963-79623-1-git-send-email-mst@redhat.com>
	<1525376963-79623-12-git-send-email-mst@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <afada599-d089-a0e5-4e15-4684e415b7b4@amsat.org>
Date: Tue, 8 May 2018 09:58:34 -0300
MIME-Version: 1.0
In-Reply-To: <1525376963-79623-12-git-send-email-mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 11/67] rocker: drop an unused include
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, Jason Wang <jasowang@redhat.com>, Jiri Pirko <jiri@resnulli.us>

On 05/03/2018 04:50 PM, Michael S. Tsirkin wrote:
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
