Received: from eggs.gnu.org ([2001:4830:134:3::10]:40373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dcxU9-0006pN-Ao
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 13:31:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dcxU5-0003CX-EN
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 13:31:05 -0400
Received: from indium.canonical.com ([91.189.90.7]:47109)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dcxU5-0003CB-90
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 13:31:01 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dcxU3-0004rj-F0
	for <qemu-devel@nongnu.org>; Wed, 02 Aug 2017 17:30:59 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id C93F12E80D1
	for <qemu-devel@nongnu.org>; Wed,  2 Aug 2017 17:30:58 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Aug 2017 17:19:43 -0000
From: Gheorghe Ungureanu <1708215@bugs.launchpad.net>
Reply-To: Bug 1708215 <1708215@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150169387475.3916.9615851037093784733.malonedeb@gac.canonical.com>
Message-Id: <150169438369.13068.5796154538118936896.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1708215] Re: Windows 10 clipboard bug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

UPDATE:
Restarting "SPICE VDAagent" within the VM allows me to paste again from hos=
t to VM, however as soon as I use copy within the VM, it stops working agai=
n.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1708215

Title:
  Windows 10 clipboard bug

Status in QEMU:
  New

Bug description:
  Hello,

  I am using qemu on arch:
      pacman -Q libvirt qemu linux virt-manager
  libvirt 3.5.0-1
  qemu 2.9.0-2
  linux 4.12.3-1
  virt-manager 1.4.1-2

  I have a windows 10 Guest, with all updates and the following packages in=
stalled in the guest:
  - QEMU guest agent 7.3.2
  - SPICE Guest Tools 0.132

  When I start the VM, I can copy/paste from the host to the guest.
  However, after I use COPY inside the VM, copy/paste is not working any
  more from host to guest. However, I can still copy/paste from guest to
  host.

  To summarize:
  - copy/paste from guest to host works always
  - copy/paste from host to guest works only if copy was not previously use=
d in guest.

  If this bug needs to be reported using another portal or if I can
  provide any further information, please contact me.

  Best Regards,
  gxgung

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1708215/+subscriptions
