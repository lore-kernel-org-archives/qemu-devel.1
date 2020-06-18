Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA9DEC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 07:52:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE2E820899
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 07:52:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE2E820899
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlpLD-00009a-VH
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 03:52:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50512)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jlpKK-0007jf-QL
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 03:51:12 -0400
Received: from indium.canonical.com ([91.189.90.7]:57184)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jlpKI-0002m4-56
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 03:51:12 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jlpKG-0005Up-8M
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2020 07:51:08 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 345E02E810B
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2020 07:51:08 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jun 2020 07:36:24 -0000
From: Greg Kurz <1829682@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Confirmed; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Tags: ppc64
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: gkurz ivmn kennethsalerno
X-Launchpad-Bug-Reporter: Ivan Warren (ivmn)
X-Launchpad-Bug-Modifier: Greg Kurz (gkurz)
References: <155831074982.26912.13291059176555697592.malonedeb@soybean.canonical.com>
Message-Id: <159246578495.5604.9140040014386205041.malone@soybean.canonical.com>
Subject: [Bug 1829682] Re: QEMU PPC SYSTEM regression - 3.1.0 and GIT - Fail
 to boot AIX
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="1cbd0aa39df153c901321817f9b57cf3f232b507";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 96b1748d279a51fe05cb73e6c8b9618da27eb5a0
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/18 03:41:11
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Reply-To: Bug 1829682 <1829682@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I'm no longer working at IBM.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1829682

Title:
  QEMU PPC SYSTEM regression - 3.1.0 and GIT - Fail to boot AIX

Status in QEMU:
  Confirmed

Bug description:
  Built from source on a debian system

  Linux db08 4.9.0-8-amd64 #1 SMP Debian 4.9.130-2 (2018-10-27) x86_64 GNU/=
Linux
  gcc version 6.3.0 20170516 (Debian 6.3.0-18+deb9u1)

  Last git commit (from queued gdibson repository)

  starting AIX 7.2 TL 2 SP 2 with the following : (the install was done
  under qemu 3.1.0)

  qemu-system-ppc64 -M pseries \
      -cpu power7 \
      -cdrom AIX_v7.2_Install_7200-02-02-1806_DVD_1_of_2_32018.iso \
      -net nic \
      -net tap,ifname=3Dtap2,script=3Dno \
      -drive file=3DDISK1.IMG,if=3Dnone,id=3Ddrive-virtio-disk0 \
      -device virtio-scsi-pci,id=3Dscsi -device scsi-hd,drive=3Ddrive-virti=
o-disk0 \
      -m 4G \
      -serial stdio \
      -monitor unix:ms,server,nowait \
      -accel tcg \
      -k fr \
      -nographic \
      -prom-env input-device=3D/vdevice/vty@71000000 \
      -prom-env output-device=3D/vdevice/vty@71000000 \
      -prom-env diag-switch?=3Dfalse \
      -prom-env boot-command=3D"boot /pci@800000020000000/scsi@2/disk@10000=
