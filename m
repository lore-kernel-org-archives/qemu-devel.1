Received: from eggs.gnu.org ([209.51.188.92]:37809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1glazX-00044o-0v
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 09:55:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1glatn-0003vx-2E
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 09:50:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32962)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1glatm-0003pp-S3
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 09:50:02 -0500
Date: Mon, 21 Jan 2019 12:44:00 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190121144400.GM4136@habkost.net>
References: <cover.1547624239.git.yi.z.zhang@linux.intel.com>
	<64bea1ff5f80647cc4592ee94d399d647bdd9862.1547624239.git.yi.z.zhang@linux.intel.com>
	<20190116104105-mutt-send-email-mst@kernel.org>
	<20190118181147.GJ4136@habkost.net>
	<20190121051535.GA21562@tiger-server>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190121051535.GA21562@tiger-server>
Subject: Re: [Qemu-devel] [PATCH V9 4/6] util/mmap-alloc: support MAP_SYNC
 in qemu_ram_mmap()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, pagupta@redhat.com, qemu-devel@nongnu.org, yu.c.zhang@linux.intel.com, stefanha@redhat.com, imammedo@redhat.com, pbonzini@redhat.com, dan.j.williams@intel.com, xiaoguangrong.eric@gmail.com

On Mon, Jan 21, 2019 at 01:15:36PM +0800, Yi Zhang wrote:
> On 2019-01-18 at 16:11:47 -0200, Eduardo Habkost wrote:
[...]
> > Anyway, I see a more fundamental problem in each version of this
> > patch: the semantics of the command-line options are not clearly
> > documented.
> > 
> > We have at least 3 different possible use cases we might need to
> > support:
> > 
> > 1) pmem=on, MAP_SYNC not desired
> > 2) pmem=on, MAP_SYNC desired but optional
> 
> Form V9, As Michael suggest, We removed the sync option, MAP_SYNC will
> force on while we set pmem=on. So we only have 2 user cases, Will update
> to user documentation.
> 1) pmem=on, MAP_SYNC not desired
> We will not pass the flag to mmap2

If this use case is supported, how the command-line should look
like to enable it?


> 2) pmem=on, MAP_SYNC desired
> We will pass the flag to mmap2

Same question as above: how the command-line should look like for
this use case?

> 
> > 3) pmem=on, MAP_SYNC required, not optional
> > 
> > Which cases from the list above we need to support?
> > 
> > From the cases above, what's the expected semantics of "pmem=on"
> > with no extra options?

We still need to answer that question.

The current semantics of pmem=on (with no extra options) is (1).
It looks like we can't change it to (2) without breaking existing
configurations.  If you make existing configurations stop working
on hosts where they currently work, you need to explain why it's
OK to do that.


> > 
> > If these questions are not answered (in the commit message and
> > user documentation), we won't be able to review and discuss the
> > code.
> > 
> > 
[...]


-- 
Eduardo
