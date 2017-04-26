Received: from eggs.gnu.org ([2001:4830:134:3::10]:52862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1d3KDm-0000hj-AF
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 06:30:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1d3KDh-0005XU-95
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 06:30:54 -0400
Received: from indium.canonical.com ([91.189.90.7]:36541)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1d3KDh-0005XA-2u
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 06:30:49 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1d3KDf-0004ug-48
	for <qemu-devel@nongnu.org>; Wed, 26 Apr 2017 10:30:47 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 02B4F2E80CC
	for <qemu-devel@nongnu.org>; Wed, 26 Apr 2017 10:30:47 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Apr 2017 10:25:02 -0000
From: Richard Jones <rjones@redhat.com>
Reply-To: Bug 1686364 <1686364@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <20170426102503.20345.45815.malonedeb@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1686364] [NEW] qemu -readconfig/-writeconfig
 cannot handle quotes in values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Public bug reported:

$ qemu-system-x86_64 -drive file=3D/tmp/foo\" -writeconfig -
# qemu config file

[drive]
=C2=A0=C2=A0file =3D "/tmp/foo""

For bonus points, try to construct a valid qemu config file that
contains a quoted value.  It's pretty clear (from looking at the code
also) that this is not possible.

Also:

- maximum value length is hard-coded in the parser at 1023 characters
(for no apparent reason)

- the format is undocumented

- don't use sscanf for parsing!

** Affects: qemu
     Importance: Undecided
         Status: New

** Description changed:

  $ qemu-system-x86_64 -drive file=3D/tmp/foo\" -writeconfig -
  # qemu config file
  =

  [drive]
-   file =3D "/tmp/foo""
+ =C2=A0=C2=A0file =3D "/tmp/foo""
  =

- For bonus points, try to construct a value qemu config file that
+ For bonus points, try to construct a valid qemu config file that
  contains a quoted value.  It's pretty clear (from looking at the code
  also) that this is not possible.
  =

  Also:
  =

  - maximum value length is hard-coded in the parser at 1023 characters
  (for no apparent reason)
  =

  - the format is undocumented
  =

  - don't use sscanf for parsing!

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1686364

Title:
  qemu -readconfig/-writeconfig cannot handle quotes in values

Status in QEMU:
  New

Bug description:
  $ qemu-system-x86_64 -drive file=3D/tmp/foo\" -writeconfig -
  # qemu config file

  [drive]
  =C2=A0=C2=A0file =3D "/tmp/foo""

  For bonus points, try to construct a valid qemu config file that
  contains a quoted value.  It's pretty clear (from looking at the code
  also) that this is not possible.

  Also:

  - maximum value length is hard-coded in the parser at 1023 characters
  (for no apparent reason)

  - the format is undocumented

  - don't use sscanf for parsing!

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1686364/+subscriptions
