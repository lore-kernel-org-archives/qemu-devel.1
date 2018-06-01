Received: from eggs.gnu.org ([2001:4830:134:3::10]:60457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fOmRd-0001pT-H1
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 11:58:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fOmRa-0006UM-Ey
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 11:58:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59186 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fOmRa-0006U7-9r
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 11:58:22 -0400
Date: Fri, 1 Jun 2018 18:58:20 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180601184855-mutt-send-email-mst@kernel.org>
References: <40602400-cae4-e175-e7ce-10ac70ba52f5@riseup.net>
	<20180601113444.GG8687@stefanha-x1.localdomain>
	<b25b3adb-bacc-bef1-7d18-c71a4933abc1@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b25b3adb-bacc-bef1-7d18-c71a4933abc1@riseup.net>
Subject: Re: [Qemu-devel] Virtio-net drivers immune to Nethammer?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: procmem <procmem@riseup.net>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org, whonix-devel@whonix.org, jasowang@redhat.com

On Fri, Jun 01, 2018 at 01:15:44PM +0000, procmem wrote:
> 
> 
> Stefan Hajnoczi:
> > On Mon, May 21, 2018 at 11:24:43PM +0000, procmem wrote:
> >> Hi I'm a privacy distro maintainer investigating the implications of the
> >> newly published nethammer attack [0] on KVM guests particularly the
> >> virtio-net drivers. The summary of the paper is that rowhammer can be
> >> remotely triggered by feeding susceptible* network driver crafted
> >> traffic. This attack can do all kinds of nasty things such as modifying
> >> SSL certs on the victim system.
> >>
> >> * Susceptible drivers are those relying on Intel CAT, uncached memory or
> >> the clflush instruction.
> >>
> >> My question is, do virtio-net drivers do any of these things?
> > I have CCed Michael Tsirkin and Jason Wang, the virtio maintainers.
> > 
> >> ***
> >>
> >> [0] https://arxiv.org/abs/1805.04956
> >>
> >>
> >>
> 
> Thanks :) I thought my message was forgotten


I don't think virtio is using either of these.

Linux does support CAT AFAIK but it has nothing to do with virtio.

-- 
MST
