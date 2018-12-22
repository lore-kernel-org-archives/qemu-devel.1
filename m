Received: from eggs.gnu.org ([2001:4830:134:3::10]:35600)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gaiwD-0008Bc-Co
	for qemu-devel@nongnu.org; Sat, 22 Dec 2018 10:11:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gaiwC-00006V-No
	for qemu-devel@nongnu.org; Sat, 22 Dec 2018 10:11:37 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20181217224348.14922-2-mreitz@redhat.com>
References: <20181217224348.14922-1-mreitz@redhat.com>
	<20181217224348.14922-2-mreitz@redhat.com>
Date: Sat, 22 Dec 2018 16:10:48 +0100
Message-ID: <w51a7kxfvgn.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v12 01/31] block: Use
 bdrv_refresh_filename() to pull
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>

On Mon 17 Dec 2018 11:43:18 PM CET, Max Reitz <mreitz@redhat.com> wrote:
> @@ -3327,6 +3333,7 @@ static int img_rebase(int argc, char **argv)
>                  qdict_put_bool(options, BDRV_OPT_FORCE_SHARE, true);
>              }
>  
> +            bdrv_refresh_filename(bs);
>              overlay_filename = bs->exact_filename[0] ? bs->exact_filename
>                                                       : bs->filename;
>              out_real_path = g_malloc(PATH_MAX);
> -- 
> 2.19.2

I also doubt that these new hunks are necessary, but it doesn't hurt to
be consistent :)

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
