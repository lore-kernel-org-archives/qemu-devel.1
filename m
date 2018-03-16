Received: from eggs.gnu.org ([2001:4830:134:3::10]:48777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ewsF7-0005t2-AE
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 12:30:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ewsF4-0004JW-45
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 12:30:09 -0400
Received: from indium.canonical.com ([91.189.90.7]:57884)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ewsF3-0004In-VR
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 12:30:06 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1ewsF3-00075h-1D
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 16:30:05 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id EE0692E80C8
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 16:30:04 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Mar 2018 16:18:02 -0000
From: Paolo Bonzini <bonzini@gnu.org>
Reply-To: Bug 1438572 <1438572@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20150331082006.7212.85829.malonedeb@chaenomeles.canonical.com>
Message-Id: <152121708253.3381.16075151243071563310.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1438572] Re: kvm does not support
 KVM_CAP_USER_MEMORY Please upgrade to at least kernel 2.6.29 or recent
 kvm-kmod (see http://sourceforge.net/projects/kvm)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This error has never existed in QEMU, only in the old qemu-kvm fork
which has been obsolete for about 5 years.  I'm closing this ticket.

** Changed in: qemu
       Status: Incomplete =3D> Won't Fix

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1438572

Title:
  kvm does not support KVM_CAP_USER_MEMORY Please upgrade to at least
  kernel 2.6.29 or recent kvm-kmod (see
  http://sourceforge.net/projects/kvm)

Status in QEMU:
  Won't Fix

Bug description:
  We have a machine which is having QEMU+KVM on below configuration of linux
  uname -a
  Linux cairotrior 2.6.18-308.13.1.el5 #1 SMP Thu Jul 26 05:45:09 EDT 2012 =
x86_64 x86_64 x86_64 GNU/Linux
  cat /etc/issue
  Red Hat Enterprise Linux Server release 5.8 (Tikanga)
  Kernel \r on an \m

  =

  But in another setup, we are trying on a different machine having RHEL 5.=
9 having higher kernel version but it still gives below error
  kvm does not support KVM_CAP_USER_MEMORY Please upgrade to at least kerne=
l 2.6.29 or recent kvm-kmod (see http://sourceforge.net/projects/kvm).
  failed to initialize KVM: Invalid argument No accelerator found!

  =

  I don=E2=80=99t know if the qemu version have compatibility issues with r=
edhat 5.9 version =E2=80=93  need someone to check if the qemu can run on r=
edhat 5.9 64 bit or not ?

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1438572/+subscriptions
