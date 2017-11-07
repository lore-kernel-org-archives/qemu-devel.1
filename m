Received: from eggs.gnu.org ([2001:4830:134:3::10]:39351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eC80a-0001CR-DR
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 12:49:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eC80W-0001Xa-Dz
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 12:49:56 -0500
Received: from indium.canonical.com ([91.189.90.7]:48998)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eC80W-0001X5-91
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 12:49:52 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eC80V-0003Ne-4e
	for <qemu-devel@nongnu.org>; Tue, 07 Nov 2017 17:49:51 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 201A52E80C7
	for <qemu-devel@nongnu.org>; Tue,  7 Nov 2017 17:49:51 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Nov 2017 17:37:31 -0000
From: Peter Maydell <peter.maydell@linaro.org>
Reply-To: Bug 1408152 <1408152@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20150106232208.16446.55378.malonedeb@soybean.canonical.com>
Message-Id: <151007625206.4922.392128525630540308.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1408152] Re: latest qemu git doesn't load
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi; we fixed this with commit 446f16a6906e9d0 in March 2015, so I'm
going to mark this as fixed.


** Changed in: qemu
       Status: New =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1408152

Title:
  latest qemu git doesn't load

Status in QEMU:
  Fix Released

Bug description:
  commit ab0302ee764fd702465aef6d88612cdff4302809This is with

  qemu-system-x86_64: util/qemu-option.c:387: qemu_opt_get_bool_helper: Ass=
ertion `opt->desc && opt->desc->type =3D=3D QEMU_OPT_BOOL' failed.
  /home/njh/bin/kfreebsd-amd64: line 7: 32549 Aborted                 (core=
 dumped) qemu-system-x86_64 -drive file=3Dkfreebsd-amd64,index=3D0,media=3D=
disk,cache=3Dwriteback,aio=3Dnative -drive file=3D/dev/sr0,index=3D1,media=
=3Dcdrom -boot c -redir tcp:2232::22 -m 1024 -machine accel=3Dkvm,kernel_ir=
qchip=3Don -cpu host -net user,hostname=3Dqemu.bandsman.co.uk -net nic,mode=
l=3De1000 -k en-us

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1408152/+subscriptions
