Received: from eggs.gnu.org ([2001:4830:134:3::10]:38012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fOpCA-0004yt-2I
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 14:54:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fOpC6-000631-4X
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 14:54:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56668 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fOpC5-00062b-VY
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 14:54:34 -0400
Date: Fri, 1 Jun 2018 19:54:29 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180601185429.GB2532@work-vm>
References: <40602400-cae4-e175-e7ce-10ac70ba52f5@riseup.net>
	<20180601113444.GG8687@stefanha-x1.localdomain>
	<b25b3adb-bacc-bef1-7d18-c71a4933abc1@riseup.net>
	<20180601184855-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180601184855-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] Virtio-net drivers immune to Nethammer?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: procmem <procmem@riseup.net>, Stefan Hajnoczi <stefanha@gmail.com>, jasowang@redhat.com, qemu-devel@nongnu.org, whonix-devel@whonix.org

* Michael S. Tsirkin (mst@redhat.com) wrote:
> On Fri, Jun 01, 2018 at 01:15:44PM +0000, procmem wrote:
> > 
> > 
> > Stefan Hajnoczi:
> > > On Mon, May 21, 2018 at 11:24:43PM +0000, procmem wrote:
> > >> Hi I'm a privacy distro maintainer investigating the implications of the
> > >> newly published nethammer attack [0] on KVM guests particularly the
> > >> virtio-net drivers. The summary of the paper is that rowhammer can be
> > >> remotely triggered by feeding susceptible* network driver crafted
> > >> traffic. This attack can do all kinds of nasty things such as modifying
> > >> SSL certs on the victim system.
> > >>
> > >> * Susceptible drivers are those relying on Intel CAT, uncached memory or
> > >> the clflush instruction.
> > >>
> > >> My question is, do virtio-net drivers do any of these things?
> > > I have CCed Michael Tsirkin and Jason Wang, the virtio maintainers.
> > > 
> > >> ***
> > >>
> > >> [0] https://arxiv.org/abs/1805.04956
> > >>
> > >>
> > >>
> > 
> > Thanks :) I thought my message was forgotten
> 
> 
> I don't think virtio is using either of these.
> 
> Linux does support CAT AFAIK but it has nothing to do with virtio.

Isn't the idea to misuse CAT to detect something about access patterns;
so it's not about it actually being related?

Dave

> -- 
> MST
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
