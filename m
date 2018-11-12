Received: from eggs.gnu.org ([2001:4830:134:3::10]:53639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gM7ys-00066k-6r
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 03:54:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gM7yo-00052l-Uc
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 03:54:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34990)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1gM7yo-00051K-MR
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 03:53:58 -0500
Date: Mon, 12 Nov 2018 16:53:31 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20181112085331.GE20675@xz-x1>
References: <1541764187-10732-1-git-send-email-yu.c.zhang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1541764187-10732-1-git-send-email-yu.c.zhang@linux.intel.com>
Subject: Re: [Qemu-devel] [PATCH v1 0/3] intel-iommu: add support for
 5-level virtual IOMMU.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yu Zhang <yu.c.zhang@linux.intel.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

On Fri, Nov 09, 2018 at 07:49:44PM +0800, Yu Zhang wrote:
> Intel's upcoming processors will extend maximum linear address width to
> 57 bits, and introduce 5-level paging for CPU. Meanwhile, the platform
> will also extend the maximum guest address width for IOMMU to 57 bits,
> thus introducing the 5-level paging for 2nd level translation(See chapter 3
> in Intel Virtualization Technology for Directed I/O). 
> 
> This patch set extends the current logic to support a wider address width.
> A 5-level paging capable IOMMU(for 2nd level translation) can be rendered
> with configuration "device intel-iommu,x-aw-bits=57".

Along with this series, I'm not sure whether it'll be good we start to
consider removing the "x-" prefix for "x-aw-bits".

Michael?

Regards,

-- 
Peter Xu
