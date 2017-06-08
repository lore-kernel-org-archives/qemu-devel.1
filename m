Received: from eggs.gnu.org ([2001:4830:134:3::10]:37996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1dImW2-0003WD-Gt
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 21:45:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1dImVz-0008Hd-Cd
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 21:45:38 -0400
Received: from mga09.intel.com ([134.134.136.24]:6581)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haozhong.zhang@intel.com>)
	id 1dImVz-0008HX-1p
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 21:45:35 -0400
Date: Thu, 8 Jun 2017 09:45:29 +0800
From: Haozhong Zhang <haozhong.zhang@intel.com>
Message-ID: <20170608014529.5eczic72rw4cxkxl@hz-desktop>
References: <20170606072229.9302-1-haozhong.zhang@intel.com>
	<20170606072229.9302-4-haozhong.zhang@intel.com>
	<20170607152749.GF21990@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170607152749.GF21990@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH v2 3/4] nvdimm: add a boolean option
 "restrict"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Xiao Guangrong <guangrong.xiao@gmail.com>, Dan Williams <dan.j.williams@intel.com>

On 06/07/17 16:27 +0100, Stefan Hajnoczi wrote:
> On Tue, Jun 06, 2017 at 03:22:28PM +0800, Haozhong Zhang wrote:
> > If a vNVDIMM device is not backed by a DAX device and its "restrict"
> > option is enabled, bit 3 of state flags in its region mapping
> > structure will be set, in order to notify the guest of the lack of
> > write persistence guarantee. Once this bit is set, the guest OS may
> > mark the vNVDIMM device as read-only.
> > 
> > This option is disabled by default for backwards compatibility. It's
> > recommended to enable for the formal usage.
> 
> Good idea.  I think the following is cleaner:
> 
> DEFINE_PROP_ON_OFF_AUTO("readonly") on the 'nvdimm' device.  The
> following states are available:
> 
>  * 'on' - ACPI_NFIT_MEM_NOT_ARMED is set
>  * 'off' - ACPI_NFIT_MEM_NOT_ARMED is clear
>  * 'auto' - ACPI_NFIT_MEM_NOT_ARMED set if backend is not persistent
> 
> This new property defaults to 'auto'.  Machine types older than
> pc-i440fx-2.10 and pc-q35-2.10 default to 'on'.

Shouldn't it be 'off' on older machine types? The older machine types
and older QEMU never check the backend and never set ACPI_NFIT_MEM_NOT_ARMED.

Haozhong
