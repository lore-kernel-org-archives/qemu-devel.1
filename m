Received: from eggs.gnu.org ([2001:4830:134:3::10]:42088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1gSMu0-00035y-CV
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 09:02:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1gSMtw-0004yO-WD
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 09:02:48 -0500
Date: Thu, 29 Nov 2018 15:02:16 +0100
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20181129135853.prrfozwknvmmvqg4@kamzik.brq.redhat.com>
References: <20181129132428.333-1-sameo@linux.intel.com>
	<20181129132428.333-2-sameo@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20181129132428.333-2-sameo@linux.intel.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/8] hw: acpi: The RSDP build API can
 return void
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

On Thu, Nov 29, 2018 at 02:24:21PM +0100, Samuel Ortiz wrote:
> For both x86 and ARM architectures, the internal RSDP build API can
> return void as the current return value is unused.
>=20
> Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/arm/virt-acpi-build.c | 4 +---
>  hw/i386/acpi-build.c     | 4 +---
>  2 files changed, 2 insertions(+), 6 deletions(-)
>

Reviewed-by: Andrew Jones <drjones@redhat.com>
