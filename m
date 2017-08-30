Received: from eggs.gnu.org ([2001:4830:134:3::10]:42992)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dn6vW-0000Oj-1f
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 13:37:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dn6vV-0004s8-8o
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 13:37:18 -0400
MIME-Version: 1.0
Sender: philippe.mathieu.daude@gmail.com
In-Reply-To: <8fe8ddad6b924b460ca4ed4a7e401c18d24c246f.1504112061.git.jcody@redhat.com>
References: <cover.1504112061.git.jcody@redhat.com>
	<8fe8ddad6b924b460ca4ed4a7e401c18d24c246f.1504112061.git.jcody@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 30 Aug 2017 14:37:15 -0300
Message-ID: <CAAdtpL6kjOHOXF2L7qr5YTqrOvbSaE1Qyu_mccD=BHVRshq7qA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 3/7] block/sheepdog: remove spurious
 NULL check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Hitoshi Mitake <mitake.hitoshi@lab.ntt.co.jp>, Liu Yuan <namei.unix@gmail.com>, Kevin Wolf <kwolf@redhat.com>, rjones@redhat.com, "open list:Block layer core" <qemu-block@nongnu.org>

On Wed, Aug 30, 2017 at 1:57 PM, Jeff Cody <jcody@redhat.com> wrote:
> 'tag' is already checked in the lines immediately preceding this check,
> and set to non-NULL if NULL.  No need to check again, it hasn't changed.
>
> Signed-off-by: Jeff Cody <jcody@redhat.com>
> ---
>  block/sheepdog.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/block/sheepdog.c b/block/sheepdog.c
> index abb2e79..bbbfa72 100644
> --- a/block/sheepdog.c
> +++ b/block/sheepdog.c
> @@ -1632,7 +1632,7 @@ static int sd_open(BlockDriverState *bs, QDict *options, int flags,
>      if (!tag) {
>          tag = "";
>      }
> -    if (tag && strlen(tag) >= SD_MAX_VDI_TAG_LEN) {
> +    if (strlen(tag) >= SD_MAX_VDI_TAG_LEN) {

you can even prepend an 'else'! :D

>          error_setg(errp, "value of parameter 'tag' is too long");
>          ret = -EINVAL;
>          goto err_no_fd;
> --
> 2.9.5
>
>
