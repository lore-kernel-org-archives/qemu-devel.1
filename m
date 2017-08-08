Received: from eggs.gnu.org ([2001:4830:134:3::10]:35151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1deyRH-0000Vu-8Q
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 02:56:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1deyRC-0002B6-FP
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 02:56:27 -0400
Received: from indium.canonical.com ([91.189.90.7]:34388)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1deyRC-0002AC-96
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 02:56:22 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1deyRA-0002kK-4v
	for <qemu-devel@nongnu.org>; Tue, 08 Aug 2017 06:56:20 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 1BB3F2E80CB
	for <qemu-devel@nongnu.org>; Tue,  8 Aug 2017 06:56:20 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Aug 2017 06:47:26 -0000
From: Riku Voipio <riku.voipio@linaro.org>
Reply-To: Bug 1709170 <1709170@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150213708469.19430.16716526584783151905.malonedeb@chaenomeles.canonical.com>
Message-Id: <150217484663.17099.6130255789712318706.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1709170] Re: QEMU fails to honor O_TMPFILE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi Thiago,

What is the version of glibc on the targets you are building to? There
was an O_TMPFILE bug in older glibc's:

https://sourceware.org/bugzilla/show_bug.cgi?id=3D17912

** Bug watch added: Sourceware.org Bugzilla #17912
   https://sourceware.org/bugzilla/show_bug.cgi?id=3D17912

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1709170

Title:
  QEMU fails to honor O_TMPFILE

Status in QEMU:
  New

Bug description:
  When making a call like

    open("/tmp", O_TMPFILE | O_RDWR);

  under QEMU, we ged -EISDIR.

  Under any kernel 3.11 or later, we are supposed to get an unnamed file
  in /tmp. In case the filesystem for /tmp does not support unnamed
  files, we are supposed to get EOPNOTSUPP.

  [I don't know the QEMU version, since this happened in a system I
  don't have access to]

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1709170/+subscriptions
