Received: from eggs.gnu.org ([2001:4830:134:3::10]:37495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eBc2a-0002Ae-Dy
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 02:41:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eBc2V-00030b-NY
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 02:41:52 -0500
Received: from indium.canonical.com ([91.189.90.7]:56386)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eBc2V-0002zr-Gz
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 02:41:47 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eBc2T-0006PA-Fz
	for <qemu-devel@nongnu.org>; Mon, 06 Nov 2017 07:41:45 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 4DD972E8240
	for <qemu-devel@nongnu.org>; Mon,  6 Nov 2017 07:41:38 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Nov 2017 07:32:24 -0000
From: ChristianEhrhardt <1726394@bugs.launchpad.net>
Reply-To: Bug 1726394 <1726394@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150876459007.17533.9812313883985505054.malonedeb@wampee.canonical.com>
Message-Id: <150995354417.8592.1344776645187340721.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1726394] Re: Passes through prctl(PR_SET_SECCOMP,
 SECCOMP_MODE_FILTER, address)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

FYI - this is from http://lists.nongnu.org/archive/html/qemu-
devel/2017-11/msg00417.html

Upstream response looks good, but not committed there yet.

@Julian - given the case will you need this as an SRU as well or is it
only tied to newer apt (or newer apt use cases)?

Test queues in Bionic are still stalling this, there was an error on an
iso test on s390x which seemed unrelated to the update - I retriggered
for now as I'd assume it needs a newer fixed daily iso.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1726394

Title:
  Passes through prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER, address)

Status in QEMU:
  New
Status in qemu package in Ubuntu:
  Fix Committed
Status in qemu package in Debian:
  Confirmed

Bug description:
  qemu-user passes through prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER,
  address) unmodified, but the third argument is an address to a BPF
  filter, causing an EFAULT. Now, the filter is architecture-specifc, so
  you can't just rewrite the addresses, so the safest bet is to just
  return an error here.

  I guess you should just return EINVAL, but not sure. I'd really like
  something that can be identified, so seccomp errors can be ignored
  when it's not supported.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1726394/+subscriptions
