Received: from eggs.gnu.org ([2001:4830:134:3::10]:39187)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1gYv64-0000gD-FR
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 10:46:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1gYv63-0005to-8i
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 10:46:20 -0500
Date: Mon, 17 Dec 2018 16:45:58 +0100
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20181217154558.hrnt2scjppa2jwsa@kamzik.brq.redhat.com>
References: <20181217104838.18957-8-sameo@linux.intel.com>
	<20181217153448.GF4456@caravaggio>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181217153448.GF4456@caravaggio>
Subject: Re: [Qemu-devel] [PATCH v5 7/8] hw: acpi: Export and share the ARM
 RSDP build
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

On Mon, Dec 17, 2018 at 04:34:48PM +0100, Samuel Ortiz wrote:
> 
> From: Samuel Ortiz <sameo@linux.intel.com>
> 
> Now that build_rsdp() supports building both legacy and current RSDP
> tables, we can move it to a generic folder (hw/acpi) and have the i386
> ACPI code reuse it in order to reduce code duplication.
> 
> Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  include/hw/acpi/aml-build.h |  2 ++
>  hw/acpi/aml-build.c         | 68 +++++++++++++++++++++++++++++++++++++
>  hw/arm/virt-acpi-build.c    | 65 -----------------------------------
>  hw/i386/acpi-build.c        | 49 +++++++++++---------------
>  4 files changed, 89 insertions(+), 95 deletions(-)
>

Reviewed-by: Andrew Jones <drjones@redhat.com>
