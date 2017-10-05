Received: from eggs.gnu.org ([2001:4830:134:3::10]:37951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e04DN-0007Hm-FJ
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 07:21:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e04DK-0003ML-QY
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 07:21:17 -0400
Received: from indium.canonical.com ([91.189.90.7]:46692)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1e04DK-0003LW-JY
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 07:21:14 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1e04DH-0008Au-S1
	for <qemu-devel@nongnu.org>; Thu, 05 Oct 2017 11:21:11 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 46F742E818D
	for <qemu-devel@nongnu.org>; Thu,  5 Oct 2017 11:21:08 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Oct 2017 11:06:16 -0000
From: Peter Maydell <peter.maydell@linaro.org>
Reply-To: Bug 1721275 <1721275@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150712892432.28170.15132413345734525245.malonedeb@gac.canonical.com>
Message-Id: <150720157641.28375.10436443125246795022.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1721275] Re: Support more ARM CPUs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

M0 is hard, because it's v6M which we don't support. M4 we already have
(but only the no-fpu variant). M7 we don't currently have -- what would
be the differences from M4? M33 is in the works (it's v8M). M23 is
harder, because it's v8M-baseline which is the v8M equivalent to v6M.
A53 and A57 we already have. How would A35 differ from A53/A57 ?

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1721275

Title:
  Support more ARM CPUs

Status in QEMU:
  New

Bug description:
  Hi,

  This is an enhancement request, rather than a bug report.

  After some discussions/presentations during the last Linaro Connect
  (SFO17), I understand that it may be easy to add support for more ARM
  CPUs in QEMU. I am interested in user-mode, if that matters.

  I'm primarily using QEMU for GCC validations, and I'd like to make
  sure that GCC doesn't generate instructions not supported by the CPU
  it's supposed to generate code for.

  I'd like to have:
  cortex-m0
  cortex-m4
  cortex-m7
  cortex-m23
  cortex-m33

  cortex-a35
  cortex-a53
  cortex-a57

  Is it possible?
  Is it the right place to ask?
  Should I file separate requests for each?

  Thanks

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1721275/+subscriptions
