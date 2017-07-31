Received: from eggs.gnu.org ([2001:4830:134:3::10]:40578)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dcAYI-00005Y-OJ
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 09:16:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dcAYF-0007mG-F2
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 09:16:06 -0400
Received: from indium.canonical.com ([91.189.90.7]:42370)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dcAYF-0007ku-8p
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 09:16:03 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dcAYC-0004YW-C5
	for <qemu-devel@nongnu.org>; Mon, 31 Jul 2017 13:16:00 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 89BCD2E8232
	for <qemu-devel@nongnu.org>; Mon, 31 Jul 2017 13:15:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Jul 2017 13:09:20 -0000
From: John Florian <1707297@bugs.launchpad.net>
Reply-To: Bug 1707297 <1707297@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150127405114.4205.4905957472648540492.malonedeb@gac.canonical.com>
Message-Id: <150150656034.3590.5339855182984610544.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1707297] Re: qemu became more picky parsing -m
 option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Not sure why I can only see Markus' comment here as part of Eric's but
anyway... the behavior change *is* expected.

Can qemu behave more like virsh then?  That would be ideal IMHO.  I
prefer to specify my RAM in powers of 2 and disk in powers of 10 so that
when I test virtually using qemu I more closely match the exact
constraints of real hardware.  For the embedded work I do fitting in
tight confines, it can make a significant difference.

(I actually to this with a wrapper I have around qemu, which is why you
see a floating point value for GiB in my example above.  My wrapper
behaves like virsh and takes any *B, *iB format and regurgitates it into
something qemu accepts.)

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1707297

Title:
  qemu became more picky parsing -m option

Status in QEMU:
  New

Bug description:
  With qemu-kvm-2.9.0-3.fc26.x86_64 I am no longer to specify the memory
  size using something like "-m 1.00000GiB" but with qemu-
  kvm-2.7.1-7.fc25.x86_64 I could without any problem.  I now get an
  error message like:

  qemu-system-x86_64: -m 1.00000GiB: Parameter 'size' expects a non-negativ=
e number below 2^64
  Optional suffix k, M, G, T, P or E means kilo-, mega-, giga-, tera-, peta-
  and exabytes, respectively.

  =

  Is this expected or a regression?

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1707297/+subscriptions
