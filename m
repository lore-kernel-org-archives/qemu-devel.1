Received: from eggs.gnu.org ([2001:4830:134:3::10]:39045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cHZ4E-0003H9-5o
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 11:39:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cHZ4D-000393-Ex
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 11:39:38 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20161130011851.24696-8-mreitz@redhat.com>
References: <20161130011851.24696-1-mreitz@redhat.com>
	<20161130011851.24696-8-mreitz@redhat.com>
Date: Thu, 15 Dec 2016 17:39:30 +0100
Message-ID: <w51lgvhdu4d.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 07/25] block:
 bdrv_get_full_backing_filename's ret. val.
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

On Wed 30 Nov 2016 02:18:33 AM CET, Max Reitz wrote:
>  int bdrv_open_backing_file(BlockDriverState *bs, QDict *parent_options,
>                             const char *bdref_key, Error **errp)
>  {
> -    char *backing_filename = g_malloc0(PATH_MAX);
> +    char *backing_filename = NULL;
>      char *bdref_key_dot;
>      const char *reference = NULL;
>      int ret = 0;
> @@ -1511,7 +1505,7 @@ int bdrv_open_backing_file(BlockDriverState *bs, QDict *parent_options,
>  
>      reference = qdict_get_try_str(parent_options, bdref_key);
>      if (reference || qdict_haskey(options, "file.filename")) {
> -        backing_filename[0] = '\0';
> +        backing_filename = NULL;

You're making it NULL, but it's NULL already.

Otherwise the patch looks fine.

Berto
