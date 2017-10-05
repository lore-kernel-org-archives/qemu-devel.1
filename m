Received: from eggs.gnu.org ([2001:4830:134:3::10]:37949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e04DN-0007Hl-EJ
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 07:21:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e04DK-0003MQ-Rb
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 07:21:17 -0400
Received: from indium.canonical.com ([91.189.90.7]:46730)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1e04DK-0003M1-Lr
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 07:21:14 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1e04DI-0008A2-6n
	for <qemu-devel@nongnu.org>; Thu, 05 Oct 2017 11:21:12 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 0F8C02E819D
	for <qemu-devel@nongnu.org>; Thu,  5 Oct 2017 11:21:09 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Oct 2017 11:07:36 -0000
From: Peter Maydell <peter.maydell@linaro.org>
Reply-To: Bug 1721275 <1721275@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150712892432.28170.15132413345734525245.malonedeb@gac.canonical.com>
Message-Id: <150720165623.21735.14616809224012717458.malone@soybean.canonical.com>
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

PS: in general I wouldn't unconditionally trust that QEMU emulating CPU
X definitely does not implement any instructions that CPU X doesn't have
-- no real world code will notice, and we don't have any mechanism to
automatically verify that we didn't accidentally forget to
conditionalize an instruction on an architecture feature.

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
