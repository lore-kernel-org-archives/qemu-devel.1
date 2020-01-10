Return-Path: <SRS0=GavZ=27=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79757C47409
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 06:18:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FB372077B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 06:18:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FB372077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipncp-000671-Cx
	for qemu-devel@archiver.kernel.org; Fri, 10 Jan 2020 01:18:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48363)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yang.zhong@intel.com>) id 1ipncD-00050Q-3A
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 01:17:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yang.zhong@intel.com>) id 1ipncA-0002Vb-S2
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 01:17:48 -0500
Received: from mga04.intel.com ([192.55.52.120]:40621)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yang.zhong@intel.com>)
 id 1ipncA-0001lo-FG
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 01:17:46 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 09 Jan 2020 22:17:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,415,1571727600"; d="scan'208";a="254856283"
Received: from yangzhon-virtual.bj.intel.com (HELO localhost) ([10.238.145.50])
 by fmsmga002.fm.intel.com with ESMTP; 09 Jan 2020 22:17:35 -0800
Date: Fri, 10 Jan 2020 14:10:51 +0800
From: Yang Zhong <yang.zhong@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH] virtio: add the queue number check
Message-ID: <20200110061051.GA1626@yangzhon-Virtual>
References: <20191223082813.28930-1-yang.zhong@intel.com>
 <5cb6ace0-dd8e-aa22-e280-1e697c2c4156@redhat.com>
 <20191223091856.GA8433@yangzhon-Virtual>
 <e13a5fcc-b861-1847-58a8-e3d6445f84b0@redhat.com>
 <20191223092508-mutt-send-email-mst@kernel.org>
 <187f02d9-1677-d232-a44a-ed7b1e5f6ee5@redhat.com>
 <20200103150145.GA24552@yangzhon-Virtual>
 <CABgObfZWq_d-R_j456yxipPnbcLzCOJwd=9mCBMiwHDOckaXYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABgObfZWq_d-R_j456yxipPnbcLzCOJwd=9mCBMiwHDOckaXYg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.120
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
Cc: Yang Zhong <yang.zhong@intel.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On Fri, Jan 03, 2020 at 10:18:58PM +0100, Paolo Bonzini wrote:
> Il ven 3 gen 2020, 16:08 Yang Zhong <yang.zhong@intel.com> ha scritto:
> 
> >   I also tried virtio-blk device like below:
> >   https://patchwork.kernel.org/cover/10873193/
> >
> >   The virtio-blk can work with this changes, but vhost-user-blk device
> >   failed with this kernel patch.
> >
> >   in vhost_virtqueue_start() function, below operation to check if the
> >   desc addr set by guest kernel. This will ignore the extra vqs.
> >     a = virtio_queue_get_desc_addr(vdev, idx);
> >     if (a == 0) {
> >         /* Queue might not be ready for start */
> >         return 0;
> >     }
> >
> >   If guest kernel add min(cpu,num_vqs), do we need add same check in
> >   realize function of vhost-user-blk device?
> >
> 
> No. If virtio-blk works, the bug is in vhost-user-blk; if virtio-blk needs
> no check in cpu count, vhost-user-blk also doesn't.
> 
> You need to check first if the bug is in QEMU or the vhost-user-blk server.
> 
  Paolo and all,

  It seems i had root cause this issue, let me list what's i found. Any
  issue please correct me, thanks!

  I found there are 2 issues in DPDK and seabios by debugging this
  issue.

  (1). Seabios issue
  In init_virtio_blk() function, which set VIRTIO_CONFIG_S_DRIVER_OK
  status to qemu vhost-user-blk device.

  // the related code
  ......
  status |= VIRTIO_CONFIG_S_DRIVER_OK;
  vp_set_status(&vdrive->vp, status);
  ......

  I think there is no need for seabios to set VIRTIO_CONFIG_S_DRIVER_OK
  status to qemu vhost-user-blk device. In fact, this time, the guest
  virtio-blk module is not started. Once seabios set this DRIVER_OK
  status to qemu vhost user device, the vhost-user-blk will call
  vhost_user_blk_start().
  
  static void vhost_user_blk_set_status(VirtIODevice *vdev, uint8_t status)
  {
    VHostUserBlk *s = VHOST_USER_BLK(vdev);
    bool should_start = virtio_device_started(vdev, status);
    int ret;

    if (!vdev->vm_running) {
        should_start = false;
    }

    if (!s->connected) {
        return;
    }

    if (s->dev.started == should_start) {
        return;
    }

    if (should_start) {
        ret = vhost_user_blk_start(vdev);
        if (ret < 0) {
            error_report("vhost-user-blk: vhost start failed: %s",
                         strerror(-ret));
            qemu_chr_fe_disconnect(&s->chardev);
        }
    } else {
        vhost_user_blk_stop(vdev);
    }
    }

    In fact, this time vhost_user_blk_start almost do nothing because
    the real guest virtio-blk driver still not started yet. This time,
    there is only one vq can be used(this vq should be inited in seabios).

    When the guest virtio-blk driver really start and complet the
    probe(), the guest virtio-blk driver will set
    VIRTIO_CONFIG_S_DRIVER_OK to vhost-user-blk device again. This
    time, this driver will allocate RIGHT queue num according to
    MIN(vcpu, num_vqs).

    So, i think set VIRTIO_CONFIG_S_DRIVER_OK status should be removed from
    seabios, and guest driver should do this.

    I removed this status seting in the seabios, and test verified this.
    guest virtio-blk driver can be normally initialized by virtio-blk or
    vhost-user-blk device from qemu.

    (2). DPDK issue
     DPDK does not know the real queue number used by guest virtio-blk
     driver and it only know the queue number from vhost-user-blk
     commond line. Once the guest virtio-blk driver change the queue
     number according to MIN(vcpu, num_vqs), DPDK still use previous
     queue number and it think virtio is never ready by
     virtio_is_ready() function.

     There are two methods to fix this issue,

     one is add VHOST_USER_SET_QUEUE_NUM to vhost user protocol.
     vhost-user-blk device can call this to inform SPDK the real
     queue number. vhost-user-device can use below method to get
     the real queue number(to check if vring.desc is NON-NULL)
     for (i = 0; i < s->dev.nvqs; i++) {
        VirtQueue *kick_vq = virtio_get_queue(vdev, i);

        if (!virtio_queue_get_desc_addr(vdev, i)) {
            continue;
        }
     }
    
     Current vhost-user protocol only support GET_QUEUE_NUM(get max
     queue num), we can add SET_QUEUE_NUM.

     or DPDK can get the real queue number by checking if the vring.desc
     is NON-NULL.

     By the way, vhost SCSI device has the same issue with
     vhost-user-blk device. 

     Yang

> Paolo

