Received: from eggs.gnu.org ([2001:4830:134:3::10]:33905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fpOHm-0006H4-Pm
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 21:38:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fpOHj-0002GU-KL
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 21:38:14 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:59915)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fpOHj-0002Fw-Dy
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 21:38:11 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Mon, 13 Aug 2018 21:37:57 -0400
Message-Id: <20180814013801.26036-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH 0/4] x86_64 mttcg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

With this series I can boot a busybox image and several Ubuntu images
with various -smp's.

The speedup we get is in line with what we get with other ISAs, e.g.
-smp 4 takes 34s instead of 1min with thread=single.

I've run this through the Valgrind race detectors, and the remaining
races reported seem benign.

I have not tested i386, so I'm not turning mttcg on for it yet.

Patches 1-2 comply with cpu_get_ticks' documentation. I'm not too
happy about effectively serializing rdtsc, since Linux guests call it
very often (for each vCPU!). But as usual, correctness goes before
performance or scalability.

You can fetch the series from:
  https://github.com/cota/qemu/tree/x86_64-mttcg

Thanks,

		Emilio
