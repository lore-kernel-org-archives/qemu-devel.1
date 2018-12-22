Received: from eggs.gnu.org ([2001:4830:134:3::10]:59281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yu.c.zhang@linux.intel.com>) id 1gaVPY-0001us-5A
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 19:45:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yu.c.zhang@linux.intel.com>) id 1gaVPP-0002kZ-A3
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 19:44:57 -0500
Received: from mga17.intel.com ([192.55.52.151]:24295)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yu.c.zhang@linux.intel.com>)
	id 1gaVPP-0002bh-0y
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 19:44:51 -0500
Date: Sat, 22 Dec 2018 08:41:37 +0800
From: Yu Zhang <yu.c.zhang@linux.intel.com>
Message-ID: <20181222004137.b7hj623kmzsq5ttv@linux.intel.com>
References: <20181219034006.d4drqoz5b6r6h3mn@linux.intel.com>
	<20181218233451-mutt-send-email-mst@kernel.org>
	<20181219055743.okeszdqlqkg7tagk@linux.intel.com>
	<20181219100355-mutt-send-email-mst@kernel.org>
	<20181220054921.sk5wnmlo2vvjgcs6@linux.intel.com>
	<20181220132644-mutt-send-email-mst@kernel.org>
	<20181221161920.45fnlmcp7aqu6ibi@linux.intel.com>
	<20181221120657-mutt-send-email-mst@kernel.org>
	<20181221173401.cb5vgokgxopnnpes@linux.intel.com>
	<20181221130713-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181221130713-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH v3 2/2] intel-iommu: extend VTD emulation
 to allow 57-bit IOVA address width.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Fri, Dec 21, 2018 at 01:10:13PM -0500, Michael S. Tsirkin wrote:
> On Sat, Dec 22, 2018 at 01:34:01AM +0800, Yu Zhang wrote:
> > On Fri, Dec 21, 2018 at 12:15:26PM -0500, Michael S. Tsirkin wrote:
> > > On Sat, Dec 22, 2018 at 12:19:20AM +0800, Yu Zhang wrote:
> > > > > I'd like to avoid poking at the CPU from VTD code. That's all.
> > > > 
> > > > OK. So for the short term，how about I remove the check of host cpu, and add a TODO
> > > > in the comments in vtd_decide_config()? 
> > > 
> > > My question would be what happens on an incorrect use?
> > 
> > I believe the vfio_dma_map will return failure for an incorrect use.
> > 
> > > And how does user figure out which values to set?
> > 
> > Well, for now I don't think user can figure out. E.g. if we expose a vIOMMU with
> > 48-bit IOVA capability, yet host only supports 39-bit IOVA, vfio shall return failure,
> > but the user does not know whose fault it is.
> > > 
> > > > As to the check against hardware IOMMU, Peter once had a proposal in
> > > > http://lists.nongnu.org/archive/html/qemu-devel/2018-11/msg02281.html
> > > > 
> > > > Do you have any comment or suggestion on Peter's proposal?
> > > 
> > > Sounds reasonable to me. Do we do it on vfio attach or unconditionally?
> > > 
> > 
> > I guess on vfio attach? Will need more thinking in it.
> 
> 
> Things like live migration (e.g. after hot removal of the vfio device)
> are also concerns.

Sorry, why live migration shall be a problem? I mean, if the DMA address
width of vIOMMU does not match the host IOMMU's, we can just stop creating
the VM, there's no live migration. 

> 
> > > 
> > > > I still do not quite know
> > > > how to do it for now...
> > > > 
> > > > [...]
> > > > 
> > > > 
> > > > B.R.
> > > > Yu
> > > 
> > > 
> > > 
> > > -- 
> > > MST
> > 
> > B.R.
> > Yu

B.R.
Yu
