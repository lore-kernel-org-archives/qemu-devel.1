Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A63C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 16:06:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8CF4206E7
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 16:06:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8CF4206E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFg8M-0004yD-PU
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 12:06:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36750)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kFg3B-0003xa-JZ
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 12:00:53 -0400
Received: from indium.canonical.com ([91.189.90.7]:36326)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kFg38-0004WJ-RF
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 12:00:53 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kFg34-0003Qw-T0
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 16:00:46 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id DA6C62E8053
 for <qemu-devel@nongnu.org>; Tue,  8 Sep 2020 16:00:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2020 15:53:41 -0000
From: Nick Bauer <1894869@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: chelsio t4
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: 1butteryadmin
X-Launchpad-Bug-Reporter: Nick Bauer (1butteryadmin)
X-Launchpad-Bug-Modifier: Nick Bauer (1butteryadmin)
Message-Id: <159958042175.17914.10047848067927369523.malonedeb@soybean.canonical.com>
Subject: [Bug 1894869] [NEW] Chelsio T4 has old MSIX PBA offset bug
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="90a5703803d95539bdb5c0b289b1675630569e1e"; Instance="production"
X-Launchpad-Hash: 350ec12daa27441217127b16c49d8798f1c9e8ea
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 11:30:40
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1894869 <1894869@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

There exists a bug with Chelsio NICs T4 that causes the following error:

kvm: -device vfio-
pci,host=3D0000:83:00.7,id=3Dhostpci1.7,bus=3Dpci.0,addr=3D0x11.7: vfio
0000:83:00.7: hardware reports invalid configuration, MSIX PBA outside
of specified BAR

I was working with a downstream Proxmox developer to try to fix this
issue, and they provided me with the following change to make from line
1484 of hw/vfio/pci.c:

static void vfio_msix_early_setup(VFIOPCIDevice *vdev, Error **errp)
          * is 0x1000, so we hard code that here.
          */
         if (vdev->vendor_id =3D=3D PCI_VENDOR_ID_CHELSIO &&
-            (vdev->device_id & 0xff00) =3D=3D 0x5800) {
+            ((vdev->device_id & 0xff00) =3D=3D 0x5800 ||
+             (vdev->device_id & 0xff00) =3D=3D 0x1425)) {
             msix->pba_offset =3D 0x1000;
         } else if (vdev->msix_relo =3D=3D OFF_AUTOPCIBAR_OFF) {
             error_setg(errp, "hardware reports invalid configuration, "

However, I found that this did not fix the issue, so the bug appears to
work differently than the one that was present on the T5 NICs which has
already been patched. I have attached the output of my lspci -nnkvv

** Affects: qemu
     Importance: Undecided
         Status: New


** Tags: chelsio t4

** Attachment added: "Full lspci -nnkvv output"
   https://bugs.launchpad.net/bugs/1894869/+attachment/5408718/+files/lspci=
.txt

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1894869

Title:
  Chelsio T4 has old MSIX PBA offset bug

Status in QEMU:
  New

Bug description:
  There exists a bug with Chelsio NICs T4 that causes the following
  error:

  kvm: -device vfio-
  pci,host=3D0000:83:00.7,id=3Dhostpci1.7,bus=3Dpci.0,addr=3D0x11.7: vfio
  0000:83:00.7: hardware reports invalid configuration, MSIX PBA outside
  of specified BAR

  I was working with a downstream Proxmox developer to try to fix this
  issue, and they provided me with the following change to make from
  line 1484 of hw/vfio/pci.c:

  static void vfio_msix_early_setup(VFIOPCIDevice *vdev, Error **errp)
            * is 0x1000, so we hard code that here.
            */
           if (vdev->vendor_id =3D=3D PCI_VENDOR_ID_CHELSIO &&
  -            (vdev->device_id & 0xff00) =3D=3D 0x5800) {
  +            ((vdev->device_id & 0xff00) =3D=3D 0x5800 ||
  +             (vdev->device_id & 0xff00) =3D=3D 0x1425)) {
               msix->pba_offset =3D 0x1000;
           } else if (vdev->msix_relo =3D=3D OFF_AUTOPCIBAR_OFF) {
               error_setg(errp, "hardware reports invalid configuration, "

  However, I found that this did not fix the issue, so the bug appears
  to work differently than the one that was present on the T5 NICs which
  has already been patched. I have attached the output of my lspci
  -nnkvv

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1894869/+subscriptions

