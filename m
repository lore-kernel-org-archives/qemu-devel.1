Received: from eggs.gnu.org ([2001:4830:134:3::10]:36905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1clXRU-00060z-R0
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 03:59:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1clXRP-0006Wf-VE
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 03:59:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52200)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1clXRP-0006WR-Oc
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 03:59:27 -0500
Date: Wed, 8 Mar 2017 16:59:17 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170308085917.GC7135@pxdev.xzpeter.org>
References: <1488425538-13785-1-git-send-email-peterx@redhat.com>
	<20170302071100-mutt-send-email-mst@kernel.org>
	<213ff4bb-b3b9-fe00-6f0e-b75114e1a5ef@redhat.com>
	<1149211275.29885713.1488962150826.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1149211275.29885713.1488962150826.JavaMail.zimbra@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3] intel_iommu: check misordered init when
 realize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Marcel Apfelbaum <marcel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, yi l liu <yi.l.liu@intel.com>, Jintack Lim <jintack@cs.columbia.edu>, Jason Wang <jasowang@redhat.com>, Alex Williamson <alex.williamson@redhat.com>

On Wed, Mar 08, 2017 at 03:35:50AM -0500, Paolo Bonzini wrote:

[...]

> The ordering should be explicit in the command line.  Since we do not have
> cycles, it should be possible.

Current QEMU should have no restriction on parameter ordering, right?
Or do we have any existing case that:

  "$QEMU -parameter1 -parameter2"

will work, while...

  "$QEMU -parameter2 -parameter1"

won't work?

Thanks,

> 
> The best solution would have been to add something like
> 
>    -device intel-iommu,id=root-complex-iommu -global mch.iommu=root-complex-iommu
> 
> but it's too late for that.

-- peterx
