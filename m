Received: from eggs.gnu.org ([2001:4830:134:3::10]:51561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1f3jIn-0004AD-Tp
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 10:22:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1f3jIk-0007p3-DJ
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 10:22:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39892 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1f3jIk-0007oS-97
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 10:22:14 -0400
Date: Wed, 4 Apr 2018 17:22:07 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180404172155-mutt-send-email-mst@kernel.org>
References: <20180328133435.20112-1-linzhecheng@huawei.com>
	<20180404095322.GK4467@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180404095322.GK4467@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH v2] virtio-serial: fix heap-over-flow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, amit.shah@redhat.com, wangxinxin.wang@huawei.com, linzhecheng <linzhecheng@huawei.com>

On Wed, Apr 04, 2018 at 10:53:22AM +0100, Stefan Hajnoczi wrote:
> On Wed, Mar 28, 2018 at 09:34:35PM +0800, linzhecheng wrote:
> > Check device having the feature of VIRTIO_CONSOLE_F_EMERG_WRITE before
> > get config->emerg_wr. It is neccessary because sizeof(virtio_console_config)
> > is 8 byte if VirtIOSerial doesn't have the feature of
> > VIRTIO_CONSOLE_F_EMERG_WRITE(see virtio_serial_device_realize),
> > read/write emerg_wr will lead to heap-over-flow.
> > 
> > Signed-off-by: linzhecheng <linzhecheng@huawei.com>
> 
> Michael or Paolo: Please merge for QEMU 2.12
> 
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>


Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

Will merge.
