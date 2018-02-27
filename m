Received: from eggs.gnu.org ([2001:4830:134:3::10]:55174)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=5899da973=anthony.perard@citrix.com>)
	id 1eqixS-0003iG-J1
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 12:22:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=5899da973=anthony.perard@citrix.com>)
	id 1eqixN-00052D-Le
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 12:22:30 -0500
Received: from smtp.citrix.com ([66.165.176.89]:53239)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=5899da973=anthony.perard@citrix.com>)
	id 1eqixN-00051g-FW
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 12:22:25 -0500
Date: Tue, 27 Feb 2018 17:22:23 +0000
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20180227172223.GD1799@perard.uk.xensource.com>
References: <20171207101030.22364-1-haozhong.zhang@intel.com>
	<20171207101812.23602-1-haozhong.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20171207101812.23602-1-haozhong.zhang@intel.com>
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
To: Haozhong Zhang <haozhong.zhang@intel.com>
Cc: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, Stefano Stabellini <sstabellini@kernel.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Dan Williams <dan.j.williams@intel.com>, Chao Peng <chao.p.peng@linux.intel.com>, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Thu, Dec 07, 2017 at 06:18:02PM +0800, Haozhong Zhang wrote:
> This is the QEMU part patches that works with the associated Xen
> patches to enable vNVDIMM support for Xen HVM domains. Xen relies on
> QEMU to build guest NFIT and NVDIMM namespace devices, and allocate
> guest address space for vNVDIMM devices.

I've got other question, and maybe possible improvements.

When QEMU build the ACPI tables, it also initialize some MemoryRegion,
which use more guest memory. Do you know if those regions are used with
your patch series on Xen? Otherwise, we could try to avoid their
creation with this:
In xenfv_machine_options()
m->rom_file_has_mr = false;
(setting this in xen_hvm_init() would probably be better, but I havn't
try)

If this is possible, libxl would not need to allocate more memory for
the guest (dm_acpi_size).

-- 
Anthony PERARD
