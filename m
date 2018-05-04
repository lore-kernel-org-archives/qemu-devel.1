Received: from eggs.gnu.org ([2001:4830:134:3::10]:50897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fESEL-0005ek-PQ
	for qemu-devel@nongnu.org; Fri, 04 May 2018 00:22:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fESEI-0007FE-Go
	for qemu-devel@nongnu.org; Fri, 04 May 2018 00:22:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57790 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fESEI-0007EX-By
	for qemu-devel@nongnu.org; Fri, 04 May 2018 00:21:58 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CBA467D83F
	for <qemu-devel@nongnu.org>; Fri,  4 May 2018 04:21:54 +0000 (UTC)
Date: Fri, 4 May 2018 12:21:44 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180504042144.GB28447@xz-mi>
References: <20180417140802.16711-1-pbonzini@redhat.com>
	<20180417140802.16711-3-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180417140802.16711-3-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/4] exec: small changes to
 flatview_do_translate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org

On Tue, Apr 17, 2018 at 04:08:00PM +0200, Paolo Bonzini wrote:
> Prepare for extracting the IOMMU part to a separate function.  Mostly
> cosmetic; the only semantic change is that, if there is more than one
> cascaded IOMMU and the second one fails to translate, *plen_out is now
> adjusted according to the page mask of the first IOMMU.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu
