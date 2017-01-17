Received: from eggs.gnu.org ([2001:4830:134:3::10]:53373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cTV8v-000175-42
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 09:53:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cTV8r-0006tF-4U
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 09:53:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45722)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cTV8q-0006sp-Uj
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 09:53:45 -0500
Date: Tue, 17 Jan 2017 22:53:36 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170117145336.GP30108@pxdev.xzpeter.org>
References: <1484276800-26814-1-git-send-email-peterx@redhat.com>
	<1484276800-26814-14-git-send-email-peterx@redhat.com>
	<7a8c721d-8a12-9727-feae-58103942fd55@redhat.com>
	<20170116075043.GE30108@pxdev.xzpeter.org>
	<ae7765c7-7101-357e-3e7f-8ca94d8ad5b5@redhat.com>
	<20170116081252.GI30108@pxdev.xzpeter.org>
	<bcfed61e-d086-0df5-849c-6d2aaa25757c@redhat.com>
	<20170116083224.GK30108@pxdev.xzpeter.org>
	<20170116182522-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170116182522-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH RFC v3 13/14] intel_iommu: allow dynamic
 switch of IOMMU region
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, tianyu.lan@intel.com, kevin.tian@intel.com, jan.kiszka@siemens.com, bd.aviv@gmail.com, qemu-devel@nongnu.org, alex.williamson@redhat.com

On Mon, Jan 16, 2017 at 06:25:32PM +0200, Michael S. Tsirkin wrote:

[...]

> > > I think this does not give more readability :) May I was wrong, let leave
> > > this for maintainer.
> > > 
> > > Thanks :)
> > 
> > Thanks for reviewing this series so fast!
> > 
> > I have no strong opinion as well. Maybe you are right. :-)
> > 
> > Michael, please let me know if you dislike this, so I can remove this
> > parameter (it equals to as->iommu_state->dmar_enabled).
> > 
> > Thanks,
> > 
> > -- peterx
> 
> I prefer not to duplicate data, yes.

Let me remove it then. Thanks,

-- peterx
