Return-Path: <SRS0=/Jg5=XA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42CD8C3A5A5
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 13:36:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95C71207E0
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 13:36:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95C71207E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5rw0-0006Yi-7Z
	for qemu-devel@archiver.kernel.org; Thu, 05 Sep 2019 09:36:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48367)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1i5rvE-00069y-R1
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 09:35:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1i5rvD-00006j-0C
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 09:35:36 -0400
Received: from indium.canonical.com ([91.189.90.7]:47182)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1i5rvB-0008W4-1d
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 09:35:34 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1i5rv9-0001Nw-44
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2019 13:35:31 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 103622E8075
 for <qemu-devel@nongnu.org>; Thu,  5 Sep 2019 13:35:31 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Sep 2019 13:25:43 -0000
From: Marat Salakhutdinov <1842925@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: qemu-img
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: maratsal
X-Launchpad-Bug-Reporter: Marat Salakhutdinov (maratsal)
X-Launchpad-Bug-Modifier: Marat Salakhutdinov (maratsal)
Message-Id: <156768994375.29003.5099707565404830326.malonedeb@chaenomeles.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19044";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 33303c70118c83c2d960e2c16734e088615df2ba
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1842925] [NEW] no batmap on convertion from qcow2
 to vhd
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
Reply-To: Bug 1842925 <1842925@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

we run following version of qemu-img:
$ qemu-img --version
qemu-img version 2.5.0 (Debian 1:2.5+dfsg-5ubuntu10.41), Copyright (c) 2004=
-2008 Fabrice Bellard
$

Here is os version:
$ cat /etc/os-release =

NAME=3D"Ubuntu"
VERSION=3D"16.04.6 LTS (Xenial Xerus)"
ID=3Dubuntu
ID_LIKE=3Ddebian
PRETTY_NAME=3D"Ubuntu 16.04.6 LTS"
VERSION_ID=3D"16.04"
HOME_URL=3D"http://www.ubuntu.com/"
SUPPORT_URL=3D"http://help.ubuntu.com/"
BUG_REPORT_URL=3D"http://bugs.launchpad.net/ubuntu/"
VERSION_CODENAME=3Dxenial
UBUNTU_CODENAME=3Dxenial
$

When we use qemu-img for conversion of qcow2 to vhd newly created file
doesnt show batmap summary when we run:

# vhd-util read -p -n centos76.vhd
VHD Footer Summary:
-------------------
Cookie              : conectix
Features            : (0x00000002) <RESV>
File format version : Major: 1, Minor: 0
Data offset         : 512
Timestamp           : Mon Mar  4 13:21:27 2019
Creator Application : 'qemu'
Creator version     : Major: 5, Minor: 3
Creator OS          : Windows
Original disk size  : 8192 MB (8590417920 Bytes)
Current disk size   : 8192 MB (8590417920 Bytes)
Geometry            : Cyl: 16645, Hds: 16, Sctrs: 63
                    : =3D 8192 MB (8590417920 Bytes)
Disk type           : Dynamic hard disk
Checksum            : 0xfffff119|0xfffff119 (Good!)
UUID                : 23772822-a66c-45a2-be37-8474604147c7
Saved state         : No
Hidden              : 0

VHD Header Summary:
-------------------
Cookie              : cxsparse
Data offset (unusd) : 18446744073709
Table offset        : 1536
Header version      : 0x00010000
Max BAT size        : 4097
Block size          : 2097152 (2 MB)
Parent name         : =

Parent UUID         : 00000000-0000-0000-0000-000000000000
Parent timestamp    : Fri Dec 31 19:00:00 1999
Checksum            : 0xfffff466|0xfffff466 (Good!)

#

I am not so strong in VHD format details and not exactly sure how batmap
is needed, but when I do conversion of qcow2 image by using vhd-util at
the end I get file with proper batmap summary.

In our environment we use CloudStack and Citrix and we use those
converted from qcow2 to vhd images as templates. In general there is no
problems, but whenever we create snapshot out of VM created from such
template vhd-util read command starts giving us error like below:

#
-------------------
Cookie              : conectix
Features            : (0x00000002) <RESV>
File format version : Major: 1, Minor: 0
Data offset         : 512
Timestamp           : Thu Aug 29 16:04:30 2019
Creator Application : 'tap'
Creator version     : Major: 1, Minor: 3
Creator OS          : Unknown!
Original disk size  : 8194 MB (8592031744 Bytes)
Current disk size   : 8194 MB (8592031744 Bytes)
Geometry            : Cyl: 16648, Hds: 16, Sctrs: 63
                    : =3D 8193 MB (8591966208 Bytes)
Disk type           : Dynamic hard disk
Checksum            : 0xfffff074|0xfffff074 (Good!)
UUID                : 2b3cac7d-16e1-4771-b8cd-bb8c7876c761
Saved state         : No
Hidden              : 0

VHD Header Summary:
-------------------
Cookie              : cxsparse
Data offset (unusd) : 18446744073709
Table offset        : 1536
Header version      : 0x00010000
Max BAT size        : 4097
Block size          : 2097152 (2 MB)
Parent name         : =

Parent UUID         : 00000000-0000-0000-0000-000000000000
Parent timestamp    : Sat Jan  1 00:00:00 2000
Checksum            : 0xfffff466|0xfffff466 (Good!)

