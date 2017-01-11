Received: from eggs.gnu.org ([2001:4830:134:3::10]:56352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cRCp3-0001DR-0T
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 01:55:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cRCp1-0004e8-6w
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 01:55:49 -0500
Received: from indium.canonical.com ([91.189.90.7]:53308)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cRCp1-0004du-0l
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 01:55:47 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cRCoz-0000Ez-U3
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 06:55:46 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id C31F32E8029
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 06:55:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Jan 2017 06:44:48 -0000
From: Thomas Huth <1464611@bugs.launchpad.net>
Reply-To: Bug 1464611 <1464611@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20150612103816.17529.55642.malonedeb@chaenomeles.canonical.com>
Message-Id: <20170111064449.26927.64323.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1464611] Re: 4 * redundant conditions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Released with version 2.8

** Changed in: qemu
       Status: Fix Committed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1464611

Title:
  4 * redundant conditions

Status in QEMU:
  Fix Released

Bug description:
  =

  1.

  [qemu/hw/block/nvme.c:355]: (style) Redundant condition: sqid. 'A &&
  (!A || B)' is equivalent to 'A || B'

    if (!sqid || (sqid && !nvme_check_sqid(n, sqid))) {

  2.

  [qemu/hw/block/nvme.c:429]: (style) Redundant condition: cqid. 'A &&
  (!A || B)' is equivalent to 'A || B'

    if (!cqid || (cqid && !nvme_check_cqid(n, cqid))) {

  3.

  [qemu/hw/tpm/tpm_passthrough.c:157]: (style) Redundant condition:
  tpm_pt.tpm_op_canceled. 'A && (!A || B)' is equivalent to 'A || B'

       if (!tpm_pt->tpm_op_canceled ||
              (tpm_pt->tpm_op_canceled && errno !=3D ECANCELED)) {

  4.

  [qemu/target-arm/translate-a64.c:5729]: (style) Redundant condition:
  size<3. 'A && (!A || B)' is equivalent to 'A || B'

        if (size > 3
              || (size < 3 && is_q)
              || (size =3D=3D 3 && !is_q)) {

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1464611/+subscriptions
