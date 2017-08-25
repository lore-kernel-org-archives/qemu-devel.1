Received: from eggs.gnu.org ([2001:4830:134:3::10]:42748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dlNIM-0002BR-N0
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 18:41:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dlNIJ-0007P9-LH
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 18:41:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39344)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dlNIJ-0007Oo-Ex
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 18:41:39 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EB2957E423
	for <qemu-devel@nongnu.org>; Fri, 25 Aug 2017 22:41:37 +0000 (UTC)
Date: Fri, 25 Aug 2017 19:41:28 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170825224128.GO15315@localhost.localdomain>
References: <20170823221445.15243-1-ehabkost@redhat.com>
	<20170823221445.15243-2-ehabkost@redhat.com>
	<20170825141900.08e2a089@w520.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170825141900.08e2a089@w520.home>
Subject: Re: [Qemu-devel] [PATCH 1/5] pci: INTERFACE_LEGACY_PCI_DEVICE and
 INTERFACE_PCIE_DEVICE interfaces
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>, Laine Stump <laine@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On Fri, Aug 25, 2017 at 02:19:00PM -0600, Alex Williamson wrote:
> On Wed, 23 Aug 2017 19:14:41 -0300
> Eduardo Habkost <ehabkost@redhat.com> wrote:
> 
> > Those two interfaces will be used to indicate which device types
> > support legacy PCI or PCI-express buses.  Management software
> > will be able to use the qom-list-types QMP command to query that
> > information.
> 
> Nit, while "legacy PCI" and "conventional PCI" have about the same
> number of google hits, I believe the latter is the more correct term.
> The quality of hits is certainly a lot better with "conventional".
> Calling something "legacy" also spurs an immediate negative reaction
> for some folks, "conventional" is more neutral.  Thanks,

Oh, Conventional PCI even has a Wikipedia article.  I agree.  I
will change it in v2.  Thanks!

-- 
Eduardo
