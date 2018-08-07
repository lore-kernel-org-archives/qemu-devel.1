Received: from eggs.gnu.org ([2001:4830:134:3::10]:44726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fn2uc-0005rL-Hp
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 10:24:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fn2ub-0004Yk-SI
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 10:24:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42348 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1fn2ub-0004YS-Hv
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 10:24:37 -0400
Date: Tue, 7 Aug 2018 16:24:24 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180807162424.7761b2a6.cohuck@redhat.com>
In-Reply-To: <153299244635.14411.14909988281437283403.stgit@gimli.home>
References: <153299204130.14411.11438396195753743913.stgit@gimli.home>
	<153299244635.14411.14909988281437283403.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/4] kvm: Use inhibit to prevent
 ballooning without synchronous mmu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, peterx@redhat.com, mst@redhat.com, david@redhat.com

On Mon, 30 Jul 2018 17:14:06 -0600
Alex Williamson <alex.williamson@redhat.com> wrote:

> Remove KVM specific tests in balloon_page(), instead marking
> ballooning as inhibited without KVM_CAP_SYNC_MMU support.
> 
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> ---
>  accel/kvm/kvm-all.c        |    4 ++++
>  hw/virtio/virtio-balloon.c |    4 +---
>  2 files changed, 5 insertions(+), 3 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
