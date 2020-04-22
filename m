Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 628E6C54FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 14:21:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20D002084D
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 14:21:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20D002084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRGG7-0005jY-An
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 10:21:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55660)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jRGFB-0004lM-Vr
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 10:20:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jRGFA-000631-N6
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 10:20:53 -0400
Received: from indium.canonical.com ([91.189.90.7]:54976)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jRGFA-0005yp-5M
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 10:20:52 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jRGF7-0008J4-Fz
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2020 14:20:49 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 77AF82E8024
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2020 14:20:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Apr 2020 14:11:08 -0000
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: kennethsalerno
X-Launchpad-Bug-Reporter: Kenneth Salerno (kennethsalerno)
X-Launchpad-Bug-Modifier: Kenneth Salerno (kennethsalerno)
Message-Id: <158756466889.23136.4781024661991862847.malonedeb@chaenomeles.canonical.com>
Subject: [Bug 1874264] [NEW] AIX 7.2 TL4 SP1 cannot IPL with QEMU >2.11.2
 ppc64-softmmu
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="486bbbd6cb608f8eb468ed0d08689a349dfabe49";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 794b242bba0ada65e019b72398cafc1d778dfd7a
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 10:20:49
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Reply-to: Bug 1874264 <1874264@bugs.launchpad.net>, Kenneth Salerno <kennethsalerno@yahoo.com>
From: Kenneth Salerno via <qemu-devel@nongnu.org>

Public bug reported:

kens@LAPTOP-JN77KAC2$ qemu-system-ppc64 -version
QEMU emulator version 4.2.93 (v5.0.0-rc3-8-g3119154db0-dirty)
Copyright (c) 2003-2020 Fabrice Bellard and the QEMU Project developers

qemu-system-ppc64 \
  -name "IBM AIX - IBM POWER9" \
  -M pseries \
  -cpu POWER9 \
  -smp 8 \
  -m 8192 \
  -nodefaults \
  -nographic \
  -prom-env input-device=3D/vdevice/vty@71000000 \
  -prom-env output-device=3D/vdevice/vty@71000000 \
  -serial tcp::9019,server,nowait \
  -monitor tcp::9020,server,nowait \
  -netdev type=3Duser,id=3Dmynet0,hostfwd=3Dtcp:127.0.0.1:9018-10.0.2.18:22=
 \
  -device virtio-net-pci,netdev=3Dmynet0 \
  -drive file=3Dimages/aix-ppc64.img,format=3Dqcow2,if=3Dnone,id=3Dhd,media=
=3Ddisk,cache=3Dunsafe \
  -device virtio-scsi-pci,id=3Dscsi -device scsi-hd,drive=3Dhd \
  -drive file=3Dimages/iso/blank-cdrom,format=3Draw,media=3Dcdrom,cache=3Du=
nsafe

---------------------------------------------------------------------------=
----
                                Welcome to AIX.
                   boot image timestamp: 14:18:40 03/27/2020
        processor count: 8;  memory size: 8192MB;  kernel size: 45422205
         boot device: /pci@800000020000000/scsi@1/disk@100000000000000
=0CAIX vm,uuid property contains invalid data
processing splpar characteristic: MaxEntCap
processing splpar characteristic: DesMem
processing splpar characteristic: DesProcs
processing splpar characteristic: MaxPlatProcs
processing splpar characteristic: HostThrs

AKVM: hcall-multi-tce detected but overridden, allow with "multce" boot arg=
ument
---------------------------------------------------------------------------=
----
=0CStarqemu-system-ppc64: OS terminated: 888 102 700 C20


qemu-system-ppc64 \
  -name "IBM AIX - IBM POWER8" \
  -M pseries \
  -cpu POWER8 \
  -smp 8 \
  -m 8192 \
  -nodefaults \
  -nographic \
  -prom-env input-device=3D/vdevice/vty@71000000 \
  -prom-env output-device=3D/vdevice/vty@71000000 \
  -serial tcp::9019,server,nowait \
  -monitor tcp::9020,server,nowait \
  -netdev type=3Duser,id=3Dmynet0,hostfwd=3Dtcp:127.0.0.1:9018-10.0.2.18:22=
 \
  -device virtio-net-pci,netdev=3Dmynet0 \
  -drive file=3Dimages/aix-ppc64.img,format=3Dqcow2,if=3Dnone,id=3Dhd,media=
