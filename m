Received: from eggs.gnu.org ([2001:4830:134:3::10]:41706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ej3jy-0003pH-5H
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 08:56:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ej3js-0003sE-Iv
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 08:56:54 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20180205151835.20812-5-mreitz@redhat.com>
References: <20180205151835.20812-1-mreitz@redhat.com>
	<20180205151835.20812-5-mreitz@redhat.com>
Date: Tue, 06 Feb 2018 14:56:40 +0100
Message-ID: <w517erqdxwn.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v8 04/26] iotests: Drop explicit base
 blockdev in 191
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

On Mon 05 Feb 2018 04:18:13 PM CET, Max Reitz wrote:
> Overriding the backing image should result in a json:{} pseudo-filename.
> Then, you can no longer use the commit block job with filename
> parameters.  Therefore, do not explicitly add the base and override the
> middle image in iotest 191, since we do not need to anyway.  This will
> allow us to continue to use the middle image's filename to identify it.
>
> In the long run, we want block-commit to accept node names for base and
> top (just like block-stream does).
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
