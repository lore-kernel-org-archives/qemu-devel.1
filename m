Received: from eggs.gnu.org ([2001:4830:134:3::10]:50200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1duJPh-0001q9-1o
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 10:22:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1duJPe-0001cP-Ce
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 10:22:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59281)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1duJPe-0001c9-6j
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 10:22:10 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4B9287DCFA
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 14:22:09 +0000 (UTC)
Date: Tue, 19 Sep 2017 11:21:57 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170919142157.GE3030@localhost.localdomain>
References: <1505745470-12208-1-git-send-email-mgamal@redhat.com>
	<1505745470-12208-2-git-send-email-mgamal@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1505745470-12208-2-git-send-email-mgamal@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 1/3] x86_iommu: Move machine check to
 x86_iommu_realize()
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

On Mon, Sep 18, 2017 at 04:37:48PM +0200, Mohammed Gamal wrote:
> Instead of having the same error checks in vtd_realize()
> and amdvi_realize(), move that over to the generic
> x86_iommu_realize().
> 
> Signed-off-by: Mohammed Gamal <mgamal@redhat.com>

If patch 2/3 is squashed into this one:

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

-- 
Eduardo