=3Ddisk,cache=3Dunsafe \
  -device virtio-scsi-pci,id=3Dscsi -device scsi-hd,drive=3Dhd \
  -drive file=3Dimages/iso/blank-cdrom,format=3Draw,media=3Dcdrom,cache=3Du=
nsafe

---------------------------------------------------------------------------=
----
                                Welcome to AIX.
                   boot image timestamp: 14:18:40 03/27/2020
        processor count: 8;  memory size: 8192MB;  kernel size: 45422205
         boot device: /pci@800000020000000/scsi@1/disk@100000000000000
=0CAIX vm,uuid property contains invalid data
processing splpar characteristic: MaxEntCap
processing splpar characteristic: DesMem
processing splpar characteristic: DesProcs
processing splpar characteristic: MaxPlatProcs
processing splpar characteristic: HostThrs

AKVM: hcall-multi-tce detected but overridden, allow with "multce" boot arg=
ument
---------------------------------------------------------------------------=
----
=0CStar**
ERROR:/home/kens/tmp/qemu/cpus.c:1727:qemu_tcg_cpu_thread_fn: assertion fai=
led: (cpu->halted)


kens@LAPTOP-JN77KAC2$ qemu-system-ppc64 -version
QEMU emulator version 2.11.2
Copyright (c) 2003-2017 Fabrice Bellard and the QEMU Project developers

qemu-system-ppc64 \
  -name "IBM AIX - IBM POWER9" \
  -M pseries,cap-htm=3Doff \
  -cpu POWER9 \
  -smp 8 \
  -m 8192 \
  -nodefaults \
  -nographic \
  -prom-env input-device=3D/vdevice/vty@71000000 \
  -prom-env output-device=3D/vdevice/vty@71000000 \
  -serial tcp::9019,server,nowait \
  -monitor tcp::9020,server,nowait \
  -netdev type=3Duser,id=3Dmynet0,hostfwd=3Dtcp:127.0.0.1:9018-10.0.2.18:22=
 \
  -device virtio-net-pci,netdev=3Dmynet0 \
  -drive file=3Dimages/aix-ppc64.img,format=3Dqcow2,if=3Dnone,id=3Dhd,media=
=3Ddisk,cache=3Dunsafe \
  -device virtio-scsi-pci,id=3Dscsi -device scsi-hd,drive=3Dhd \
  -drive file=3Dimages/iso/blank-cdrom,format=3Draw,media=3Dcdrom,cache=3Du=
nsafe

---------------------------------------------------------------------------=
----
                                Welcome to AIX.
                   boot image timestamp: 14:18:40 03/27/2020
        processor count: 8;  memory size: 8192MB;  kernel size: 45422205
         boot device: /pci@800000020000000/scsi@1/disk@100000000000000
=0CAIX vm,uuid property contains invalid data
processing splpar characteristic: MaxEntCap
processing splpar characteristic: DesMem
processing splpar characteristic: DesProcs
processing splpar characteristic: MaxPlatProcs

AKVM: hcall-multi-tce detected but overridden, allow with "multce" boot arg=
ument
---------------------------------------------------------------------------=
----
=0CStar
0539
0811
0539
0812
0708
0811
0811
0811
0811
0811
0811
0811
0811
078c
25b6
25b6
25b6
25b6
25b6
25b6
25b6
25b6
25b6
25b6
25b6
078c
0539
2071
0539
2073
0539
25b3vscsi_send_capabilities: capabilities size mismatch !
VSCSI: Unknown MAD type 09

0539
0538
0539
0591
0539
0538
0539
0538
0539
25b0
0539

0511
0551
0517
0517
0517
0517
0553
0517
0517
0538
0539
0538
0539
270b
0539
0538
0539
2070
0539
0538
0539
0811
0539
0811
0539
0812
0708
0811
0811
0811
0811
0811
0811
0811
0811
078c
25b6
25b6
25b6
25b6
25b6
25b6
25b6
25b6
25b6
25b6
25b6
078c
04ee
078c
0727
0727
2071
2072
2072
2071
0539
25b3
0539
25b5
0539
0538
0539
0538
0539
0538
0539
0538
0539
0538
0581
0539
0538
0539
7000
0539
0538
0539
0538
0539
0538
0581
0581
0539
0538
0539
25b0
0539
0538
0539
0538
0539
0731
0539
0538
0539
0538
0539
0538
0539
0538
0539
0538
0539
0538
0539
0538
0539
0538
0539
0538
0539
0538
0539
0538
0539
0538
0539
0538
0539
0538
0539
0538
0539
0538
0539
0538
0539
0538
0539
0538
0539
2028
0539
0538
0539

