Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=FORGED_HOTMAIL_RCVD2,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D82EC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 08:56:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 338C9223D1
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 08:56:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 338C9223D1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=hotmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXLmx-0002Ie-Bg
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 03:56:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37555)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1iXLmD-0001st-08
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 03:55:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1iXLmB-0002D5-OX
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 03:55:52 -0500
Received: from indium.canonical.com ([91.189.90.7]:47602)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1iXLmB-0002CO-Iw
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 03:55:51 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1iXLmA-0002q5-0U
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 08:55:50 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id DBC892E80C8
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 08:55:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 Nov 2019 08:41:09 -0000
From: wzis <wzis@hotmail.com>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Incomplete; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: philmd th-huth wzis
X-Launchpad-Bug-Reporter: wzis (wzis)
X-Launchpad-Bug-Modifier: wzis (wzis)
References: <157413352600.6824.7282626865462030571.malonedeb@gac.canonical.com>
Message-Id: <157423926917.6529.2045468605161224800.malone@gac.canonical.com>
Subject: [Bug 1853083] Re: qemu ppc64 4.0 boot AIX5.1 hung
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="c597c3229eb023b1e626162d5947141bf7befb13";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: a8e6e2326145a2a49ff7a00853b1bb8d03e45323
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 91.189.90.7
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
Reply-To: Bug 1853083 <1853083@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

With
qemu-system-ppc64 -cpu power5+ -machine pseries -m 2048 -serial mon:stdio  =
-hda aix-hdd.qcow2 -cdrom /Download/AIX5.1/VOLUME1.iso -prom-env boot-comma=
nd=3D'boot cdrom: -s verbose'

got:
VNC server running on ::1:5900


SLOF **********************************************************************
QEMU Starting
 Build Date =3D Jul  3 2019 12:26:14
 FW Version =3D git-ba1ab360eebe6338
 Press "s" to enter Open Firmware.

Populating /vdevice methods
Populating /vdevice/vty@71000000
Populating /vdevice/nvram@71000001
Populating /vdevice/l-lan@71000002
Populating /vdevice/v-scsi@71000003
       SCSI: Looking for devices
          8000000000000000 DISK     : "QEMU     QEMU HARDDISK    2.5+"
          8200000000000000 CD-ROM   : "QEMU     QEMU CD-ROM      2.5+"
Populating /pci@800000020000000
                     00 0000 (D) : 1234 1111    qemu vga
                     00 0800 (D) : 1033 0194    serial bus [ usb-xhci ]
Installing QEMU fb


Scanning USB
  XHCI: Initializing


( 700 ) Program Exception [ fff ]


    R0 .. R7           R8 .. R15         R16 .. R23         R24 .. R31
000000007dbf36f4   000000007e4594a8   0000000000000000   000000007dc06400
000000007e669dc0   0000000000000100   0000000000000000   000000007dc0ae70
000000007dc10700   000000007e45c000   000000007e466010   000000007e459488
000000007e45c000   000000007dc50700   000000007dc0b040   0000200081021000
0000000000000000   000000007e436000   0000000000008000   0000200081020040
0000000000000fff   0000000000000000   000000000000f003   0000200081020070
000000007e466008   0000000000000000   0000000000000006   0000000000000002
0000000001180000   0000000000000000   000000007e66a050   000000007e459488

    CR / XER           LR / CTR          SRR0 / SRR1        DAR / DSISR
        80000408   000000007dbf3650   000000007dbf366c   0000000000000000
0000000000000000   0000000000000000   8000000000080000           00000000


1 >

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1853083

Title:
  qemu ppc64 4.0 boot AIX5.1 hung

Status in QEMU:
  Incomplete

Bug description:
  When boot AIX5.1 from cdrom device, qemu hung there, no further info
  is displayed and cpu consumption is high.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1853083/+subscriptions

