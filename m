Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D38C5DF60
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 21:41:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F59F21882
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 21:41:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F59F21882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS6aD-0004Am-Sv
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 16:41:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58987)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iS5pg-0001S3-Cd
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 15:53:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iS5pe-0002UO-1z
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 15:53:43 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50498
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
 id 1iS5pd-0002BL-22; Tue, 05 Nov 2019 15:53:41 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 xA5KpYr5040633; Tue, 5 Nov 2019 15:53:20 -0500
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2w3eegm8vm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 Nov 2019 15:53:20 -0500
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id xA5Kq5X9041997;
 Tue, 5 Nov 2019 15:53:20 -0500
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com
 [169.55.91.170])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2w3eegm8va-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 Nov 2019 15:53:20 -0500
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
 by ppma02wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xA5KnuYp025651;
 Tue, 5 Nov 2019 20:53:19 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26]) by ppma02wdc.us.ibm.com with ESMTP id 2w11e79805-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 Nov 2019 20:53:19 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com
 [9.57.199.107])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xA5KrJTs15860552
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 5 Nov 2019 20:53:19 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F3508124058;
 Tue,  5 Nov 2019 20:53:18 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E0013124052;
 Tue,  5 Nov 2019 20:53:18 +0000 (GMT)
Received: from localhost (unknown [9.53.179.218])
 by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue,  5 Nov 2019 20:53:18 +0000 (GMT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 55/55] virtio-blk: Cancel the pending BH when the dataplane is
 reset
Date: Tue,  5 Nov 2019 14:52:43 -0600
Message-Id: <20191105205243.3766-56-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191105205243.3766-1-mdroth@linux.vnet.ibm.com>
References: <20191105205243.3766-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-11-05_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1911050170
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0a-001b2d01.pphosted.com id xA5KpYr5040633
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-stable@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

When 'system_reset' is called, the main loop clear the memory
region cache before the BH has a chance to execute. Later when
the deferred function is called, some assumptions that were
made when scheduling them are no longer true when they actually
execute.

This is what happens using a virtio-blk device (fresh RHEL7.8 install):

 $ (sleep 12.3; echo system_reset; sleep 12.3; echo system_reset; sleep 1=
; echo q) \
   | qemu-system-x86_64 -m 4G -smp 8 -boot menu=3Don \
     -device virtio-blk-pci,id=3Dimage1,drive=3Ddrive_image1 \
     -drive file=3D/var/lib/libvirt/images/rhel78.qcow2,if=3Dnone,id=3Ddr=
ive_image1,format=3Dqcow2,cache=3Dnone \
     -device virtio-net-pci,netdev=3Dnet0,id=3Dnic0,mac=3D52:54:00:c4:e7:=
84 \
     -netdev tap,id=3Dnet0,script=3D/bin/true,downscript=3D/bin/true,vhos=
t=3Don \
     -monitor stdio -serial null -nographic
  (qemu) system_reset
  (qemu) system_reset
  (qemu) qemu-system-x86_64: hw/virtio/virtio.c:225: vring_get_region_cac=
hes: Assertion `caches !=3D NULL' failed.
  Aborted

  (gdb) bt
  Thread 1 (Thread 0x7f109c17b680 (LWP 10939)):
  #0  0x00005604083296d1 in vring_get_region_caches (vq=3D0x56040a24bdd0)=
 at hw/virtio/virtio.c:227
  #1  0x000056040832972b in vring_avail_flags (vq=3D0x56040a24bdd0) at hw=
/virtio/virtio.c:235
  #2  0x000056040832d13d in virtio_should_notify (vdev=3D0x56040a240630, =
vq=3D0x56040a24bdd0) at hw/virtio/virtio.c:1648
  #3  0x000056040832d1f8 in virtio_notify_irqfd (vdev=3D0x56040a240630, v=
q=3D0x56040a24bdd0) at hw/virtio/virtio.c:1662
  #4  0x00005604082d213d in notify_guest_bh (opaque=3D0x56040a243ec0) at =
hw/block/dataplane/virtio-blk.c:75
  #5  0x000056040883dc35 in aio_bh_call (bh=3D0x56040a243f10) at util/asy=
nc.c:90
  #6  0x000056040883dccd in aio_bh_poll (ctx=3D0x560409161980) at util/as=
ync.c:118
  #7  0x0000560408842af7 in aio_dispatch (ctx=3D0x560409161980) at util/a=
io-posix.c:460
  #8  0x000056040883e068 in aio_ctx_dispatch (source=3D0x560409161980, ca=
llback=3D0x0, user_data=3D0x0) at util/async.c:261
  #9  0x00007f10a8fca06d in g_main_context_dispatch () at /lib64/libglib-=
2.0.so.0
  #10 0x0000560408841445 in glib_pollfds_poll () at util/main-loop.c:215
  #11 0x00005604088414bf in os_host_main_loop_wait (timeout=3D0) at util/=
main-loop.c:238
  #12 0x00005604088415c4 in main_loop_wait (nonblocking=3D0) at util/main=
-loop.c:514
  #13 0x0000560408416b1e in main_loop () at vl.c:1923
  #14 0x000056040841e0e8 in main (argc=3D20, argv=3D0x7ffc2c3f9c58, envp=3D=
0x7ffc2c3f9d00) at vl.c:4578

Fix this by cancelling the BH when the virtio dataplane is stopped.

[This is version of the patch was modified as discussed with Philippe on
the mailing list thread.
--Stefan]

Reported-by: Yihuang Yu <yihyu@redhat.com>
Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
Fixes: https://bugs.launchpad.net/qemu/+bug/1839428
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-Id: <20190816171503.24761-1-philmd@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
(cherry picked from commit ebb6ff25cd888a52a64a9adc3692541c6d1d9a42)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/block/dataplane/virtio-blk.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/block/dataplane/virtio-blk.c b/hw/block/dataplane/virtio-=
blk.c
index 158c78f852..5fea76df85 100644
--- a/hw/block/dataplane/virtio-blk.c
+++ b/hw/block/dataplane/virtio-blk.c
@@ -297,6 +297,9 @@ void virtio_blk_data_plane_stop(VirtIODevice *vdev)
         virtio_bus_cleanup_host_notifier(VIRTIO_BUS(qbus), i);
     }
=20
+    qemu_bh_cancel(s->bh);
+    notify_guest_bh(s); /* final chance to notify guest */
+
     /* Clean up guest notifier (irq) */
     k->set_guest_notifiers(qbus->parent, nvqs, false);
=20
--=20
2.17.1


