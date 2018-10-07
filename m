Received: from eggs.gnu.org ([2001:4830:134:3::10]:48348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1g9Crl-0000Q3-Qo
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 13:29:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1g9Crg-0000da-Ot
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 13:29:14 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20181006183851.3797-1-sw@weilnetz.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <eddc100f-944d-7661-77c0-bb1c90ed315a@amsat.org>
Date: Sun, 7 Oct 2018 19:29:02 +0200
MIME-Version: 1.0
In-Reply-To: <20181006183851.3797-1-sw@weilnetz.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] qemu-io-cmds: Fix two
 format strings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Weil <sw@weilnetz.de>, QEMU Developer <qemu-devel@nongnu.org>
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On 10/6/18 8:38 PM, Stefan Weil wrote:
> Use %zu instead of %zd for unsigned numbers.
> 
> This fixes two error messages from the LSTM static code analyzer:
> 
> This argument should be of type 'ssize_t' but is of type 'unsigned long'

Eventually prepend some spaces to have the difference between your
statement and the analyzer output.

> 
> Signed-off-by: Stefan Weil <sw@weilnetz.de>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  qemu-io-cmds.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
> index db0b3ee5ef..5363482213 100644
> --- a/qemu-io-cmds.c
> +++ b/qemu-io-cmds.c
> @@ -907,7 +907,7 @@ static int readv_f(BlockBackend *blk, int argc, char **argv)
>          memset(cmp_buf, pattern, qiov.size);
>          if (memcmp(buf, cmp_buf, qiov.size)) {
>              printf("Pattern verification failed at offset %"
> -                   PRId64 ", %zd bytes\n", offset, qiov.size);
> +                   PRId64 ", %zu bytes\n", offset, qiov.size);
>              ret = -EINVAL;
>          }
>          g_free(cmp_buf);
> @@ -1294,7 +1294,7 @@ static void aio_read_done(void *opaque, int ret)
>          memset(cmp_buf, ctx->pattern, ctx->qiov.size);
>          if (memcmp(ctx->buf, cmp_buf, ctx->qiov.size)) {
>              printf("Pattern verification failed at offset %"
> -                   PRId64 ", %zd bytes\n", ctx->offset, ctx->qiov.size);
> +                   PRId64 ", %zu bytes\n", ctx->offset, ctx->qiov.size);
>          }
>          g_free(cmp_buf);
>      }
> 
