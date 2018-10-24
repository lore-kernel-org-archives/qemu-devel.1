Received: from eggs.gnu.org ([2001:4830:134:3::10]:59838)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gFQ9J-0001O3-BG
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 16:53:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gFQ9G-0002X8-1R
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 16:53:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59230)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gFQ9F-0002Tp-1s
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 16:53:01 -0400
Date: Wed, 24 Oct 2018 16:52:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181024165231-mutt-send-email-mst@kernel.org>
References: <20181022183656.4902-1-sameo@linux.intel.com>
	<20181022183656.4902-19-sameo@linux.intel.com>
	<0f69efce-a104-00ae-ef8a-899aea0a801c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f69efce-a104-00ae-ef8a-899aea0a801c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 18/26] hw: acpi: Initial hardware-reduced
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>

On Wed, Oct 24, 2018 at 12:09:18AM +0200, Paolo Bonzini wrote:
> On 22/10/2018 20:36, Samuel Ortiz wrote:
> > We build a minimal set of ACPI hardware-reduced tables: XSDT,
> > FADT, MADT and a DSDT pointed by a RSDP.
> > The DSDT only contains one PCI host bridge for now.
> > 
> > This API will be consumed by new x86 machine type but also potentially
> > by the ARM virt one.
> > 
> > Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > Cc: Igor Mammedov <imammedo@redhat.com>
> > Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
> 
> Do not include patches that essentially add dead code.  It is nice to
> have hardware-reduced support, but if you want to contribute it you need
> to add a user as well, for example the ARM virt machine type.
> 
> In fact, using it in the ARM virt machine type is a no-brainer, so doing
> that change (even if it's not yet part of NEMU) would be an excellent
> way to reduce your delta, without going through the processing of
> convincing QEMU maintainers of the advantages of your new x86 machine type.
> 
> Paolo

Excellent point, thanks Paolo.

-- 
MST
