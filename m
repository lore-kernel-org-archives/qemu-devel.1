Received: from eggs.gnu.org ([2001:4830:134:3::10]:41148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gRgDZ-0006PQ-QE
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 11:28:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gRgDT-0003qA-Ui
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 11:28:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58880)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gRgDS-0003ow-Do
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 11:28:03 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9C71B308626B
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 16:28:01 +0000 (UTC)
Date: Tue, 27 Nov 2018 11:27:53 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181127112541-mutt-send-email-mst@kernel.org>
References: <1543238443-4993-1-git-send-email-pbonzini@redhat.com>
	<20181126173604-mutt-send-email-mst@kernel.org>
	<6cd98ced-a043-18c0-3aa5-4cda15c76ec5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6cd98ced-a043-18c0-3aa5-4cda15c76ec5@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/5] vhost: enable for all targets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org

On Tue, Nov 27, 2018 at 10:04:59AM +0100, Paolo Bonzini wrote:
> On 26/11/18 23:43, Michael S. Tsirkin wrote:
> > On Mon, Nov 26, 2018 at 02:20:38PM +0100, Paolo Bonzini wrote:
> >> vhost does not have to be supported only if KVM is present, in fact
> >> vhost-user does not even need any kind of kernel support.  This series
> >> changes this.  The rationale is that, when vhost-user-test.c will be
> >> converted to qgraph, it will be able to test vhost-user support
> >> for virtio-mmio backend even on x86.
> > 
> > The reason for limiting it to KVM was very simple:
> > it has the same set of problems with ordering
> > as mttcg.
> > 
> > So I guess it's fine but I think we must then limit it
> > to when tcg emits fence instructions.
> > 
> > Otherwise we'll get subtle race conditions.
> 
> Got it, I'll take a look.  However, right now you _can_ use vhost with
> tcg as long as e.g. qemu-system-x86_64 is compiled with KVM support, so
> this patch is not changing anything in this respect; the bug is
> independent of this series.
> 
> Paolo
> 

Well qemu built with KVM implies host architecture == guest
architecture, right? That should ensure race conditions do not happen in
a very hacky way.

-- 
MST
