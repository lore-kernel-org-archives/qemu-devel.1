Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF7AC432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 17:21:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5868A20718
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 17:21:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5868A20718
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVInq-0003zN-8h
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 12:21:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56792)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iVIm4-0002cP-EC
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 12:19:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iVIm1-0005A4-1r
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 12:19:15 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40376
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
 id 1iVIm0-0004PC-7T
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 12:19:12 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 xAEGpf5Q022953; Thu, 14 Nov 2019 12:18:00 -0500
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2w99d450b9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 14 Nov 2019 12:17:59 -0500
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id xAEGwoYR042729;
 Thu, 14 Nov 2019 12:17:59 -0500
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.11])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2w99d450ap-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 14 Nov 2019 12:17:59 -0500
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
 by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xAEHAv9n029717;
 Thu, 14 Nov 2019 17:17:58 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by ppma03dal.us.ibm.com with ESMTP id 2w5n37809x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 14 Nov 2019 17:17:58 +0000
Received: from b03ledav005.gho.boulder.ibm.com
 (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xAEHHvIC55378262
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Nov 2019 17:17:57 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 568D4BE053;
 Thu, 14 Nov 2019 17:17:57 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 131D8BE04F;
 Thu, 14 Nov 2019 17:17:56 +0000 (GMT)
Received: from localhost (unknown [9.53.179.218])
 by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
 Thu, 14 Nov 2019 17:17:56 +0000 (GMT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20191114041049-mutt-send-email-mst@kernel.org>
References: <20191113054301.31529-1-mdroth@linux.vnet.ibm.com>
 <20191113050402-mutt-send-email-mst@kernel.org>
 <157369365636.3335.3099930975683371802@sif>
 <20191114034532-mutt-send-email-mst@kernel.org>
 <20191114041049-mutt-send-email-mst@kernel.org>
Message-ID: <157375187402.3335.9181283576251818887@sif>
User-Agent: alot/0.7
Subject: Re: [PATCH RFC] virtio-pci: disable vring processing when
 bus-mastering is disabled
Date: Thu, 14 Nov 2019 11:17:54 -0600
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-11-14_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=8 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1910280000 definitions=main-1911140150
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.158.5
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Quoting Michael S. Tsirkin (2019-11-14 03:12:00)
> On Thu, Nov 14, 2019 at 04:10:36AM -0500, Michael S. Tsirkin wrote:
> > On Wed, Nov 13, 2019 at 07:07:36PM -0600, Michael Roth wrote:
> > > Quoting Michael S. Tsirkin (2019-11-13 04:09:02)
> > > > On Tue, Nov 12, 2019 at 11:43:01PM -0600, Michael Roth wrote:
> > > > > Currently the SLOF firmware for pseries guests will disable/re-en=
able
> > > > > a PCI device multiple times via IO/MEM/MASTER bits of PCI_COMMAND
> > > > > register after the initial probe/feature negotiation, as it tends=
 to
> > > > > work with a single device at a time at various stages like probing
> > > > > and running block/network bootloaders without doing a full reset
> > > > > in-between.
> > > > > =

> > > > > In QEMU, when PCI_COMMAND_MASTER is disabled we disable the
> > > > > corresponding IOMMU memory region, so DMA accesses (including to =
vring
> > > > > fields like idx/flags) will no longer undergo the necessary
> > > > > translation. Normally we wouldn't expect this to happen since it =
would
> > > > > be misbehavior on the driver side to continue driving DMA request=
s.
> > > > > =

> > > > > However, in the case of pseries, with iommu_platform=3Don, we tri=
gger the
> > > > > following sequence when tearing down the virtio-blk dataplane ioe=
ventfd
> > > > > in response to the guest unsetting PCI_COMMAND_MASTER:
> > > > > =

> > > > >   #2  0x0000555555922651 in virtqueue_map_desc (vdev=3Dvdev@entry=
=3D0x555556dbcfb0, p_num_sg=3Dp_num_sg@entry=3D0x7fffe657e1a8, addr=3Daddr@=
entry=3D0x7fffe657e240, iov=3Diov@entry=3D0x7fffe6580240, max_num_sg=3Dmax_=
num_sg@entry=3D1024, is_write=3Dis_write@entry=3Dfalse, pa=3D0, sz=3D0)
> > > > >       at /home/mdroth/w/qemu.git/hw/virtio/virtio.c:757
> > > > >   #3  0x0000555555922a89 in virtqueue_pop (vq=3Dvq@entry=3D0x5555=
56dc8660, sz=3Dsz@entry=3D184)
> > > > >       at /home/mdroth/w/qemu.git/hw/virtio/virtio.c:950
> > > > >   #4  0x00005555558d3eca in virtio_blk_get_request (vq=3D0x555556=
dc8660, s=3D0x555556dbcfb0)
> > > > >       at /home/mdroth/w/qemu.git/hw/block/virtio-blk.c:255
> > > > >   #5  0x00005555558d3eca in virtio_blk_handle_vq (s=3D0x555556dbc=
fb0, vq=3D0x555556dc8660)
> > > > >       at /home/mdroth/w/qemu.git/hw/block/virtio-blk.c:776
> > > > >   #6  0x000055555591dd66 in virtio_queue_notify_aio_vq (vq=3Dvq@e=
ntry=3D0x555556dc8660)
> > > > >       at /home/mdroth/w/qemu.git/hw/virtio/virtio.c:1550
> > > > >   #7  0x000055555591ecef in virtio_queue_notify_aio_vq (vq=3D0x55=
5556dc8660)
> > > > >       at /home/mdroth/w/qemu.git/hw/virtio/virtio.c:1546
> > > > >   #8  0x000055555591ecef in virtio_queue_host_notifier_aio_poll (=
opaque=3D0x555556dc86c8)
> > > > >       at /home/mdroth/w/qemu.git/hw/virtio/virtio.c:2527
> > > > >   #9  0x0000555555d02164 in run_poll_handlers_once (ctx=3Dctx@ent=
ry=3D0x55555688bfc0, timeout=3Dtimeout@entry=3D0x7fffe65844a8)
> > > > >       at /home/mdroth/w/qemu.git/util/aio-posix.c:520
> > > > >   #10 0x0000555555d02d1b in try_poll_mode (timeout=3D0x7fffe65844=
a8, ctx=3D0x55555688bfc0)
> > > > >       at /home/mdroth/w/qemu.git/util/aio-posix.c:607
> > > > >   #11 0x0000555555d02d1b in aio_poll (ctx=3Dctx@entry=3D0x5555568=
8bfc0, blocking=3Dblocking@entry=3Dtrue)
> > > > >       at /home/mdroth/w/qemu.git/util/aio-posix.c:639
> > > > >   #12 0x0000555555d0004d in aio_wait_bh_oneshot (ctx=3D0x55555688=
bfc0, cb=3Dcb@entry=3D0x5555558d5130 <virtio_blk_data_plane_stop_bh>, opaqu=
e=3Dopaque@entry=3D0x555556de86f0)
> > > > >       at /home/mdroth/w/qemu.git/util/aio-wait.c:71
> > > > >   #13 0x00005555558d59bf in virtio_blk_data_plane_stop (vdev=3D<o=
ptimized out>)
> > > > >       at /home/mdroth/w/qemu.git/hw/block/dataplane/virtio-blk.c:=
288
> > > > >   #14 0x0000555555b906a1 in virtio_bus_stop_ioeventfd (bus=3Dbus@=
entry=3D0x555556dbcf38)
> > > > >       at /home/mdroth/w/qemu.git/hw/virtio/virtio-bus.c:245
> > > > >   #15 0x0000555555b90dbb in virtio_bus_stop_ioeventfd (bus=3Dbus@=
entry=3D0x555556dbcf38)
> > > > >       at /home/mdroth/w/qemu.git/hw/virtio/virtio-bus.c:237
> > > > >   #16 0x0000555555b92a8e in virtio_pci_stop_ioeventfd (proxy=3D0x=
555556db4e40)
> > > > >       at /home/mdroth/w/qemu.git/hw/virtio/virtio-pci.c:292
> > > > >   #17 0x0000555555b92a8e in virtio_write_config (pci_dev=3D0x5555=
56db4e40, address=3D<optimized out>, val=3D1048832, len=3D<optimized out>)
> > > > >       at /home/mdroth/w/qemu.git/hw/virtio/virtio-pci.c:613
> > > > > =

