Received: from eggs.gnu.org ([2001:4830:134:3::10]:57466)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e6aSU-000098-7t
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 06:59:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e6aSP-00047u-Au
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 06:59:50 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:49673)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e6aSP-00047S-6Y
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 06:59:45 -0400
Received: by mail-qk0-x243.google.com with SMTP id q83so21335727qke.6
	for <qemu-devel@nongnu.org>; Mon, 23 Oct 2017 03:59:43 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171023095910.23202-1-marcandre.lureau@redhat.com>
	<20171023095910.23202-3-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f8c56768-2081-302d-22bb-e9da913de40f@amsat.org>
Date: Mon, 23 Oct 2017 07:59:39 -0300
MIME-Version: 1.0
In-Reply-To: <20171023095910.23202-3-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 2/6] memfd: remove needless include
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, ehabkost@redhat.com

On 10/23/2017 06:59 AM, Marc-André Lureau wrote:
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  util/memfd.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/util/memfd.c b/util/memfd.c
> index e9c1a0e700..b5b7a41347 100644
> --- a/util/memfd.c
> +++ b/util/memfd.c
> @@ -27,8 +27,6 @@
>  
>  #include "qemu/osdep.h"
>  
> -#include <glib/gprintf.h>
> -
>  #include "qemu/memfd.h"
>  
>  #ifdef CONFIG_MEMFD
> 
