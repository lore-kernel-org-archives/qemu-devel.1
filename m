Received: from eggs.gnu.org ([2001:4830:134:3::10]:47756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cGyw9-0005Vp-8y
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 21:04:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cGyw5-00089g-A9
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 21:04:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54126)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cGyw5-00089L-51
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 21:04:49 -0500
Date: Wed, 14 Dec 2016 10:04:43 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20161214020443.GF32222@pxdev.xzpeter.org>
References: <1481613903-17467-1-git-send-email-peterx@redhat.com>
	<1481613903-17467-3-git-send-email-peterx@redhat.com>
	<20161213064028.78938d07@t450s.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161213064028.78938d07@t450s.home>
Subject: Re: [Qemu-devel] [PATCH for-2.9 v2 2/2] intel_iommu: provide
 "aw-bits" parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, kevin.tian@intel.com, famz@redhat.com, mst@redhat.com, jasowang@redhat.com

On Tue, Dec 13, 2016 at 06:40:28AM -0700, Alex Williamson wrote:
> On Tue, 13 Dec 2016 15:25:03 +0800
> Peter Xu <peterx@redhat.com> wrote:
> 
> > Previously vt-d codes only supports 39 bits iova address width. This
> > patch provide a new parameter for Intel IOMMU to extend its address
> > width to 48 bits.
> > 
> > After enabling larger address width (48), we should be able to map
> > larger iova addresses in the guest. To check whether 48 bits aw is
> > enabled, we can grep in the guest dmesg with line: "dmar: Host address
> > width 48".
> > 
> > To keep compatibility with old QEMU and most hosts, default aw bits are
> > set to 39 bits.
> 
> I really fail to see the benefit of this option.  Clearly we always
> need to be able to support identity maps through the IOMMU, so the
> address width of the vIOMMU needs to support the maximum address of any
> memory or mmio range available to the VM.  However if that's the case,
> then the address width of the vIOMMU should be automatically configured
> for the VM configuration.  What's the benefit of creating yet another
> obscure device option rather than configuring this automatically.  If
> the argument is to be able to test 48bit vIOMMU support, then we could
> simply prefix this option with 'x-' to indicate an experimental,
> unsupported option.  Creating this option with the expectation that the
> user must specify this in order to potentially create a valid VT-d
> configuration for the VM doesn't make sense to me.  Thanks,

I'll rename with "x-" prefix and repost. Thanks,

-- peterx
