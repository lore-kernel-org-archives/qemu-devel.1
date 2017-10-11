Received: from eggs.gnu.org ([2001:4830:134:3::10]:55503)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e2CMM-0000DA-Ts
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 04:27:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e2CMJ-00057a-Pi
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 04:27:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43846)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1e2CMJ-00056g-JP
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 04:27:19 -0400
Date: Wed, 11 Oct 2017 10:27:11 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171011102711.179d7a27.cohuck@redhat.com>
In-Reply-To: <20170928203708.9376-17-david@redhat.com>
References: <20170928203708.9376-1-david@redhat.com>
	<20170928203708.9376-17-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 16/30] s390x/kvm: factor out SIGP code
 into sigp.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, thuth@redhat.com, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <richard.henderson@linaro.org>

On Thu, 28 Sep 2017 22:36:54 +0200
David Hildenbrand <david@redhat.com> wrote:

> We want to use the same code base for TCG, so let's cleanly factor it
> out.
> 
> The sigp mutex is currently not really needed, as everything is
> protected by the iothread mutex. But this could change later, so leave
> it in place and initialize it properly from common code.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/s390x/s390-virtio-ccw.c |   3 +
>  target/s390x/Makefile.objs |   1 +
>  target/s390x/cpu.c         |   8 -
>  target/s390x/cpu.h         |   6 +-
>  target/s390x/internal.h    |   4 +
>  target/s390x/kvm-stub.c    |   5 -
>  target/s390x/kvm.c         | 349 +-----------------------------------------
>  target/s390x/kvm_s390x.h   |   1 -
>  target/s390x/sigp.c        | 366 +++++++++++++++++++++++++++++++++++++++++++++
>  target/s390x/trace-events  |   4 +-
>  10 files changed, 388 insertions(+), 359 deletions(-)
>  create mode 100644 target/s390x/sigp.c

This had gained some conflicts in the meanwhile, but they were easy to
fix.
