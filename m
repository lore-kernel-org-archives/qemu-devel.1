Received: from eggs.gnu.org ([209.51.188.92]:45370)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1h2Hlm-0006D7-9D
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 10:50:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1h2Hlk-0001u0-Rt
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 10:50:45 -0500
Received: from indium.canonical.com ([91.189.90.7]:57176)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1h2Hlj-0001l4-7R
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 10:50:43 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1h2Hlf-0003n2-IP
	for <qemu-devel@nongnu.org>; Fri, 08 Mar 2019 15:50:39 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 89EF72E80C9
	for <qemu-devel@nongnu.org>; Fri,  8 Mar 2019 15:50:39 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 08 Mar 2019 15:35:43 -0000
From: Scott Moser <ssmoser2+ubuntu@gmail.com>
Reply-To: Bug 1819182 <1819182@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <155205925919.27918.10336996226499931700.malonedeb@soybean.canonical.com>
Message-Id: <155205934395.15700.14568849889267163588.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1819182] Re: info does not recognize file format
 of vpc with subformat=fixed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

$ ./go-create
#version: 2.11.1                                                           =
     =

qcow: PASS fmt=3Dqcow auto=3Dqcow exp=3Dqcow [name=3Dmy-img.qcow opts=3D]  =
               =

qcow2: PASS fmt=3Dqcow2 auto=3Dqcow2 exp=3Dqcow2 [name=3Dmy-img.qcow2 opts=
=3D]            =

qed: PASS fmt=3Dqed auto=3Dqed exp=3Dqed [name=3Dmy-img.qed opts=3D]       =
               =

raw: PASS fmt=3Draw auto=3Draw exp=3Draw [name=3Dmy-img.raw opts=3D]       =
               =

vdi: PASS fmt=3Dvdi auto=3Dvdi exp=3Dvdi [name=3Dmy-img.vdi opts=3D]       =
               =

vhdx: PASS fmt=3Dvhdx auto=3Dvhdx exp=3Dvhdx [name=3Dmy-img.vhdx opts=3D]  =
               =

vmdk: PASS fmt=3Dvmdk auto=3Dvmdk exp=3Dvmdk [name=3Dmy-img.vmdk opts=3D]  =
               =

vpc: PASS fmt=3Dvpc auto=3Dvpc exp=3Dvpc [name=3Dmy-img.vpc opts=3D]       =
               =

vpc-fixed: FAIL fmt=3Dvpc auto=3Draw exp=3Dvpc [name=3Dmy-img.vpc-fixed opt=
s=3D-o subformat=3Dfixed]                                                  =
                      =

vpc-fforce: FAIL fmt=3Dvpc auto=3Draw exp=3Dvpc [name=3Dmy-img.vpc-fforce o=
pts=3D-o subformat=3Dfixed,force_size]                                     =
                      =

FAIL [2]    =


** Attachment added: "shell script reproducing and testing different types."
   https://bugs.launchpad.net/qemu/+bug/1819182/+attachment/5244750/+files/=
go-create

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1819182

Title:
  info does not recognize file format of vpc with subformat=3Dfixed

Status in QEMU:
  New

Bug description:
  After creating or converting an image to vpc with 'subformat=3Dfixed'
  'qemu-img info' incorrectly identifies the image as 'raw' format.

  $ qemu-img --version
  qemu-img version 2.11.1(Debian 1:2.11+dfsg-1ubuntu7.10)
  Copyright (c) 2003-2017 Fabrice Bellard and the QEMU Project developers

  $ qemu-img create -f vpc -o subformat=3Dfixed my.vpc 2G
  Formatting 'my.vpc', fmt=3Dvpc size=3D2147483648 subformat=3Dfixed

  $ qemu-img info my.vpc
  image: my.vpc
  file format: raw
  virtual size: 2.0G (2147992064 bytes)
  disk size: 4.0K

  $ qemu-img info -f vpc my.vpc
  image: my.vpc
  file format: vpc
  virtual size: 2.0G (2147991552 bytes)
  disk size: 4.0K

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1819182/+subscriptions
