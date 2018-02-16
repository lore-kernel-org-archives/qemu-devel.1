Received: from eggs.gnu.org ([2001:4830:134:3::10]:39773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1emWXm-0002wK-Et
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 22:18:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1emWXi-0002UA-FE
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 22:18:38 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:44977)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1emWXi-0002Tp-8L
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 22:18:34 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 15 Feb 2018 22:18:23 -0500
Message-Id: <1518751105-17211-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH 0/2] target/sh4: translator loop conversion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Aurelien Jarno <aurelien@aurel32.net>

Tested on Aurelien's debian sh4 image.

There's a twist in this conversion in that max_insns might be
modified by .tb_start; this is what patch 1 introduces.

Note that I've sent patches for converting other targets to the
translation loop; those have not yet hit master so in patch 1
I am ignoring the corresponding targets.

Thanks,

		Emilio
