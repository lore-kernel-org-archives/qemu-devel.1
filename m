Received: from eggs.gnu.org ([2001:4830:134:3::10]:55467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eCIb4-0002Gx-81
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 00:08:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eCIb3-00038I-ER
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 00:08:18 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <cover.1510093478.git.jcody@redhat.com>
	<facec289ff8a7ea66e420585ac87baf65b3f4cd5.1510093478.git.jcody@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <ecd8c311-ee18-a556-2dca-3410d60834c6@amsat.org>
Date: Wed, 8 Nov 2017 02:08:08 -0300
MIME-Version: 1.0
In-Reply-To: <facec289ff8a7ea66e420585ac87baf65b3f4cd5.1510093478.git.jcody@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 6/7] block/curl: fix minor memory leaks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, mitake.hitoshi@lab.ntt.co.jp, rjones@redhat.com, namei.unix@gmail.com

Hi Jeff,

On 11/07/2017 07:27 PM, Jeff Cody wrote:

"Missed in 1bff9606429."

> Signed-off-by: Jeff Cody <jcody@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  block/curl.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/block/curl.c b/block/curl.c
> index 00a9879..35cf417 100644
> --- a/block/curl.c
> +++ b/block/curl.c
> @@ -857,6 +857,9 @@ out_noclean:
>      qemu_mutex_destroy(&s->mutex);
>      g_free(s->cookie);
>      g_free(s->url);
> +    g_free(s->username);
> +    g_free(s->proxyusername);
> +    g_free(s->proxypassword);
>      qemu_opts_del(opts);
>      return -EINVAL;
>  }
> @@ -955,6 +958,9 @@ static void curl_close(BlockDriverState *bs)
>  
>      g_free(s->cookie);
>      g_free(s->url);
> +    g_free(s->username);
> +    g_free(s->proxyusername);
> +    g_free(s->proxypassword);
>  }
>  
>  static int64_t curl_getlength(BlockDriverState *bs)
> 
