Received: from eggs.gnu.org ([2001:4830:134:3::10]:42238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dINeL-0003wW-NM
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 19:12:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dINeI-0002I8-JA
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 19:12:33 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:33553)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dINeI-0002Gm-0L
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 19:12:30 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Tue,  6 Jun 2017 19:12:23 -0400
Message-Id: <1496790745-314-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH v3 0/2] tcg: allocate TB structs preceding
 translate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, alex.bennee@linaro.org, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Pranith Kumar <bobby.prani@gmail.com>, Geert Martin Ijewski <gm.ijewski@web.de>

v2: https://lists.gnu.org/archive/html/qemu-devel/2017-06/msg01147.html

Changes from v2:

- Dropped the configure-time check. Instead, do this at init-time
  as suggested by Richard.

- Added Pranith's R-b tag to the TCG patch.

- Added cache info query for Windows thanks to Geerd's help.

- Added cache info query for MacOS [ #ifdef __APPLE__ ] via sysctl. (Note:
  I only tested the code on a standalone program, since I cannot install
  QEMU's dependences on the MacOS machine I got access to)

- Use int instead of unsigned int for the line sizes. This allows
  us to use ROUND_UP without having to cast to int (ROUND_UP negates
  the alignment parameter)

Question: is it worth adding a paranoid check to make sure the linesizes
we obtain are a pow2? If there's a bug somewhere in the reporting,
we'll get in trouble due to ROUND_UP, which only works with pow2
parameters. A safer alternative is to use QEMU_ALIGN_UP, but it's slower.

This patchset applies cleanly on top of the current master (65dfad62a).

Thanks,

		Emilio
