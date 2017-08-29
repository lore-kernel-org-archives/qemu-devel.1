Received: from eggs.gnu.org ([2001:4830:134:3::10]:34597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dmdSm-0000Rh-Bk
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 06:09:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dmdSl-0004wj-HW
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 06:09:40 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:36768)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dmdSl-0004wR-C2
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 06:09:39 -0400
Received: by mail-wm0-x243.google.com with SMTP id j72so3189695wmi.3
	for <qemu-devel@nongnu.org>; Tue, 29 Aug 2017 03:09:39 -0700 (PDT)
Date: Tue, 29 Aug 2017 11:09:36 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170829100936.GP25960@stefanha-x1.localdomain>
References: <CAAeL1MGV5zSPq0OCVCsw4+xzRXm95z-yd_oN2__yskd6aUmESQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAeL1MGV5zSPq0OCVCsw4+xzRXm95z-yd_oN2__yskd6aUmESQ@mail.gmail.com>
Subject: Re: [Qemu-devel] Make NVME device "migratable" (savevm)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sergei Dyshel <qyron.private@gmail.com>
Cc: qemu-devel@nongnu.org, Keith Busch <keith.busch@intel.com>

On Fri, Aug 25, 2017 at 11:39:30AM +0300, Sergei Dyshel wrote:
> Hi all,
> From what I understand, I can't "savevm" a VM that uses NVME device because
> it has ".unmigratable = 1" in the code. What support must be implemented in
> order to make it "migratable"?

CCing Keith Busch, the NVMe maintainer.

$ scripts/get_maintainer.pl -f hw/block/nvme.c
Keith Busch <keith.busch@intel.com> (supporter:nvme)
