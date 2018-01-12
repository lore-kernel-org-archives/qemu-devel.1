Received: from eggs.gnu.org ([2001:4830:134:3::10]:47903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eZplC-0008Kj-IR
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 22:12:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eZplB-0002BB-Ly
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 22:12:02 -0500
Date: Fri, 12 Jan 2018 11:11:51 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180112031151.GD29151@lemon.usersys.redhat.com>
References: <20180110091846.10699-1-famz@redhat.com>
	<20180110091846.10699-4-famz@redhat.com>
	<51927002-e1b5-6bd0-2ebd-5270d6153339@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51927002-e1b5-6bd0-2ebd-5270d6153339@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 3/9] block: Add VFIO based NVMe driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>, Keith Busch <keith.busch@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Karl Rister <krister@redhat.com>

On Wed, 01/10 08:44, Eric Blake wrote:
> On 01/10/2018 03:18 AM, Fam Zheng wrote:
> > This is a new protocol driver that exclusively opens a host NVMe
> > controller through VFIO. It achieves better latency than linux-aio by
> > completely bypassing host kernel vfs/block layer.
> > 
> 
> > +static BlockDriver bdrv_nvme = {
> > +    .format_name              = "nvme",
> > +    .protocol_name            = "nvme",
> > +    .instance_size            = sizeof(BDRVNVMeState),
> > +
> > +    .bdrv_parse_filename      = nvme_parse_filename,
> > +    .bdrv_file_open           = nvme_file_open,
> > +    .bdrv_close               = nvme_close,
> > +    .bdrv_getlength           = nvme_getlength,
> > +
> > +    .bdrv_co_preadv           = nvme_co_preadv,
> > +    .bdrv_co_pwritev          = nvme_co_pwritev,
> > +    .bdrv_co_flush_to_disk    = nvme_co_flush,
> > +    .bdrv_reopen_prepare      = nvme_reopen_prepare,
> > +
> > +    .bdrv_co_get_block_status = nvme_co_get_block_status,
> 
> Semantic conflict with my pending patches to switch to byte-based block
> status in the drivers.

Should be very easy to rebase for either of us. :)

Fam
