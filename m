Received: from eggs.gnu.org ([2001:4830:134:3::10]:52675)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cW708-0007In-T0
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 14:43:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cW705-000425-Qw
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 14:43:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50002)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cW705-00041i-LD
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 14:43:29 -0500
Date: Tue, 24 Jan 2017 21:43:27 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170124214100-mutt-send-email-mst@kernel.org>
References: <1484633936-25344-1-git-send-email-caoj.fnst@cn.fujitsu.com>
	<1484633936-25344-5-git-send-email-caoj.fnst@cn.fujitsu.com>
	<587DBEBE.4070409@cn.fujitsu.com>
	<20170117175708-mutt-send-email-mst@kernel.org>
	<afeb5d3c-9301-0965-6032-3d44d0a656cc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afeb5d3c-9301-0965-6032-3d44d0a656cc@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v9 04/11] msix: check msix_init's return
 value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Cao jin <caoj.fnst@cn.fujitsu.com>, jiri@resnulli.us, Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, dmitry@daynix.com

On Tue, Jan 24, 2017 at 07:18:14PM +0100, Paolo Bonzini wrote:
> 
> 
> On 17/01/2017 17:01, Michael S. Tsirkin wrote:
> >>> Doesn't do it for megasas & hcd-xhci, later patches will fix them.
> >>>
> >>> Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
> > I don't like this one, frankly. That's a bunch of code duplication.
> > I suspect vfio is the only one who might reasonably get EINVAL here.
> > So how about e.g. msix_validate_and_init that doesn't assert and use that
> > from vfio, then switch msix_init to assert instead?
> 
> The names we use normally would be msix_init and msix_init_nofail.
> Would still require a change through the whole tree, but it's more
> consistent at least.
> 
> Paolo

This area has seen too much noise already but OK I guess.
Also, msix_init_exclusive_bar probably should assert
internally, no need for two versions.

-- 
MST
