Received: from eggs.gnu.org ([2001:4830:134:3::10]:38505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fPVaA-0000kL-UH
	for qemu-devel@nongnu.org; Sun, 03 Jun 2018 12:10:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fPVa6-0006UW-1h
	for qemu-devel@nongnu.org; Sun, 03 Jun 2018 12:10:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53282 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fPVa5-0006Tf-Sg
	for qemu-devel@nongnu.org; Sun, 03 Jun 2018 12:10:09 -0400
Date: Sun, 3 Jun 2018 19:10:07 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180603190821-mutt-send-email-mst@kernel.org>
References: <40602400-cae4-e175-e7ce-10ac70ba52f5@riseup.net>
	<20180601113444.GG8687@stefanha-x1.localdomain>
	<b25b3adb-bacc-bef1-7d18-c71a4933abc1@riseup.net>
	<20180601184855-mutt-send-email-mst@kernel.org>
	<1f4afbd1-e822-aa63-89a5-ba77c7110168@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f4afbd1-e822-aa63-89a5-ba77c7110168@riseup.net>
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

On Sat, Jun 02, 2018 at 03:08:54AM +0000, procmem wrote:
> 
> 
> Michael S. Tsirkin:
> > On Fri, Jun 01, 2018 at 01:15:44PM +0000, procmem wrote:
> >>
> >>
> >> Stefan Hajnoczi:
> >>> On Mon, May 21, 2018 at 11:24:43PM +0000, procmem wrote:
> >>>> Hi I'm a privacy distro maintainer investigating the implications of the
> >>>> newly published nethammer attack [0] on KVM guests particularly the
> >>>> virtio-net drivers. The summary of the paper is that rowhammer can be
> >>>> remotely triggered by feeding susceptible* network driver crafted
> >>>> traffic. This attack can do all kinds of nasty things such as modifying
> >>>> SSL certs on the victim system.
> >>>>
> >>>> * Susceptible drivers are those relying on Intel CAT, uncached memory or
> >>>> the clflush instruction.
> >>>>
> >>>> My question is, do virtio-net drivers do any of these things?
> >>> I have CCed Michael Tsirkin and Jason Wang, the virtio maintainers.
> >>>
> >>>> ***
> >>>>
> >>>> [0] https://arxiv.org/abs/1805.04956
> >>>>
> >>>>
> >>>>
> >>
> >> Thanks :) I thought my message was forgotten
> > 
> > 
> > I don't think virtio is using either of these.
> > 
> > Linux does support CAT AFAIK but it has nothing to do with virtio.
> > 
> 
> Thanks for confirming. This is good news indeed. I am considering
> posting about this to kernel-hardening so it's on the sec team's radar
> when considering upstream network drivers. What do you think?

It's up to you but the usefulness of reposting like that will be limited IMHO,
unless you have something specific to add.

I think everyone saw the nethammer paper by now, and kernel hardening
team doesn't review network driver patches.

-- 
MST
