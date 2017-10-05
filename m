Received: from eggs.gnu.org ([2001:4830:134:3::10]:39423)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1e07Bw-00088g-0m
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 10:32:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1e07Bv-0001xf-5N
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 10:32:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43698)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kchamart@redhat.com>) id 1e07Bu-0001t0-UU
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 10:31:59 -0400
Date: Thu, 5 Oct 2017 16:31:51 +0200
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20171005143151.wkxcj5njhevxhnow@eukaryote>
References: <034d01d2d94d$9d6be9d0$d843bd70$@gmail.com>
	<029301d2e062$601f0c30$205d2490$@gmail.com>
	<029401d2e064$87f5ccb0$97e16610$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <029401d2e064$87f5ccb0$97e16610$@gmail.com>
Subject: Re: [Qemu-devel] FW: Are there any qemu emulated SR-IOV devices?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mwoodpatrick@gmail.com
Cc: qemu-devel@nongnu.org, knut.omang@oracle.com, marcel.apfelbaum@gmail.com, mst@redhat.com

[Sorry, I'm a bit late in responding, as I missed this e-mail.]

On Thu, Jun 08, 2017 at 07:35:52AM -0700, mwoodpatrick@gmail.com wrote:
> I wanted to play around with SR-IOV using qemu and was wondering if there
> are any qemu emulated SR-IOV devices I could experiment with?

Near as I know there isn't any existing emulated SR-IOV device in QEMU.
But yes, an emulated SR-IOV would also be useful for testing purposes
for projects like OpenStack, without having the need for real hardware.

> If not I plan on creating one and would appreciate any pointers to documents
> describing how to add an emulated device that supports more than 8 functions
> and has ARI enabled

I'm far from an expert on this area, but just wanted to point out that
there's some existing support for SR-IOV in QEMU, added via:

    [PATCH v6 0/4] pcie: Add support for Single Root I/O Virtualization --
    https://lists.nongnu.org/archive/html/qemu-devel/2015-10/msg05155.html

Knut Omang (Cced) who added the above support also had some notes here
on how to implement an SR-IOV capable device.:

    https://lists.nongnu.org/archive/html/qemu-devel/2015-10/msg05157.html
    -- pcie: Add some SR/IOV API documentation	in docs/pcie_sriov.txt

        "Add a small intro + minimal documentation for how to implement
        SR/IOV support for an emulated device.


[...]
 
-- 
/kashyap
