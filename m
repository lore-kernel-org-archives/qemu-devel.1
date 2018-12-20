Received: from eggs.gnu.org ([2001:4830:134:3::10]:48456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gZzol-0008BJ-G4
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 10:01:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gZzof-0005uX-7o
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 10:00:55 -0500
Received: from indium.canonical.com ([91.189.90.7]:39382)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gZzof-0005tb-1J
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 10:00:49 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gZzod-00005P-MO
	for <qemu-devel@nongnu.org>; Thu, 20 Dec 2018 15:00:47 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id A56E32E80C9
	for <qemu-devel@nongnu.org>; Thu, 20 Dec 2018 15:00:47 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Dec 2018 14:47:55 -0000
From: Daniel Berrange <1809252@bugs.launchpad.net>
Reply-To: Bug 1809252 <1809252@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <154531078494.20640.11118060956049517137.malonedeb@wampee.canonical.com>
Message-Id: <154531727594.2249.17418510241473588973.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1809252] Re: Password authentication in
 FIPS-compliant mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The VNC password authentication scheme is not extensible. It is
unfixably broken by design.

QEMU provides the SASL authentication scheme for VNC which allows for
strong authentication, when combined with the VeNCrypt authentication
scheme that uses TLS.

These extensions are supported by the gtk-vnc client used by remote-
viewer, virt-viewer, virt-manager, GNOME Boxes and more.  Other VNC
clients are also known to implement VeNCrypt, though SASL support is
less wide spread.

>From a QEMU POV, there's nothing more we need todo really - any
remaining gaps are client side.

** Changed in: qemu
       Status: New =3D> Invalid

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1809252

Title:
  Password authentication in FIPS-compliant mode

Status in QEMU:
  Invalid

Bug description:
  The documentation states, that:

  "The VNC protocol has limited support for password based
  authentication. (...) Password authentication is not supported when
  operating in FIPS 140-2 compliance mode as it requires the use of the
  DES cipher."

  Would it be possible for qemu to use a different cipher and re-enable
  password as an option in VNC console? Is there a technical reason for
  not using a stronger cipher?

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1809252/+subscriptions
