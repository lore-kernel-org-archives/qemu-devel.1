Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF47C33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 18:27:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25F6424676
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 18:27:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LB3b2KMC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25F6424676
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioX6X-0005Yg-KL
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 13:27:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44918)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <danielhb413@gmail.com>) id 1ioX3f-0001M3-54
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:24:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <danielhb413@gmail.com>) id 1ioX3d-0003bi-El
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:24:55 -0500
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842]:40593)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <danielhb413@gmail.com>)
 id 1ioX3d-0003b4-5d; Mon, 06 Jan 2020 13:24:53 -0500
Received: by mail-qt1-x842.google.com with SMTP id e6so43206345qtq.7;
 Mon, 06 Jan 2020 10:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=7r60/2+UgSmMY0vXGIJweGB5lb3xcciRJ3ojSxazjoM=;
 b=LB3b2KMCHB2aHogtMJ5UNa8lwCVB0lI+4OwlPjlAbGdUZKTMAr5F90t65oPthvVeaK
 KROOr/YJy9u1kWaHd0pwZoFFJZYFo3elG6RZXewdUGRKF88DZGbGwrRJJRVPvumVw61y
 CxqHRFnpF/6VrVucIjvYo+v2y4UmkKc3JiRUmOPx5OBRREkxnkvklj5xrgjjhWaisfr4
 5wgdpPMZfM24ViAZ2rJvvTYO12lKr/nVncKvbYRrJrGMFpVLxqJG6AYsgu0T8fMLBHKZ
 1A7k0+c7VLQeGB7jF5ECg8LrcnGIEvJh1MhdULc77X1QIgZrkG92Kh3ZNjCNNjcgo8wM
 2/BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=7r60/2+UgSmMY0vXGIJweGB5lb3xcciRJ3ojSxazjoM=;
 b=PP3GWTwRpAFtSkV+x2NyULGC7v+Udlb5RQTDELsjLuAisvAQC5xtGxpu2np21lyafS
 Y0fbghFn2pwmxJSHZ8Ko0Dq+lCmNyZbJZLaeV/ttQMub4Hf1xI63g5PyP6MWARtjhEje
 WqKLsVhti31K1eOwnHhD045kVE7F0P7N2E/0ba4g8vhZeoESrL9gJg6EH0mgbv9isk9R
 q/vqK+XTjWILAVTiU26ekecFBnBKI/AkNnzRbpLHgZ2NdreW29gRDiAG2rPVhpR6cfcT
 i/2l8QAXS4kIYa7n1q18czxuPFbeDWmr/l+6+qjwA4hMLh7tHhdqnV1iM3ETlGz7TNNU
 lSeg==
X-Gm-Message-State: APjAAAX8oV77mn7xHnWEjCz4Gimpx02/xIXcFi0/qT7VbZrfMsbBOa0p
 aPY5yIE83HJuDrbdBtUy+bgz/33w
X-Google-Smtp-Source: APXvYqyoDfLGSMJXKtOo/0LyiZQUa1ga2ohAuISkp6U6hL8TGYfb/xpsQmaHuUuQjAdXPkBZXE5y2g==
X-Received: by 2002:ac8:689a:: with SMTP id m26mr76509045qtq.68.1578335092238; 
 Mon, 06 Jan 2020 10:24:52 -0800 (PST)
Received: from rekt.ibmuc.com ([2804:431:c7c6:655b:9e1c:e865:3705:e1df])
 by smtp.gmail.com with ESMTPSA id b81sm21026522qkc.135.2020.01.06.10.24.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2020 10:24:51 -0800 (PST)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 00/59] trivial unneeded labels cleanup
Date: Mon,  6 Jan 2020 15:23:26 -0300
Message-Id: <20200106182425.20312-1-danielhb413@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::842
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
Cc: qemu-trivial@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,

This is the type of cleanup I've contributed to Libvirt
during the last year. Figured QEMU also deserves the same
care.

The idea here is remove unneeded labels. By 'unneeded' I
mean labels that does nothing but a 'return' call. One
common case is something like this:

if ()
    goto cleanup;
[...]
 cleanup:
    return 0;

This code can be simplified to:

