Received: from eggs.gnu.org ([2001:4830:134:3::10]:49653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1dAXHG-00010O-Bf
	for qemu-devel@nongnu.org; Tue, 16 May 2017 03:52:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1dAXHF-0001tz-Fw
	for qemu-devel@nongnu.org; Tue, 16 May 2017 03:52:18 -0400
References: <20170516074256.24731-1-kraxel@redhat.com>
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <2c224267-32ec-ccf7-ae80-113ebfdce1e2@weilnetz.de>
Date: Tue, 16 May 2017 09:52:07 +0200
MIME-Version: 1.0
In-Reply-To: <20170516074256.24731-1-kraxel@redhat.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] block/win32: fix 'ret not initialized'
 warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:raw" <qemu-block@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Fam Zheng <famz@redhat.com>

Am 16.05.2017 um 09:42 schrieb Gerd Hoffmann:
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  block/file-win32.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/block/file-win32.c b/block/file-win32.c
> index 1a35dbabf2..8f14f0bdcd 100644
> --- a/block/file-win32.c
> +++ b/block/file-win32.c
> @@ -346,6 +346,7 @@ static int raw_open(BlockDriverState *bs, QDict *options, int flags,
>
>      if (qdict_get_try_bool(options, "locking", false)) {
>          error_setg(errp, "locking=on is not supported on Windows");
> +        ret = -EINVAL;
>          goto fail;
>      }


This is a bug fix for commit 1c3a555c.

Reviewed-by: Stefan Weil <sw@weilnetz.de>