0c33
Saving Base Customize Data to boot disk
Starting the sync daemon
Starting the error daemon

System initialization completed.
TE=3DOFF
CHKEXEC=3DOFF
CHKSHLIB=3DOFF
CHKSCRIPT=3DOFF
CHKKERNEXT=3DOFF
STOP_UNTRUSTD=3DOFF
STOP_ON_CHKFAIL=3DOFF
LOCK_KERN_POLICIES=3DOFF
TSD_FILES_LOCK=3DOFF
TSD_LOCK=3DOFF
TEP=3DOFF
TLP=3DOFF
Successfully updated the Kernel Authorization Table.
Successfully updated the Kernel Role Table.
Successfully updated the Kernel Command Table.
Successfully updated the Kernel Device Table.
Successfully updated the Kernel Object Domain Table.
Successfully updated the Kernel Domains Table.
Successfully updated the Kernel RBAC log level.
Successfully updated the Kernel RBAC log level.
OPERATIONAL MODE Security Flags
ROOT                      :    ENABLED
TRACEAUTH                 :   DISABLED
System runtime mode is now OPERATIONAL MODE.
Setting tunable parameters...complete
Checking for srcmstr active...complete
Starting tcpip daemons:
0513-059 The sendmail Subsystem has been started. Subsystem PID is 4456846.
0513-059 The syslogd Subsystem has been started. Subsystem PID is 4522382.
0513-059 The portmap Subsystem has been started. Subsystem PID is 4194776.
0513-059 The inetd Subsystem has been started. Subsystem PID is 4129230.
0513-059 The snmpmibd Subsystem has been started. Subsystem PID is 4325672.
Finished starting tcpip daemons.


AIX Version 7
Copyright IBM Corporation, 1982, 2019.
Console login: root
root's Password:

***************************************************************************=
****
*                                                                          =
   *
*                                                                          =
   *
*  Welcome to AIX Version 7.2!                                             =
   *
*                                                                          =
   *
*                                                                          =
   *
*  Please see the README file in /usr/lpp/bos for information pertinent to =
   *
*  this release of the AIX Operating System.                               =
   *
*                                                                          =
   *
*                                                                          =
   *
***************************************************************************=
****
Last login: Wed Apr 22 07:21:19 EDT 2020 on /dev/vty0

root@aix-ppc64# oslevel -s
7200-04-01-1939
root@aix-ppc64#

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1874264

Title:
  AIX 7.2 TL4 SP1 cannot IPL with QEMU >2.11.2 ppc64-softmmu

Status in QEMU:
  New

Bug description:
  kens@LAPTOP-JN77KAC2$ qemu-system-ppc64 -version
  QEMU emulator version 4.2.93 (v5.0.0-rc3-8-g3119154db0-dirty)
  Copyright (c) 2003-2020 Fabrice Bellard and the QEMU Project developers

  qemu-system-ppc64 \
    -name "IBM AIX - IBM POWER9" \
    -M pseries \
    -cpu POWER9 \
    -smp 8 \
    -m 8192 \
    -nodefaults \
    -nographic \
    -prom-env input-device=3D/vdevice/vty@71000000 \
    -prom-env output-device=3D/vdevice/vty@71000000 \
    -serial tcp::9019,server,nowait \
    -monitor tcp::9020,server,nowait \
    -netdev type=3Duser,id=3Dmynet0,hostfwd=3Dtcp:127.0.0.1:9018-10.0.2.18:=
22 \
    -device virtio-net-pci,netdev=3Dmynet0 \
    -drive file=3Dimages/aix-ppc64.img,format=3Dqcow2,if=3Dnone,id=3Dhd,med=
ia=3Ddisk,cache=3Dunsafe \
    -device virtio-scsi-pci,id=3Dscsi -device scsi-hd,drive=3Dhd \
    -drive file=3Dimages/iso/blank-cdrom,format=3Draw,media=3Dcdrom,cache=
=3Dunsafe

  -------------------------------------------------------------------------=
------
                                  Welcome to AIX.
                     boot image timestamp: 14:18:40 03/27/2020
          processor count: 8;  memory size: 8192MB;  kernel size: 45422205
           boot device: /pci@800000020000000/scsi@1/disk@100000000000000
  =0CAIX vm,uuid property contains invalid data
  processing splpar characteristic: MaxEntCap
  processing splpar characteristic: DesMem
  processing splpar characteristic: DesProcs
  processing splpar characteristic: MaxPlatProcs
  processing splpar characteristic: HostThrs

  AKVM: hcall-multi-tce detected but overridden, allow with "multce" boot a=
