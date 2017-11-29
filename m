Received: from eggs.gnu.org ([2001:4830:134:3::10]:50452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eK43m-0002Y6-S5
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 10:14:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eK43i-00085y-Rd
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 10:14:02 -0500
Date: Wed, 29 Nov 2017 16:13:51 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171129161351.7908b6b0.cohuck@redhat.com>
In-Reply-To: <20171128203326.6062-5-david@redhat.com>
References: <20171128203326.6062-1-david@redhat.com>
	<20171128203326.6062-5-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 for-2.12 04/15] s390x/ioinst: pass the
 retaddr to all IO instructions
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

On Tue, 28 Nov 2017 21:33:14 +0100
David Hildenbrand <david@redhat.com> wrote:

> TCG needs the retaddr when injecting an interrupt. Let's just pass it
> along and use 0 for KVM. The value will be completely ignored for KVM.

Can we get a #define for that? Just to make it clear at a glance that
we're passing an ignored value and not some magic thing.

> 
> Convert program_interrupt() to program_interrupt_ra() directly, making
> use of the passed address.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/internal.h    | 29 +++++++++++---------
>  target/s390x/ioinst.c      | 67 +++++++++++++++++++++++-----------------------
>  target/s390x/kvm.c         | 26 +++++++++---------
>  target/s390x/misc_helper.c | 20 +++++++-------
>  4 files changed, 73 insertions(+), 69 deletions(-)

Seems sane.
