Received: from eggs.gnu.org ([2001:4830:134:3::10]:32994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cTVMD-00014v-Nm
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 10:07:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cTVM9-0004y1-Or
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 10:07:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:4071)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cTVM9-0004xW-Hq
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 10:07:29 -0500
Date: Tue, 17 Jan 2017 17:07:27 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170117170627-mutt-send-email-mst@kernel.org>
References: <1484276800-26814-1-git-send-email-peterx@redhat.com>
	<20170113175646-mutt-send-email-mst@kernel.org>
	<20170114025958.GA14805@pxdev.xzpeter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170114025958.GA14805@pxdev.xzpeter.org>
Subject: Re: [Qemu-devel] [PATCH RFC v3 00/14] VT-d: vfio enablement and
 misc enhances
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, tianyu.lan@intel.com, kevin.tian@intel.com, jan.kiszka@siemens.com, jasowang@redhat.com, alex.williamson@redhat.com, bd.aviv@gmail.com

On Sat, Jan 14, 2017 at 10:59:58AM +0800, Peter Xu wrote:
> On Fri, Jan 13, 2017 at 05:58:02PM +0200, Michael S. Tsirkin wrote:
> > On Fri, Jan 13, 2017 at 11:06:26AM +0800, Peter Xu wrote:
> > > v3:
> > > - fix style error reported by patchew
> > > - fix comment in domain switch patch: use "IOMMU address space" rather
> > >   than "IOMMU region" [Kevin]
> > > - add ack-by for Paolo in patch:
> > >   "memory: add section range info for IOMMU notifier"
> > >   (this is seperately collected besides this thread)
> > > - remove 3 patches which are merged already (from Jason)
> > > - rebase to master b6c0897
> > 
> > So 1-6 look like nice cleanups to me. Should I merge them now?
> 
> That'll be great if you'd like to merge them. Then I can further
> shorten this series for the next post.
> 
> Regarding to the error_report() issue that Jason has mentioned, I can
> touch them up in the future when needed - after all, most of the patch
> content are about converting DPRINT()s into traces.
> 
> Thanks!
> 
> -- peterx

I think I agree with Jason, it's best not to have guest behaviour
trigger error_report. So pls address and I'll merge.