rgument
  -------------------------------------------------------------------------=
------
  =0CStarqemu-system-ppc64: OS terminated: 888 102 700 C20

  =

  qemu-system-ppc64 \
    -name "IBM AIX - IBM POWER8" \
    -M pseries \
    -cpu POWER8 \
    -smp 8 \
    -m 8192 \
    -nodefaults \
    -nographic \
    -prom-env input-device=3D/vdevice/vty@71000000 \
    -prom-env output-device=3D/vdevice/vty@71000000 \
    -serial tcp::9019,server,nowait \
    -monitor tcp::9020,server,nowait \
    -netdev type=3Duser,id=3Dmynet0,hostfwd=3Dtcp:127.0.0.1:9018-10.0.2.18:=
22 \
    -device virtio-net-pci,netdev=3Dmynet0 \
    -drive file=3Dimages/aix-ppc64.img,format=3Dqcow2,if=3Dnone,id=3Dhd,med=
ia=3Ddisk,cache=3Dunsafe \
    -device virtio-scsi-pci,id=3Dscsi -device scsi-hd,drive=3Dhd \
    -drive file=3Dimages/iso/blank-cdrom,format=3Draw,media=3Dcdrom,cache=
=3Dunsafe

  -------------------------------------------------------------------------=
------
                                  Welcome to AIX.
                     boot image timestamp: 14:18:40 03/27/2020
          processor count: 8;  memory size: 8192MB;  kernel size: 45422205
           boot device: /pci@800000020000000/scsi@1/disk@100000000000000
  =0CAIX vm,uuid property contains invalid data
  processing splpar characteristic: MaxEntCap
  processing splpar characteristic: DesMem
  processing splpar characteristic: DesProcs
  processing splpar characteristic: MaxPlatProcs
  processing splpar characteristic: HostThrs

  AKVM: hcall-multi-tce detected but overridden, allow with "multce" boot a=
rgument
  -------------------------------------------------------------------------=
------
  =0CStar**
  ERROR:/home/kens/tmp/qemu/cpus.c:1727:qemu_tcg_cpu_thread_fn: assertion f=
ailed: (cpu->halted)

  =

  kens@LAPTOP-JN77KAC2$ qemu-system-ppc64 -version
  QEMU emulator version 2.11.2
  Copyright (c) 2003-2017 Fabrice Bellard and the QEMU Project developers

  qemu-system-ppc64 \
    -name "IBM AIX - IBM POWER9" \
    -M pseries,cap-htm=3Doff \
    -cpu POWER9 \
    -smp 8 \
    -m 8192 \
    -nodefaults \
    -nographic \
    -prom-env input-device=3D/vdevice/vty@71000000 \
    -prom-env output-device=3D/vdevice/vty@71000000 \
    -serial tcp::9019,server,nowait \
    -monitor tcp::9020,server,nowait \
    -netdev type=3Duser,id=3Dmynet0,hostfwd=3Dtcp:127.0.0.1:9018-10.0.2.18:=
22 \
    -device virtio-net-pci,netdev=3Dmynet0 \
    -drive file=3Dimages/aix-ppc64.img,format=3Dqcow2,if=3Dnone,id=3Dhd,med=
ia=3Ddisk,cache=3Dunsafe \
    -device virtio-scsi-pci,id=3Dscsi -device scsi-hd,drive=3Dhd \
    -drive file=3Dimages/iso/blank-cdrom,format=3Draw,media=3Dcdrom,cache=
=3Dunsafe

  -------------------------------------------------------------------------=
------
                                  Welcome to AIX.
                     boot image timestamp: 14:18:40 03/27/2020
          processor count: 8;  memory size: 8192MB;  kernel size: 45422205
           boot device: /pci@800000020000000/scsi@1/disk@100000000000000
  =0CAIX vm,uuid property contains invalid data
  processing splpar characteristic: MaxEntCap
  processing splpar characteristic: DesMem
  processing splpar characteristic: DesProcs
  processing splpar characteristic: MaxPlatProcs

  AKVM: hcall-multi-tce detected but overridden, allow with "multce" boot a=
rgument
  -------------------------------------------------------------------------=
