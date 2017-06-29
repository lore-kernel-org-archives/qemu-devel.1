Received: from eggs.gnu.org ([2001:4830:134:3::10]:45203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dQZKX-0005Lk-0u
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 09:17:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dQZKW-00058W-9O
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 09:17:56 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170621125047.30294-2-mreitz@redhat.com>
References: <20170621125047.30294-1-mreitz@redhat.com>
	<20170621125047.30294-2-mreitz@redhat.com>
Date: Thu, 29 Jun 2017 15:17:44 +0200
Message-ID: <w51h8yz53wn.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v5 01/25] block/mirror: Small
 absolute-paths simplification
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

On Wed 21 Jun 2017 02:50:23 PM CEST, Max Reitz wrote:
> When invoking drive-mirror in absolute-paths mode, the target's backing
> BDS is assigned to it in mirror_exit(). The current logic only does so
> if the target does not have that backing BDS already; but it actually
> cannot have a backing BDS at all (the BDS is opened with O_NO_BACKING in
> qmp_drive_mirror()), so just assert that and assign the new backing BDS
> unconditionally.
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
