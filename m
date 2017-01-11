Received: from eggs.gnu.org ([2001:4830:134:3::10]:34324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cRD8V-0003kQ-Ni
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 02:15:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cRD8R-0004VD-04
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 02:15:55 -0500
Received: from indium.canonical.com ([91.189.90.7]:58922)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cRD8Q-0004UR-QX
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 02:15:50 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cRD8P-0008AB-GA
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 07:15:49 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 5CBF12E80C9
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 07:15:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Jan 2017 07:01:55 -0000
From: Thomas Huth <1624726@bugs.launchpad.net>
Reply-To: Bug 1624726 <1624726@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20160917203131.11876.45030.malonedeb@gac.canonical.com>
Message-Id: <20170111070155.27560.65937.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1624726] Re: Integrator/CP regression after
 QOM'ification of integratorcp.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Patch has been included here:
http://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3De9d9ee234f852026d58
... and been released with QEMU version 2.8

** Changed in: qemu
       Status: New =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1624726

Title:
  Integrator/CP regression after QOM'ification of integratorcp.c

Status in HelenOS branches:
  New
Status in QEMU:
  Fix Released

Bug description:
  The following command line no longer works (i.e. the guest does not
  boot) with QEMU 2.7.0:

      qemu-system-arm -M integratorcp -m 128M -kernel
  HelenOS-0.6.0-arm32-integratorcp.boot

  The HelenOS image can be downloaded here:

  http://www.helenos.org/releases/HelenOS-0.6.0-arm32-integratorcp.boot

  I did git bisect and came to this revision:

  a1f42e0c9abc1028a8bb8686dbb3749fcd2d18e8 is the first bad commit
  commit a1f42e0c9abc1028a8bb8686dbb3749fcd2d18e8
  Author: xiaoqiang.zhao <zxq_yx_007@163.com>
  Date:   Mon Mar 7 15:05:44 2016 +0800

      hw/arm: QOM'ify integratorcp.c
      =

      * Drop the use of old SysBus init function and use instance_init
      * Remove the empty 'icp_pic_class_init' from Typeinfo
      =

      Signed-off-by: xiaoqiang zhao <zxq_yx_007@163.com>
      Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
      Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

  :040000 040000 b73418ea3fb69ed72438776e78786456fe4c414c
  b483e8579037fdae7d136b2f4ada3147bdde92f1 M      hw

  Upon closer inspection, I discovered that for some reason s->memsz in
  integratorcm_init() is zero. In the last good revision, this value was
  128. As a temporary workaround, hardcoding it to this expected value
  fixes the problem.

To manage notifications about this bug go to:
https://bugs.launchpad.net/helenos/+bug/1624726/+subscriptions
