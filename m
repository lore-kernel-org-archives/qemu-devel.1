Received: from eggs.gnu.org ([2001:4830:134:3::10]:34158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1enDqT-0003A3-17
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 20:32:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1enDqP-0006LV-Nq
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 20:32:49 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:40363)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1enDqP-0006Gu-GH
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 20:32:45 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Sat, 17 Feb 2018 20:32:35 -0500
Message-Id: <1518917557-12063-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH 0/2] target/openrisc: translator loop conversion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Stafford Horne <shorne@gmail.com>

Tested on the image linked from the wiki:
  https://wiki.qemu.org/Testing/System_Images
Boot after decompressing with:
  or1k-softmmu/qemu-system-or1k -cpu or1200 -M or1k-sim \
	-kernel path/to/or1k-linux-4.10 \
	-serial stdio -nographic -monitor none

Thanks,

		Emilio
