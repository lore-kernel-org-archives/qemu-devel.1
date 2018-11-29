Received: from eggs.gnu.org ([2001:4830:134:3::10]:53209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1gSNJa-00056U-Eu
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 09:29:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1gSNJY-0007AJ-IZ
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 09:29:14 -0500
Date: Thu, 29 Nov 2018 15:28:57 +0100
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20181129142857.f6k343h2zys2zkor@kamzik.brq.redhat.com>
References: <20181129132428.333-1-sameo@linux.intel.com>
	<20181129132428.333-6-sameo@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181129132428.333-6-sameo@linux.intel.com>
Subject: Re: [Qemu-devel] [PATCH v2 5/8] hw: arm: Convert the RSDP build to
 the buid_append_foo() API
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

On Thu, Nov 29, 2018 at 02:24:25PM +0100, Samuel Ortiz wrote:
> Instead of filling a mapped and packed C structure field in random order
> and being careful about endianness and sizes, build_rsdp() now uses
> build_append_int_noprefix() to compose RSDP table.
> 
> This makes for an easier to review and maintain code that is almost
> matching 1:1 the ACPI spec itself.
> 
> Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
> ---
>  hw/arm/virt-acpi-build.c | 42 +++++++++++++++++++++-------------------
>  1 file changed, 22 insertions(+), 20 deletions(-)


Reviewed-by: Andrew Jones <drjones@redhat.com>
