Received: from eggs.gnu.org ([2001:4830:134:3::10]:35844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ej563-0002S7-5k
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 10:23:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ej55y-0003S4-HA
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 10:23:47 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20180205151835.20812-19-mreitz@redhat.com>
References: <20180205151835.20812-1-mreitz@redhat.com>
	<20180205151835.20812-19-mreitz@redhat.com>
Date: Tue, 06 Feb 2018 16:23:30 +0100
Message-ID: <w51po5icfbh.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v8 18/26] block: Add sgfnt_runtime_opts to
 BlockDriver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>

On Mon 05 Feb 2018 04:18:27 PM CET, Max Reitz wrote:
> --- a/block/blkdebug.c
> +++ b/block/blkdebug.c
> @@ -886,6 +886,21 @@ static int blkdebug_reopen_prepare(BDRVReopenState *reopen_state,
>      return 0;
>  }
>  
> +static const char *const blkdebug_sgfnt_runtime_opts[] = {
> +    "config",
> +    "inject-error.",
> +    "set-state.",
> +    "suspend.",

Where did this "suspend." come from?

Berto
