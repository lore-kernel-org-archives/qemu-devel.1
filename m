Received: from eggs.gnu.org ([2001:4830:134:3::10]:57487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gPqTw-0007r4-Fl
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 10:01:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gPqTt-0005Wq-Av
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 10:01:28 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Thu, 22 Nov 2018 17:00:25 +0200
Message-Id: <cover.1542898669.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH 0/2] Minor fixes for the mirror block job
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

Hi,

a couple of minor fixes for the mirror block job. I don't think these
bugs can be reproduced at the moment so this shouldn't be 3.1
material.

Berto

Alberto Garcia (2):
  mirror: Release the dirty bitmap if mirror_start_job() fails
  mirror: Block the source BlockDriverState in mirror_start_job()

 block/mirror.c             | 11 +++++++++++
 tests/qemu-iotests/141.out |  4 ++--
 2 files changed, 13 insertions(+), 2 deletions(-)

-- 
2.11.0
