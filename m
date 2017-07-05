Received: from eggs.gnu.org ([2001:4830:134:3::10]:47702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1dSl1n-0004ml-Oa
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 10:11:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1dSl1m-0004Fh-Lj
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 10:11:39 -0400
References: <20170704220346.29244-1-marcandre.lureau@redhat.com>
	<20170704220346.29244-32-marcandre.lureau@redhat.com>
From: "Denis V. Lunev" <den@openvz.org>
Message-ID: <19ecc51e-1f7c-c812-abcb-9de3c587d698@openvz.org>
Date: Wed, 5 Jul 2017 17:11:12 +0300
MIME-Version: 1.0
In-Reply-To: <20170704220346.29244-32-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 31/35] parallels: mark coroutine_fn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:parallels" <qemu-block@nongnu.org>

On 07/05/2017 01:03 AM, Marc-Andr=C3=A9 Lureau wrote:
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  block/parallels.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/block/parallels.c b/block/parallels.c
> index 8be46a7d48..213e42b9d2 100644
> --- a/block/parallels.c
> +++ b/block/parallels.c
> @@ -472,7 +472,8 @@ static int parallels_check(BlockDriverState *bs, Bdrv=
CheckResult *res,
>  }
> =20
> =20
> -static int parallels_create(const char *filename, QemuOpts *opts, Error =
**errp)
> +static int coroutine_fn
> +parallels_create(const char *filename, QemuOpts *opts, Error **errp)
>  {
>      int64_t total_size, cl_size;
>      uint8_t tmp[BDRV_SECTOR_SIZE];
Reviewed-by: Denis V. Lunev <den@openvz.org>
