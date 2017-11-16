Received: from eggs.gnu.org ([2001:4830:134:3::10]:45661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eFIE9-0000do-HA
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 06:21:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eFIE3-0008TN-Pt
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 06:21:01 -0500
Received: from indium.canonical.com ([91.189.90.7]:33494)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eFIE3-0008S5-Kq
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 06:20:55 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eFIE1-0007I7-Fr
	for <qemu-devel@nongnu.org>; Thu, 16 Nov 2017 11:20:53 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 6EA742E80C8
	for <qemu-devel@nongnu.org>; Thu, 16 Nov 2017 11:20:53 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Nov 2017 11:10:32 -0000
From: Chen Zhang <1732671@bugs.launchpad.net>
Reply-To: Bug 1732671 <1732671@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <151083063268.1193.17138246799552738242.malonedeb@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1732671] [NEW] vnc websocket compatibility issue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Public bug reported:

WebSocket support in VNC should allow access from VNC client through
upgraded WebSocket connection. This feature is not working in IE 11/Edge
with noVNC HTML5 client, in contrast to that in Firefox/Safari, etc.

The reason that IE 11/Edge fails to accept the connection upgrade is
that the value equality of the `Upgrade` header field is checked in a
strict case-sensitive manner in QEMU side, however, the IE/Edge does not
send the exactly same string value `websocket` but a capital letter `W`
instead.

Defined in section 4.2.1 of rfc6455, the upgrade header field shall be
treated case-insensitively.

A patch shall be made in `io/channel-websock.c`, converting the value of
upgrade string to lowercase before comparison is made with
QIO_CHANNEL_WEBSOCK_UPGRADE_WEBSOCKET, to allow case-insensitive
comparison in the process.

** Affects: qemu
     Importance: Undecided
         Status: New


** Tags: vnc

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1732671

Title:
  vnc websocket compatibility issue

Status in QEMU:
  New

Bug description:
  WebSocket support in VNC should allow access from VNC client through
  upgraded WebSocket connection. This feature is not working in IE
  11/Edge with noVNC HTML5 client, in contrast to that in
  Firefox/Safari, etc.

  The reason that IE 11/Edge fails to accept the connection upgrade is
  that the value equality of the `Upgrade` header field is checked in a
  strict case-sensitive manner in QEMU side, however, the IE/Edge does
  not send the exactly same string value `websocket` but a capital
  letter `W` instead.

  Defined in section 4.2.1 of rfc6455, the upgrade header field shall be
  treated case-insensitively.

  A patch shall be made in `io/channel-websock.c`, converting the value
  of upgrade string to lowercase before comparison is made with
  QIO_CHANNEL_WEBSOCK_UPGRADE_WEBSOCKET, to allow case-insensitive
  comparison in the process.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1732671/+subscriptions
