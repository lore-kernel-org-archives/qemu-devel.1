Received: from eggs.gnu.org ([2001:4830:134:3::10]:44134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eKFUB-0000fz-Mw
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 22:26:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eKFU8-0003Ah-JK
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 22:26:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59736)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eKFU8-0003A5-E3
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 22:26:00 -0500
Date: Thu, 30 Nov 2017 11:25:51 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20171130032551.GA18017@xz-mi>
References: <20171114231350.286025-1-prasad.singamsetty@oracle.com>
	<20171114231350.286025-3-prasad.singamsetty@oracle.com>
	<20171128193156-mutt-send-email-mst@kernel.org>
	<cdbe8732-88fa-512e-481b-250abc18bf92@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cdbe8732-88fa-512e-481b-250abc18bf92@oracle.com>
Subject: Re: [Qemu-devel] [PATCH v1 2/2] intel-iommu: Extend address width
 to 48 bits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Prasad Singamsetty <prasad.singamsetty@oracle.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, imammedo@redhat.com, konrad.wilk@oracle.com

On Wed, Nov 29, 2017 at 01:05:22PM -0800, Prasad Singamsetty wrote:
> Thanks Michael. Some comments below.
> 
> On 11/28/2017 9:32 AM, Michael S. Tsirkin wrote:
> > On Tue, Nov 14, 2017 at 06:13:50PM -0500, prasad.singamsetty@oracle.com wrote:
> > > From: Prasad Singamsetty <prasad.singamsetty@oracle.com>
> > > 
> > > The current implementation of Intel IOMMU code only supports 39 bits
> > > iova address width. This patch provides a new parameter (x-aw-bits)
> > > for intel-iommu to extend its address width to 48 bits but keeping the
> > > default the same (39 bits). The reason for not changing the default
> > > is to avoid potential compatibility problems
> > 
> > You can change the default, just make it 39 for existing machine types.
> 
> I think introducing a new machine type is not appropriate as this
> is an implementation limitation for the existing machine type.
> Currently q35 is the only machine type that supports intel-iommu.
> And we want to retain the current default behavior for q35 to avoid
> any new issues with live migration.

I guess "existing machine type" means e.g. pc-q35-2.11 and older ones,
rather than creating another machine type in parallel with q35.  So we
can set 48 bits as default on upcoming pc-q35-2.12 machines, while
keep the 39 bits on the old ones.

Please refer to include/hw/compat.h.

> 
> > 
> > > with live migration of
> > > intel-iommu enabled QEMU guest. The only valid values for 'x-aw-bits'
> > > parameter are 39 and 48.
> > 
> > I'd rather make it a boolean then.
> 
> Right. It seems Intel already has additional sizes supported so keeping
> it as an integer seems better.

Yes, considering that 5-level IOMMUs are coming (AFAIK).

-- 
Peter Xu
