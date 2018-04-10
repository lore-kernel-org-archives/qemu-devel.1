Received: from eggs.gnu.org ([2001:4830:134:3::10]:36504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f5tHS-0006cD-2h
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 09:25:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f5tHO-0004lr-Ol
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 09:25:50 -0400
Received: from indium.canonical.com ([91.189.90.7]:33366)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1f5tHO-0004lN-IS
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 09:25:46 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1f5tHM-0004pZ-Vw
	for <qemu-devel@nongnu.org>; Tue, 10 Apr 2018 13:25:45 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id F06772E80D0
	for <qemu-devel@nongnu.org>; Tue, 10 Apr 2018 13:25:44 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Apr 2018 13:19:06 -0000
From: Peter Maydell <peter.maydell@linaro.org>
Reply-To: Bug 1761027 <1761027@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152280226155.9459.1066946337801120026.malonedeb@soybean.canonical.com>
Message-Id: <152336634676.28660.12989513220034456565.launchpad@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1761027] Re: Unexpected error: "AioContext
 polling is not implemented on Windows"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Summary changed:

- Unexpected error
+ Unexpected error: "AioContext polling is not implemented on Windows"

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1761027

Title:
  Unexpected error: "AioContext polling is not implemented on Windows"

Status in QEMU:
  Fix Committed

Bug description:
  When run it this error happens:
  Unexpected error in aio_context_set_poll_params() at /home/stefan/src/qem=
u/repo.or.cz/qemu/ar7/util/aio-win32.c:413:
  C:\Program Files\qemu\qemu-system-x86_64.exe: AioContext polling is not i=
mplemented on Windows

  This application has requested the Runtime to terminate it in an unusual =
way.
  Please contact the application's support team for more information.


  System:
  Windows 10 x64

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1761027/+subscriptions
