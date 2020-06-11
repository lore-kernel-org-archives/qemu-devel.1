Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	LOTS_OF_MONEY,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE5BC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 10:11:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B448F20747
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 10:11:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B448F20747
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjKBJ-0002sm-Uc
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 06:11:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50120)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jjKAe-0002QD-7x
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 06:10:52 -0400
Received: from indium.canonical.com ([91.189.90.7]:51500)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jjKAc-00075k-VK
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 06:10:51 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jjKAb-0007ei-05
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2020 10:10:49 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id F233D2E8047
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2020 10:10:48 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2020 10:03:36 -0000
From: P J P <1883083@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: qemu
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: pjps
X-Launchpad-Bug-Reporter: P J P (pjps)
X-Launchpad-Bug-Modifier: P J P (pjps)
Message-Id: <159186981638.8308.16825672026309340419.malonedeb@gac.canonical.com>
Subject: [Bug 1883083] [NEW] QEMU: block/vvfat driver issues
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="b190cebbf563f89e480a8b57f641753c8196bda0";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: eb10c71b1bf3cf7e8e5b8805fecee846a2355d6b
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 04:11:21
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, HEADER_FROM_DIFFERENT_DOMAINS=1,
 LOTS_OF_MONEY=0.001, RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=_AUTOLEARN
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
Reply-To: Bug 1883083 <1883083@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

Nathan Huckleberry <nhuck15@gmail.com> has reported following issues in
the block/vvfat driver for the virtual VFAT file system image, used to
share a host system directory with a guest VM.

Please note:
  -> https://www.qemu.org/docs/master/system/images.html#virtual-fat-disk-i=
mages

Virtual VFAT read/write support is available only for (beta) testing
purposes.

Following issues are reproducible with:

   host)$ ./bin/qemu-system-x86_64 -nographic -enable-kvm \
              -drive file=3Dfat:rw:/tmp/var/run/,index=3D2  -m 2048 /var/li=
b/libvirt/images/f27vm.qcow2

  guest)# mount -t vfat /dev/sdb1 /mnt/

The attached reproducers (run inside a guest) include:

1. dir.sh: - directory traversal on the host
   - It creates a file under /mnt/yyyy
   - Then edits the VFAT directory entry to make it -> /mnt/../y
   - The handle_renames_and_mkdirs() routine does not check this new file n=
ame
     and creates a file outside of the shared directory on the host

2. dos.sh: hits an assertion failure in vvfat driver
   - Creates a deep directory tree like - /mnt/0/1/2/3/4/5/6/../29/30/
   - While updating vvfat commits, driver hits an assertion in
     handle_renames_and_mkdirs
       ...
       } else if (commit->action =3D=3D ACTION_MKDIR) {
           ...
           assert(j < s->mapping.next);    <=3D=3D it fails

3. read.sh: reads past vvfat directory entries
   - Creates a file with: echo "x" > /mnt/a
   - Reads past VVFAT directory entry structure with

       # head -c 1000000 $MNTDEV | xxd | grep x -A 512

   - It may disclose some heap addresses.

4. write.sh: heap buffer overflow
   - Creates large number of files as /mnt/file[1..35]
   - while syncing directory tree with the host, driver hits an overflow
     while doing memmove(3) in array_roll() routine

** Affects: qemu
     Importance: Undecided
         Status: New


** Tags: qemu

** Attachment added: "vvfat-reproducers-shared-by-Nathan"
   https://bugs.launchpad.net/bugs/1883083/+attachment/5382870/+files/vvfat=
-issues.tar.xz

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1883083

Title:
  QEMU: block/vvfat driver issues

Status in QEMU:
  New

Bug description:
  Nathan Huckleberry <nhuck15@gmail.com> has reported following issues
  in the block/vvfat driver for the virtual VFAT file system image, used
  to share a host system directory with a guest VM.

  Please note:
    -> https://www.qemu.org/docs/master/system/images.html#virtual-fat-disk=
-images

  Virtual VFAT read/write support is available only for (beta) testing
  purposes.

  Following issues are reproducible with:

     host)$ ./bin/qemu-system-x86_64 -nographic -enable-kvm \
                -drive file=3Dfat:rw:/tmp/var/run/,index=3D2  -m 2048 /var/=
lib/libvirt/images/f27vm.qcow2

    guest)# mount -t vfat /dev/sdb1 /mnt/

  The attached reproducers (run inside a guest) include:

  1. dir.sh: - directory traversal on the host
     - It creates a file under /mnt/yyyy
     - Then edits the VFAT directory entry to make it -> /mnt/../y
     - The handle_renames_and_mkdirs() routine does not check this new file=
 name
       and creates a file outside of the shared directory on the host

  2. dos.sh: hits an assertion failure in vvfat driver
     - Creates a deep directory tree like - /mnt/0/1/2/3/4/5/6/../29/30/
     - While updating vvfat commits, driver hits an assertion in
       handle_renames_and_mkdirs
         ...
         } else if (commit->action =3D=3D ACTION_MKDIR) {
             ...
             assert(j < s->mapping.next);    <=3D=3D it fails

  3. read.sh: reads past vvfat directory entries
     - Creates a file with: echo "x" > /mnt/a
     - Reads past VVFAT directory entry structure with

         # head -c 1000000 $MNTDEV | xxd | grep x -A 512

     - It may disclose some heap addresses.

  4. write.sh: heap buffer overflow
     - Creates large number of files as /mnt/file[1..35]
     - while syncing directory tree with the host, driver hits an overflow
       while doing memmove(3) in array_roll() routine

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1883083/+subscriptions

