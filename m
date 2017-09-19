Received: from eggs.gnu.org ([2001:4830:134:3::10]:50434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1duJQF-0002Bu-7f
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 10:22:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1duJQC-0001sE-Hz
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 10:22:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50770)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1duJQC-0001rx-Bt
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 10:22:44 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7E1074ACBC
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 14:22:43 +0000 (UTC)
Date: Tue, 19 Sep 2017 11:22:38 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170919142238.GF3030@localhost.localdomain>
References: <1505745470-12208-1-git-send-email-mgamal@redhat.com>
	<1505745470-12208-3-git-send-email-mgamal@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1505745470-12208-3-git-send-email-mgamal@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 2/3] intel_iommu,
 amd_iommu: Remove redundant object_dynamic_cast calls
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

On Mon, Sep 18, 2017 at 04:37:49PM +0200, Mohammed Gamal wrote:
> Now that the calling x86_iommu_realize() calls object_dynamic_cast(),
> doing the cast in amdvi_realize() and vtd_realize() is not needed.
> 
> Use PC_MACHINE macro directly.
> 
> Signed-off-by: Mohammed Gamal <mgamal@redhat.com>

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

I suggest squashing this into patch 1/3.  It doesn't need to be a
separate patch.

-- 
Eduardo
