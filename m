Received: from eggs.gnu.org ([2001:4830:134:3::10]:59427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cU8Lc-0005PB-Gy
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 03:45:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cU8LZ-0002X6-Bg
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 03:45:32 -0500
Received: from indium.canonical.com ([91.189.90.7]:43986)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cU8LZ-0002WF-5y
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 03:45:29 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cU8LX-00043l-Ta
	for <qemu-devel@nongnu.org>; Thu, 19 Jan 2017 08:45:28 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 975122E80C3
	for <qemu-devel@nongnu.org>; Thu, 19 Jan 2017 08:45:27 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Jan 2017 08:34:56 -0000
From: Thomas Huth <645662@bugs.launchpad.net>
Reply-To: Bug 645662 <645662@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20100923002702.20683.97345.malonedeb@soybean.canonical.com>
Message-Id: <20170119083456.26958.18707.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 645662] Re: Python 3.1.2 math errors with Qemu
 0.12.5
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Can you still reproduce this problem with the latest version of QEMU? As
far as I know, the FPU emulation has been completely switched to
softfloat with the latest versions, so I assume your problem might be
fixed in recent releases...

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/645662

Title:
  Python 3.1.2 math errors with Qemu 0.12.5

Status in QEMU:
  Incomplete

Bug description:
  When doing the regression tests for Python 3.1.2 with Qemu 0.12.5, (Linux=
 version 2.6.26-2-686 (Debian 2.6.26-25lenny1)),
  gcc (Debian 4.3.2-1.1) 4.3.2, Python compiled from sources within qemu,
  3 math tests fail, apparently because the floating point unit is buggy. Q=
meu was compiled from original sources
  on Debian Lenny with kernel  2.6.34.6 from kernel.org, gcc  (Debian 4.3.2=
-1.1) 4.3. =


  Regression testing errors:

  test_cmath
  test test_cmath failed -- Traceback (most recent call last):
    File "/root/tools/python3/Python-3.1.2/Lib/test/test_cmath.py", line 36=
4, in
      self.fail(error_message)
  AssertionError: acos0034: acos(complex(-1.0000000000000002, 0.0))
  Expected: complex(3.141592653589793, -2.1073424255447014e-08)
  Received: complex(3.141592653589793, -2.1073424338879928e-08)
  Received value insufficiently close to expected value.

  =

  test_float
  test test_float failed -- Traceback (most recent call last):
    File "/root/tools/python3/Python-3.1.2/Lib/test/test_float.py", line 47=
9, in
      self.assertEqual(s, repr(float(s)))
  AssertionError: '8.72293771110361e+25' !=3D '8.722937711103609e+25'

  =

  test_math
  test test_math failed -- multiple errors occurred; run in verbose mode fo=
r deta

  =3D>

  runtests.sh -v test_math

  le01:~/tools/python3/Python-3.1.2# ./runtests.sh -v test_math
  test_math BAD
   1 BAD
   0 GOOD
   0 SKIPPED
   1 total
  le01:~/tools/python3/Python-3.1.2#

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/645662/+subscriptions
