Received: from eggs.gnu.org ([2001:4830:134:3::10]:56741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1eK6Ic-0007wc-W0
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 12:37:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1eK6IZ-0001Cv-SR
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 12:37:31 -0500
Sender: Richard Henderson <rth7680@gmail.com>
References: <20171128203326.6062-1-david@redhat.com>
	<20171128203326.6062-6-david@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <2433e178-fe47-ee7b-fed5-01a708c88052@twiddle.net>
Date: Wed, 29 Nov 2017 17:37:24 +0000
MIME-Version: 1.0
In-Reply-To: <20171128203326.6062-6-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 for-2.12 05/15] s390x/pci: pass the
 retaddr to all PCI instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>

On 11/28/2017 08:33 PM, David Hildenbrand wrote:
> Once we wire up TCG, we will need the retaddr to correctly inject
> program interrupts. As we want to get rid of the function
> program_interrupt(), convert PCI code too.
> 
> For KVM, we can simply pass a 0.
> 
> Convert program_interrupt() to program_interrupt_ra() directly, making
> use of the passed address.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/s390x/s390-pci-inst.c | 83 +++++++++++++++++++++++++-----------------------
>  hw/s390x/s390-pci-inst.h | 16 ++++++----
>  target/s390x/kvm.c       | 14 ++++----
>  3 files changed, 59 insertions(+), 54 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

with or without RA_IGNORED.


r~
