Received: from eggs.gnu.org ([2001:4830:134:3::10]:43029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eC8BJ-00074O-JU
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 13:01:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eC8B8-00080t-Ep
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 13:00:56 -0500
Received: from indium.canonical.com ([91.189.90.7]:52326)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eC8B8-0007zy-8H
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 13:00:50 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eC8B7-0005Lf-A2
	for <qemu-devel@nongnu.org>; Tue, 07 Nov 2017 18:00:49 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 491C72E8058
	for <qemu-devel@nongnu.org>; Tue,  7 Nov 2017 18:00:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Nov 2017 17:46:53 -0000
From: Peter Maydell <peter.maydell@linaro.org>
Reply-To: Bug 1431084 <1431084@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20150312002554.14936.93110.malonedeb@wampee.canonical.com>
Message-Id: <151007681359.4416.16161740712839944009.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1431084] Re: improve configure error message
 "ERROR: User requested feature nptl"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

You say "Both linux kernel headers and `libglib2.0-dev` are installed",
but the error message says "Install glibc and linux kernel headers".
"glibc" is not "libglib". I suspect you didn't have what on Ubuntu is
the "libc6-dev" package. Unfortunately it's difficult to be specific in
these error messages, because different distros call their dev packages
by different names.


** Changed in: qemu
       Status: New =3D> Invalid

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1431084

Title:
  improve configure error message "ERROR: User requested feature nptl"

Status in QEMU:
  Invalid

Bug description:
  Running `./configure` on Ubuntu 14.10 amd64 with Linux 3.19.1 causes
  the error

      ERROR: User requested feature nptl
             configure was not able to find it.
             Install glibc and linux kernel headers.

  Both linux kernel headers and `libglib2.0-dev` are installed in my
  case, so the error message definitely misses a point and is at least
  confusing and should either omit the hint if the recommended
  dependencies are already installed or - better - give one that fixes
  the issue.

  experienced with git commit d598911b6f5e7bf7bafb63b8e1d074729e94aca7

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1431084/+subscriptions
