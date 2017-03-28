Received: from eggs.gnu.org ([2001:4830:134:3::10]:58742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1csmQc-0005ql-92
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 04:24:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1csmQY-000541-Bb
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 04:24:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52631
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1csmQY-00053o-4c
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 04:24:30 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2S8NtcA093592
	for <qemu-devel@nongnu.org>; Tue, 28 Mar 2017 04:24:29 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0b-001b2d01.pphosted.com with ESMTP id 29fm690afg-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 28 Mar 2017 04:24:29 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Tue, 28 Mar 2017 09:24:27 +0100
Date: Tue, 28 Mar 2017 10:24:21 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <20170328101409.1aa23618@bahia.lan>
References: <149063674781.4447.14258971700726134711.stgit@bahia.lan>
	<149063676337.4447.2095575576822297032.stgit@bahia.lan>
	<20170327211728-mutt-send-email-mst@kernel.org>
	<20170328101409.1aa23618@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20170328102421.2f4fbeec.cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 1/5] virtio: Error object based
 virtio_error()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>

On Tue, 28 Mar 2017 10:14:09 +0200
Greg Kurz <groug@kaod.org> wrote:

> On Mon, 27 Mar 2017 21:20:56 +0300
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Mon, Mar 27, 2017 at 07:46:03PM +0200, Greg Kurz wrote:
> > > This introduces an Error object based implementation of virtio_error(). It
> > > allows to implement virtio_error() wrappers in device-specific code.
> > > 
> > > Signed-off-by: Greg Kurz <groug@kaod.org>
> > > ---
> > >  hw/virtio/virtio.c         |   21 ++++++++++++++++-----
> > >  include/hw/virtio/virtio.h |    1 +
> > >  2 files changed, 17 insertions(+), 5 deletions(-)
> > > 

> > Also, whether to stop the device, or the VM, or just warn,
> > seems like a policy decision. Why not set it on command line
> > like we do for other storage?
> > 
> 
> Huh? This patch simply introduces a new API to a feature that underwent
> several rounds of discussion and reached a reasonable consensus (even
> your R-b).
> 
> I'm not sure this 9pfs series is the right place to talk about all the
> behavior changes you're suggesting for virtio_error()... I'd rather
> drop this patch and duplicate code in virtio-9p instead if I want the
> fixes to go to 2.9.

I agree that we should discuss this outside of this patch series. It's
not like it is introducing a new error case.

> 
> Cc'ing Connie and Stefanha for insights.

See my reply to Michael's mail.
