Received: from eggs.gnu.org ([2001:4830:134:3::10]:48440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gXkEC-0005o3-35
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 04:57:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gXkE8-0007P0-1u
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 04:57:51 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <cover.1542898669.git.berto@igalia.com>
References: <cover.1542898669.git.berto@igalia.com>
Date: Fri, 14 Dec 2018 10:57:43 +0100
Message-ID: <w51mup8ctwo.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 0/2] Minor fixes for the mirror block job
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

ping

On Thu 22 Nov 2018 04:00:25 PM CET, Alberto Garcia wrote:
> Hi,
>
> a couple of minor fixes for the mirror block job. I don't think these
> bugs can be reproduced at the moment so this shouldn't be 3.1
> material.
>
> Berto
>
> Alberto Garcia (2):
>   mirror: Release the dirty bitmap if mirror_start_job() fails
>   mirror: Block the source BlockDriverState in mirror_start_job()
>
>  block/mirror.c             | 11 +++++++++++
>  tests/qemu-iotests/141.out |  4 ++--
>  2 files changed, 13 insertions(+), 2 deletions(-)
>
> -- 
> 2.11.0
