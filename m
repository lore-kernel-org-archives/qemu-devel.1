Received: from eggs.gnu.org ([2001:4830:134:3::10]:53807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fx9O9-00036p-DX
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 07:20:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fx9O4-00063f-E6
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 07:20:53 -0400
Received: from indium.canonical.com ([91.189.90.7]:35804)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fx9O4-00062f-6K
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 07:20:48 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fx9O3-0005xL-48
	for <qemu-devel@nongnu.org>; Tue, 04 Sep 2018 11:20:47 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 16D712E80C8
	for <qemu-devel@nongnu.org>; Tue,  4 Sep 2018 11:20:47 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Sep 2018 11:10:44 -0000
From: Ricky Tigg <1790617@bugs.launchpad.net>
Reply-To: Bug 1790617 <1790617@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <153605729836.31419.16934091552250503095.malonedeb@soybean.canonical.com>
Message-Id: <153605944425.28670.3548694707396374554.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1790617] Re: Version of disk image format not
 exhibited using the 'qemu-img info' command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

So many useful information that would be worth to be part of the
documentation associated to the above mentioned link.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1790617

Title:
  Version of disk image format not exhibited using the 'qemu-img info'
  command

Status in QEMU:
  Invalid

Bug description:
  OS: Fedora (64 bits) =E2=80=93 Linux =E2=80=93. Last available component:=
 qemu-
  img.x86_64 2:2.11.2-2.fc28

  Description: version of disk image format not exhibited using the
  'qemu-img info' command.

  Command 'qemu-img info qcow2 [image-file-name.img]' produces this stderr =
message:
  qemu-img: Expecting one image file name
  Try 'qemu-img --help' for more information

  How to reproduce in terminal:
  1. Create a VM using Raw disk image format =

  2. Run either commands 'qemu-img info -f raw [image-file-name.img]', 'qem=
u-img info [image-file-name.img]'.
  3. Run either commands 'qemu-img info -f qcow2 [image-file-name.qcow2]', =
'qemu-img info [image-file-name.qcow2]'.

  Actual result: output model resulting from step .2 exhibits following inf=
ormations:
  image: image-file-name.img
  file format: raw
  virtual size: _G (_ bytes)
  disk size: _G

  Output model resulting from step .3 exhibits following informations:
  image: image-file-name.qcow2
  file format: qcow2
  virtual size: _G (_ bytes)
  disk size: _G
  cluster_size: _
  Snapshot list:
  ID        TAG                 VM SIZE                DATE       VM CLOCK
  1         snapshot1          _G 2018-07-31 18:27:49   00:03:45.890

  Format specific information:
      compat: 1.1
      lazy refcounts: true
      refcount bits: 16
      corrupt: false

  Actual result: raw and qcow2 formats respective versions =E2=80=93which a=
re
  likely to be mentioned as "version"=E2=80=93 to be exhibited.

  Additional information: in documentation lastly updated 2018-08-23 at
  https://access.redhat.com/documentation/en-
  us/red_hat_enterprise_linux/7/html/virtualization_deployment_and_administ=
ration_guide/index
  it is stated in chapters:

  14.10 =E2=80=93 'images in raw format can be resized in both directions, =
whereas qcow2 version 2 or qcow2 version 3 images can be grown';
  14.12 =E2=80=93 'the qcow2 version supplied with Red Hat Enterprise Linux=
 7 is 1.1', 'To know which version you are using, run qemu-img info qcow2 [=
imagefilename.img] command.'.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1790617/+subscriptions