> > > > > I.e. the calling code is only scheduling a one-shot BH for
> > > > > virtio_blk_data_plane_stop_bh, but somehow we end up trying to pr=
ocess
> > > > > an additional virtqueue entry before we get there. This is likely=
 due
> > > > > to the following check in virtio_queue_host_notifier_aio_poll:
> > > > > =

> > > > >   static bool virtio_queue_host_notifier_aio_poll(void *opaque)
> > > > >   {
> > > > >       EventNotifier *n =3D opaque;
> > > > >       VirtQueue *vq =3D container_of(n, VirtQueue, host_notifier);
> > > > >       bool progress;
> > > > > =

> > > > >       if (!vq->vring.desc || virtio_queue_empty(vq)) {
> > > > >           return false;
> > > > >       }
> > > > > =

> > > > >       progress =3D virtio_queue_notify_aio_vq(vq);
> > > > > =

> > > > > namely the call to virtio_queue_empty(). In this case, since no n=
ew
> > > > > requests have actually been issued, shadow_avail_idx =3D=3D last_=
avail_idx,
> > > > > so we actually try to access the vring via vring_avail_idx() to g=
et
> > > > > the latest non-shadowed idx:
> > > > > =

> > > > >   int virtio_queue_empty(VirtQueue *vq)
> > > > >   {
> > > > >       bool empty;
> > > > >       ...
> > > > > =

> > > > >       if (vq->shadow_avail_idx !=3D vq->last_avail_idx) {
> > > > >           return 0;
> > > > >       }
> > > > > =

> > > > >       rcu_read_lock();
> > > > >       empty =3D vring_avail_idx(vq) =3D=3D vq->last_avail_idx;
> > > > >       rcu_read_unlock();
> > > > >       return empty;
> > > > > =

> > > > > but since the IOMMU region has been disabled we get a bogus value=
 (0
> > > > > usually), which causes virtio_queue_empty() to falsely report that
> > > > > there are entries to be processed, which causes errors such as:
> > > > > =

> > > > >   "virtio: zero sized buffers are not allowed"
> > > > > =

> > > > > or
> > > > > =

> > > > >   "virtio-blk missing headers"
> > > > > =

> > > > > and puts the device in an error state.
> > > > > =

> > > > > This patch works around the issue by introducing virtio_set_disab=
led(),
> > > > > which piggy-backs off the vdev->broken flag we already use to byp=
ass
> > > > > checks like virtio_queue_empty(), and sets/unsets it in response =
to
> > > > > enabling/disabling bus-mastering.
> > > > > =

> > > > > NOTES:
> > > > > =

> > > > >  - It's possible we could also work around this in SLOF by doing a
> > > > >    full reset instead of relying on PCI_COMMAND to enable/disable=
, but
> > > > >    in any case the QEMU behavior seems wrong.
> > > > >  - This leaves some other oddities in play, like the fact that
> > > > >    DRIVER_OK also gets unset in response to bus-mastering being
> > > > >    disabled, but not restored (however the device seems to contin=
ue
> > > > >    working)
> > > > >  - Similarly, we disable the host notifier via
> > > > >    virtio_bus_stop_ioeventfd(), which seems to move the handling =
out
> > > > >    of virtio-blk dataplane and back into the main IO thread, and =
it
> > > > >    ends up staying there till a reset (but otherwise continues wo=
rking
> > > > >    normally)
> > > > > =

> > > > > Cc: David Gibson <david@gibson.dropbear.id.au>,
> > > > > Cc: Alexey Kardashevskiy <aik@ozlabs.ru>
> > > > > Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > > > > Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> > > > > ---
> > > > >  hw/virtio/virtio-pci.c     | 12 ++++++++----
> > > > >  hw/virtio/virtio.c         |  7 ++++++-
> > > > >  include/hw/virtio/virtio.h |  1 +
> > > > >  3 files changed, 15 insertions(+), 5 deletions(-)
> > > > > =

> > > > > diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> > > > > index c6b47a9c73..394d409fb9 100644
> > > > > --- a/hw/virtio/virtio-pci.c
> > > > > +++ b/hw/virtio/virtio-pci.c
> > > > > @@ -608,10 +608,14 @@ static void virtio_write_config(PCIDevice *=
pci_dev, uint32_t address,
> > > > >          pcie_cap_flr_write_config(pci_dev, address, val, len);
> > > > >      }
> > > > >  =

> > > > > -    if (range_covers_byte(address, len, PCI_COMMAND) &&
> > > > > -        !(pci_dev->config[PCI_COMMAND] & PCI_COMMAND_MASTER)) {
> > > > > -        virtio_pci_stop_ioeventfd(proxy);
> > > > > -        virtio_set_status(vdev, vdev->status & ~VIRTIO_CONFIG_S_=
DRIVER_OK);
> > > > > +    if (range_covers_byte(address, len, PCI_COMMAND)) {
> > > > > +        if (!(pci_dev->config[PCI_COMMAND] & PCI_COMMAND_MASTER)=
) {
> > > > > +            virtio_set_disabled(vdev, true);
> > > > > +            virtio_pci_stop_ioeventfd(proxy);
> > > > > +            virtio_set_status(vdev, vdev->status & ~VIRTIO_CONFI=
G_S_DRIVER_OK);
> > > > > +        } else {
> > > > > +            virtio_set_disabled(vdev, false);
> > > > > +        }
> > > > >      }
> > > > >  =

> > > > >      if (proxy->config_cap &&
> > > > > diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> > > > > index 527df03bfd..46580c357d 100644
> > > > > --- a/hw/virtio/virtio.c
> > > > > +++ b/hw/virtio/virtio.c
> > > > > @@ -2575,6 +2575,11 @@ void virtio_device_set_child_bus_name(Virt=
IODevice *vdev, char *bus_name)
> > > > >      vdev->bus_name =3D g_strdup(bus_name);
> > > > >  }
> > > > >  =

> > > > > +void virtio_set_disabled(VirtIODevice *vdev, bool disable)
> > > > > +{
> > > > > +    vdev->broken =3D disable;
> > > > > +}
> > > > > +
> > > > >  void GCC_FMT_ATTR(2, 3) virtio_error(VirtIODevice *vdev, const c=
har *fmt, ...)
> > > > >  {
> > > > >      va_list ap;
> > > > =

> > > > Hmm. I think just clear and immediate set of bus master while devic=
e was
> > > > not doing any DMA actually should be fine and should not require a
> > > > reset.  Now it's true that right now guests reset first thing which=
 will
> > > > clear the broken flag, but I'd say it's wrong to require this speci=
fic
> > > > order.
> > > > I think the easiest thing is to add a "disabled" flag.
> > > =

> > > Agreed. Some comments on that below.
> > > =

> > > > =

> > > > =

> > > > > @@ -2588,7 +2593,7 @@ void GCC_FMT_ATTR(2, 3) virtio_error(VirtIO=
Device *vdev, const char *fmt, ...)
> > > > >          virtio_notify_config(vdev);
> > > > >      }
> > > > >  =

> > > > > -    vdev->broken =3D true;
> > > > > +    virtio_set_disabled(vdev, true);
> > > > >  }
> > > > >  =

> > > > >  static void virtio_memory_listener_commit(MemoryListener *listen=
er)
> > > > > diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virti=
o.h
> > > > > index 48e8d04ff6..921945b7e8 100644
> > > > > --- a/include/hw/virtio/virtio.h
> > > > > +++ b/include/hw/virtio/virtio.h
> > > > > @@ -168,6 +168,7 @@ void virtio_init(VirtIODevice *vdev, const ch=
ar *name,
> > > > >                           uint16_t device_id, size_t config_size);
> > > > >  void virtio_cleanup(VirtIODevice *vdev);
> > > > >  =

> > > > > +void virtio_set_disabled(VirtIODevice *vdev, bool disable);
> > > > >  void virtio_error(VirtIODevice *vdev, const char *fmt, ...) GCC_=
FMT_ATTR(2, 3);
> > > > >  =

> > > > >  /* Set the child bus name. */
> > > > =

> > > > =

> > > > One open question here is cross version migration.
> > > > What exactly happens if we migrate to an old qemu?
> > > > from an old qemu?
> > > =

> > > Currently vdev->broken is already migrated via a subsection if it is =
set.
> > > =

> > > So, with the current proposed patch I would expect the following:
> > > =

> > >  old -> new:
> > >    dev->broken set due to proposed virtio_set_disabled():
> > >      - N/A
> > >    dev->broken set due to other/existing reasons:
> > >      - value is migrated, migration succeeds
> > >      - device continues not working until a reset, or bus-mastering
> > >        enabled/re-enabled. (which is good, but also makes me realize
> > >        that a device that was put into broken state for reasons
> > >        other than virtio_set_disabled() should not get 'unbroken'
> > >        simply because bus-master bit was cycled. a separate flag
> > >        is probably needed)
> > >      - PASS
> > >    dev->broken not set:
> > >      - not migrated
> > >      - PASS
> > >  new -> old:
> > >    dev->broken set due to proposed virtio_set_disabled():
> > >      - migration succeeds to any QEMU that already has handling for
> > >        dev->broken.
> > >      - migration fails for any QEMU that doesn't have handling for
> > >        dev->broken as it does now, but will a higher chance of
> > >        triggering
> > >      - device won't work until it is reset. for most guests we will
> > >        probably get a reset before the device is used again anyway. f=
or
> > >        the SLOF case the device will stay broken after bus-mastering
> > >        re-enabled, but that's the case for existing QEMU now anyway
> > >      - PASS, but with increased chance of migration breakage for
> > >        QEMU's that don't have handling for dev->broken.
> > >    dev->broken set due to other/existing reasons:
> > >      - migration succeeds to any QEMU that already has handling for
> > >        dev->broken. device will require a reset as it does now.
> > >      - migration fails for any QEMU that doesn't have handling for
> > >        dev->broken as it does now
> > >      - PASS
> > >    dev->broken not set:
> > >      - not migrated
> > >      - PASS
> > > =

> > > With a new dev->disabled flag, which we'd likely send using a subsect=
ion
> > > like with dev->broken, I would expect the following:
> > > =

> > >  old -> new:
> > >    dev->disabled set:
> > >      - N/A
> > >    dev->disabled not set:
> > >      - not migrated
> > >      - if source disables BM just before migration we will likely go
> > >        into an error state that either sets dev->broken or puts the
> > >        device in some other possibly bad state. either case would req=
uire
> > >        subsequent reset, just as they would without migration
> > >      - PASS
> > >  new -> old:
> > >    dev->disabled set:
> > >      - migration stream fails
> > >      - FAIL, but as expected, and doesn't seem common currently outsi=
de
> > >        of SLOF early-boot else we'd probably have more reports of
> > >        breakage from vring access while BM isn't set.
> > >    dev->broken not set:
> > >      - not migrated
> > >      - PASS
> > > =

> > > So re-using 'broken' is slightly better from a migration standpoint, =
but
> > > as noted above it is probably wrong to unset 'broken' just because BM=
 bit
> > > gets cycled, so a new 'disabled' flag is probably needed.
> > > =

> > > We could probably get by with just adding a check for dev->disabled i=
n =

> > > virtio_queue_empty(), or even earlier in
> > > virtio_queue_host_notifier_aio_poll(), but it seems more proper to al=
so
> > > add it in most of the same places we currently check for dev->broken.
> > > =

> > > That seems somewhat redundant though, so I think maybe the best appro=
ach
> > > is to:
> > > =

> > >  - replace most dev->broken checks with checks for dev->disabled
> > =

> > I propose calling an inline functions so we are not tied to a specific
> > field.
> > =


Makes sense.

> > >  - set dev->disabled whenever dev->broken gets set
> > >  - add a check in virtio_set_disabled() that only allows us to re-ena=
ble if
> > >    dev->broken hasn't also been set.
> > > =

> > > I'll work on a follow-up using that approach if it seems reasonable to
> > > you.
> =

> =

> Also, since the new field is not migrated anyway, how about a flag
> that old machine types set, and behave the way we do now?

Hmm, you're right that in the above cases there's only one case where we
would migrate (new->old, when dev->disabled is set), and this would
break the migration stream anyway, so there's no reason to migrate. But I
forgot to include the more common case of new->new:

  new -> new:
    dev->disabled set:
      - migrated
      - PASS
    dev->disabled not set:
      - not migrated
      - PASS
    =

So I was planning on migrating it via subsection. But it does make sense
to only use it for newer machine types so we don't trigger the failure
for (new->old && dev->disabled =3D=3D true). Maybe that's what you were
suggesting in the first place?

I'll give that a shot.

> > > =

> > > Thanks!
> > > =

> > > > =

> > > > > -- =

> > > > > 2.17.1
> > > > =

>=20

