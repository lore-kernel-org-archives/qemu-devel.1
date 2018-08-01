Received: from eggs.gnu.org ([2001:4830:134:3::10]:44949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fkrGl-0005NZ-TO
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 09:34:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fkrGh-0007vp-0D
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 09:34:27 -0400
Date: Wed, 1 Aug 2018 15:34:19 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180801153419.08e12a63.cohuck@redhat.com>
In-Reply-To: <20180801132733.15628-1-pbonzini@redhat.com>
References: <20180801132733.15628-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] tests: virtio: separate ccw tests from
 libqos
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, e.emanuelegiuseppe@gmail.com

On Wed,  1 Aug 2018 15:27:33 +0200
Paolo Bonzini <pbonzini@redhat.com> wrote:

> Because qtest does not support s390 channel I/O, s390 only performs smoke tests on
> those few devices that do not have any functional tests.  Therefore, every time we
> add functional tests for a virtio device, the choice is between removing
> those tests from the s390 suite (so that s390 actually _loses_ coverage)
> or sprinkling the test with architecture checks.
> 
> This patch simply creates a ccw-specific test that only performs smoke tests on
> all virtio-ccw devices.  If channel I/O support is ever added to qtest and libqos,
> then this file can go away.  In the meanwhile, it simplifies maintenance and
> makes sure that all virtio devices are tested.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  tests/Makefile.include  |   5 +-
>  tests/virtio-ccw-test.c | 118 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 120 insertions(+), 3 deletions(-)
>  create mode 100644 tests/virtio-ccw-test.c

I'm not that familiar with qtest/libqos, but that sounds like a
reasonable approach.

Acked-by: Cornelia Huck <cohuck@redhat.com>
