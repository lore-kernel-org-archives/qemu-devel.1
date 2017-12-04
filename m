Received: from eggs.gnu.org ([2001:4830:134:3::10]:46145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eLsFb-0005s8-7t
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 10:01:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eLsFV-0002u8-Gy
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 10:01:43 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20171120201004.14999-15-mreitz@redhat.com>
References: <20171120201004.14999-1-mreitz@redhat.com>
	<20171120201004.14999-15-mreitz@redhat.com>
Date: Mon, 04 Dec 2017 16:01:21 +0100
Message-ID: <w51609m4jwe.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v7 for-2.12 14/25] block/nbd: Make
 bdrv_dirname() return NULL
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

On Mon 20 Nov 2017 09:09:53 PM CET, Max Reitz wrote:
> The generic bdrv_dirname() implementation would be able to generate some
> form of directory name for many NBD nodes, but it would be always wrong.
> Therefore, we have to explicitly make it an error (until NBD has some
> form of specification for export paths, if it ever will).
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