if ()
    return 0;


Which is cleaner and requires less brain cycles to wonder
whether the 'cleanup' label does anything special, such
as a heap memory cleanup.

Another common case uses a variable to set a return value,
generally an error, then return:

if () {
    ret = -ENOENT;
    goto out;
}
[..]
 out:
    return ret;

Likewise, it is clearer to just 'return -ENOENT' instead of
jumping to a label. There are other cases being handled in
these patches, but these are the most common.

There are still a handful of unneeded labels hanging around after
this series. There are cases in which the label name is
part of the code semantics and I judged not worth removing.
search_chunk() in block/dmg.c has an example of an unneeded
'err' label that I decided to not remove.

No functional change was made. If any of these patches changes
existing behavior it is unintended and an error from my
part.



Daniel Henrique Barboza (59):
  spapr.c: remove 'out' label in spapr_dt_cas_updates()
  ppc440_bamboo.c: remove label from bamboo_load_device_tree()
  kvm-all.c: remove unneeded labels
  paaudio.c: remove unneeded labels
  ram.c: remove unneeded labels
  mips-semi.c: remove 'uhi_done' label in helper_do_semihosting()
  unicore32/softmmu.c: remove 'do_fault' label in get_phys_addr_ucv2()
  chardev/char-mux.c: remove 'send_char' label
  chardev/char-pipe.c: remove 'fail' label in win_chr_pipe_init()
  chardev/char-win.c: remove 'fail' label in win_chr_serial_init()
  exec.c: remove 'err' label in ram_block_discard_range()
  virtfs-proxy-helper.c: remove 'err_out' label in setugid()
  block/vdi.c: remove 'fail' label in vdi_open()
  block/file-posix.c: remove unneeded labels
  block/blkreplay.c: remove unneeded 'fail' label in blkreplay_open()
  block/gluster.c: remove unneeded 'exit' label
  block/dmg.c: remove unneeded 'fail' label in dmg_read_mish_block()
  qcow2-refcount.c: remove unneeded 'fail' label in
    qcow2_refcount_init()
  block/ssh.c: remove unneeded labels
  block/vpc.c: remove unneeded 'fail' label in create_dynamic_disk()
  block/backup.c remove unneeded 'out' label in backup_run()
  block/vmdk.c: remove unneeded labels
  block/vxhs.c: remove unneeded 'out' label in vxhs_iio_callback()
  block/vhdx-log.c: remove unneeded labels
  block/vhdx.c: remove unneeded 'exit' labels
  block/replication.c: remove unneeded label in replication_co_writev
  crypto/block-luks.c: remove unneeded label in
    qcrypto_block_luks_find_key
  qga/commands-win32.c: remove 'out' label in get_pci_info
  cryptodev-vhost.c: remove unneeded 'err' label in
    cryptodev_vhost_start
  util/module.c: remove unneeded label in module_load_file()
  util/aio-posix.c: remove unneeded 'out' label in aio_epoll
  qemu-img.c: remove 'out4' label in img_compare
  ipmi/ipmi_bmc_sim.c: remove unneeded labels
  ipmi/ipmi_bt.c: remove unneeded label in ipmi_bt_handle_event
  ipmi_bmc_extern.c: remove unneeded label in
    ipmi_bmc_extern_handle_command
  ipmi/ipmi_kcs.c: remove unneeded label in ipmi_kcs_handle_event
  s390x/event-facility.c: remove unneeded labels
  s390x/sclp.c: remove unneeded label in sclp_service_call()
  usb/dev-mtp.c: remove unneeded label in write_retry()
  hsb/hcd-ehci.c: remove unneeded labels
  intc/s390_flic_kvm.c: remove unneeded label in kvm_flic_load()
  i386/intel_iommu.c: remove unneeded labels
  i386/amd_iommu.c: remove unneeded label in amdvi_int_remap_msi()
  9p-local.c: remove unneeded label in local_unlinkat_common()
  9pfs/9p.c: remove unneeded labels
  alpha/typhoon.c: remove unneeded label in typhoon_translate_iommu()
  pvrdma_main.c: remove unneeded labels
  pvrdma_dev_ring.c: remove unneeded label in pvrdma_ring_init()
  rdma/rdma_rm.c: remove unneeded label in rdma_rm_alloc_pd()
  rdma/rdma_backend.c: remove unneeded label in rdma_backend_init()
  virtio/vhost.c: remove unneeded labels
  net/vhost_net.c: remove unneeded labels
  net/net_tx_pkt.c: remove unneeded label in net_tx_pkt_get_gso_type()
  ivshmem-server/main.c: remove unneeded label in main()
  linux-user/flatload.c: remove unused 'out' label
  linux-user/signal.c: remove unneeded label in do_sigaltstack()
  linux-user/syscall.c: fix trailing whitespaces and style
  linux-user/syscall.c: remove unneeded labels
  linux-user/vm86.c: remove unneeded label in do_vm86()

 accel/kvm/kvm-all.c           | 30 +++++-------
 audio/paaudio.c               | 10 +---
 backends/cryptodev-vhost.c    |  4 +-
 block/backup.c                |  6 +--
 block/blkreplay.c             |  8 +---
 block/dmg.c                   | 10 +---
 block/file-posix.c            | 10 ++--
 block/gluster.c               |  3 +-
 block/qcow2-refcount.c        |  7 +--
 block/replication.c           |  9 ++--
 block/ssh.c                   | 61 ++++++++-----------------
 block/vdi.c                   | 40 ++++++----------
 block/vhdx-log.c              | 86 +++++++++++++----------------------
 block/vhdx.c                  | 10 ++--
 block/vmdk.c                  | 37 ++++++---------
 block/vpc.c                   | 12 ++---
 block/vxhs.c                  |  4 +-
 chardev/char-mux.c            |  3 +-
 chardev/char-pipe.c           | 13 ++----
 chardev/char-win.c            | 19 ++++----
 contrib/ivshmem-server/main.c |  9 ++--
 crypto/block-luks.c           |  3 +-
 exec.c                        | 13 +++---
 fsdev/virtfs-proxy-helper.c   |  4 +-
 hw/9pfs/9p-local.c            | 12 ++---
 hw/9pfs/9p.c                  |  9 ++--
 hw/alpha/typhoon.c            | 18 ++++----
 hw/i386/amd_iommu.c           | 13 ++----
 hw/i386/intel_iommu.c         |  8 ++--
 hw/intc/s390_flic_kvm.c       | 10 ++--
 hw/ipmi/ipmi_bmc_extern.c     |  5 +-
 hw/ipmi/ipmi_bmc_sim.c        |  9 +---
 hw/ipmi/ipmi_bt.c             |  8 ++--
 hw/ipmi/ipmi_kcs.c            |  4 +-
 hw/net/net_tx_pkt.c           | 11 ++---
 hw/net/vhost_net.c            |  7 ++-
 hw/ppc/ppc440_bamboo.c        |  8 +---
 hw/ppc/spapr.c                |  9 ++--
 hw/rdma/rdma_backend.c        |  4 +-
 hw/rdma/rdma_rm.c             | 11 ++---
 hw/rdma/vmw/pvrdma_dev_ring.c |  7 +--
 hw/rdma/vmw/pvrdma_main.c     | 10 ++--
 hw/s390x/event-facility.c     | 21 +++------
 hw/s390x/sclp.c               | 16 ++-----
 hw/usb/dev-mtp.c              | 13 ++----
 hw/usb/hcd-ehci.c             | 32 ++++---------
 hw/virtio/vhost.c             | 11 ++---
 linux-user/flatload.c         |  1 -
 linux-user/signal.c           | 20 +++-----
 linux-user/syscall.c          | 54 ++++++++++------------
 linux-user/vm86.c             |  7 +--
 migration/ram.c               | 18 ++------
 qemu-img.c                    |  7 +--
 qga/commands-win32.c          | 17 ++++---
 target/mips/mips-semi.c       | 15 +++---
 target/unicore32/softmmu.c    | 23 +++-------
 util/aio-posix.c              |  3 +-
 util/module.c                 | 11 ++---
 58 files changed, 293 insertions(+), 550 deletions(-)

-- 
2.24.1


