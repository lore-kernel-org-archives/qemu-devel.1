Received: from eggs.gnu.org ([2001:4830:134:3::10]:60093)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liliang.opensource@gmail.com>) id 1eqezh-0001us-I8
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 08:08:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liliang.opensource@gmail.com>) id 1eqezd-0008SD-JZ
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 08:08:33 -0500
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:44307)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liliang.opensource@gmail.com>)
	id 1eqezd-0008Rr-Cu
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 08:08:29 -0500
Received: by mail-pf0-x242.google.com with SMTP id 17so7906230pfw.11
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 05:08:29 -0800 (PST)
From: Liang Li <liliang.opensource@gmail.com>
Date: Tue, 27 Feb 2018 21:08:22 +0800
Message-ID: <20180227130820.GA11350@localhost>
References: <1517915299-15349-1-git-send-email-wei.w.wang@intel.com>
	<1517915299-15349-4-git-send-email-wei.w.wang@intel.com>
	<20180209121517.GD2428@work-vm> <5A938E93.5020502@intel.com>
	<20180227024325-mutt-send-email-mst@kernel.org>
	<5A952EA7.8010708@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5A952EA7.8010708@intel.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/3] virtio-balloon: add a timer to
 limit the free page report waiting time
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Wang <wei.w.wang@intel.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org, quintela@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, mst@redhat.com

On Tue, Feb 27, 2018 at 06:10:47PM +0800, Wei Wang wrote:
> On 02/27/2018 08:50 AM, Michael S. Tsirkin wrote:
> > On Mon, Feb 26, 2018 at 12:35:31PM +0800, Wei Wang wrote:
> > > On 02/09/2018 08:15 PM, Dr. David Alan Gilbert wrote:
> > > > * Wei Wang (wei.w.wang@intel.com) wrote:
> > 
> > I think all this is premature optimization. It is not at all clear that
> > anything is gained by delaying migration. Just ask for hints and start
> > sending pages immediately.  If guest tells us a page is free before it's
> > sent, we can skip sending it.  OTOH if migration is taking less time to
> > complete than it takes for guest to respond, then we are better off just
> > ignoring the hint.
> 
> OK, I'll try to create a thread for the free page optimization. We create
> the thread to poll for free pages at the beginning of the bulk stage, and
> stops at the end of bulk stage.
> There are also comments about postcopy support with this feature, I plan to
> leave that as the second step (that support seems not urgent for now).
> 
> 
> Best,
> Wei

you can make use the current migration thread instead of creating a new one.

Liang
