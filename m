Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9144CC433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 14:52:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6C1820732
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 14:52:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6C1820732
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kICJd-0007Kj-Qp
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 10:52:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34642)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kICIF-00068J-RR
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 10:50:51 -0400
Received: from indium.canonical.com ([91.189.90.7]:38024)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kICID-0004qA-Iq
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 10:50:51 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kICIA-0003zS-Dh
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2020 14:50:46 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 4BA962E8079
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2020 14:50:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2020 14:41:44 -0000
From: Alex Williamson <1894869@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug: distribution=debian; sourcepackage=None; component=None;
 status=In Progress; importance=Unknown; assignee=None; 
X-Launchpad-Bug-Tags: chelsio t4
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: 1butteryadmin alex-l-williamson stefan-proxmox
X-Launchpad-Bug-Reporter: Nick Bauer (1butteryadmin)
X-Launchpad-Bug-Modifier: Alex Williamson (alex-l-williamson)
References: <159958042175.17914.10047848067927369523.malonedeb@soybean.canonical.com>
Message-Id: <160018090448.621.5036512890832739817.malone@chaenomeles.canonical.com>
Subject: [Bug 1894869] Re: Chelsio T4 has old MSIX PBA offset bug
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="83bdf6c8a3a5f87722c8927e54838522f3e57504"; Instance="production"
X-Launchpad-Hash: 0758a733b482df364e1e36901745ed870cf15612
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 09:50:55
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

I don't understand the purpose of function 7 on these cards, the class
code indicates an Ethernet device, but without any BARs, I very much
doubt that the functions provide any useful service.  Config space is
invalid for the function as QEMU identifies, the referenced BAR resource
for the MSI-X vector table and PBA is invalid.  Without proving that the
function provides an actual netdev interface in the host, I don't see
any value to adding a quirk to work around the invalid MSI-X capability.
The solution is to simply not assign this function to a VM.

SR-IOV is not enable on these cards.  Perhaps enabling SR-IOV would
provide the additional NICs you're trying to assign.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1894869

Title:
  Chelsio T4 has old MSIX PBA offset bug

Status in QEMU:
  New
Status in Debian:
  In Progress

Bug description:
  There exists a bug with Chelsio NICs T4 that causes the following
  error:

  kvm: -device vfio-
  pci,host=3D0000:83:00.7,id=3Dhostpci1.7,bus=3Dpci.0,addr=3D0x11.7: vfio
  0000:83:00.7: hardware reports invalid configuration, MSIX PBA outside
  of specified BAR

  I discovered this bug on a Proxmox system, and I was working with a
  downstream Proxmox developer to try to fix this issue. They provided
  me with the following change to make from line 1484 of hw/vfio/pci.c:

  static void vfio_msix_early_setup(VFIOPCIDevice *vdev, Error **errp)
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* is 0x1000, =
so we hard code that here.
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*/
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (vdev->vendor_id=
 =3D=3D PCI_VENDOR_ID_CHELSIO &&
  -            (vdev->device_id & 0xff00) =3D=3D 0x5800) {
  +            ((vdev->device_id & 0xff00) =3D=3D 0x5800 ||
  +             (vdev->device_id & 0xff00) =3D=3D 0x1425)) {
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0msix->pba_offset =3D 0x1000;
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0} else if (vdev->ms=
ix_relo =3D=3D OFF_AUTOPCIBAR_OFF) {
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0error_setg(errp, "hardware reports invalid configuration, "

  However, I found that this did not fix the issue, so the bug appears
  to work differently than the one that was present on the T5 NICs which
  has already been patched. I have attached the output of my lspci
  -nnkvv

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1894869/+subscriptions

