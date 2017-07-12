Received: from eggs.gnu.org ([2001:4830:134:3::10]:50556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dVClp-00008t-Dx
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 04:13:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dVCll-0001bb-3c
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 04:13:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56440)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dVClk-0001bJ-TA
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 04:13:13 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A7AE561E50
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 08:13:11 +0000 (UTC)
Date: Wed, 12 Jul 2017 16:13:03 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170712081303.GH29326@pxdev.xzpeter.org>
References: <1499844982-5738-1-git-send-email-peterx@redhat.com>
	<149984564169.66.8890128169968285578@5d477a5b5989>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <149984564169.66.8890128169968285578@5d477a5b5989>
Subject: Re: [Qemu-devel] [PATCH v2 0/4] VT-d: some enhancements on iotlb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, jasowang@redhat.com, mst@redhat.com

On Wed, Jul 12, 2017 at 12:47:22AM -0700, no-reply@patchew.org wrote:
> Hi,
> 
> This series seems to have some coding style problems. See output below for
> more information:
> 
> Type: series
> Message-id: 1499844982-5738-1-git-send-email-peterx@redhat.com
> Subject: [Qemu-devel] [PATCH v2 0/4] VT-d: some enhancements on iotlb
> 
> === TEST SCRIPT BEGIN ===
> #!/bin/bash
> 
> BASE=base
> n=1
> total=$(git log --oneline $BASE.. | wc -l)
> failed=0
> 
> git config --local diff.renamelimit 0
> git config --local diff.renames True
> 
> commits="$(git log --format=%H --reverse $BASE..)"
> for c in $commits; do
>     echo "Checking PATCH $n/$total: $(git log -n 1 --format=%s $c)..."
>     if ! git show $c --format=email | ./scripts/checkpatch.pl --mailback -; then
>         failed=1
>         echo
>     fi
>     n=$((n+1))
> done
> 
> exit $failed
> === TEST SCRIPT END ===
> 
> Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
> Switched to a new branch 'test'
> 0363bbd intel_iommu: implement mru list for iotlb
> 661bf52 intel_iommu: use access_flags for iotlb
> a571ac1 intel_iommu: let iotlb size tunable
> 3d04c28 intel_iommu: fix VTD_PAGE_MASK
> 
> === OUTPUT BEGIN ===
> Checking PATCH 1/4: intel_iommu: fix VTD_PAGE_MASK...
> ERROR: Macros with complex values should be enclosed in parenthesis
> #38: FILE: hw/i386/intel_iommu_internal.h:387:
> +#define VTD_PAGE_MASK               ~(VTD_PAGE_SIZE - 1)
> 
> total: 1 errors, 0 warnings, 16 lines checked

Oops. I forgot this one (after weeks). Will repost.

-- 
Peter Xu
