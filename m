Received: from eggs.gnu.org ([2001:4830:134:3::10]:50280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cv8VV-0001gq-I1
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 16:23:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cv8VU-0000Y2-O4
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 16:23:21 -0400
References: <20170403175150.15253-1-mreitz@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <3ec28a9e-a87b-f390-d9f4-849a48ac0020@redhat.com>
Date: Mon, 3 Apr 2017 16:23:11 -0400
MIME-Version: 1.0
In-Reply-To: <20170403175150.15253-1-mreitz@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH for-2.9 0/2] block/mirror: Fix
 use-after-free
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org



On 04/03/2017 01:51 PM, Max Reitz wrote:
> And the exciting 2.9 ride continues!
> 
> When mirroring from a BDS with no parents at all (such as those added
> with -blockdev or blockdev-add), we have a use-after-free in mirror's
> error path. The first patch of this series fixes that, the other adds a
> patch so we don't regress.
> 
> What issue will we find next? Stay tuned!
> 

Reviewed-by: John Snow <jsnow@redhat.com>

> 
> Max Reitz (2):
>   block/mirror: Fix use-after-free
>   iotests: Add mirror tests for orphaned source
> 
>  block/mirror.c                | 12 +++++++++--
>  tests/qemu-iotests/041        | 46 +++++++++++++++++++++++++++++++++++++++++++
>  tests/qemu-iotests/041.out    |  4 ++--
>  tests/qemu-iotests/iotests.py | 15 ++++++++++++++
>  4 files changed, 73 insertions(+), 4 deletions(-)
> 
