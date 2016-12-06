Received: from eggs.gnu.org ([2001:4830:134:3::10]:39206)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cEB6d-00030w-CA
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 03:28:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cEB6Z-0006va-F3
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 03:28:07 -0500
Received: from 7.mo4.mail-out.ovh.net ([178.33.253.54]:47182)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cEB6Z-0006rt-7y
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 03:28:03 -0500
Received: from player762.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 4E34E217F5
	for <qemu-devel@nongnu.org>; Tue,  6 Dec 2016 09:28:00 +0100 (CET)
Date: Tue, 6 Dec 2016 09:27:49 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20161206092749.01a55bca@bahia>
In-Reply-To: <20161205170128.533850e5.cornelia.huck@de.ibm.com>
References: <148095126363.31351.4484514300033863622.stgit@bahia>
	<20161205164200.49bec0f6.cornelia.huck@de.ibm.com>
	<20161205170128.533850e5.cornelia.huck@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.8] qdev: apply global properties in
 reverse order
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cornelia.huck@de.ibm.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-stable@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Mon, 5 Dec 2016 17:01:28 +0100
Cornelia Huck <cornelia.huck@de.ibm.com> wrote:

> On Mon, 5 Dec 2016 16:42:00 +0100
> Cornelia Huck <cornelia.huck@de.ibm.com> wrote:
> 
> > On Mon, 05 Dec 2016 16:21:22 +0100
> > Greg Kurz <groug@kaod.org> wrote:  
> 
> > > AFAIK, libvirt's XML doesn't know about modern/legacy modes for virtio
> > > devices. Early adopters of virtio 1.0 had to rely on the <qemu:commandline>
> > > tag to pass global properties to QEMU. This patch ensures that XML files
> > > used with older machine types remain valid with newer versions of QEMU.  
> 
> I recall some libvirt patches floating around for this legacy/modern
> stuff, but I don't know their status.
> 

libvirt does some probing of disable-legacy but I could find nothing that
allows a user to explicitly choose between legacy or modern.

> > > 
> > > FWIW I guess it could help to have this fix in 2.8, and also probably in
> > > 2.7.1.  
> > 
> > ...but I'm a bit worried about doing that change this late in the
> > cycle, as we may introduce subtle changes for other configurations. At
> > the very least, we should look over the existing backwards compat
> > properties (I'll look at those I'm familiar with).  
> 
> The s390x properties seem safe.
> 
> For virtio-pci, the ability to override extra state might become
> problematic for modern devices. Although manually setting this property
> is probably a patholotical case...
> 

I agree that migrating a 2.6 machine type with disable-modern=off being
set through -global for a given subtype, from QEMU 2.6 to QEMU 2.8 (or 2.7)
is probably a corner case :)
