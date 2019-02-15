Received: from eggs.gnu.org ([209.51.188.92]:47842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gumVp-00010N-CL
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 18:03:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gumVn-0006fc-EI
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 18:03:17 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42627)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gul1G-00063l-Iq
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 16:27:38 -0500
Received: by mail-qt1-f193.google.com with SMTP id b8so12551665qtr.9
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 13:27:29 -0800 (PST)
Date: Fri, 15 Feb 2019 16:27:25 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190215162652-mutt-send-email-mst@kernel.org>
References: <20190215133005.15955-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190215133005.15955-1-david@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/6] tests: Add device unplug tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Collin Walling <walling@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Greg Kurz <groug@kaod.org>, Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

On Fri, Feb 15, 2019 at 02:29:59PM +0100, David Hildenbrand wrote:
> This is a set of tests to test basic device unplugging functionality for
> - some PCI implementations
> - CCW devices on s390x
> - spapr memory and cpu core devices
> 
> I plaed with ACPI CPU unplug but getting that to run with qtest is more
> involved. (remove devices on reset, trick cpu-hotplug-legacy property,
> somehow create cpu hotplug state objects ...). Well we no have at least
> one unplug test for DIMMs and one for CPUs.
> 
> @David, I dropped you t-b and r-b due to many changes but would be happy
> to readd them ;)


Series:
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>


I think it's mostly spapr things so feel free to merge through
that tree.

> v1 -> v2:
> - Tests for CCW, spapr memory and spapr cpu core unplug added
> - Fix a deadlock when unplugging dummy CPUs
> - Style fixes / simplifications (Thomas)
> - Don't use the global_qtest variable (Thomas)
> - Fix double-free (Greg)
> 
> 
> David Hildenbrand (6):
>   cpus: Properly release the iothread lock when killing a dummy VCPU
>   spapr: support memory unplug for qtest
>   tests/device-plug: Add a simple PCI unplug request test
>   tests/device-plug: Add CCW unplug test for s390x
>   tests/device-plug: Add CPU core unplug request test for spapr
>   tests/device-plug: Add memory unplug request test for spapr
> 
>  cpus.c                   |   1 +
>  hw/ppc/spapr_ovec.c      |   6 ++
>  tests/Makefile.include   |   4 +
>  tests/device-plug-test.c | 165 +++++++++++++++++++++++++++++++++++++++
>  4 files changed, 176 insertions(+)
>  create mode 100644 tests/device-plug-test.c
> 
> -- 
> 2.17.2
