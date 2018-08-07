Received: from eggs.gnu.org ([2001:4830:134:3::10]:45817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fn1Xm-00054x-WC
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 08:56:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fn1Xi-0003LB-57
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 08:56:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60566 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fn1Xh-0003Kw-WA
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 08:56:54 -0400
Date: Tue, 7 Aug 2018 20:56:48 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180807125648.GE7265@xz-mi>
References: <153299204130.14411.11438396195753743913.stgit@gimli.home>
	<153299244635.14411.14909988281437283403.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <153299244635.14411.14909988281437283403.stgit@gimli.home>
Subject: Re: [Qemu-devel] [PATCH v2 2/4] kvm: Use inhibit to prevent
 ballooning without synchronous mmu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, cohuck@redhat.com, mst@redhat.com, david@redhat.com

On Mon, Jul 30, 2018 at 05:14:06PM -0600, Alex Williamson wrote:
> Remove KVM specific tests in balloon_page(), instead marking
> ballooning as inhibited without KVM_CAP_SYNC_MMU support.
> 
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

Regards,

-- 
Peter Xu
