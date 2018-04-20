Received: from eggs.gnu.org ([2001:4830:134:3::10]:46099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1f9UmD-0001HU-OY
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 08:04:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1f9UmA-0000C5-Ku
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 08:04:29 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20180416165849.28864-3-mreitz@redhat.com>
References: <20180416165849.28864-1-mreitz@redhat.com>
	<20180416165849.28864-3-mreitz@redhat.com>
Date: Fri, 20 Apr 2018 14:04:12 +0200
Message-ID: <w51zi1yw0cj.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 2/9] block: BLK_PERM_WRITE
 includes ..._UNCHANGED
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

On Mon 16 Apr 2018 06:58:42 PM CEST, Max Reitz wrote:
> Currently we never actually check whether the WRITE_UNCHANGED
> permission has been taken for unchanging writes.  But the one check that
> is commented out checks both WRITE and WRITE_UNCHANGED; and considering
> that WRITE_UNCHANGED is already documented as being weaker then WRITE,
> we should probably explicitly document WRITE to include WRITE_UNCHANGED.
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

s/then/than/ as Stefan mentioned.

Berto
