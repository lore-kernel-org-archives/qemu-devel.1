Received: from eggs.gnu.org ([2001:4830:134:3::10]:43414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eE6Ns-0005EB-09
	for qemu-devel@nongnu.org; Sun, 12 Nov 2017 23:30:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eE6Nn-0001Y5-TE
	for qemu-devel@nongnu.org; Sun, 12 Nov 2017 23:30:08 -0500
Received: from indium.canonical.com ([91.189.90.7]:33520)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eE6Nn-0001Wh-NJ
	for qemu-devel@nongnu.org; Sun, 12 Nov 2017 23:30:03 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eE6Nk-0003Xs-Oq
	for <qemu-devel@nongnu.org>; Mon, 13 Nov 2017 04:30:00 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id BA6A02E80D5
	for <qemu-devel@nongnu.org>; Mon, 13 Nov 2017 04:30:00 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Nov 2017 04:17:24 -0000
From: Launchpad Bug Tracker <996798@bugs.launchpad.net>
Reply-To: Bug 996798 <996798@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20120508215526.13179.23990.malonedeb@soybean.canonical.com>
Message-Id: <151054664506.17693.13190844544637035017.malone@loganberry.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 996798] Re: Incorrect order of task switching
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/996798

Title:
  Incorrect order of task switching

Status in QEMU:
  Expired

Bug description:
  In Intel  specifications
  (http://download.intel.com/design/processor/manuals/253668.pdf 7.3),
  we can see:

  =C2=A0=C2=A0=C2=A0=C2=A08. Saves the state of the current (old) task in t=
he current task=E2=80=99s
  TSS.

  =E2=80=A6

  =C2=A0=C2=A0=C2=A012. The TSS state is loaded into the processor

  But, in QEMU code
  (https://raw.github.com/qemu/QEMU/v1.0/target-i386/op_helper.c :375),
  the order is reversed: TSS registers & segments loads BEFORE save old
  task state.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/996798/+subscriptions
