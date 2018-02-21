Received: from eggs.gnu.org ([2001:4830:134:3::10]:55626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1eobRJ-0007gx-VK
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 15:57:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1eobQF-0004dd-VF
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 15:56:33 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:55287)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1eobQF-0004c9-Aw
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 15:55:27 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Wed, 21 Feb 2018 15:55:07 -0500
Message-Id: <1519246509-4022-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCHv3 0/2] target/sh4: translator loop conversion
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

Changes from v2:
- Use int for both num_insns and max_insns, which involves no churn
  compared to converting everything to unsigned.

Thanks,

		Emilio
