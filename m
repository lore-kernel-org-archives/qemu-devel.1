Received: from eggs.gnu.org ([2001:4830:134:3::10]:36908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1d336Z-0006f6-Ob
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 12:14:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1d336U-0007Ty-Qc
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 12:14:19 -0400
Received: from indium.canonical.com ([91.189.90.7]:44551)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1d336U-0007Tf-Ka
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 12:14:14 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1d336S-0000fo-Rc
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 16:14:12 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id C5AFA2E8067
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 16:14:12 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Apr 2017 12:58:25 -0000
From: Thomas Huth <1289898@bugs.launchpad.net>
Reply-To: Bug 1289898 <1289898@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140308232431.4881.19998.malonedeb@soybean.canonical.com>
Message-Id: <20170425125826.6243.40291.launchpad@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1289898] Re: qemu-system-ppc64 easily cause file
 corruption
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

*** This bug is a duplicate of bug 1463812 ***
    https://bugs.launchpad.net/bugs/1463812

** This bug has been marked a duplicate of bug 1463812
   qemu-system-ppc64 V2.30 cause RHEL5.9 disk corruption

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1289898

Title:
  qemu-system-ppc64 easily cause file corruption

Status in QEMU:
  Incomplete

Bug description:
  the qemu-system-ppc64 is used to run RHEL5.9 for IBM Power on RHEL 5.3.
  Previously I was using QEMU 1.5.x for several months with no problem. But=
 after the RHEL 5.3 host damaged, and rebuilt, now I tried both QEMU 1.6.2 =
and QEMU 1.7.0, found both can easily cause file corruptions. Symptoms:

  * using scp to transfer a tar.bz file from the RHEL 5.3 host to the RHEL =
5.9 PPC VM, found the size is correct, but the content is corrupted from th=
e middle of the 90+ MB file.  re-transfer again, got a correct file. But af=
ter untar, found some extracted files corrupted.
  The extracted file corruption happened several times, and also the filesy=
stem in the VM had corrupted several times, had to restore the boot image t=
o recover.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1289898/+subscriptions
