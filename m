Received: from eggs.gnu.org ([2001:4830:134:3::10]:35489)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gYutp-0002Te-2T
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 10:33:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gYuto-0004Nr-D8
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 10:33:41 -0500
Date: Mon, 17 Dec 2018 16:32:59 +0100
From: Samuel Ortiz <sameo@linux.intel.com>
Message-ID: <20181217153259.GE4456@caravaggio>
References: <20181217104838.18957-1-sameo@linux.intel.com>
	<20181217104838.18957-8-sameo@linux.intel.com>
	<20181217140611.GC4456@caravaggio>
	<20181217162547.696ce9de@Igors-MacBook-Pro.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181217162547.696ce9de@Igors-MacBook-Pro.local>
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
To: Igor Mammedov <imammedo@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Ben Warren <ben@skyportsystems.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Mon, Dec 17, 2018 at 04:25:47PM +0100, Igor Mammedov wrote:
> On Mon, 17 Dec 2018 15:06:11 +0100
> Samuel Ortiz <sameo@linux.intel.com> wrote:
> 
> > 
> > From: Samuel Ortiz <sameo@linux.intel.com>
> 
> Subject should be
>   [Qemu-devel] [PATCH v5 7/8] hw: acpi: Export and share the ARM RSDP build
>                       ^^^
> and without "Re: "
>
I did not realize it's ok to break a thread's topic/subject. Will
resend.

> > 
> > Now that build_rsdp() supports building both legacy and current RSDP
> > tables, we can move it to a generic folder (hw/acpi) and have the i386
> > ACPI code reuse it in order to reduce code duplication.
> > 
> > Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
> > Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> > 
> > V4 -> V5:
> >   * Fixed the 16 bytes padding comment.
> > 
> > ---
> [...]
> 
