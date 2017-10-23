Received: from eggs.gnu.org ([2001:4830:134:3::10]:53168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1e6gGY-0006g2-DI
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 13:11:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1e6gGU-0000q5-44
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 13:11:54 -0400
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:44017)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1e6gGT-0000pA-QV
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 13:11:50 -0400
Received: by mail-wm0-x230.google.com with SMTP id m72so9306197wmc.0
	for <qemu-devel@nongnu.org>; Mon, 23 Oct 2017 10:11:49 -0700 (PDT)
Date: Mon, 23 Oct 2017 19:11:46 +0200
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20171023171146.GB15029@stefanha-x1.localdomain>
References: <1508390650-19115-1-git-send-email-changpeng.liu@intel.com>
	<1508390650-19115-3-git-send-email-changpeng.liu@intel.com>
	<20171019151745.GH6205@stefanha-x1.localdomain>
	<FF7FC980937D6342B9D289F5F3C7C2625B5D8682@SHSMSX103.ccr.corp.intel.com>
	<20171020095435.GD21393@stefanha-x1.localdomain>
	<FF7FC980937D6342B9D289F5F3C7C2625B5D8EB6@SHSMSX103.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FF7FC980937D6342B9D289F5F3C7C2625B5D8EB6@SHSMSX103.ccr.corp.intel.com>
Subject: Re: [Qemu-devel] [PATCH v4 2/4] vhost-user-blk: introduce a new
 vhost-user-blk host device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Liu, Changpeng" <changpeng.liu@intel.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>, "felipe@nutanix.com" <felipe@nutanix.com>, "Harris, James R" <james.r.harris@intel.com>

On Mon, Oct 23, 2017 at 04:26:36AM +0000, Liu, Changpeng wrote:
> 
> 
> > -----Original Message-----
> > From: Stefan Hajnoczi [mailto:stefanha@gmail.com]
> > Sent: Friday, October 20, 2017 5:55 PM
> > To: Liu, Changpeng <changpeng.liu@intel.com>
> > Cc: qemu-devel@nongnu.org; pbonzini@redhat.com; mst@redhat.com;
> > marcandre.lureau@redhat.com; felipe@nutanix.com; Harris, James R
> > <james.r.harris@intel.com>
> > Subject: Re: [PATCH v4 2/4] vhost-user-blk: introduce a new vhost-user-blk host
> > device
> > 
> > On Fri, Oct 20, 2017 at 01:47:58AM +0000, Liu, Changpeng wrote:
> > > > > +static Property vhost_user_blk_properties[] = {
> > > > > +    DEFINE_PROP_CHR("chardev", VHostUserBlk, chardev),
> > > > > +    DEFINE_PROP_UINT16("num_queues", VHostUserBlk, num_queues, 1),
> > > > > +    DEFINE_PROP_UINT32("queue_size", VHostUserBlk, queue_size, 128),
> > > > > +    DEFINE_PROP_BIT64("f_size_max", VHostUserBlk, host_features,
> > > > > +                      VIRTIO_BLK_F_SIZE_MAX, true),
> > > > > +    DEFINE_PROP_BIT64("f_sizemax", VHostUserBlk, host_features,
> > > > > +                      VIRTIO_BLK_F_SIZE_MAX, true),
> > > > > +    DEFINE_PROP_BIT64("f_segmax", VHostUserBlk, host_features,
> > > > > +                      VIRTIO_BLK_F_SEG_MAX, true),
> > > > > +    DEFINE_PROP_BIT64("f_geometry", VHostUserBlk, host_features,
> > > > > +                      VIRTIO_BLK_F_GEOMETRY, true),
> > > > > +    DEFINE_PROP_BIT64("f_readonly", VHostUserBlk, host_features,
> > > > > +                      VIRTIO_BLK_F_RO, false),
> > > > > +    DEFINE_PROP_BIT64("f_blocksize", VHostUserBlk, host_features,
> > > > > +                      VIRTIO_BLK_F_BLK_SIZE, true),
> > > > > +    DEFINE_PROP_BIT64("f_topology", VHostUserBlk, host_features,
> > > > > +                      VIRTIO_BLK_F_TOPOLOGY, true),
> > > > > +    DEFINE_PROP_BIT64("f_multiqueue", VHostUserBlk, host_features,
> > > > > +                      VIRTIO_BLK_F_MQ, true),
> > > > > +    DEFINE_PROP_BIT64("f_flush", VHostUserBlk, host_features,
> > > > > +                      VIRTIO_BLK_F_FLUSH, true),
> > > > > +    DEFINE_PROP_BIT64("f_barrier", VHostUserBlk, host_features,
> > > > > +                      VIRTIO_BLK_F_BARRIER, false),
> > > > > +    DEFINE_PROP_BIT64("f_scsi", VHostUserBlk, host_features,
> > > > > +                      VIRTIO_BLK_F_SCSI, false),
> > > > > +    DEFINE_PROP_BIT64("f_wce", VHostUserBlk, host_features,
> > > > > +                      VIRTIO_BLK_F_WCE, false),
> > > >
> > > > Please explain how feature negotation works.  The vhost-user slave
> > > > advertises support features in the return value from
> > > > VHOST_USER_GET_FEATURES.  How does this additional feature mask work
> > and
> > > > why is it useful?
> > > According to Paolo's previous comments, VIRTIO_BLK_F_WCE/
> > VIRTIO_BLK_F_SCSI/ VIRTIO_BLK_F_BARRIER
> > > should be removed. Here I added all the feature flags just want to avoid the
> > case that vhost-user slave target
> > > can support but Qemu vhost block driver cannot support it.
> > 
> > Please explain a bit more how these options can be used.
> > 
> > When I looked at the vhost code it seemed like the vhost slave can
> > report any feature bits it wishes (even things QEMU doesn't know about).
> > What is the purpose of override some of the feature bits on the QEMU
> > command-line?
> Hi Stefan,
> Here I added a switch which can override vhost-slave's feature bits, for example, vhost-slave reported `VIRTIO_BLK_F_RO`,
> but Qemu vhost-master can disable it through command line when started the Qemu. Users don't need to change any
> vhost-slave's code to disable this feature, and this is also aligned with vhost-scsi and vhost-net's implementation.

You said vhost-master can disable features but the code doesn't seem to
work that way:

+    /* Turn on pre-defined features */
+    features |= s->host_features;

If the use case isn't clear please remove these properties for now.

Stefan
