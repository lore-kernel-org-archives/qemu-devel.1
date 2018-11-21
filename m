Received: from eggs.gnu.org ([2001:4830:134:3::10]:33864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gPTj5-0001AJ-5a
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 09:43:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gPTj4-0001ZE-GQ
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 09:43:35 -0500
Date: Wed, 21 Nov 2018 15:42:50 +0100
From: Samuel Ortiz <sameo@linux.intel.com>
Message-ID: <20181121144250.GG4426@caravaggio>
References: <20181105014047.26447-1-sameo@linux.intel.com>
	<20181105014047.26447-3-sameo@linux.intel.com>
	<20181109152716.236d3c6e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181109152716.236d3c6e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 02/24] hw: acpi: Export ACPI build
 alignment API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Shannon Zhao <shannon.zhaosl@gmail.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, Richard Henderson <rth@twiddle.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, xen-devel@lists.xenproject.org, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>

On Fri, Nov 09, 2018 at 03:27:16PM +0100, Igor Mammedov wrote:
> On Mon,  5 Nov 2018 02:40:25 +0100
> Samuel Ortiz <sameo@linux.intel.com> wrote:
> 
> > This is going to be needed by the Hardware-reduced ACPI routines.
> > 
> > Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> > Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> > Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
> the patch is probably misplaced withing series,
> if there is an external user within this series then this patch should
> be squashed there, otherwise it doesn't belong to this series.
hw/acpi/reduced.c needs it, I forgot to remove that patch when removing
the hardware-reduced code from the serie. I will remove it.

Cheers,
Samuel.
