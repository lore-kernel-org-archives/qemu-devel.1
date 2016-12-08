Received: from eggs.gnu.org ([2001:4830:134:3::10]:33153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cEtPG-0005Mc-Bv
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 02:46:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cEtPD-0001yX-BA
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 02:46:18 -0500
Received: from indium.canonical.com ([91.189.90.7]:53021)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cEtPD-0001xX-5W
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 02:46:15 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cEtP9-000348-PG
	for <qemu-devel@nongnu.org>; Thu, 08 Dec 2016 07:46:12 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 8400D2E81C8
	for <qemu-devel@nongnu.org>; Thu,  8 Dec 2016 07:46:04 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Dec 2016 07:33:31 -0000
From: Ashish Girdhar <1579306@bugs.launchpad.net>
Reply-To: Bug 1579306 <1579306@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20160507052845.589.63580.malonedeb@chaenomeles.canonical.com>
Message-Id: <20161208073331.25282.58200.malone@gac.canonical.com>
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

I am also facing this issue.

On further probing, I found out that usb-uas in Qemu doesn't support
"SET_SEL" control command due to which windows driver "uaspstor.sys"
couldn't complete the enumeration.

It is clearly mentioned in USB 3.1 specs that uasp devices should handle
two new control commands - SET_SEL and SET_ISOCH_DELAY.

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