0000000000 -s verbose"

  Yields this :

  =

  ^M
  SLOF^[[0m^[[?25l ********************************************************=
**************^M
  ^[[1mQEMU Starting^M
  ^[[0m Build Date =3D Jan 14 2019 18:00:39^M
   FW Version =3D git-a5b428e1c1eae703^M
   Press "s" to enter Open Firmware.^M^M
  ^M^M
  ^[[0m^[[?25hC0000^MC0100^MC0120^MC0140^MC0200^MC0240^MC0260^MC02E0^MC0300=
^MC0320^MC0340^MC0360^MC0370^MC0380^MC0371^MC0372^MC0373^MC0374^MC03F0^MC04=
00^MC0480^MC04C0^MC04D0^MC0500^MPopulating /vdevice methods^M
  Populating /vdevice/vty@71000000^M
  Populating /vdevice/nvram@71000001^M
  Populating /vdevice/l-lan@71000002^M
  Populating /vdevice/v-scsi@71000003^M
         SCSI: Looking for devices^M
            8200000000000000 CD-ROM   : "QEMU     QEMU CD-ROM      2.5+"^M
  C05A0^MPopulating /pci@800000020000000^M
                       00 0000 (D) : 1234 1111    qemu vga^M
                       00 0800 (D) : 1033 0194    serial bus [ usb-xhci ]^M
                       00 1000 (D) : 1af4 1004    virtio [ scsi ]^M
  Populating /pci@800000020000000/scsi@2^M
         SCSI: Looking for devices^M
            100000000000000 DISK     : "QEMU     QEMU HARDDISK    2.5+"^M
  C0600^MC06C0^MC0700^MC0800^MC0880^MC0890^MC08A0^MC08A8^MInstalling QEMU f=
b^M
  ^M
  ^M
  ^M
  C08B0^MScanning USB ^M
    XHCI: Initializing^M
      USB Keyboard ^M
      USB mouse ^M
  C08C0^MC08D0^MNo console specified using screen & keyboard^M
  User selected input-device console: /vdevice/vty@71000000^M
  User selected output-device console: /vdevice/vty@71000000^M
  C08E0^MC08E8^MC08FF^M     ^M
    Welcome to Open Firmware^M
  ^M
    Copyright (c) 2004, 2017 IBM Corporation All rights reserved.^M
    This program and the accompanying materials are made available^M
    under the terms of the BSD License available at^M
    http://www.opensource.org/licenses/bsd-license.php^M
  ^M
  ^M
  Trying to load: -s verbose from: /pci@800000020000000/scsi@2/disk@1000000=
00000000 ...   Successfully loaded^M
  ^M
                          ---> qemu,pseries detected <---^M
  ^M
  ^M
  ^M
  ^M
  ^M
  ^M
  ^M
  -------------------------------------------------------------------------=
------^M
                                  Welcome to AIX.^M
                     boot image timestamp: 05:56:13 04/20/2019^M
          processor count: 1;  memory size: 4096MB;  kernel size: 38426884^M
           boot device: /pci@800000020000000/scsi@2/disk@100000000000000^M
  ^M
  8000FFEC bytes of free memory remain at address 7FFF0014^M
  load address: 0x00004000   aixmon size: 0x000D2C00   boot image size: 0x0=
1A6B430^M
  ^LAIX vm,uuid property contains invalid data^Mload address: 0x00004000   =
aixmon size: 0x000D2C00   boot image size: 0x01A6B430^M
  ^LAIX vm,uuid property contains invalid data^M
  get_ppp return code: 0xFFFFFFFE^M
  ^M
  AKVM: hcall-multi-tce detected but overridden, allow with "multce" boot a=
rgument^M
  The temporary memory region list is at 1 percent capacity.^M
  The temporary IPLCB is at 1 percent capacity.^M
  The IPLCB address is 0x0FFF9000^M
  name                 offset           size^M
  ipl_cb_and_bit_map 00000000 ......00005958^M
  bit_map........... 00000790 ......00000006^M
  ipl_info.......... 000001C8 ......00000024^M
  splpar_info....... 000001EC ......00000048^M
  system_info....... 00000234 ......000000C4^M
  processor_info.... 000002F8 ......00000148^M
  lpar_id_info...... 00000440 ......00000088^M
  dr_proc_info...... 000004C8 ......00000008^M
  dr_mem_info....... 000004D0 ......00000028^M
  lpar_info......... 000004F8 ......00000014^M
  segment page...... 00000518 ......00000028^M
  processor page.... 00000540 ......00000010^M
  res_asso_id....... 00000550 ......00000050^M
  res_asso_group.... 000005A0 ......00000048^M
  asso_ref_pnt...... 000005E8 ......00000010^M
  residual.......... 00000820 ......00005138^M
  fwad_info......... 000005F8 ......00000040^M
  contig mem rsv.... 00000738 ......00000058^M
      region address      region length       attr  label^M
  0   0x0000000000000000  0x000000000FFF7000  0x01  0x01^M
  1   0x000000000FFF7000  0x0000000000002000  0x01  0x03^M
  2   0x000000000FFF9000  0x0000000000006000  0x01  0x02^M
  3   0x000000000FFFF000  0x0000000000000014  0x00  0x05^M
  4   0x000000000FFFF014  0x00000000F0000FEC  0x01  0x01^M
  5   0x0000000100000000  0xFFFFFFFF00000000  0x00  0x07^M
  ----------------------------^M
  ^M
  0000012C bytes of free memory remain at address 00004000^M
  compressed kernel addr: D6C00;  sz: 98CE33;  uncompressed kernel addr:  1=
DB59600^M
           name     source       dest       size   flags^M
   0      .data   1e6f9840    2000000    12bdd20     1^M
   1    basecfg    1b04000    fff5000       15d9     1^M
   2      ramfs     a63a30    efe9000    100b82a     1^M
   3      .text   1db59840      d6c00     ba0000     1^M
   4       .ldr   1f9b7560     c77000      a9523     1^M
   5     symtab   1fe0aaf4     d21000     1f4410     1^M
   6  kern. hdr   1db59600          0        240     1^M
   7       .bss          0    32bdd20    27222e0     2^M
  free space between BSS and RAM filesystem: 09609000^M
  ^M
  entry_point: 0x000D6C28^M
                         kernel debugger setting: enabled^M
  -------------------------------------------------------------------------=
------^M
  ^LStarLED{A20}^M
  Data Storage Interrupt - PROC^M
  .dispatch+000098              lwz    r0,1830(r6)         r0=3D0,1830(r6)=
=3DF00000002FF48E30^M
  KDB(0)>

  (apologies for all the ^M - they are emitted by qemu or AIX - not
  sure)

  Using the same command to boot AIX from 3.1.0 works (no DSI
  Interrupt). - Other problems occur later, but no Kernel interrupt,
  only user space problems - and that's another problem - but one at a
  time !

  --Ivan

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1829682/+subscriptions

