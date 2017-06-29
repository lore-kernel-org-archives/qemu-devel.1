Received: from eggs.gnu.org ([2001:4830:134:3::10]:45803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dQZMU-0007V3-Bg
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 09:20:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dQZMT-0005oB-Kf
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 09:19:58 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170621125047.30294-3-mreitz@redhat.com>
References: <20170621125047.30294-1-mreitz@redhat.com>
	<20170621125047.30294-3-mreitz@redhat.com>
Date: Thu, 29 Jun 2017 15:19:54 +0200
Message-ID: <w51efu353t1.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v5 02/25] block: Use children list in
 bdrv_refresh_filename
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

On Wed 21 Jun 2017 02:50:24 PM CEST, Max Reitz wrote:
> bdrv_refresh_filename() should invoke itself recursively on all
> children, not just on file.
>
> With that change, we can remove the manual invocations in blkverify,
> quorum, commit, and mirror.
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
