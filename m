Received: from eggs.gnu.org ([2001:4830:134:3::10]:59079)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ejqGZ-0007rh-W4
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 12:45:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ejqGW-000437-P8
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 12:45:48 -0500
Received: from indium.canonical.com ([91.189.90.7]:37330)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ejqGW-00042Z-J0
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 12:45:44 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1ejqGT-00050W-W0
	for <qemu-devel@nongnu.org>; Thu, 08 Feb 2018 17:45:42 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id AA89C2E80CF
	for <qemu-devel@nongnu.org>; Thu,  8 Feb 2018 17:45:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Feb 2018 17:32:07 -0000
From: Toomas Soome <tsoome@me.com>
Reply-To: Bug 1747393 <1747393@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <151782642980.10198.17726074601611845094.malonedeb@wampee.canonical.com>
Message-Id: <151811112806.27805.4234071796130648960.launchpad@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1747393] Re: nvme is missing support for
 NVME_ADM_CMD_ASYNC_EV_REQ
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Description changed:

  NVME_ADM_CMD_ASYNC_EV_REQ is required by specification but apparently we
  will be responded by error when this command is used.
+ =

+ The Asynchronous Event Request is a mandatory opcode required by
+ specification (Figure 40, Section 5 in NVMe 1.2; Figure 41, Section 5 in
+ NVMe 1.3). A simple way to deal with this in an emulator that doesn't
+ really want to use async events is to queue up the requests and not do
+ anything with them, and only complete them when the driver aborts the
+ command.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1747393

Title:
  nvme is missing support for NVME_ADM_CMD_ASYNC_EV_REQ

Status in QEMU:
  New

Bug description:
  NVME_ADM_CMD_ASYNC_EV_REQ is required by specification but apparently
  we will be responded by error when this command is used.

  The Asynchronous Event Request is a mandatory opcode required by
  specification (Figure 40, Section 5 in NVMe 1.2; Figure 41, Section 5
  in NVMe 1.3). A simple way to deal with this in an emulator that
  doesn't really want to use async events is to queue up the requests
  and not do anything with them, and only complete them when the driver
  aborts the command.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1747393/+subscriptions
