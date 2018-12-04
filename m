Received: from eggs.gnu.org ([208.118.235.92]:39786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1gUC15-0001dj-HZ
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 09:49:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1gUC13-0007Sw-Kg
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 09:49:39 -0500
Date: Tue, 4 Dec 2018 15:49:13 +0100
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20181204144913.2awwajttbtu2cjur@kamzik.brq.redhat.com>
References: <20181130130032.11835-1-sameo@linux.intel.com>
	<20181130130032.11835-5-sameo@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181130130032.11835-5-sameo@linux.intel.com>
Subject: Re: [Qemu-devel] [PATCH v3 4/8] hw: arm: Carry RSDP specific data
 through AcpiRsdpData
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Ben Warren <ben@skyportsystems.com>, "Michael S. Tsirkin" <mst@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Fri, Nov 30, 2018 at 02:00:28PM +0100, Samuel Ortiz wrote:
> That will allow us to generalize the ARM build_rsdp() routine to support
> both legacy RSDP (The current i386 implementation) and extended RSDP
> (The ARM implementation).
> 
> Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  include/hw/acpi/acpi-defs.h |  8 ++++++++
>  hw/arm/virt-acpi-build.c    | 18 +++++++++++++-----
>  2 files changed, 21 insertions(+), 5 deletions(-)
>

Reviewed-by: Andrew Jones <drjones@redhat.com>
