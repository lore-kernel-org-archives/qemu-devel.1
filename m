Received: from eggs.gnu.org ([2001:4830:134:3::10]:44074)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fzeIy-0007ZS-RA
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 04:45:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fzeIy-0005Fw-9B
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 04:45:52 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20180809213528.14738-5-mreitz@redhat.com>
References: <20180809213528.14738-1-mreitz@redhat.com>
	<20180809213528.14738-5-mreitz@redhat.com>
Date: Tue, 11 Sep 2018 10:45:45 +0200
Message-ID: <w515zzcpgli.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-3.1 v10 04/31] block: Add
 BDS.auto_backing_file
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

On Thu 09 Aug 2018 11:35:01 PM CEST, Max Reitz wrote:
> @@ -295,11 +296,13 @@ static int qcow_open(BlockDriverState *bs, QDict *options, int flags,
>              goto fail;
>          }
>          ret = bdrv_pread(bs->file, header.backing_file_offset,
> -                   bs->backing_file, len);
> +                   bs->auto_backing_file, len);
>          if (ret < 0) {
>              goto fail;
>          }
> -        bs->backing_file[len] = '\0';
> +        bs->auto_backing_file[len] = '\0';
> +        pstrcpy(bs->backing_file, sizeof(bs->backing_file),
> +                bs->auto_backing_file);
>      }

The patch looks fine, I just wonder why you don't simply copy
bs->backing_file into bs->auto_backing_file instead of the other way
around, it would make the patch smaller.

Either way,

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
