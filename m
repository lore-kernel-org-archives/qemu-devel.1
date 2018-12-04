Received: from eggs.gnu.org ([208.118.235.92]:41401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1gUC5J-0003z4-AN
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 09:54:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1gUC5I-0002Aq-Dk
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 09:54:01 -0500
Date: Tue, 4 Dec 2018 15:53:41 +0100
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20181204145341.ii67fzma5l5j443y@kamzik.brq.redhat.com>
References: <20181130130032.11835-1-sameo@linux.intel.com>
	<20181130130032.11835-7-sameo@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181130130032.11835-7-sameo@linux.intel.com>
Subject: Re: [Qemu-devel] [PATCH v3 6/8] hw: arm: Support both legacy and
 current RSDP build
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

On Fri, Nov 30, 2018 at 02:00:30PM +0100, Samuel Ortiz wrote:
> We add the ability to build legacy or current RSDP tables, based on the
> AcpiRsdpData revision field passed to build_rsdp().
> Although arm/virt only uses RSDP v2, adding that capability to
> build_rsdp will allow us to share the RSDP build code between ARM and x86.
> 
> Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  hw/arm/virt-acpi-build.c | 39 ++++++++++++++++++++++++++++++++++-----
>  1 file changed, 34 insertions(+), 5 deletions(-)
>

Reviewed-by: Andrew Jones <drjones@redhat.com>
