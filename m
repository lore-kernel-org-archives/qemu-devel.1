Received: from eggs.gnu.org ([209.51.188.92]:37530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gtAIY-0000XX-LH
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 07:02:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gtAIX-0003V4-Qa
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 07:02:54 -0500
References: <20190211113255.3837-1-cohuck@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <b1aee869-e556-e273-4389-55afb50a162a@redhat.com>
Date: Mon, 11 Feb 2019 13:02:42 +0100
MIME-Version: 1.0
In-Reply-To: <20190211113255.3837-1-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH] s390x: always provide pci
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Collin Walling <walling@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Richard Henderson <rth@twiddle.net>

On 2019-02-11 12:32, Cornelia Huck wrote:
> We tried to make pci support optional on s390x in the past;
> unfortunately, we still require the s390 phb to be created
> unconditionally due to backwards compatibility issues.
> 
> Instead of sinking more effort into this (including compat
> handling for older machines etc.) for non-obvious gains, let's
> just make CONFIG_PCI something that is always set on s390x.
> 
> Note that you can still fence off pci for the _guest_ if you
> provide a cpu model without the zpci feature.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
> Follow-up patch to the discussion around "hw/s390x: Fix the function
> arguments in the pci stub file". I've done a quick sanity test with
> tcg only so far.
> ---
>  hw/s390x/Makefile.objs      |  3 +-
>  hw/s390x/s390-pci-stub.c    | 77 -------------------------------------
>  hw/s390x/s390-virtio-ccw.c  |  4 --
>  target/s390x/cpu_models.c   |  5 ---
>  target/s390x/gen-features.c |  1 -
>  target/s390x/kvm.c          |  4 +-
>  6 files changed, 2 insertions(+), 92 deletions(-)
>  delete mode 100644 hw/s390x/s390-pci-stub.c

Reviewed-by: Thomas Huth <thuth@redhat.com>
