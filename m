Received: from eggs.gnu.org ([2001:4830:134:3::10]:45767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e5D17-0003UO-HT
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 11:45:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e5D12-0004vo-Lr
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 11:45:53 -0400
Date: Thu, 19 Oct 2017 17:45:22 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171019174522.637f048d.cohuck@redhat.com>
In-Reply-To: <1508336428-20511-1-git-send-email-thuth@redhat.com>
References: <1508336428-20511-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/2] Enable the simple virtio tests on
 s390x, too
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Eric Blake <eblake@redhat.com>, Michael S Tsirkin <mst@redhat.com>, Amit Shah <amit@kernel.org>

On Wed, 18 Oct 2017 16:20:26 +0200
Thomas Huth <thuth@redhat.com> wrote:

> First patch introduces the qtest_startf() function that can be used
> to start tests with a printf-like string. This patch was originally
> part of Eric's bigger qtest refactoring series, and I originally wanted
> to wait 'til it's included in the master branch. But since this did
> not happen yet and QEMU soft-freeze is approaching soon, I decided
> to rather included a slightly simplified version of that patch here
> instead.
> 
> The second patch then finally enables some of the simple virtio tests
> on s390x, too.
> 
> Eric Blake (1):
>   libqtest: Add qtest_[v]startf()
> 
> Thomas Huth (1):
>   tests: Enable the very simple virtio tests on s390x, too
> 
>  tests/Makefile.include         |  9 ++++---
>  tests/boot-order-test.c        | 11 +++------
>  tests/boot-serial-test.c       | 12 +++------
>  tests/endianness-test.c        | 33 +++++++++----------------
>  tests/ipmi-bt-test.c           | 11 +++------
>  tests/libqtest.c               | 22 +++++++++++++++++
>  tests/libqtest.h               | 25 +++++++++++++++++++
>  tests/m25p80-test.c            |  9 +++----
>  tests/pnv-xscom-test.c         | 16 +++---------
>  tests/prom-env-test.c          | 13 ++++------
>  tests/tco-test.c               | 10 +++-----
>  tests/test-filter-mirror.c     | 14 +++++------
>  tests/test-filter-redirector.c | 56 ++++++++++++++++++++----------------------
>  tests/virtio-balloon-test.c    |  8 +++---
>  tests/virtio-blk-test.c        |  5 +---
>  tests/virtio-console-test.c    | 19 ++++++++------
>  tests/virtio-serial-test.c     | 10 +++++---
>  tests/vmgenid-test.c           | 29 ++++++----------------
>  18 files changed, 156 insertions(+), 156 deletions(-)
> 

Thanks, applied.
