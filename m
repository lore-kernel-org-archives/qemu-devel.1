Received: from eggs.gnu.org ([2001:4830:134:3::10]:54459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dijnF-0005fA-Cu
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 12:06:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dijnB-0001Mj-BY
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 12:06:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59382)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dijnB-0001MD-5C
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 12:06:37 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 39F7D37EEF
	for <qemu-devel@nongnu.org>; Fri, 18 Aug 2017 16:06:36 +0000 (UTC)
References: <1502949374-3061-1-git-send-email-peterx@redhat.com>
	<55204f73-46d3-0f8e-195f-15a9247819d7@redhat.com>
	<20170818040245.GD2294@pxdev.xzpeter.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <452181c0-1f46-a0de-4b36-231445552c24@redhat.com>
Date: Fri, 18 Aug 2017 18:06:17 +0200
MIME-Version: 1.0
In-Reply-To: <20170818040245.GD2294@pxdev.xzpeter.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.11] intel_iommu: fix missing BQL in
 pt fast path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>

On 18/08/2017 06:02, Peter Xu wrote:
>> The patch below is okay.  However, vtd_switch_address_space is
>> expensive, which is why I suggested the bottom half.
> But still, shall we just do it this way? It looks cleaner.
> 
> For the slowness (as I mentioned below), one thing to mention is that,
> this fast path should even not be used when PT is enabled.  When
> "iommu=pt" is set, the IOMMU regions are off start from the very
> beginning.  In other words, this patch should only affect a very
> corner use case, and to make sure that use case is safe, though it
> brings the first IO of that use case slower.
> 
> How do you think?

Sure, the patch you posted is fine by me.

Paolo
