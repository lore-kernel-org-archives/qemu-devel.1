Received: from eggs.gnu.org ([2001:4830:134:3::10]:54208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dgAQ5-00040S-M6
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 09:56:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dgAQ2-0004D1-Ah
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 09:56:09 -0400
Received: from indium.canonical.com ([91.189.90.7]:45861)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dgAQ2-0004C9-52
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 09:56:06 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dgAQ0-0007La-5V
	for <qemu-devel@nongnu.org>; Fri, 11 Aug 2017 13:56:04 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 03D1B2E80CB
	for <qemu-devel@nongnu.org>; Fri, 11 Aug 2017 13:46:35 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Aug 2017 13:26:02 -0000
From: VinceLe <vincent.legoll@gmail.com>
Reply-To: Bug 1583420 <1583420@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20160519041228.8083.93782.malonedeb@soybean.canonical.com>
Message-Id: <150245796213.10991.8962791449163833675.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1583420] Re: Please support "-soundhw none"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

It looks like qemu without any specific -soundhw CLI option uses pulseaudio.
So I still think a -soundhw none would be nice to have.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1583420

Title:
  Please support "-soundhw none"

Status in QEMU:
  Invalid

Bug description:
  qemu currently provides a default set of sound hardware.  The -soundhw
  option can change that default set, such as by using "-soundhw pcspkr"
  to disable most of it, but no "-soundhw none" option exists to disable
  all of it.  As far as I can tell, disabling the default sound hardware
  requires specifying -nodefaults and then manually specifying all the
  desired hardware, leaving out sound hardware.

  Please consider adding support for "-soundhw none", to disable all the
  default sound hardware.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1583420/+subscriptions
