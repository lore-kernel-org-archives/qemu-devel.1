Received: from eggs.gnu.org ([2001:4830:134:3::10]:58095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gKlUX-0001PF-4h
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 09:41:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gKlQc-0004lO-TT
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 09:37:03 -0500
Date: Thu, 8 Nov 2018 15:36:11 +0100
From: Samuel Ortiz <sameo@linux.intel.com>
Message-ID: <20181108143611.GD32519@caravaggio>
References: <20181105014047.26447-1-sameo@linux.intel.com>
	<20181105014047.26447-6-sameo@linux.intel.com>
	<20181108151623.4de26ecb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181108151623.4de26ecb@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 05/24] hw: acpi: Implement XSDT support
 for RSDP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Shannon Zhao <shannon.zhaosl@gmail.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, Richard Henderson <rth@twiddle.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, xen-devel@lists.xenproject.org, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>

Hi Igor,

On Thu, Nov 08, 2018 at 03:16:23PM +0100, Igor Mammedov wrote:
> On Mon,  5 Nov 2018 02:40:28 +0100
> Samuel Ortiz <sameo@linux.intel.com> wrote:
> 
> > XSDT is the 64-bit version of the legacy ACPI RSDT (Root System
> > Description Table). RSDT only allow for 32-bit addressses and have thus
> > been deprecated. Since ACPI version 2.0, RSDPs should point at XSDTs and
> > no longer RSDTs, although RSDTs are still supported for backward
> > compatibility.
> > 
> > Since version 2.0, RSDPs should add an extended checksum, a complete table
> > length and a version field to the table.
> 
> This patch re-implements what arm/virt board already does
> and fixes checksum bug in the later and at the same time
> without a user (within the patch).
> 
> I'd suggest redo it a way similar to FADT refactoring
>   patch 1: fix checksum bug in virt/arm
>   patch 2: update reference tables in test
I now see what you meant with the ACPI reference tables, thanks.
I'll follow your advice.

Cheers,
Samuel.
