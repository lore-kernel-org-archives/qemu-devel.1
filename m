Received: from eggs.gnu.org ([2001:4830:134:3::10]:57528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gJh62-0004ZJ-GU
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 10:47:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gJgwq-0007IO-0U
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 10:37:55 -0500
Received: from mga01.intel.com ([192.55.52.88]:60257)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sameo@linux.intel.com>)
	id 1gJgwo-0007FU-3u
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 10:37:51 -0500
Date: Mon, 5 Nov 2018 16:37:09 +0100
From: Samuel Ortiz <sameo@linux.intel.com>
Message-ID: <20181105153708.GA26338@caravaggio>
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
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org

Igor,

On Mon, Nov 05, 2018 at 03:10:28AM +0100, Samuel Ortiz wrote:
> > QEMU already has hw reduced implementation, specifically in arm/virt board
> Back in May, I tried booting a virt machine type with "acpi=force" with
> no success, and today's HEAD still fails. With "acpi=on":
> 
> [    0.000000] ACPI: Early table checksum verification disabled
> [    0.000000] ACPI: Failed to init ACPI tables
My bad, I was using the wrong firmware/pflash options. With the right
ones, I can boot with an edk2 firmware and an EFI variable space. Thanks
Philippe and Eric for the help.

Cheers,
Samuel.
