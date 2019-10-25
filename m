Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E24CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 20:34:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3948205F4
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 20:34:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3948205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO6Hj-00074s-Kb
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 16:34:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34317)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1iO69e-0002gv-6b
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 16:25:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1iO69c-0003QA-HF
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 16:25:50 -0400
Received: from indium.canonical.com ([91.189.90.7]:37240)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1iO69c-0003Pv-AH
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 16:25:48 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1iO69a-00064w-M8
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 20:25:46 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 7C14A2E80C3
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 20:25:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Oct 2019 20:15:12 -0000
From: Witold Baryluk <1849894@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: baryluk
X-Launchpad-Bug-Reporter: Witold Baryluk (baryluk)
X-Launchpad-Bug-Modifier: Witold Baryluk (baryluk)
Message-Id: <157203451253.3372.9480827920211406597.malonedeb@gac.canonical.com>
Subject: [Bug 1849894] [NEW] hw/scsi/scsi-disk.c line 2554 allocation overflow
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="469f241f4e73cc0bdffa4e30654052a2af068e06";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 3569849f91bd78a7cf5ff2a38c9b16110b3b445b
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
Reply-To: Bug 1849894 <1849894@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

When compiling qemu from git master (at commit
03bf012e523ecdf047ac56b2057950247256064d ) on Linux amd64, with gcc-9
9.2.1 , and using `-march=3Dnative -flto`, during linking of most target
binaries, compiler does detect an issue with allocation in
scsi_disk_new_request_dump and aborts compilation.


make[1]: Entering directory '/home/user/qemu/slirp'
make[1]: Nothing to be done for 'all'.
make[1]: Leaving directory '/home/user/qemu/slirp'
nm: stats64.o: no symbols
  LINK    aarch64-softmmu/qemu-system-aarch64
In function =E2=80=98scsi_disk_new_request_dump=E2=80=99,
    inlined from =E2=80=98scsi_new_request=E2=80=99 at hw/scsi/scsi-disk.c:=
2580:9,
    inlined from =E2=80=98scsi_new_request=E2=80=99 at hw/scsi/scsi-disk.c:=
2564:21:
hw/scsi/scsi-disk.c:2554:19: error: argument 1 value =E2=80=981844674407370=
9551612=E2=80=99 exceeds maximum object size 9223372036854775807 [-Werror=
=3Dalloc-size-larger-than=3D]
hw/scsi/scsi-disk.c: In function =E2=80=98scsi_new_request=E2=80=99:
/usr/include/glib-2.0/glib/gmem.h:78:10: note: in a call to allocation func=
tion =E2=80=98g_malloc=E2=80=99 declared here
   78 | gpointer g_malloc         (gsize  n_bytes) G_GNUC_MALLOC G_GNUC_ALL=
OC_SIZE(1);
      |          ^
lto1: all warnings being treated as errors
lto-wrapper: fatal error: c++ returned 1 exit status
compilation terminated.
/usr/bin/ld: error: lto-wrapper failed
collect2: error: ld returned 1 exit status


same happens for most other targets: alpha-softmmu/qemu-system-alpha
arm-softmmu/qemu-system-arm hppa-softmmu/qemu-system-hppa i386-softmmu
/qemu-system-i386 lm32-softmmu/qemu-system-lm32 mips-softmmu/qemu-
system-mips mips64-softmmu/qemu-system-mips64 mips64el-softmmu/qemu-
system-mips64el mipsel-softmmu/qemu-system-mipsel ppc-softmmu/qemu-
system-ppc ppc64-softmmu/qemu-system-ppc64 riscv32-softmmu/qemu-system-
riscv32 riscv64-softmmu/qemu-system-riscv64 s390x-softmmu/qemu-system-
s390x sh4-softmmu/qemu-system-sh4 sh4eb-softmmu/qemu-system-sh4eb sparc-
softmmu/qemu-system-sparc sparc64-softmmu/qemu-system-sparc64
x86_64-softmmu/qemu-system-x86_64 xtensa-softmmu/qemu-system-xtensa
xtensaeb-softmmu/qemu-system-xtensaeb

Notice -softmmu being a common factor here.


The size of the allocation for the temporary buffer for dumping using
snprintf is determined based on the size of the buffer via call to
scsi_cdb_length. I believe the heavy inlining and constant propagation
makes scsi_cdb_length return -1, so len =3D -1. Then allocation size is
5*len + 1, or -4. Which overflows to 2^64 - 4 or so.

The case of len=3D=3D-1 from scsi_cdb_length happens if the (buf[0] >> 5) is
not 0, 1, 2, 4 or 5.

