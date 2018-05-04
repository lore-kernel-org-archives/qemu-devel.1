Received: from eggs.gnu.org ([2001:4830:134:3::10]:37113)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fEdcl-00054z-3y
	for qemu-devel@nongnu.org; Fri, 04 May 2018 12:31:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fEdch-0008RJ-Uo
	for qemu-devel@nongnu.org; Fri, 04 May 2018 12:31:59 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:43026)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fEdch-0008RD-QB
	for qemu-devel@nongnu.org; Fri, 04 May 2018 12:31:55 -0400
Received: by mail-qt0-x242.google.com with SMTP id f13-v6so18311205qtp.10
	for <qemu-devel@nongnu.org>; Fri, 04 May 2018 09:31:55 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1525376963-79623-1-git-send-email-mst@redhat.com>
	<1525376963-79623-7-git-send-email-mst@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <1adf2611-5631-0e7b-c0ef-212daa79d636@amsat.org>
Date: Fri, 4 May 2018 13:31:51 -0300
MIME-Version: 1.0
In-Reply-To: <1525376963-79623-7-git-send-email-mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 06/67] trace: use local path for local
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

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

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
