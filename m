Received: from eggs.gnu.org ([2001:4830:134:3::10]:34250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fwsUp-00059T-Gd
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 13:18:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fwsUm-00076T-BL
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 13:18:39 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:44895)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fwsUm-00075h-3r
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 13:18:36 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Mon,  3 Sep 2018 13:18:25 -0400
Message-Id: <20180903171831.15446-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH 0/6] i386 + x86_64 mttcg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

I sent ~20 days ago a series that allowed me to boot x86_64 with mttcg:
  https://patchwork.kernel.org/cover/10564977/

Thanks to Paolo's work (already merged), we don't need to hold
the BQL when calling cpu_get_ticks, which makes the MTTCG conversion
even simpler. [ I have a couple more patches related to some of
that work, but I'll send them next week once Paolo is back ]

This series enables MTTCG for both x86_64 and i386. I tested both
with a buildroot image, and looked for races with Valgrind's helgrind.

The first four patches are not really necessary for i386 MTTCG,
but since they'll eventually go via Paolo's tree I included them here.

You can fetch this series from:
  https://github.com/cota/qemu/tree/i386-mttcg

Thanks,

		Emilio
