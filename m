Received: from eggs.gnu.org ([2001:4830:134:3::10]:58653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fzpGw-0000QD-Kg
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 16:28:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fzpGs-0002W8-6l
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 16:28:30 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:37371)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fzpGs-0002Vk-0p
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 16:28:26 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Tue, 11 Sep 2018 16:28:10 -0400
Message-Id: <20180911202823.21657-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH v3 00/13] i386 + x86_64 mttcg
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

v2: https://lists.gnu.org/archive/html/qemu-devel/2018-09/msg01122.html

Changes since v2:

- Add rth's R-b tag to the last patch
- Drop v2's first 10 patches, since Paolo already picked those up
- Move TCG temps + x86_64_hregs to DisasContext
  + While at it, drop the cpu_ prefix from the TCG temps,
    e.g. cpu_A0 -> s->A0
  + Split the conversion into separate patches to ease review.
    The patches are quite boring and long because the temps
    are everywhere, and I had to add DisasContext *s to quite a few
    functions

The series is checkpatch-clean.

You can fetch these patches from:
  https://github.com/cota/qemu/tree/i386-mttcg-v3

Thanks,

		Emilio
