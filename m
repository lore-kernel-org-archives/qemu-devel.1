Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C1CC43446
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 14:21:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F18322070B
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 14:21:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F18322070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k040n-0005nT-7b
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 10:21:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49098)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k03zr-0004sF-SC
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 10:20:55 -0400
Received: from indium.canonical.com ([91.189.90.7]:52906)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k03zp-00088a-Gq
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 10:20:55 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1k03zl-0007uu-H4
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2020 14:20:49 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 286772E8116
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2020 14:20:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2020 14:13:33 -0000
From: Hgkamath <1889033@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: hgkamath
X-Launchpad-Bug-Reporter: Hgkamath (hgkamath)
X-Launchpad-Bug-Modifier: Hgkamath (hgkamath)
References: <159582569332.29849.16382151377697591855.malonedeb@chaenomeles.canonical.com>
Message-Id: <159585921361.17570.17942250251784724267.malone@soybean.canonical.com>
Subject: [Bug 1889033] Re: qemu-img permission denied on vmdk creation on CIFS
 share
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="e85d0ab92e2924d39b8285aeae075a01d25eff06";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: b1de5a6fa52c84d97abab3451e78db05e57d55ec
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 09:56:02
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Reply-To: Bug 1889033 <1889033@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I retract comment "a)I would have expected that the monolithic flat
would have created only one large file just like sparse, but it seems to
create a description file, in addition to the storing file."

pdf vmdk_specs-1.pdf "Virtual Disk Format 1.1" (https://www.vmware.com/app/=
vmdk/?src=3Dvmdk) on page 7, line-34, a note is mentioned that says that is=
 just how it is. =

"A virtual disk described as monolithic and flat consists of two files. One=
 file contains the descriptor. The other file is the extent used to store v=
irtual machine data"

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1889033

Title:
  qemu-img permission denied on vmdk creation on CIFS share

Status in QEMU:
  New

Bug description:
  =

  - on a CIFS mount qemu-img claims not to have permissions to write into a=
 file.
  - VMDK sparse file creation succeeds
  - VMDK Flat file creation create the flat-file, but fails to write the de=
scription-file
  - VMDK flat file creation succeeds on native linux mount such as ~/tmp or=
 /tmp
  - same effect as root or non-root
  - same effect with selinux setenforce 0

  a) I would have expected that the monolithic flat would have created only=
 one large file just like sparse, but it seems to create a description file=
, in addition to the storing file.
  b) I am aware that qemu-img may have problem opening very large files on =
CIFS, however, this file is not very large

  Windows-10 latest updated 2004 19041.388
  Linux VM, Fedora-32 in Virtualbox 6.1.12 =

  # rpm -qa | grep  qemu-img
  qemu-img-4.2.0-7.fc32.x86_64

  mount options: =

  mount -t cifs //10.x,x,x/$shname  /mnt/hshare -o defaults,username=3Dgana=
,rw,uid=3D1000,gid=3D1000,vers=3D3.0

  [root@fedora ~]# cd /mnt/hshare/some/folder/createvmdk/
  [root@fedora createvmdk]# qemu-img create -f vmdk test1.vmdk 100M -o subf=
ormat=3DmonolithicFlat
  Formatting 'test1.vmdk', fmt=3Dvmdk size=3D104857600 compat6=3Doff hwvers=
ion=3Dundefined subformat=3DmonolithicFlat
  qemu-img: test1.vmdk: Could not write description: Permission denied
  [root@fedora createvmdk]# ls -l test1*.*
  -rwxr-xr-x. 1 gana gana 104857600 Jul 26 23:02 test1-flat.vmdk
  -rwxr-xr-x. 1 gana gana         0 Jul 26 23:02 test1.vmdk
  [root@fedora createvmdk]# du -k test1*.*
  0       test1-flat.vmdk
  0       test1.vmdk
  # (doesn't seem to be really flat)

  creation in /tmp works
  # cd /tmp
  [root@fedora tmp]# qemu-img create -f vmdk test1.vmdk 100M -o subformat=
=3DmonolithicFlat
  Formatting 'test1.vmdk', fmt=3Dvmdk size=3D104857600 compat6=3Doff hwvers=
ion=3Dundefined subformat=3DmonolithicFlat
  [root@fedora tmp]# ls -l /tmp/test1*.*
  -rw-r--r--. 1 root root 104857600 Jul 26 22:43 /tmp/test1-flat.vmdk
  -rw-r--r--. 1 root root       313 Jul 26 22:43 /tmp/test1.vmdk
  [root@fedora createvmdk]# du -k /tmp/test1*.*
  4       /tmp/test1-flat.vmdk
  4       /tmp/test1.vmdk

  [root@fedora createvmdk]# cat /tmp/test1.vmdk
  # Disk DescriptorFile
  version=3D1
  CID=3D5f13c13d
  parentCID=3Dffffffff
  createType=3D"monolithicFlat"

  # Extent description
  RW 204800 FLAT "test1-flat.vmdk" 0

  # The Disk Data Base
  #DDB

  ddb.virtualHWVersion =3D "4"
  ddb.geometry.cylinders =3D "203"
  ddb.geometry.heads =3D "16"
  ddb.geometry.sectors =3D "63"
  ddb.adapterType =3D "ide"

  =

  On the other-hand creating a sparse file works
  cd /mnt/hshare/some/folder/createvmdk/
  [root@fedora createvmdk]# qemu-img create -f vmdk test2.vmdk 100M -o subf=
ormat=3DmonolithicSparse
  Formatting 'test2.vmdk', fmt=3Dvmdk size=3D104857600 compat6=3Doff hwvers=
ion=3Dundefined subformat=3DmonolithicSparse
  [root@fedora createvmdk]# ls l test2*.*
  -rwxr-xr-x. 1 gana gana     65536 Jul 26 22:52 test2.vmdk
  [root@fedora createvmdk]#  du -k  /tmp/test2*.*
  12      /tmp/test2.vmdk

  test2.vmdk is a binary file
  inside it, located among garbled ascii characters is an embedded VMDK des=
cription
  ````
  # Disk DescriptorFile
  version=3D1
  CID=3Dcf302a20
  parentCID=3Dffffffff
  createType=3D"monolithicSparse"

  # Extent description
  RW 204800 SPARSE "test2.vmdk"

  # The Disk Data Base
  #DDB

  ddb.virtualHWVersion =3D "4"
  ddb.geometry.cylinders =3D "203"
  ddb.geometry.heads =3D "16"
  ddb.geometry.sectors =3D "63"
  ddb.adapterType =3D "ide"
  ```

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1889033/+subscriptions

