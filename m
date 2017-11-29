Received: from eggs.gnu.org ([2001:4830:134:3::10]:35098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eK4i0-0007uJ-1z
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 10:55:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eK4hw-0005UO-31
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 10:55:36 -0500
Date: Wed, 29 Nov 2017 16:55:03 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171129165503.23a0c3d7.cohuck@redhat.com>
In-Reply-To: <20171128203326.6062-15-david@redhat.com>
References: <20171128203326.6062-1-david@redhat.com>
	<20171128203326.6062-15-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 for-2.12 14/15] s390x/tcg: drop
 program_interrupt()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>

On Tue, 28 Nov 2017 21:33:24 +0100
David Hildenbrand <david@redhat.com> wrote:

> All users are gone, we can finally drop it and make sure that all new
> new program interrupt injections are reminded of the retaddr - as they

s/new new/new/

> have to use program_interrupt_ra() now.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/cpu.h       |  1 -
>  target/s390x/interrupt.c | 22 ++++++++--------------
>  2 files changed, 8 insertions(+), 15 deletions(-)
> 
