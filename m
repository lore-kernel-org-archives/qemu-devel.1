Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA63FC48BD7
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 03:41:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A060A20989
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 03:41:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A060A20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgLI6-00051w-AR
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 23:41:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39235)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bounces@canonical.com>) id 1hgLHF-0004av-4K
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 23:40:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1hgLHD-0008B2-NV
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 23:40:49 -0400
Received: from indium.canonical.com ([91.189.90.7]:47728)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1hgLHD-0008A9-GH
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 23:40:47 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1hgLHB-0004pb-GA
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2019 03:40:45 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 6DADD2E80C7
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2019 03:40:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Jun 2019 03:34:31 -0000
From: Kai <1834399@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=capstone; status=New; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: neil007
X-Launchpad-Bug-Reporter: Kai (neil007)
X-Launchpad-Bug-Modifier: Kai (neil007)
Message-Id: <156160647178.17582.14349839554314537194.malonedeb@gac.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18991";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: ee00c8fbf963edf76daf07df84d5442111f83b78
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1834399] [NEW] AArch64: branch out of range
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
Reply-To: Bug 1834399 <1834399@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

I build lib32-qemu which is a multilib variant for mips o32 on project
Yocto with qemumips64. It finally runs command and fails:


mips-wrsmllib32-linux-gcc  -meb -mabi=3D32 -mhard-float -fstack-protector-s=
trong   -Wformat -Wformat-security -Werror=3Dformat-security --sysroot=3D/m=
nt/docker/LIN1019-1459-ubuntu1604/tmp-glibc/work/mips-wrsmllib32-linux/lib3=
2-qemu/4.0.0-r0/lib32-recipe-sysroot =

-I/mnt/docker/LIN1019-1459-ubuntu1604/tmp-glibc/work/mips-wrsmllib32-linux/=
lib32-qemu/4.0.0-r0/lib32-recipe-sysroot/usr/include/pixman-1 -I/mnt/docker=
/LIN1019-1459-ubuntu1604/tmp-glibc/work/mips-wrsmllib32-linux/lib32-qemu/4.=
0.0-r0/qemu-4.0.0/dtc/libfdt -pthread -I/mnt/docker/LIN1019-1459-ubuntu1604=
/tmp-glibc/work/mips-wrsmllib32-linux/lib32-qemu/4.0.0-r0/lib32-recipe-sysr=
oot/usr/include/glib-2.0 -I/mnt/docker/LIN1019-1459-ubuntu1604/tmp-glibc/wo=
rk/mips-wrsmllib32-linux/lib32-qemu/4.0.0-r0/lib32-recipe-sysroot/usr/lib/g=
lib-2.0/include
-D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE -Og -g =

-I/mnt/docker/LIN1019-1459-ubuntu1604/tmp-glibc/work/mips-wrsmllib32-linux/=
lib32-qemu/4.0.0-r0/qemu-4.0.0/capstone/include -I/mnt/docker/LIN1019-1459-=
ubuntu1604/tmp-glibc/work/mips-wrsmllib32-linux/lib32-qemu/4.0.0-r0/qemu-4.=
0.0/tests =

-DCAPSTONE_USE_SYS_DYN_MEM -DCAPSTONE_HAS_ARM -DCAPSTONE_HAS_ARM64 -DCAPSTO=
NE_HAS_POWERPC -DCAPSTONE_HAS_X86
-c arch/AArch64/AArch64InstPrinter.c -o /mnt/docker/LIN1019-1459-ubuntu1604=
/tmp-glibc/work/mips-wrsmllib32-linux/lib32-qemu/4.0.0-r0/build/capstone/ob=
j/arch/AArch64/AArch64InstPrinter.o


And error messages:

{standard input}: Assembler messages:
{standard input}:38045: Error: branch out of range
{standard input}:38269: Error: branch out of range
{standard input}:38493: Error: branch out of range
{standard input}:38717: Error: branch out of range
{standard input}:38941: Error: branch out of range
{standard input}:39165: Error: branch out of range
{standard input}:39389: Error: branch out of range
{standard input}:39613: Error: branch out of range
{standard input}:39728: Error: branch out of range
{standard input}:39990: Error: branch out of range
{standard input}:40252: Error: branch out of range
{standard input}:40514: Error: branch out of range
{standard input}:40776: Error: branch out of range
{standard input}:41038: Error: branch out of range


