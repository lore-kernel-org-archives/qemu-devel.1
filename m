Received: from eggs.gnu.org ([2001:4830:134:3::10]:32968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gYumR-0006uZ-Vj
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 10:26:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gYumR-0005fF-Bc
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 10:26:03 -0500
Date: Mon, 17 Dec 2018 16:25:47 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20181217162547.696ce9de@Igors-MacBook-Pro.local>
In-Reply-To: <20181217140611.GC4456@caravaggio>
References: <20181217104838.18957-1-sameo@linux.intel.com>
	<20181217104838.18957-8-sameo@linux.intel.com>
	<20181217140611.GC4456@caravaggio>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 7/8] hw: acpi: Export and share the ARM
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
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Ben Warren <ben@skyportsystems.com>, "Michael S. Tsirkin" <mst@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Mon, 17 Dec 2018 15:06:11 +0100
Samuel Ortiz <sameo@linux.intel.com> wrote:

> 
> From: Samuel Ortiz <sameo@linux.intel.com>

Subject should be
  [Qemu-devel] [PATCH v5 7/8] hw: acpi: Export and share the ARM RSDP build
                      ^^^
and without "Re: "

> 
> Now that build_rsdp() supports building both legacy and current RSDP
> tables, we can move it to a generic folder (hw/acpi) and have the i386
> ACPI code reuse it in order to reduce code duplication.
> 
> Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> ---
> 
> V4 -> V5:
>   * Fixed the 16 bytes padding comment.
> 
> ---
[...]
