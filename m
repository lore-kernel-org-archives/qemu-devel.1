Received: from eggs.gnu.org ([2001:4830:134:3::10]:43016)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fbZPb-0002Vg-Bp
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 18:41:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fbZPY-0001Us-8R
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 18:41:11 -0400
Received: from indium.canonical.com ([91.189.90.7]:36186)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fbZPY-0001UY-0V
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 18:41:08 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fbZPV-0002qn-QQ
	for <qemu-devel@nongnu.org>; Fri, 06 Jul 2018 22:41:06 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 892312E819B
	for <qemu-devel@nongnu.org>; Fri,  6 Jul 2018 22:41:05 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Jul 2018 22:30:59 -0000
From: Waldemar Kozaczuk <1776920@bugs.launchpad.net>
Reply-To: Bug 1776920 <1776920@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152898515528.25954.5483198787570860596.malonedeb@soybean.canonical.com>
Message-Id: <153091625926.30275.601765805471577037.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1776920] Re: qemu-img convert on Mac OSX creates
 corrupt images
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Bingo! Adding '-S 0' makes convert work. But it is not perfect as the
end result is fully allocated image.

So with qcow2 like this:

image: mysql-example.qemu
file format: qcow2
virtual size: 10G (10737418240 bytes)
disk size: 50M
cluster_size: 65536
Format specific information:
    compat: 1.1
    lazy refcounts: false
    refcount bits: 16
    corrupt: false

and do this:

qemu-img convert mysql-example.qemu -S 0 -O vmdk mysql-example.vbox

I get 10G vmdk file:
10738794496 Jul  6 18:27 mysql-example.vbox

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1776920

Title:
  qemu-img convert on Mac OSX creates corrupt images

Status in QEMU:
  New

Bug description:
  An image created by qemu-img create, then modified by another program
  is converted to bad/corrupt image when using convert sub command on
  Mac OSX. The same convert works on Linux. The version of qemu-img is
  2.12.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1776920/+subscriptions
