Received: from eggs.gnu.org ([2001:4830:134:3::10]:55510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cZDIe-0008MM-G1
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 04:03:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cZD8O-0003Lc-1c
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 03:52:57 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <5c316901-5632-ff05-7700-6427cd33bf74@redhat.com>
References: <cover.1485878688.git.berto@igalia.com>
	<79f66648c685929a144396bda24d13a207131dcf.1485878688.git.berto@igalia.com>
	<5c316901-5632-ff05-7700-6427cd33bf74@redhat.com>
Date: Thu, 02 Feb 2017 09:52:46 +0100
Message-ID: <w5137fxoty9.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 1/2] qemu-io: don't allow I/O operations
 larger than INT_MAX
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

On Wed 01 Feb 2017 11:16:38 PM CET, Max Reitz <mreitz@redhat.com> wrote:

> Thanks, applied to my block tree, with
> %s/INT_MAX/BDRV_REQUEST_MAX_BYTES/g:

I think you can use %d to print BDRV_REQUEST_MAX_BYTES, after all the
definition guarantees that it won't be larger than MIN(SIZE_MAX,INT_MAX)

But it's fine with me if you prefer to cast it to uint64_t, that way
it'll remain valid if BDRV_REQUEST_MAX_BYTES is increased in the future.

Berto