The gcc version is 9.1. I have verified that gcc 8.3 works. And there is no=
 error when remove option '-Og' with gcc 9.1.

I am not sure whether it is a defect of gcc 9.1 or capstone. Should it
be fixed in capstone? Thanks.

** Affects: capstone
     Importance: Undecided
         Status: New

** Project changed: qemu =3D> capstone

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1834399

Title:
  AArch64: branch out of range

Status in Capstone:
  New

Bug description:
  I build lib32-qemu which is a multilib variant for mips o32 on project
  Yocto with qemumips64. It finally runs command and fails:

  =

  mips-wrsmllib32-linux-gcc  -meb -mabi=3D32 -mhard-float -fstack-protector=
-strong   -Wformat -Wformat-security -Werror=3Dformat-security --sysroot=3D=
/mnt/docker/LIN1019-1459-ubuntu1604/tmp-glibc/work/mips-wrsmllib32-linux/li=
b32-qemu/4.0.0-r0/lib32-recipe-sysroot =

  -I/mnt/docker/LIN1019-1459-ubuntu1604/tmp-glibc/work/mips-wrsmllib32-linu=
x/lib32-qemu/4.0.0-r0/lib32-recipe-sysroot/usr/include/pixman-1 -I/mnt/dock=
er/LIN1019-1459-ubuntu1604/tmp-glibc/work/mips-wrsmllib32-linux/lib32-qemu/=
4.0.0-r0/qemu-4.0.0/dtc/libfdt -pthread -I/mnt/docker/LIN1019-1459-ubuntu16=
04/tmp-glibc/work/mips-wrsmllib32-linux/lib32-qemu/4.0.0-r0/lib32-recipe-sy=
sroot/usr/include/glib-2.0 -I/mnt/docker/LIN1019-1459-ubuntu1604/tmp-glibc/=
work/mips-wrsmllib32-linux/lib32-qemu/4.0.0-r0/lib32-recipe-sysroot/usr/lib=
/glib-2.0/include
  -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE -Og -g =

  -I/mnt/docker/LIN1019-1459-ubuntu1604/tmp-glibc/work/mips-wrsmllib32-linu=
x/lib32-qemu/4.0.0-r0/qemu-4.0.0/capstone/include -I/mnt/docker/LIN1019-145=
9-ubuntu1604/tmp-glibc/work/mips-wrsmllib32-linux/lib32-qemu/4.0.0-r0/qemu-=
4.0.0/tests =

  -DCAPSTONE_USE_SYS_DYN_MEM -DCAPSTONE_HAS_ARM -DCAPSTONE_HAS_ARM64 -DCAPS=
TONE_HAS_POWERPC -DCAPSTONE_HAS_X86
  -c arch/AArch64/AArch64InstPrinter.c -o /mnt/docker/LIN1019-1459-ubuntu16=
04/tmp-glibc/work/mips-wrsmllib32-linux/lib32-qemu/4.0.0-r0/build/capstone/=
obj/arch/AArch64/AArch64InstPrinter.o


  And error messages:

  {standard input}: Assembler messages:
  {standard input}:38045: Error: branch out of range
  {standard input}:38269: Error: branch out of range
  {standard input}:38493: Error: branch out of range
  {standard input}:38717: Error: branch out of range
  {standard input}:38941: Error: branch out of range
  {standard input}:39165: Error: branch out of range
  {standard input}:39389: Error: branch out of range
  {standard input}:39613: Error: branch out of range
  {standard input}:39728: Error: branch out of range
  {standard input}:39990: Error: branch out of range
  {standard input}:40252: Error: branch out of range
  {standard input}:40514: Error: branch out of range
  {standard input}:40776: Error: branch out of range
  {standard input}:41038: Error: branch out of range

  =

  The gcc version is 9.1. I have verified that gcc 8.3 works. And there is =
no error when remove option '-Og' with gcc 9.1.

  I am not sure whether it is a defect of gcc 9.1 or capstone. Should it
  be fixed in capstone? Thanks.

To manage notifications about this bug go to:
https://bugs.launchpad.net/capstone/+bug/1834399/+subscriptions

