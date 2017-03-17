Received: from eggs.gnu.org ([2001:4830:134:3::10]:50925)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cowRx-0002hl-Pr
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 14:18:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cowRw-000416-V2
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 14:18:05 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170317152412.8472-1-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <8d5d2fd4-644f-d24a-fb56-4d9edc3723e8@amsat.org>
Date: Fri, 17 Mar 2017 15:17:56 -0300
MIME-Version: 1.0
In-Reply-To: <20170317152412.8472-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] curl: fix compilation on OpenBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-block@nongnu.org

On 03/17/2017 12:24 PM, Paolo Bonzini wrote:
> EPROTO is not found in OpenBSD.   We usually use EIO when no better
> errno is available, do that here too.
>
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  block/curl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/block/curl.c b/block/curl.c
> index e83dcd8..34dbd33 100644
> --- a/block/curl.c
> +++ b/block/curl.c
> @@ -377,7 +377,7 @@ static void curl_multi_check_completion(BDRVCURLState *s)
>                      }
>
>                      qemu_mutex_unlock(&s->mutex);
> -                    acb->common.cb(acb->common.opaque, -EPROTO);
> +                    acb->common.cb(acb->common.opaque, -EIO);
>                      qemu_mutex_lock(&s->mutex);
>                      qemu_aio_unref(acb);
>                      state->acb[i] = NULL;
>
