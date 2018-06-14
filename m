Received: from eggs.gnu.org ([2001:4830:134:3::10]:53957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fTHRh-0003CR-Vy
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 21:53:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fTHRe-0006JQ-UW
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 21:53:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44388 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fTHRe-0006JH-Ow
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 21:53:02 -0400
Date: Thu, 14 Jun 2018 09:52:57 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180614015257.GO15344@xz-mi>
References: <1528895946-28677-1-git-send-email-eric.auger@redhat.com>
	<ed56ac4b-6e22-c6b1-4cfa-ce3a9a8af35a@redhat.com>
	<8e5da16e-2283-ff87-9426-293e7770e2aa@redhat.com>
	<0140c2fe-1a79-c465-5302-ecff541ebd60@redhat.com>
	<af509759-6173-271b-eeff-c016e78edf83@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <af509759-6173-271b-eeff-c016e78edf83@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] exec: Fix MAP_RAM for cached access
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, eric.auger.pro@gmail.com, qemu-devel@nongnu.org

On Wed, Jun 13, 2018 at 04:20:34PM +0200, Auger Eric wrote:
> Hi Paolo,
> 
> On 06/13/2018 03:53 PM, Paolo Bonzini wrote:
> > On 13/06/2018 15:44, Auger Eric wrote:
> >>> Queuing this patch.  I'm not sure how I missed this, I have actually
> >>> tested it with SMMU.
> >> no problem. Strange also I was the only one facing the issue.
> > 
> > No, I must have blundered it between testing and posting the patches.
> > 
> >>> Do you also need the MemTxAttrs so that the right PCI requestor id is
> >>> used, or do you get it from somewhere else?
> >> which call site do you have in mind, sorry?
> > 
> > I'm wondering if the MemoryRegionCache needs to store the MemTxAttrs.
> > They would be passed to address_space_init_cache.
> 
> I acknowledge I don't master this code enough but I would say MSI
> wouldn't work already (vITS wouldn't translate them properly) if the
> proper requester_id wasn't conveyed properly. MSI writes to the doorbell
> are not cached I guess?

I might be wrong, but I guess Paolo means the DMA part.  In
address_space_cache_init() now we are with MEMTXATTRS_UNSPECIFIED when
translate the first time (to be cached).

But I'd also guess we're fine with that now since after all we're not
even passing the attrs into IOMMUMemoryRegionClass.translate() yet.

Regards,

-- 
Peter Xu
