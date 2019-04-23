Received: from eggs.gnu.org ([209.51.188.92]:42446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hIxvV-0007ga-Nm
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 12:05:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hIxvU-0007JL-TL
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 12:05:45 -0400
Date: Tue, 23 Apr 2019 18:05:24 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190423180524.56881870.cohuck@redhat.com>
In-Reply-To: <20190417113143.5551-3-david@redhat.com>
References: <20190417113143.5551-1-david@redhat.com>
	<20190417113143.5551-3-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 2/2] exec: Introduce
 qemu_maxrampagesize() and rename qemu_getrampagesize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Igor Mammedov <imammedo@redhat.com>, peter.maydell@linaro.org, pbonzini@redhat.com, Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, Alex Williamson <alex.williamson@redhat.com>

On Wed, 17 Apr 2019 13:31:43 +0200
David Hildenbrand <david@redhat.com> wrote:

> Rename qemu_getrampagesize() to qemu_minrampagesize(). While at it,
> properly rename find_max_supported_pagesize() to
> find_min_backend_pagesize().
> 
> s390x is actually interested into the maximum ram pagesize, so
> introduce and use qemu_maxrampagesize().
> 
> Add a TODO, indicating that looking at any mapped memory backends is not
> 100% correct in some cases.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  exec.c                     | 44 ++++++++++++++++++++++++++++++++++----
>  hw/ppc/spapr_caps.c        |  4 ++--
>  hw/s390x/s390-virtio-ccw.c |  2 +-
>  hw/vfio/spapr.c            |  2 +-
>  include/exec/ram_addr.h    |  3 ++-
>  target/ppc/kvm.c           |  2 +-
>  6 files changed, 47 insertions(+), 10 deletions(-)

This now has two R-bs, so unless somebody speaks up against it, I'll
just take this through the s390x tree together with patch 1.
