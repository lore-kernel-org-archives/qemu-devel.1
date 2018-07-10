Received: from eggs.gnu.org ([2001:4830:134:3::10]:55613)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fci2A-0005N7-2b
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 22:05:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fci26-0002Df-Vg
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 22:05:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45064 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fci26-0002Cy-RH
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 22:05:38 -0400
Date: Tue, 10 Jul 2018 05:05:37 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180710045848-mutt-send-email-mst@kernel.org>
References: <20180629221907.3662-1-venu.busireddy@oracle.com>
	<20180702161404.GA2339@rkaganb.sw.ru>
	<449f1449-ddf6-cd95-976c-14d04d8d503a@oracle.com>
	<20180703095825.GC30904@rkaganb.sw.ru>
	<d5db37d0-5eaf-8942-8ab7-d73057a67e6f@oracle.com>
	<20180709130035.GA6271@rkaganb.sw.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180709130035.GA6271@rkaganb.sw.ru>
Subject: Re: [Qemu-devel] [PATCH v3 0/3] Use of unique identifier for
 pairing virtio and passthrough devices...
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Kagan <rkagan@virtuozzo.com>, si-wei liu <si-wei.liu@oracle.com>, Venu Busireddy <venu.busireddy@oracle.com>, Marcel Apfelbaum <marcel@redhat.com>, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org

On Mon, Jul 09, 2018 at 04:00:36PM +0300, Roman Kagan wrote:
> There are a few things that need to be specific for PT and/or PV
> transport, the matching identifier among them, but I guess a lot can
> still be in common.

Maybe but frankly unless someone actually plans to bother implementing
all this in QEMU's limited emulation of hyper-v on top of kvm, I don't
see why would we care.

What I saw gives me the impression Hyper-V wants to just be
left alone as much as possible and maybe we should respect that.

-- 
MST
