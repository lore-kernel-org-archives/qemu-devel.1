Received: from eggs.gnu.org ([2001:4830:134:3::10]:49864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cFFs1-0003y7-QH
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 02:45:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cFFrw-0007xQ-Uu
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 02:45:29 -0500
Received: from indium.canonical.com ([91.189.90.7]:41109)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cFFrw-0007xD-Ox
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 02:45:24 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cFFru-0004Yt-Oc
	for <qemu-devel@nongnu.org>; Fri, 09 Dec 2016 07:45:22 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id B503D2E8085
	for <qemu-devel@nongnu.org>; Fri,  9 Dec 2016 07:45:22 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Dec 2016 07:26:07 -0000
From: Tom Yan <tom.ty89@gmail.com>
Reply-To: Bug 1579306 <1579306@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20160507052845.589.63580.malonedeb@chaenomeles.canonical.com>
Message-Id: <20161209072607.16666.38832.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1579306] Re: usb-uas does not work in Windows
 (10) guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I think they are two separate issues in usb-uas and usb-host
respectively. I probably should not have bring in the usb-host case here
but create another report for it.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1579306

Title:
  usb-uas does not work in Windows (10) guest

Status in QEMU:
  New

Bug description:
  When I attach a "-device usb-uas" to a VM with Windows 10 10586, the
  device fail to start with the following error in the guest:

  "The device cannot start. (Code 10)

  {Operation Failed}
  The requested operation was unsuccessful"

  If the host controller is nec-usb-xhci, there will be two of the
  following error on the terminal of the host as well:

  "qemu-system-x86_64: usb_uas_handle_control: unhandled control
  request"

  If it's usb-ehci, ich9-usb-ehci1 or ich9-usb-echi2, this will not show
  up on the host side, but the device stil fails with the same error on
  the guest side.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1579306/+subscriptions
