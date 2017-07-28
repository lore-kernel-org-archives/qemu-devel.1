Received: from eggs.gnu.org ([2001:4830:134:3::10]:36530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dbEzo-0005aP-Ic
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 19:48:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dbEzl-0000CM-Vg
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 19:48:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59922)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dbEzl-0000Bt-PH
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 19:48:37 -0400
Date: Sat, 29 Jul 2017 02:48:33 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170729024712-mutt-send-email-mst@kernel.org>
References: <20170719004721-mutt-send-email-mst@kernel.org>
	<20170719105549.GB3500@work-vm>
	<20170725165915-mutt-send-email-mst@kernel.org>
	<20170728180255.GF2560@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170728180255.GF2560@work-vm>
Subject: Re: [Qemu-devel] host side todo list for virtio rdma
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, linux-rdma@vger.kernel.org, qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.a@redhat.com>

On Fri, Jul 28, 2017 at 07:02:55PM +0100, Dr. David Alan Gilbert wrote:
> OK, does it seem silly for a message to go all the way to the host
> kernel to then have to go back down to QEMU to be turned back into verbs
> to go back upto the host kernel?

This is how most IO works except vhost.  If it's not a data path
there's no need to write code to avoid some context switches IMHO.

-- 
MST
