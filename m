Received: from eggs.gnu.org ([2001:4830:134:3::10]:34354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1erIKu-0004Jl-8d
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 02:09:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1erIKt-0002pj-F0
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 02:09:04 -0500
Date: Thu, 1 Mar 2018 15:08:36 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180301070836.GF21198@lemon.usersys.redhat.com>
References: <20180228180507.3964-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180228180507.3964-1-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 00/16] block/mirror: Add active-sync
 mirroring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On Wed, 02/28 19:04, Max Reitz wrote:
> v3: [Fam]
> - Patch 5: Drop shadowing ret declaration
> - Patch 11: Added
> - Patch 12: Add comment on how @iter is modified by
>             bdrv_dirty_iter_next_area()
> - Patch 14:
>   - Squashed old patch 12 into this one
>   - Don't forget write_zeroes and discard
> - Patch 15: %s/passive/background/
> - Patch 16: Write some zeroes so we can see those are actively copied,
>             too (i.e. test the changes to patch 14 from v2)

Reviewed-by: Fam Zheng <famz@redhat.com>