failed to get batmap header

#

With the templates that show correct batmap summary that are created by
conversion of qcow2 image by vhd-util convert we don't have such
problems.

So I wanted to check with community if not existence of the batmap can
cause (be the reason of) this behaviour later on snapshot creation
stage? Should we always have batmap summary on output of vhd-util read
command?

** Affects: qemu
     Importance: Undecided
         Status: New


** Tags: qemu-img

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1842925

Title:
  no batmap on convertion from qcow2 to vhd

Status in QEMU:
  New

Bug description:
  we run following version of qemu-img:
  $ qemu-img --version
  qemu-img version 2.5.0 (Debian 1:2.5+dfsg-5ubuntu10.41), Copyright (c) 20=
04-2008 Fabrice Bellard
  $

  Here is os version:
  $ cat /etc/os-release =

  NAME=3D"Ubuntu"
  VERSION=3D"16.04.6 LTS (Xenial Xerus)"
  ID=3Dubuntu
  ID_LIKE=3Ddebian
  PRETTY_NAME=3D"Ubuntu 16.04.6 LTS"
  VERSION_ID=3D"16.04"
  HOME_URL=3D"http://www.ubuntu.com/"
  SUPPORT_URL=3D"http://help.ubuntu.com/"
  BUG_REPORT_URL=3D"http://bugs.launchpad.net/ubuntu/"
  VERSION_CODENAME=3Dxenial
  UBUNTU_CODENAME=3Dxenial
  $

  When we use qemu-img for conversion of qcow2 to vhd newly created file
  doesnt show batmap summary when we run:

  # vhd-util read -p -n centos76.vhd
  VHD Footer Summary:
  -------------------
  Cookie              : conectix
  Features            : (0x00000002) <RESV>
  File format version : Major: 1, Minor: 0
  Data offset         : 512
  Timestamp           : Mon Mar  4 13:21:27 2019
  Creator Application : 'qemu'
  Creator version     : Major: 5, Minor: 3
  Creator OS          : Windows
  Original disk size  : 8192 MB (8590417920 Bytes)
  Current disk size   : 8192 MB (8590417920 Bytes)
  Geometry            : Cyl: 16645, Hds: 16, Sctrs: 63
                      : =3D 8192 MB (8590417920 Bytes)
  Disk type           : Dynamic hard disk
  Checksum            : 0xfffff119|0xfffff119 (Good!)
  UUID                : 23772822-a66c-45a2-be37-8474604147c7
  Saved state         : No
  Hidden              : 0

  VHD Header Summary:
  -------------------
  Cookie              : cxsparse
  Data offset (unusd) : 18446744073709
  Table offset        : 1536
  Header version      : 0x00010000
  Max BAT size        : 4097
  Block size          : 2097152 (2 MB)
  Parent name         : =

  Parent UUID         : 00000000-0000-0000-0000-000000000000
  Parent timestamp    : Fri Dec 31 19:00:00 1999
  Checksum            : 0xfffff466|0xfffff466 (Good!)

  #

  I am not so strong in VHD format details and not exactly sure how
  batmap is needed, but when I do conversion of qcow2 image by using
  vhd-util at the end I get file with proper batmap summary.

  In our environment we use CloudStack and Citrix and we use those
  converted from qcow2 to vhd images as templates. In general there is
  no problems, but whenever we create snapshot out of VM created from
  such template vhd-util read command starts giving us error like below:

  #
  -------------------
  Cookie              : conectix
  Features            : (0x00000002) <RESV>
  File format version : Major: 1, Minor: 0
  Data offset         : 512
  Timestamp           : Thu Aug 29 16:04:30 2019
  Creator Application : 'tap'
  Creator version     : Major: 1, Minor: 3
  Creator OS          : Unknown!
  Original disk size  : 8194 MB (8592031744 Bytes)
  Current disk size   : 8194 MB (8592031744 Bytes)
  Geometry            : Cyl: 16648, Hds: 16, Sctrs: 63
                      : =3D 8193 MB (8591966208 Bytes)
  Disk type           : Dynamic hard disk
  Checksum            : 0xfffff074|0xfffff074 (Good!)
  UUID                : 2b3cac7d-16e1-4771-b8cd-bb8c7876c761
  Saved state         : No
  Hidden              : 0

  VHD Header Summary:
  -------------------
  Cookie              : cxsparse
  Data offset (unusd) : 18446744073709
  Table offset        : 1536
  Header version      : 0x00010000
  Max BAT size        : 4097
  Block size          : 2097152 (2 MB)
  Parent name         : =

  Parent UUID         : 00000000-0000-0000-0000-000000000000
  Parent timestamp    : Sat Jan  1 00:00:00 2000
  Checksum            : 0xfffff466|0xfffff466 (Good!)

  failed to get batmap header

  #

  With the templates that show correct batmap summary that are created
  by conversion of qcow2 image by vhd-util convert we don't have such
  problems.

  So I wanted to check with community if not existence of the batmap can
  cause (be the reason of) this behaviour later on snapshot creation
  stage? Should we always have batmap summary on output of vhd-util read
  command?

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1842925/+subscriptions