------
  =0CStar
  0539
  0811
  0539
  0812
  0708
  0811
  0811
  0811
  0811
  0811
  0811
  0811
  0811
  078c
  25b6
  25b6
  25b6
  25b6
  25b6
  25b6
  25b6
  25b6
  25b6
  25b6
  25b6
  078c
  0539
  2071
  0539
  2073
  0539
  25b3vscsi_send_capabilities: capabilities size mismatch !
  VSCSI: Unknown MAD type 09

  0539
  0538
  0539
  0591
  0539
  0538
  0539
  0538
  0539
  25b0
  0539

  0511
  0551
  0517
  0517
  0517
  0517
  0553
  0517
  0517
  0538
  0539
  0538
  0539
  270b
  0539
  0538
  0539
  2070
  0539
  0538
  0539
  0811
  0539
  0811
  0539
  0812
  0708
  0811
  0811
  0811
  0811
  0811
  0811
  0811
  0811
  078c
  25b6
  25b6
  25b6
  25b6
  25b6
  25b6
  25b6
  25b6
  25b6
  25b6
  25b6
  078c
  04ee
  078c
  0727
  0727
  2071
  2072
  2072
  2071
  0539
  25b3
  0539
  25b5
  0539
  0538
  0539
  0538
  0539
  0538
  0539
  0538
  0539
  0538
  0581
  0539
  0538
  0539
  7000
  0539
  0538
  0539
  0538
  0539
  0538
  0581
  0581
  0539
  0538
  0539
  25b0
  0539
  0538
  0539
  0538
  0539
  0731
  0539
  0538
  0539
  0538
  0539
  0538
  0539
  0538
  0539
  0538
  0539
  0538
  0539
  0538
  0539
  0538
  0539
  0538
  0539
  0538
  0539
  0538
  0539
  0538
  0539
  0538
  0539
  0538
  0539
  0538
  0539
  0538
  0539
  0538
  0539
  0538
  0539
  0538
  0539
  2028
  0539
  0538
  0539

  0c33
  Saving Base Customize Data to boot disk
  Starting the sync daemon
  Starting the error daemon

  System initialization completed.
  TE=3DOFF
  CHKEXEC=3DOFF
  CHKSHLIB=3DOFF
  CHKSCRIPT=3DOFF
  CHKKERNEXT=3DOFF
  STOP_UNTRUSTD=3DOFF
  STOP_ON_CHKFAIL=3DOFF
  LOCK_KERN_POLICIES=3DOFF
  TSD_FILES_LOCK=3DOFF
  TSD_LOCK=3DOFF
  TEP=3DOFF
  TLP=3DOFF
  Successfully updated the Kernel Authorization Table.
  Successfully updated the Kernel Role Table.
  Successfully updated the Kernel Command Table.
  Successfully updated the Kernel Device Table.
  Successfully updated the Kernel Object Domain Table.
  Successfully updated the Kernel Domains Table.
  Successfully updated the Kernel RBAC log level.
  Successfully updated the Kernel RBAC log level.
  OPERATIONAL MODE Security Flags
  ROOT                      :    ENABLED
  TRACEAUTH                 :   DISABLED
  System runtime mode is now OPERATIONAL MODE.
  Setting tunable parameters...complete
  Checking for srcmstr active...complete
  Starting tcpip daemons:
  0513-059 The sendmail Subsystem has been started. Subsystem PID is 445684=
6.
  0513-059 The syslogd Subsystem has been started. Subsystem PID is 4522382.
  0513-059 The portmap Subsystem has been started. Subsystem PID is 4194776.
  0513-059 The inetd Subsystem has been started. Subsystem PID is 4129230.
  0513-059 The snmpmibd Subsystem has been started. Subsystem PID is 432567=
2.
  Finished starting tcpip daemons.

  =

  AIX Version 7
  Copyright IBM Corporation, 1982, 2019.
  Console login: root
  root's Password:

  *************************************************************************=
******
  *                                                                        =
     *
  *                                                                        =
     *
  *  Welcome to AIX Version 7.2!                                           =
     *
  *                                                                        =
     *
  *                                                                        =
     *
  *  Please see the README file in /usr/lpp/bos for information pertinent t=
o    *
  *  this release of the AIX Operating System.                             =
     *
  *                                                                        =
     *
  *                                                                        =
     *
  *************************************************************************=
******
  Last login: Wed Apr 22 07:21:19 EDT 2020 on /dev/vty0

  root@aix-ppc64# oslevel -s
  7200-04-01-1939
  root@aix-ppc64#

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1874264/+subscriptions

