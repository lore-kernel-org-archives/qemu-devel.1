Received: from eggs.gnu.org ([2001:4830:134:3::10]:59647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ehILh-0007KV-Nx
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 12:08:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ehILc-0005Dt-4x
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 12:08:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56116)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ehILb-0005DF-V9
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 12:08:28 -0500
Date: Thu, 1 Feb 2018 19:08:15 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180201190712-mutt-send-email-mst@kernel.org>
References: <20180119130653.24044-1-stefanha@redhat.com>
	<5A65C652.6080307@intel.com>
	<20180123111238.GC6565@stefanha-x1.localdomain>
	<5A673369.6050408@intel.com>
	<20180124114055.GC17193@stefanha-x1.localdomain>
	<5A69AF21.5000209@intel.com>
	<20180126144429.GD17788@stefanha-x1.localdomain>
	<5A70606F.3030307@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5A70606F.3030307@intel.com>
Subject: Re: [Qemu-devel] [RFC 0/2] virtio-vhost-user: add virtio-vhost-user
 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Wang <wei.w.wang@intel.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, zhiyong.yang@intel.com, Maxime Coquelin <maxime.coquelin@redhat.com>, jasowang@redhat.com

On Tue, Jan 30, 2018 at 08:09:19PM +0800, Wei Wang wrote:
> Issues:
> Suppose we have both the vhost and virtio-net set up, and vhost pmd <->
> virtio-net pmd communication works well. Now, vhost pmd exits (virtio-net
> pmd is still there). Some time later, we re-run vhost pmd, the vhost pmd
> doesn't know the virtqueue addresses of the virtio-net pmd, unless the
> virtio-net pmd reloads to start the 2nd phase of the vhost-user protocol. So
> the second run of the vhost pmd won't work.
> 
> Any thoughts?
> 
> Best,
> Wei

So vhost in qemu must resend all configuration on reconnect.
Does this address the issues?

-- 
MST
