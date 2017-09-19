Received: from eggs.gnu.org ([2001:4830:134:3::10]:47847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1duK1r-0006MS-0P
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 11:01:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1duK1o-0002Iu-AS
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 11:01:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47176)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1duK1o-0002IL-5O
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 11:01:36 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2BB3A7E445
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 15:01:35 +0000 (UTC)
Date: Tue, 19 Sep 2017 12:01:25 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170919150125.GJ3030@localhost.localdomain>
References: <1505832682-27325-1-git-send-email-mgamal@redhat.com>
	<1505832682-27325-3-git-send-email-mgamal@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1505832682-27325-3-git-send-email-mgamal@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 2/2] x86_iommu: check if machine has PCI
 bus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mohammed Gamal <mgamal@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, thuth@redhat.com, peterx@redhat.com, pbonzini@redhat.com

On Tue, Sep 19, 2017 at 04:51:22PM +0200, Mohammed Gamal wrote:
> Starting qemu with
> qemu-system-x86_64 -S -M isapc -device {amd|intel}-iommu
> leads to a segfault. The code assume PCI bus is present and
> tries to access the bus structure without checking.
> 
> Since Intel VT-d and AMDVI should only work with PCI, add a
> check for PCI bus and return error if not present.
> 
> Signed-off-by: Mohammed Gamal <mgamal@redhat.com>

When resubmitting patches without changes, please keep/add the
Reviewed-by lines from previous patch versions.

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

-- 
Eduardo
