Received: from eggs.gnu.org ([2001:4830:134:3::10]:49181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d188n-0003VN-Da
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 05:12:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d188m-0005qx-IR
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 05:12:41 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170420040003.31074-1-famz@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <928a9bd8-9f0a-a3c3-8326-b955d118c906@amsat.org>
Date: Thu, 20 Apr 2017 06:12:28 -0300
MIME-Version: 1.0
In-Reply-To: <20170420040003.31074-1-famz@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] sheepdog: Set error when connection fails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, sheepdog@lists.wpkg.org, qemu-block@nongnu.org, Hitoshi Mitake <mitake.hitoshi@lab.ntt.co.jp>, Jeff Cody <jcody@redhat.com>, Max Reitz <mreitz@redhat.com>, Liu Yuan <namei.unix@gmail.com>

On 04/20/2017 01:00 AM, Fam Zheng wrote:
> Signed-off-by: Fam Zheng <famz@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  block/sheepdog.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/block/sheepdog.c b/block/sheepdog.c
> index fb9203e..7e889ee 100644
> --- a/block/sheepdog.c
> +++ b/block/sheepdog.c
> @@ -608,6 +608,7 @@ static int connect_to_sdog(BDRVSheepdogState *s, Error **errp)
>          qemu_set_nonblock(fd);
>      } else {
>          fd = -EIO;
> +        error_setg(errp, "Failed to connect to sheepdog server");
>      }
>
>      return fd;
>
