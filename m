Received: from eggs.gnu.org ([209.51.188.92]:46968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gm15K-0004tq-8E
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:47:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gm15I-0005cS-70
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:47:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35408)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gm15H-0005MU-Rw
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:47:40 -0500
Date: Tue, 22 Jan 2019 13:47:08 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190122134252-mutt-send-email-mst@kernel.org>
References: <cover.1547624239.git.yi.z.zhang@linux.intel.com>
	<64bea1ff5f80647cc4592ee94d399d647bdd9862.1547624239.git.yi.z.zhang@linux.intel.com>
	<20190116104105-mutt-send-email-mst@kernel.org>
	<20190118181147.GJ4136@habkost.net>
	<20190121051535.GA21562@tiger-server>
	<20190121144400.GM4136@habkost.net>
	<20190122032124.GA30317@tiger-server>
	<20190121222305-mutt-send-email-mst@kernel.org>
	<CAPcyv4iMO1jxKakMOvePUwPx3GuLDSRf=H2HoqenPP-wGV+n_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4iMO1jxKakMOvePUwPx3GuLDSRf=H2HoqenPP-wGV+n_w@mail.gmail.com>
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
To: Dan Williams <dan.j.williams@intel.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Pankaj Gupta <pagupta@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>, yu.c.zhang@linux.intel.com, Stefan Hajnoczi <stefanha@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>

On Tue, Jan 22, 2019 at 09:33:37AM -0800, Dan Williams wrote:
> On Mon, Jan 21, 2019 at 7:27 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> [..]
> > > 2. The reset of cases:
> > >       - we will never pass the MAP_SYNC to mmap2
> >
> > I don't see code probing for MAP_SYNC support. Did I miss it?
> > But if all you want is to have old linux ignore MAP_SYNC,
> > I think you got your wish automatically - just do not set
> > MAP_SHARED_VALIDATE.
> 
> That will also cause new Linux to ignore MAP_SYNC.

Oh you are right. I missed this point.

And given that these patches do not seem to set MAP_SHARED_VALIDATE
at all I conclude that even though thet set MAP_SYNC
it actually has no effect at all.

So I wonder how they were tested.
Would the contributors care to elaborate?
That would be good info to put in the commit log message.

-- 
MST
