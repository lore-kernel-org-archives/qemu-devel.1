Received: from eggs.gnu.org ([209.51.188.92]:36736)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hJGmI-0002MR-Ho
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 08:13:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hJGee-0002jm-Rn
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 08:05:37 -0400
Received: from indium.canonical.com ([91.189.90.7]:56642)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hJGee-0002fn-LY
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 08:05:36 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hJGed-0001dL-EW
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 12:05:35 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 630CB2E80C8
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 12:05:35 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Apr 2019 11:56:57 -0000
From: Daniel Berrange <1826200@bugs.launchpad.net>
Reply-To: Bug 1826200 <1826200@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <155610584995.13565.1262636932024040431.malonedeb@wampee.canonical.com>
Message-Id: <155610701798.13864.6201237209107021604.launchpad@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1826200] Re: RFE: populate "OEM Strings" (type
 11) SMBIOS table strings from regular files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Changed in: qemu
       Status: New =3D> Confirmed

** Changed in: qemu
     Assignee: (unassigned) =3D> Daniel Berrange (berrange)

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1826200

Title:
  RFE: populate "OEM Strings" (type 11) SMBIOS table strings from
  regular files

Status in QEMU:
  Confirmed

Bug description:
  The feature added in

  https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3D2d6dcbf93fb01b4a7f4=
5a93d276d4d74b16392dd

  and exposed by libvirt as

    https://libvirt.org/formatdomain.html#elementsSysinfo

  allows the user to specify up to 255 strings in the unofmatted area of
  the Type 11 SMBIOS table, where each string may be of arbitrary
  length. This feature is useful for exposing arbitrary text to
  arbitrary guest components (in particular when strings are prefixed
  with "application identifiers").

  Right now, strings can only be specified on the QEMU command line,
  which limits the amount of data that can be passed. Please enable
  users to pass data from regular files too.

  For example:

    $QEMU -smbios
  type=3D11,value=3DHello,txtfile=3Dfile1.txt,txtfile=3Dfile2.txt

  where "file1.txt" and "file2.txt" could be text files containing ASCII
  application prefixes, followed by base64-encoded binary data.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1826200/+subscriptions
