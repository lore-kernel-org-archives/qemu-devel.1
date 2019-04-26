Received: from eggs.gnu.org ([209.51.188.92]:34122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hK1Qx-0004YR-GJ
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 10:02:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hK1Qw-0006PP-Fe
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 10:02:35 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <cover.1554985749.git.berto@igalia.com>
References: <cover.1554985749.git.berto@igalia.com>
Date: Fri, 26 Apr 2019 16:02:32 +0200
Message-ID: <w51sgu4g8zr.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-4.1 v2 0/2] commit: Make base read-only
 if there is an early failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

ping

On Thu 11 Apr 2019 02:32:26 PM CEST, Alberto Garcia wrote:
> Hi,
>
> this is the same patch I posted yesterday, but with a test case.
>
> Berto
>
> Alberto Garcia (2):
>   commit: Make base read-only if there is an early failure
>   iotests: Check that images are in read-only mode after block-commit
>
>  block/commit.c             |   3 ++
>  tests/qemu-iotests/249     | 115 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/qemu-iotests/249.out |  35 ++++++++++++++
>  tests/qemu-iotests/group   |   1 +
>  4 files changed, 154 insertions(+)
>  create mode 100755 tests/qemu-iotests/249
>  create mode 100644 tests/qemu-iotests/249.out
>
> -- 
> 2.11.0
