Received: from eggs.gnu.org ([2001:4830:134:3::10]:40626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gJhZn-0003QO-TS
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 11:18:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gJhYo-0000f7-S6
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 11:17:13 -0500
Received: from mga14.intel.com ([192.55.52.115]:39912)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sameo@linux.intel.com>)
	id 1gJhYl-0000Vc-9u
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 11:17:05 -0500
Date: Mon, 5 Nov 2018 17:16:19 +0100
From: Samuel Ortiz <sameo@linux.intel.com>
Message-ID: <20181105161619.GA27585@caravaggio>
References: <20181101102303.16439-1-sameo@linux.intel.com>
	<20181102132925.365e1881@redhat.com>
	<20181105021028.GA6380@caravaggio>
	<20181105160753.o2n7xrvyidil6tut@kamzik.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181105160753.o2n7xrvyidil6tut@kamzik.brq.redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 00/23] ACPI reorganization for
 hardware-reduced support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org, philmd@redhat.com

Hi Andrew,

On Mon, Nov 05, 2018 at 05:07:53PM +0100, Andrew Jones wrote:
> > > QEMU already has hw reduced implementation, specifically in arm/virt board
> > Back in May, I tried booting a virt machine type with "acpi=force" with
> > no success, and today's HEAD still fails. With "acpi=on":
> > 
> > [    0.000000] ACPI: Early table checksum verification disabled
> > [    0.000000] ACPI: Failed to init ACPI tables
> > 
> > So this code has been broken for several months and I suspect it's not
> > really run by anyone.
> 
> Hi Samuel,
> 
> We use it all the time. To see if there had been an upstream regression I
> just tried latest qemu (v3.0.0-1763-gb2f7a038bb4c) with a latest kernel
> (v4.20-rc1) in my guest. It worked just fine, and there was no need for
> any kernel command line parameters.
> 
> What guest kernel version did you try?
This is my bad, apologies for jumping the gun. I was not using the right
pflash options and thus the ACPI tables were simply not passed to the
kernel. Philippe and Eric helped me fix that, and now I can boot
arm/virt on top of ACPI. Sorry for the bad noise.

Cheers,
Samuel.
