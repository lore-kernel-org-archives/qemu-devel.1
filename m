Received: from eggs.gnu.org ([2001:4830:134:3::10]:48435)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fMKHK-00048u-Cm
	for qemu-devel@nongnu.org; Fri, 25 May 2018 17:29:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fMKHH-0002RU-8d
	for qemu-devel@nongnu.org; Fri, 25 May 2018 17:29:38 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:35132)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fMKHH-0002Qq-3s
	for qemu-devel@nongnu.org; Fri, 25 May 2018 17:29:35 -0400
Received: by mail-qk0-x242.google.com with SMTP id h140-v6so5142219qke.2
	for <qemu-devel@nongnu.org>; Fri, 25 May 2018 14:29:34 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1527266793-301361-1-git-send-email-mst@redhat.com>
	<1527266793-301361-6-git-send-email-mst@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <0c23ec8f-242e-3731-6da8-27a07185770c@amsat.org>
Date: Fri, 25 May 2018 18:29:29 -0300
MIME-Version: 1.0
In-Reply-To: <1527266793-301361-6-git-send-email-mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 05/20] trace: use local path for local
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
Cc: eblake@redhat.com, peter.maydell@linaro.org, Stefan Hajnoczi <stefanha@redhat.com>

On 05/25/2018 01:47 PM, Michael S. Tsirkin wrote:
> When pulling in headers that are in the same directory as C file (as
> opposed to one in include/), we should use its relative path, without a
> directory.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

This reminds me of this project:

https://github.com/noidontdig/gitdown

    gitdown is a script which moderates your git
    committing activity based on your blood alcohol
    content (BAC).

:P

> ---
>  trace/control.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/trace/control.h b/trace/control.h
> index 1903e22..eb65c8e 100644
> --- a/trace/control.h
> +++ b/trace/control.h
> @@ -267,6 +267,6 @@ char *trace_opt_parse(const char *optarg);
>  uint32_t trace_get_vcpu_event_count(void);
>  
>  
> -#include "trace/control-internal.h"
> +#include "control-internal.h"
>  
>  #endif /* TRACE__CONTROL_H */
> 
