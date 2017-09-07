Received: from eggs.gnu.org ([2001:4830:134:3::10]:42440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dptWs-0001NQ-G6
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 05:55:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dptWn-0006QN-Vi
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 05:55:22 -0400
Date: Thu, 7 Sep 2017 11:55:03 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170907115503.4b67c33f.cohuck@redhat.com>
In-Reply-To: <20170907085310.19353-1-kwolf@redhat.com>
References: <20170907085310.19353-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] qemu-iotests: Add missing -machine
 accel=qtest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org

On Thu,  7 Sep 2017 10:53:10 +0200
Kevin Wolf <kwolf@redhat.com> wrote:

> A basic set of qemu options is initialised in ./common:
> 
>     export QEMU_OPTIONS="-nodefaults -machine accel=qtest"
> 
> However, two test cases (172 and 186) overwrite QEMU_OPTIONS and neglect
> to manually set '-machine accel=qtest'. Add the missing option for 172.
> 186 probably only copied the code from 172, it doesn't actually need to
> overwrite QEMU_OPTIONS, so remove that in 186.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  tests/qemu-iotests/172 | 2 +-
>  tests/qemu-iotests/186 | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)

I tested this on top of my change switching the default machine to
"tcg:kvm:xen:hax", and this now passes on x86_64 builds both with and
without tcg.

Tested-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
