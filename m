Received: from eggs.gnu.org ([2001:4830:134:3::10]:45108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eMBfc-0004dN-0V
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 06:45:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eMBfa-0004su-WE
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 06:45:52 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20171120201004.14999-25-mreitz@redhat.com>
References: <20171120201004.14999-1-mreitz@redhat.com>
	<20171120201004.14999-25-mreitz@redhat.com>
Date: Tue, 05 Dec 2017 12:45:41 +0100
Message-ID: <w517eu175zu.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v7 for-2.12 24/25] block/curl: Implement
 bdrv_refresh_filename()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>

On Mon 20 Nov 2017 09:10:03 PM CET, Max Reitz <mreitz@redhat.com> wrote:
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/curl.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/block/curl.c b/block/curl.c
> index 11318a9a29..fe57223fda 100644
> --- a/block/curl.c
> +++ b/block/curl.c
> @@ -957,6 +957,20 @@ static int64_t curl_getlength(BlockDriverState *bs)
>      return s->len;
>  }
>  
> +static void curl_refresh_filename(BlockDriverState *bs)
> +{
> +    BDRVCURLState *s = bs->opaque;
> +
> +    if (!s->sslverify || s->cookie ||
> +        s->username || s->password || s->proxyusername || s->proxypassword)
> +    {
> +        return;
> +    }
> +
> +    pstrcpy(bs->exact_filename, sizeof(bs->exact_filename), s->url);
> +}

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