However, I can't find out how gcc figures out that buf[0] is not one of
these variables. To me looking at this function, compiler should not
know anything about buf[0].

I tried following the chain of calls back, including devirtualize
alloc_req, and I found scsi_device_alloc_req calling these alloc_req
callbacks, but it is itself called from scsi_req_new, which is called in
get_scsi_requests , just after buf is filled from QEMUFile using
qemu_get_buffer, which ultimately goes even further into read paths,
which there might be many AFAIK.


glib2 version 2.62.1-1

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1849894

Title:
  hw/scsi/scsi-disk.c line 2554 allocation overflow

Status in QEMU:
  New

Bug description:
  When compiling qemu from git master (at commit
  03bf012e523ecdf047ac56b2057950247256064d ) on Linux amd64, with gcc-9
  9.2.1 , and using `-march=3Dnative -flto`, during linking of most target
  binaries, compiler does detect an issue with allocation in
  scsi_disk_new_request_dump and aborts compilation.

  =

  make[1]: Entering directory '/home/user/qemu/slirp'
  make[1]: Nothing to be done for 'all'.
  make[1]: Leaving directory '/home/user/qemu/slirp'
  nm: stats64.o: no symbols
    LINK    aarch64-softmmu/qemu-system-aarch64
  In function =E2=80=98scsi_disk_new_request_dump=E2=80=99,
      inlined from =E2=80=98scsi_new_request=E2=80=99 at hw/scsi/scsi-disk.=
c:2580:9,
      inlined from =E2=80=98scsi_new_request=E2=80=99 at hw/scsi/scsi-disk.=
c:2564:21:
  hw/scsi/scsi-disk.c:2554:19: error: argument 1 value =E2=80=9818446744073=
709551612=E2=80=99 exceeds maximum object size 9223372036854775807 [-Werror=
=3Dalloc-size-larger-than=3D]
  hw/scsi/scsi-disk.c: In function =E2=80=98scsi_new_request=E2=80=99:
  /usr/include/glib-2.0/glib/gmem.h:78:10: note: in a call to allocation fu=
nction =E2=80=98g_malloc=E2=80=99 declared here
     78 | gpointer g_malloc         (gsize  n_bytes) G_GNUC_MALLOC G_GNUC_A=
LLOC_SIZE(1);
        |          ^
  lto1: all warnings being treated as errors
  lto-wrapper: fatal error: c++ returned 1 exit status
  compilation terminated.
  /usr/bin/ld: error: lto-wrapper failed
  collect2: error: ld returned 1 exit status


  same happens for most other targets: alpha-softmmu/qemu-system-alpha
  arm-softmmu/qemu-system-arm hppa-softmmu/qemu-system-hppa i386-softmmu
  /qemu-system-i386 lm32-softmmu/qemu-system-lm32 mips-softmmu/qemu-
  system-mips mips64-softmmu/qemu-system-mips64 mips64el-softmmu/qemu-
  system-mips64el mipsel-softmmu/qemu-system-mipsel ppc-softmmu/qemu-
  system-ppc ppc64-softmmu/qemu-system-ppc64 riscv32-softmmu/qemu-
  system-riscv32 riscv64-softmmu/qemu-system-riscv64 s390x-softmmu/qemu-
  system-s390x sh4-softmmu/qemu-system-sh4 sh4eb-softmmu/qemu-system-
  sh4eb sparc-softmmu/qemu-system-sparc sparc64-softmmu/qemu-system-
  sparc64 x86_64-softmmu/qemu-system-x86_64 xtensa-softmmu/qemu-system-
  xtensa xtensaeb-softmmu/qemu-system-xtensaeb

  Notice -softmmu being a common factor here.


  The size of the allocation for the temporary buffer for dumping using
  snprintf is determined based on the size of the buffer via call to
  scsi_cdb_length. I believe the heavy inlining and constant propagation
  makes scsi_cdb_length return -1, so len =3D -1. Then allocation size is
  5*len + 1, or -4. Which overflows to 2^64 - 4 or so.

  The case of len=3D=3D-1 from scsi_cdb_length happens if the (buf[0] >> 5)
  is not 0, 1, 2, 4 or 5.

  However, I can't find out how gcc figures out that buf[0] is not one
  of these variables. To me looking at this function, compiler should
  not know anything about buf[0].

  I tried following the chain of calls back, including devirtualize
  alloc_req, and I found scsi_device_alloc_req calling these alloc_req
  callbacks, but it is itself called from scsi_req_new, which is called
  in  get_scsi_requests , just after buf is filled from QEMUFile using
  qemu_get_buffer, which ultimately goes even further into read paths,
  which there might be many AFAIK.


  =

  glib2 version 2.62.1-1

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1849894/+subscriptions

