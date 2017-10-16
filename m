Received: from eggs.gnu.org ([2001:4830:134:3::10]:33270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e45UR-0000DM-6h
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 09:31:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e45UL-0003ww-0K
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 09:31:31 -0400
Received: from indium.canonical.com ([91.189.90.7]:40454)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1e45UK-0003wD-Pa
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 09:31:24 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1e45UI-0006HV-HI
	for <qemu-devel@nongnu.org>; Mon, 16 Oct 2017 13:31:22 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 6D4532E80D7
	for <qemu-devel@nongnu.org>; Mon, 16 Oct 2017 13:31:21 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Oct 2017 13:16:22 -0000
From: Christophe Lyon <christophe.lyon+launchpad@gmail.com>
Reply-To: Bug 1721275 <1721275@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150712892432.28170.15132413345734525245.malonedeb@gac.canonical.com>
Message-Id: <150815978220.15244.13378023945796441528.malone@soybean.canonical.com>
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

Thanks for PS, I thought QEMU was stricter than that.

Regarding M7 vs M$ or A35 vs A53/A57, even though there's no functional
difference, it would be convenient in Makefiles to have CPU=3Dcortex-a53,
and use $(CPU) to expand GCC and QEMU options, without having to guess
which CPU I should use for QEMU that would match the one I pass to GCC.

Regarding v[68]M, are there any plans to add support for these variants
to QEMU?

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
