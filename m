Received: from eggs.gnu.org ([2001:4830:134:3::10]:55403)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gPqNL-0005Dk-Rk
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 09:54:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gPqNK-0004l7-2o
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 09:54:39 -0500
Date: Thu, 22 Nov 2018 15:54:29 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181122145429.GD31879@linux.fritz.box>
References: <20181120184148.22501-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181120184148.22501-1-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] nvme: fix out-of-bounds access to the CMB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, mreitz@redhat.com, Li Qiang <liq3ea@gmail.com>, Keith Busch <keith.busch@intel.com>, qemu-block@nongnu.org

Am 20.11.2018 um 19:41 hat Paolo Bonzini geschrieben:
> Because the CMB BAR has a min_access_size of 2, if you read the last
> byte it will try to memcpy *2* bytes from n->cmbuf, causing an off-by-one
> error.  This is CVE-2018-16847.
> 
> Another way to fix this might be to register the CMB as a RAM memory
> region, which would also be more efficient.  However, that might be a
> change for big-endian machines; I didn't think this through and I don't
> know how real hardware works.  Add a basic testcase for the CMB in case
> somebody does this change later on.
> 
> Cc: Keith Busch <keith.busch@intel.com>
> Cc: qemu-block@nongnu.org
> Reported-by: Li Qiang <liq3ea@gmail.com>
> Reviewed-by: Li Qiang <liq3ea@gmail.com>
> Tested-by: Li Qiang <liq3ea@gmail.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Thanks, applied to the block branch and reverted 5e3c0220d7.

Kevin
