Received: from eggs.gnu.org ([2001:4830:134:3::10]:54371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dxa1Q-000751-MF
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 10:42:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dxa1L-0008P1-O0
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 10:42:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53816)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dxa1L-0008Od-II
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 10:42:35 -0400
Date: Thu, 28 Sep 2017 16:42:26 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170928164226.5e3ca82c.cohuck@redhat.com>
In-Reply-To: <20170927072030.35737-3-borntraeger@de.ibm.com>
References: <20170927072030.35737-1-borntraeger@de.ibm.com>
	<20170927072030.35737-3-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 2/3] s390x/ais: enable ais when
 migration is available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Richard Henderson <rth@twiddle.net>, Michael Roth <mdroth@linux.vnet.ibm.com>, Yi Min Zhao <zyimin@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>

On Wed, 27 Sep 2017 09:20:29 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> Instead of unconditionally enabling the KVM AIS capability
> in the kvm arch init function, do this in the flic realize function
> when we know if migration is available. This requires to initialize
> flic before the CPUs (and cpu models).
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/intc/s390_flic.c          |  8 ++------
>  hw/intc/s390_flic_kvm.c      | 16 +++++++++++-----
>  hw/s390x/css.c               |  4 ++--
>  hw/s390x/s390-virtio-ccw.c   | 10 +++++++---
>  include/hw/s390x/s390_flic.h |  1 -
>  target/s390x/kvm.c           | 10 ++--------
>  6 files changed, 24 insertions(+), 25 deletions(-)

Thanks, applied.
