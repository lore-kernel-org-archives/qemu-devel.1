Received: from eggs.gnu.org ([2001:4830:134:3::10]:57514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cHYgC-0002xk-0m
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 11:14:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cHYgB-0004cB-4t
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 11:14:48 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20161130011851.24696-2-mreitz@redhat.com>
References: <20161130011851.24696-1-mreitz@redhat.com>
	<20161130011851.24696-2-mreitz@redhat.com>
Date: Thu, 15 Dec 2016 17:14:01 +0100
Message-ID: <w51r359dvau.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 01/25] block/mirror: Small
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

On Wed 30 Nov 2016 02:18:27 AM CET, Max Reitz wrote:
> When invoking drive-mirror in absolute-paths mode, the target's backing
> BDS is assigned to it in mirror_complete(). The current logic only does
> so if the target does not have that backing BDS already; but it actually
> cannot have a backing BDS at all (the BDS is opened with O_NO_BACKING in
> qmp_drive_mirror()), so just assert that and assign the new backing BDS
> unconditionally.
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
