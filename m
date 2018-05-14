Received: from eggs.gnu.org ([2001:4830:134:3::10]:58684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fIBq0-0005wh-Vu
	for qemu-devel@nongnu.org; Mon, 14 May 2018 07:40:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fIBq0-00012Y-9q
	for qemu-devel@nongnu.org; Mon, 14 May 2018 07:40:21 -0400
Date: Mon, 14 May 2018 07:40:10 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20180514114010.GA868@localhost.localdomain>
References: <20180508135436.30140-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180508135436.30140-1-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/2] qemu-iotests: post-QEMU 2.12 fixes
 for 185
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

On Tue, May 08, 2018 at 02:54:34PM +0100, Stefan Hajnoczi wrote:
> v2:
>  * Rebase onto Jeff's block tree to get mirror ratelimit fix [Jeff, Vladimir]
>  * Update comments in 185 since drain no longer causes a spurious iteration
> 
> The 185 qemu-iotests test case was in a bad state for the QEMU 2.12 release.
> We fudged the expected test output to make it pass, except for
> non-deterministic behavior.
> 
> These patches get us back to pre-QEMU 2.12.  Notably the offsets reported in
> block job events now correspond to smaller buffer sizes because the job doesn't
> iterate during drain.
> 
> It's worth mentioning that the test case is still non-deterministic.  For more
> on that, see the first patch.
> 
> Stefan Hajnoczi (2):
>   qemu-iotests: reduce chance of races in 185
>   blockjob: do not cancel timer in resume
> 
>  blockjob.c                 | 22 +++++++++++++++-------
>  tests/qemu-iotests/185     | 17 +++++++++++++----
>  tests/qemu-iotests/185.out | 12 +++++-------
>  3 files changed, 33 insertions(+), 18 deletions(-)
> 
> -- 
> 2.14.3
> 

Thanks,

Applied to my block branch:

git://github.com/codyprime/qemu-kvm-jtc block

-Jeff
