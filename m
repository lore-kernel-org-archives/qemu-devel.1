Received: from eggs.gnu.org ([2001:4830:134:3::10]:46394)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eKLXo-0008K4-Ki
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 04:54:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eKLXk-0006Hb-M9
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 04:54:12 -0500
References: <20171129202701.16117-1-david@redhat.com>
	<20171129202701.16117-6-david@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <b6d7d5ea-3566-b62b-6931-7cdf4a2f5518@redhat.com>
Date: Thu, 30 Nov 2017 10:54:03 +0100
MIME-Version: 1.0
In-Reply-To: <20171129202701.16117-6-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 for-2.12 05/16] s390x/pci: pass the
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
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>

On 29.11.2017 21:26, David Hildenbrand wrote:
> Once we wire up TCG, we will need the retaddr to correctly inject
> program interrupts. As we want to get rid of the function
> program_interrupt(), convert PCI code too.
> 
> For KVM, we can simply use RA_IGNORED.
> 
> Convert program_interrupt() to s390_program_interrupt() directly, making
> use of the passed address.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/s390x/s390-pci-inst.c | 83 +++++++++++++++++++++++++-----------------------
>  hw/s390x/s390-pci-inst.h | 16 ++++++----
>  target/s390x/kvm.c       | 14 ++++----
>  3 files changed, 59 insertions(+), 54 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>
