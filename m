Received: from eggs.gnu.org ([2001:4830:134:3::10]:43273)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1emA0E-00049Q-KQ
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 22:14:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1emA09-0000cu-Lr
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 22:14:30 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Wed, 14 Feb 2018 22:14:19 -0500
Message-Id: <1518664462-2960-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH 0/3] target/ppc: convert to generic translation
 loop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org

After converting riscv to the translation loop, I'm trying to keep
the momentum going. Hopefully this will lead to quite a few more
targets being converted.

The appended converts the ppc target to TranslatorOps.

I have tested it by booting ubuntu on a ppc64 guest.

Please review! Thanks,

		Emilio
