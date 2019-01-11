Received: from eggs.gnu.org ([209.51.188.92]:37254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ghwne-000776-1v
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 08:24:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ghwnc-0003Ci-6T
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 08:24:38 -0500
Date: Fri, 11 Jan 2019 14:24:16 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190111132416.GI5010@dhcp-200-186.str.redhat.com>
References: <20190109110144.18633-1-stefanha@redhat.com>
	<w51pnt57slp.fsf@maestria.local.igalia.com>
	<w51tvifqqlr.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <w51tvifqqlr.fsf@maestria.local.igalia.com>
Subject: Re: [Qemu-devel] [PATCH] throttle-groups: fix restart coroutine
 iothread race
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

Am 11.01.2019 um 14:19 hat Alberto Garcia geschrieben:
> On Wed 09 Jan 2019 04:34:10 PM CET, Alberto Garcia wrote:
> > On Wed 09 Jan 2019 12:01:44 PM CET, Stefan Hajnoczi wrote:
> >> The following QMP command leads to a crash when iothreads are used:
> >>
> >>   { 'execute': 'device_del', 'arguments': {'id': 'data'} }
> >
> > How did you reproduce this? Do you have a test case?
> 
> Ok, I finally reproduced it, the patch looks good to me.

Can it be turned into a qemu-iotests case or is it too complicated for
that?

Kevin
