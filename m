Received: from eggs.gnu.org ([2001:4830:134:3::10]:54240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gPbzj-0000as-PU
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 18:33:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gPbzg-00055e-Le
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 18:33:19 -0500
Date: Thu, 22 Nov 2018 00:27:33 +0100
From: Samuel Ortiz <sameo@linux.intel.com>
Message-ID: <20181121232733.GC4450@caravaggio>
References: <20181105014047.26447-1-sameo@linux.intel.com>
	<20181105014047.26447-16-sameo@linux.intel.com>
	<20181115142854.1c62f32f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181115142854.1c62f32f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 15/24] hw: i386: Export the i386 ACPI
 SRAT build method
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Stefano Stabellini <sstabellini@kernel.org>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org, Richard Henderson <rth@twiddle.net>

On Thu, Nov 15, 2018 at 02:28:54PM +0100, Igor Mammedov wrote:
> On Mon,  5 Nov 2018 02:40:38 +0100
> Samuel Ortiz <sameo@linux.intel.com> wrote:
> 
> > This is the standard way of building SRAT on x86 platfoms. But future
> > machine types could decide to define their own custom SRAT build method
> > through the ACPI builder methods.
> > Moreover, we will also need to reach build_srat() from outside of
> > acpi-build in order to use it as the ACPI builder SRAT build method.
> SRAT is usually highly machine specific (memory holes, layout, guest OS
> specific quirks) so it's hard to generalize it.
Hence the need for an SRAT builder interface.

> I'd  drop SRAT related patches from this series and introduce
> i386/virt specific SRAT when you post patches for it.
virt uses the existing i386 build_srat() routine, there's nothing
special about it. So this would be purely duplicated code.

Cheers,
Samuel.
