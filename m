Received: from eggs.gnu.org ([2001:4830:134:3::10]:60836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jeff@jeffcook.io>) id 1eaqT1-0007DQ-W0
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 17:09:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jeff@jeffcook.io>) id 1eaqSy-0006Tn-0i
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 17:09:27 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:33685)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jeff@jeffcook.io>) id 1eaqSx-0006Rs-Ow
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 17:09:23 -0500
Message-Id: <1515967760.2831153.1235131064.2949643B@webmail.messagingengine.com>
From: Jeff Cook <jeff@jeffcook.io>
MIME-Version: 1.0
Date: Sun, 14 Jan 2018 17:09:20 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] QEMU with Spice/GL breaks on nvidia
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ebassi@gmail.com

Please see discussion at https://github.com/anholt/libepoxy/issues/148
regarding a recent breakage between QEMU and the nvidia driver.
The gist seems to be that commit
86c0522c63e84ee9a98b9cd9cf6588faba1bac23 introduces mechanisms that
check for EGL extensions at build time instead of runtime. nvidia does
not provide the requested extension, resulting in a crash when the Spice
window is loaded.
Thanks
Jeff
