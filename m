Received: from eggs.gnu.org ([2001:4830:134:3::10]:38933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fWTq6-0004ft-1w
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 17:43:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fWTq2-0001Cl-T4
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 17:43:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53794 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fWTq2-0001Cd-Nm
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 17:43:26 -0400
Date: Sat, 23 Jun 2018 00:43:24 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180623003545-mutt-send-email-mst@kernel.org>
References: <CADGSJ208NRp=bjhSkzF2K5Ft94TwdRs73WfSp4h-_vXvEKwgiQ@mail.gmail.com>
	<20180619125453.2d2dfb2d.cohuck@redhat.com>
	<20180619233001-mutt-send-email-mst@kernel.org>
	<20180620115359.1a3bf6fb.cohuck@redhat.com>
	<20180620170904-mutt-send-email-mst@kernel.org>
	<20180620180619.6b4ee52d.cohuck@redhat.com>
	<20180620224535-mutt-send-email-mst@kernel.org>
	<20180621165913.7e3f4faa.cohuck@redhat.com>
	<20180621211712-mutt-send-email-mst@kernel.org>
	<20180622170955.298900c1.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180622170955.298900c1.cohuck@redhat.com>
Subject: Re: [Qemu-devel] [virtio-dev] Re: [PATCH] qemu: Introduce
 VIRTIO_NET_F_STANDBY feature bit to virtio_net
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Siwei Liu <loseweigh@gmail.com>, "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, Alexander Duyck <alexander.h.duyck@intel.com>, virtio-dev@lists.oasis-open.org, aaron.f.brown@intel.com, Jiri Pirko <jiri@resnulli.us>, Jakub Kicinski <kubakici@wp.pl>, Netdev <netdev@vger.kernel.org>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, konrad.wilk@oracle.com, boris.ostrovsky@oracle.com, Joao Martins <joao.m.martins@oracle.com>, Venu Busireddy <venu.busireddy@oracle.com>, vijay.balakrishna@oracle.com

On Fri, Jun 22, 2018 at 05:09:55PM +0200, Cornelia Huck wrote:
> Would it be more helpful to focus on generic
> migration support for vfio instead of going about it device by device?

Just to note this approach is actually device by device *type*.  It's
mostly device agnostic for a given device type so you can migrate
between hosts with very different hardware.

And support for more PV device types has other advantages
such as security and forward compatibility to future hosts.

Finally, it all can happen mostly within QEMU. User is currently
required to enable it but it's pretty lightweight.

OTOH vfio migration generally requires actual device-specific work, and
only works when hosts are mostly identical. When they aren't it's easy
to blame the user, but tools for checking host compatiblity are
currently non-existent. Upper layer management will also have to learn
about host and device compatibility wrt migration. At the moment they
can't even figure it out wrt software versions of vhost in kernel and
dpdk so I won't hold my breath for all of this happening quickly.


-- 
MST
