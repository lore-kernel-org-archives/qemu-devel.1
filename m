Received: from eggs.gnu.org ([2001:4830:134:3::10]:39487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dYSUA-0000xD-QU
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 03:36:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dYSU6-00035V-Sc
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 03:36:30 -0400
Received: from indium.canonical.com ([91.189.90.7]:43674)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dYSU6-00035C-MN
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 03:36:26 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dYSU4-0002W2-Tv
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 07:36:24 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id E16452E8041
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 07:36:24 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Jul 2017 07:22:13 -0000
From: Oliver Francke <Oliver.Francke@filoo.de>
Reply-To: Bug 1185395 <1185395@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20130529115415.23233.51064.malonedeb@wampee.canonical.com>
	<150055152492.6757.2784805857295424199.malone@gac.canonical.com>
Message-Id: <FCDB75F4-0E23-4599-9609-7A658C2D04FE@filoo.de>
Errors-To: bounces@canonical.com
Subject: Re: [Qemu-devel] [Bug 1185395] qemu-1.5.0 savevm error -95 while
 writing vm with ceph-rbd as storage-backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi Thomas,

thnx for coming back on this. Currently on vacation, but just gave it a
shot on fresh compiled qemu-2.9.0:

=E2=80=94

savevm
Error while writing VM state: Operation not supported

=E2=80=94

I think there once existed a patch from the Proxmox guys dealing with the V=
M state informations. But
apparently did not make it into main-stream.

Kind regards,

Oliver.

> Am 20.07.2017 um 13:52 schrieb Thomas Huth <1185395@bugs.launchpad.net>:
> =

> Triaging old bug tickets ... can you still reproduce this problem with
> the latest version of QEMU (currently v2.9.0)?
> =

> ** Changed in: qemu
>       Status: New =3D> Incomplete
> =

> -- =

> You received this bug notification because you are subscribed to the bug
> report.
> https://bugs.launchpad.net/bugs/1185395
> =

> Title:
>  qemu-1.5.0 savevm error -95 while writing vm with ceph-rbd as storage-
>  backend
> =

> Status in QEMU:
>  Incomplete
> =

> Bug description:
>  With a running VM I encounter this strange behaviour, former qemu-versio=
ns don't show up such an error.
>  Perhaps this comes from the rbd-backend in qemu-1.5.0 in combination wit=
h ceph-0.56.6?
> =

>  ( -95 might be a general "Operation not supported" error? )
> =

>  Up to 1.4.2 everything is OK with savevm, though.
> =

>  Any help welcome,
> =

>  Oliver.
> =

> To manage notifications about this bug go to:
> https://bugs.launchpad.net/qemu/+bug/1185395/+subscriptions

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1185395

Title:
  qemu-1.5.0 savevm error -95 while writing vm with ceph-rbd as storage-
  backend

Status in QEMU:
  Incomplete

Bug description:
  With a running VM I encounter this strange behaviour, former qemu-version=
s don't show up such an error.
  Perhaps this comes from the rbd-backend in qemu-1.5.0 in combination with=
 ceph-0.56.6?

  ( -95 might be a general "Operation not supported" error? )

  Up to 1.4.2 everything is OK with savevm, though.

  Any help welcome,

  Oliver.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1185395/+subscriptions
