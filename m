Received: from eggs.gnu.org ([2001:4830:134:3::10]:51055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1eqyAd-0001pj-IT
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 04:37:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1eqyAa-0000tS-Fj
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 04:37:07 -0500
Received: from mga06.intel.com ([134.134.136.31]:37081)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haozhong.zhang@intel.com>)
	id 1eqyAa-0000t3-71
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 04:37:04 -0500
Date: Wed, 28 Feb 2018 17:36:59 +0800
From: Haozhong Zhang <haozhong.zhang@intel.com>
Message-ID: <20180228093659.xpq2amq2zjuw2mdr@hz-desktop>
References: <20171207101030.22364-1-haozhong.zhang@intel.com>
	<20171207101812.23602-1-haozhong.zhang@intel.com>
	<20180227172223.GD1799@perard.uk.xensource.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180227172223.GD1799@perard.uk.xensource.com>
Subject: Re: [Qemu-devel] [RFC QEMU PATCH v4 00/10] Implement vNVDIMM for
 Xen HVM guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anthony PERARD <anthony.perard@citrix.com>
Cc: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, Stefano Stabellini <sstabellini@kernel.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Dan Williams <dan.j.williams@intel.com>, Chao Peng <chao.p.peng@linux.intel.com>, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On 02/27/18 17:22 +0000, Anthony PERARD wrote:
> On Thu, Dec 07, 2017 at 06:18:02PM +0800, Haozhong Zhang wrote:
> > This is the QEMU part patches that works with the associated Xen
> > patches to enable vNVDIMM support for Xen HVM domains. Xen relies on
> > QEMU to build guest NFIT and NVDIMM namespace devices, and allocate
> > guest address space for vNVDIMM devices.
> 
> I've got other question, and maybe possible improvements.
> 
> When QEMU build the ACPI tables, it also initialize some MemoryRegion,
> which use more guest memory. Do you know if those regions are used with
> your patch series on Xen?

Yes, that's why dm_acpi_size is introduced.

> Otherwise, we could try to avoid their
> creation with this:
> In xenfv_machine_options()
> m->rom_file_has_mr = false;
> (setting this in xen_hvm_init() would probably be better, but I havn't
> try)

If my memory is correct, simply setting rom_file_has_mr to false does
not work (though I cannot remind the exact reason). I'll have a look
as the code to refresh my memory.

Haozhong

> 
> If this is possible, libxl would not need to allocate more memory for
> the guest (dm_acpi_size).
> 
> -- 
> Anthony PERARD
