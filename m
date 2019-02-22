Received: from eggs.gnu.org ([209.51.188.92]:36983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gx8Cb-0005B4-Pu
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 05:37:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gx8Ca-000227-Mv
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 05:37:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34664)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1gx8Ca-0001mu-Aj
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 05:37:08 -0500
Date: Fri, 22 Feb 2019 11:36:34 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190222113634.362e80fa@redhat.com>
In-Reply-To: <20190222085355.GA30665@richard>
References: <20190219080826.9812-1-richardw.yang@linux.intel.com>
	<20190221154551.5ab655f4@redhat.com>
	<20190222085355.GA30665@richard>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4] i386,
 acpi: check acpi_memory_hotplug capacity in pre_plug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Yang <richardw.yang@linux.intel.com>
Cc: mst@redhat.com, qemu-devel@nongnu.org

On Fri, 22 Feb 2019 16:53:55 +0800
Wei Yang <richardw.yang@linux.intel.com> wrote:

> On Thu, Feb 21, 2019 at 03:45:51PM +0100, Igor Mammedov wrote:
> >On Tue, 19 Feb 2019 16:08:26 +0800
> >Wei Yang <richardw.yang@linux.intel.com> wrote:
> >  
> >> Currently we do device realization like below:
> >> 
> >>    hotplug_handler_pre_plug()
> >>    dc->realize()
> >>    hotplug_handler_plug()
> >> 
> >> Before we do device realization and plug, we should allocate necessary
> >> resources and check if memory-hotplug-support property is enabled.
> >> 
> >> At the piix4 and ich9, the memory-hotplug-support property is checked at
> >> plug stage. This means that device has been realized and mapped into guest
> >> address space 'pc_dimm_plug()' by the time acpi plug handler is called,
> >> where it might fail and crash QEMU due to reaching g_assert_not_reached()
> >> (piix4) or error_abort (ich9).
> >> 
> >> Fix it by checking if memory hotplug is enabled at pre_plug stage
> >> where we can gracefully abort hotplug request.
> >> 
> >> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> >> CC: Igor Mammedov <imammedo@redhat.com>
> >> CC: Eric Blake <eblake@redhat.com>  
> >patch refuses to be applied to current master
> >  
> 
> Could latest upstream compile successfully?
> 

works for me
