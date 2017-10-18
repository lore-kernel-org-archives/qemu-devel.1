Received: from eggs.gnu.org ([2001:4830:134:3::10]:51206)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1e4hNw-0006IA-53
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 01:59:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1e4hNt-0001Tj-3z
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 01:59:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38734)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1e4hNs-0001Rf-Tw
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 01:59:17 -0400
Date: Wed, 18 Oct 2017 13:59:07 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171018055907.GA2521@lemon>
References: <a41b88a6-4882-1abc-b6e2-e42acf03c198@oracle.com>
	<20171013170143.GB3370@work-vm>
	<20171013111403.293919fe@t450s.home>
	<20171015035318.GA22780@pxdev.xzpeter.org>
	<c4d07be9-7d9b-71fa-e84c-e393138f7a84@oracle.com>
	<20171017035604.GJ4166@pxdev.xzpeter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171017035604.GJ4166@pxdev.xzpeter.org>
Subject: Re: [Qemu-devel] host physical address width issues/questions for
 x86_64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: Prasad Singamsetty <prasad.singamsetty@oracle.com>, ehabkost@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>, Sunit Jain <sunit.jain@oracle.com>, pbonzini@redhat.com, rth@twiddle.net

On Tue, 10/17 11:56, Peter Xu wrote:
> I don't sure I know the reason.  Anyway, it originated from one of
> Fam's request for some NVMe testsr

FWIW, I was basically trying to test a driver code under development with 48bit
vIOMMU. I ended up using real hardware and also made the code compatible with
lower bits IOMMU.

Fam
