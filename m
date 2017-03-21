Received: from eggs.gnu.org ([2001:4830:134:3::10]:38148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cqG8Q-0001V7-I6
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 05:31:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cqG8N-0000Cu-FI
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 05:31:22 -0400
Received: from indium.canonical.com ([91.189.90.7]:54523)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cqG8N-0000CJ-9g
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 05:31:19 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cqG8L-0005FF-4v
	for <qemu-devel@nongnu.org>; Tue, 21 Mar 2017 09:31:17 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 1FBE52E80C1
	for <qemu-devel@nongnu.org>; Tue, 21 Mar 2017 09:31:17 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Mar 2017 09:17:29 -0000
From: Philipp Schmidt <877498@bugs.launchpad.net>
Reply-To: Bug 877498 <877498@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20111018150547.17888.51364.malonedeb@soybean.canonical.com>
	<20170320225702.17627.30545.malone@gac.canonical.com>
Message-Id: <E058BAFE-8BAA-49A6-BCE3-F77083446646@ppc.in-berlin.de>
Errors-To: bounces@canonical.com
Subject: Re: [Qemu-devel] [Bug 877498] qemu does not pass sector size from
 physical devices to virtual devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi,

I can=E2=80=99t verify it for the logical block size right away, but =

this bug still present for the physical block size in qemu-kvm 1:2.1+dfsg-1.

I will try to verify this bug with testing soon

> On 20. Mar 2017, at 23:57, Thomas Huth <877498@bugs.launchpad.net> wrote:
> =

> QEMU 0.12 is pretty much outdated ... can you still reproduce this issue
> with the latest version of QEMU, or can we close this bug nowadays?
> =

> ** Changed in: qemu
>       Status: New =3D> Incomplete
> =

> -- =

> You received this bug notification because you are subscribed to the bug
> report.
> https://bugs.launchpad.net/bugs/877498
> =

> Title:
>  qemu does not pass sector size from physical devices to virtual
>  devices
> =

> Status in QEMU:
>  Incomplete
> =

> Bug description:
>  When passing a physical disk (i.e. a multipathed fcal volume in my
>  case) with a 4k sector size as raw image to qemu (-drive
>  file=3D/dev/mapper/hartebeest-sys,if=3Dnone,id=3Ddrive-virtio-
>  disk0,boot=3Don,format=3Draw), the resulting virtual device has a sector
>  size of 512b, rendering the partition table unusable.
> =

>  Versions used: QEMU 0.12.5 (qemu-kvm-0.12.5) from debian unstable
> =

> To manage notifications about this bug go to:
> https://bugs.launchpad.net/qemu/+bug/877498/+subscriptions
> =


AVE!
  Philipp S. Tiesel / phils=E2=80=A6
-- =

   {phils}--->---(phils@in-panik.de)--->---(http://phils.in-panik.de)----,
      wenn w eine   aube ist dn      man au dran dre en                   |
           o     Schr        an muss     hc         h   (Kurt Schwitters) |
:wq!  <----(phone: +49-179-6737439)---<---(jabber: phils@in-panik.de)----'

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/877498

Title:
  qemu does not pass sector size from physical devices to virtual
  devices

Status in QEMU:
  Incomplete

Bug description:
  When passing a physical disk (i.e. a multipathed fcal volume in my
  case) with a 4k sector size as raw image to qemu (-drive
  file=3D/dev/mapper/hartebeest-sys,if=3Dnone,id=3Ddrive-virtio-
  disk0,boot=3Don,format=3Draw), the resulting virtual device has a sector
  size of 512b, rendering the partition table unusable.

  Versions used: QEMU 0.12.5 (qemu-kvm-0.12.5) from debian unstable

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/877498/+subscriptions
