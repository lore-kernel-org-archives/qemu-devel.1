Received: from eggs.gnu.org ([2001:4830:134:3::10]:53512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d3C4m-0002Sm-M5
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 21:49:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d3C4j-0001ey-IK
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 21:49:04 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:34633)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d3C4j-0001eh-Ed
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 21:49:01 -0400
Received: by mail-qk0-x241.google.com with SMTP id u75so11548389qka.1
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 18:49:01 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170425223739.6703-1-quintela@redhat.com>
	<20170425223739.6703-27-quintela@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <ae2ae7e8-6e56-8cd2-a50c-f6837c7ccc07@amsat.org>
Date: Tue, 25 Apr 2017 22:48:57 -0300
MIME-Version: 1.0
In-Reply-To: <20170425223739.6703-27-quintela@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 26/26] audio: Use ARRAY_SIZE from
 qemu/osdep.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com

On 04/25/2017 07:37 PM, Juan Quintela wrote:
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/audio/fmopl.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/hw/audio/fmopl.c b/hw/audio/fmopl.c
> index dc9043c..202f752 100644
> --- a/hw/audio/fmopl.c
> +++ b/hw/audio/fmopl.c
> @@ -34,15 +34,11 @@
>  #include <math.h>
>  //#include "driver.h"		/* use M.A.M.E. */
>  #include "fmopl.h"
> -
> +#include "qemu/osdep.h"
>  #ifndef PI
>  #define PI 3.14159265358979323846
>  #endif
>
> -#ifndef ARRAY_SIZE
> -#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
> -#endif
> -
>  /* -------------------- for debug --------------------- */
>  /* #define OPL_OUTPUT_LOG */
>  #ifdef OPL_OUTPUT_LOG
>
