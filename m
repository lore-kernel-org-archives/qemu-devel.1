Received: from eggs.gnu.org ([2001:4830:134:3::10]:46891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <keith.busch@intel.com>) id 1dmnEN-00065X-1D
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 16:35:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <keith.busch@intel.com>) id 1dmnEJ-00057Z-UX
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 16:35:27 -0400
Received: from mga04.intel.com ([192.55.52.120]:28013)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <keith.busch@intel.com>)
	id 1dmnEJ-00056Z-LK
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 16:35:23 -0400
Date: Tue, 29 Aug 2017 16:40:55 -0400
From: Keith Busch <keith.busch@intel.com>
Message-ID: <20170829204055.GD4428@localhost.localdomain>
References: <CAAeL1MGV5zSPq0OCVCsw4+xzRXm95z-yd_oN2__yskd6aUmESQ@mail.gmail.com>
	<20170829100936.GP25960@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170829100936.GP25960@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] Make NVME device "migratable" (savevm)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Sergei Dyshel <qyron.private@gmail.com>, qemu-devel@nongnu.org

On Tue, Aug 29, 2017 at 11:09:36AM +0100, Stefan Hajnoczi wrote:
> On Fri, Aug 25, 2017 at 11:39:30AM +0300, Sergei Dyshel wrote:
> > Hi all,
> > From what I understand, I can't "savevm" a VM that uses NVME device because
> > it has ".unmigratable = 1" in the code. What support must be implemented in
> > order to make it "migratable"?
> 
> CCing Keith Busch, the NVMe maintainer.

To make it migratable, you'll need implement the VMStateDescription to
save and restore the entire controller state, including all the queues.
It doesn't actually look like there's a much state to track compared to
other migratale devices, I just never got any time to write it out.
