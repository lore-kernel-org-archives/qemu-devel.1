Received: from eggs.gnu.org ([2001:4830:134:3::10]:33926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cDvi5-00059R-4V
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 11:01:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cDvhz-00067s-II
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 11:01:45 -0500
Received: from 001b2d01.pphosted.com ([148.163.156.1]:33268
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cDvhz-00067Y-8q
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 11:01:39 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uB5G0l32127376
	for <qemu-devel@nongnu.org>; Mon, 5 Dec 2016 11:01:38 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2758u5tbt1-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 05 Dec 2016 11:01:37 -0500
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Mon, 5 Dec 2016 16:01:35 -0000
Date: Mon, 5 Dec 2016 17:01:28 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <20161205164200.49bec0f6.cornelia.huck@de.ibm.com>
References: <148095126363.31351.4484514300033863622.stgit@bahia>
	<20161205164200.49bec0f6.cornelia.huck@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20161205170128.533850e5.cornelia.huck@de.ibm.com>
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
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-stable@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Mon, 5 Dec 2016 16:42:00 +0100
Cornelia Huck <cornelia.huck@de.ibm.com> wrote:

> On Mon, 05 Dec 2016 16:21:22 +0100
> Greg Kurz <groug@kaod.org> wrote:

> > AFAIK, libvirt's XML doesn't know about modern/legacy modes for virtio
> > devices. Early adopters of virtio 1.0 had to rely on the <qemu:commandline>
> > tag to pass global properties to QEMU. This patch ensures that XML files
> > used with older machine types remain valid with newer versions of QEMU.

I recall some libvirt patches floating around for this legacy/modern
stuff, but I don't know their status.

> > 
> > FWIW I guess it could help to have this fix in 2.8, and also probably in
> > 2.7.1.
> 
> ...but I'm a bit worried about doing that change this late in the
> cycle, as we may introduce subtle changes for other configurations. At
> the very least, we should look over the existing backwards compat
> properties (I'll look at those I'm familiar with).

The s390x properties seem safe.

For virtio-pci, the ability to override extra state might become
problematic for modern devices. Although manually setting this property
is probably a patholotical case...
