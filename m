Received: from eggs.gnu.org ([2001:4830:134:3::10]:47048)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gPboc-00043N-5a
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 18:21:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gPbob-0002W4-JH
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 18:21:50 -0500
Date: Thu, 22 Nov 2018 00:21:06 +0100
From: Samuel Ortiz <sameo@linux.intel.com>
Message-ID: <20181121232106.GB4450@caravaggio>
References: <20181105014047.26447-1-sameo@linux.intel.com>
	<20181105014047.26447-13-sameo@linux.intel.com>
	<20181115133658.2cdbd918@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181115133658.2cdbd918@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 12/24] hw: acpi: Export the MCFG getter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Yang Zhong <yang.zhong@intel.com>, Peter Maydell <peter.maydell@linaro.org>, Stefano Stabellini <sstabellini@kernel.org>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org, Richard Henderson <rth@twiddle.net>

Hi Igor,

On Thu, Nov 15, 2018 at 01:36:58PM +0100, Igor Mammedov wrote:
> On Mon,  5 Nov 2018 02:40:35 +0100
> Samuel Ortiz <sameo@linux.intel.com> wrote:
> 
> > From: Yang Zhong <yang.zhong@intel.com>
> > 
> > The ACPI MCFG getter is not x86 specific and could be called from
> > anywhere within generic ACPI API, so let's export it.
> So far it's x86 or more exactly q35 specific thing,
It's property based, and it's using a generic PCIE property afaict.
So it's up to each machine type to define those properties.
I'm curious here: What's the idiomatic way to define a machine
setting/attribute/property, let each instance define it or not, and
make it available at run time?
Would you be getting the PCI host pointer from the ACPI build state and
getting that information back from there?

Cheers,
Samuel.
