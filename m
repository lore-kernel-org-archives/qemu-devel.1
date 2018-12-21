Received: from eggs.gnu.org ([2001:4830:134:3::10]:55750)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gaG7u-0002xl-97
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 03:25:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gaG7p-0001Hp-9j
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 03:25:44 -0500
Received: from indium.canonical.com ([91.189.90.7]:56380)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gaG7o-0001Fy-UN
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 03:25:41 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gaG7l-0000hi-8t
	for <qemu-devel@nongnu.org>; Fri, 21 Dec 2018 08:25:37 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 280BC2E8053
	for <qemu-devel@nongnu.org>; Fri, 21 Dec 2018 08:25:37 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Dec 2018 08:12:47 -0000
From: =?utf-8?q?Tomasz_Bara=C5=84ski?= <1809252@bugs.launchpad.net>
Reply-To: Bug 1809252 <1809252@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <154531078494.20640.11118060956049517137.malonedeb@wampee.canonical.com>
Message-Id: <154537996750.24485.3791215180966276526.malone@gac.canonical.com>
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

I understand. Thank you, guys!

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
