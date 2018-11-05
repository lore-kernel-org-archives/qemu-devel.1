Received: from eggs.gnu.org ([2001:4830:134:3::10]:40709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1gJhag-0003hs-Ns
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 11:19:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1gJhQ9-0003VZ-AG
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 11:08:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53494)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <drjones@redhat.com>) id 1gJhQ4-0003IH-OD
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 11:08:05 -0500
Date: Mon, 5 Nov 2018 17:07:53 +0100
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20181105160753.o2n7xrvyidil6tut@kamzik.brq.redhat.com>
References: <20181101102303.16439-1-sameo@linux.intel.com>
	<20181102132925.365e1881@redhat.com>
	<20181105021028.GA6380@caravaggio>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181105021028.GA6380@caravaggio>
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
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org, philmd@redhat.com

On Mon, Nov 05, 2018 at 03:10:28AM +0100, Samuel Ortiz wrote:
> Hi Igor,
> 
> On Fri, Nov 02, 2018 at 01:29:25PM +0100, Igor Mammedov wrote:
> > On Thu,  1 Nov 2018 11:22:40 +0100
> > Samuel Ortiz <sameo@linux.intel.com> wrote:
> > 
> > Thanks for looking at ACPI mess we have in QEMU and trying to make it better,
> Thanks for the initial review and feedback.
> 
> > this series look a bit hackish probably because it was written to suit new
> > virt board, so it needs some more clean up to be done.
> >
> > > This patch set provides an ACPI code reorganization in preparation for
> > > adding hardware-reduced support to QEMU.
> > QEMU already has hw reduced implementation, specifically in arm/virt board
> Back in May, I tried booting a virt machine type with "acpi=force" with
> no success, and today's HEAD still fails. With "acpi=on":
> 
> [    0.000000] ACPI: Early table checksum verification disabled
> [    0.000000] ACPI: Failed to init ACPI tables
> 
> So this code has been broken for several months and I suspect it's not
> really run by anyone.

Hi Samuel,

We use it all the time. To see if there had been an upstream regression I
just tried latest qemu (v3.0.0-1763-gb2f7a038bb4c) with a latest kernel
(v4.20-rc1) in my guest. It worked just fine, and there was no need for
any kernel command line parameters.

What guest kernel version did you try?

Thanks,
drew
