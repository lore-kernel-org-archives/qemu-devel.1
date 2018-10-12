Received: from eggs.gnu.org ([2001:4830:134:3::10]:35840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gB2ju-0002lY-HQ
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 15:04:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gB2jq-0003dA-JX
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 15:04:46 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:58221)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gB2jo-0003bB-CO
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 15:04:41 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Fri, 12 Oct 2018 15:04:31 -0400
Message-Id: <20181012190434.19477-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH v4 0/3] Dynamic TLB sizing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

RFC v3: https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg01753.html

Changes since RFC v3:

- This is now a proper patch series, since it should not (knowingly)
  break anything.

- Rebase on top of rth's tcg-next (ffd8994b90f5), which includes
  patch 1 from RFC v3.

- Make the feature optional, so that we don't need to change
  all TCG backends right now. For this, define
  TCG_TARGET_IMPLEMENTS_DYN_TLB, which follows a similar approach
  to what we do with TCG instructions with TCG_TARGET_HAS_foo.

- Merge most changes into a single patch to ease review.
  Alex: as a result I dropped two of your R-b's, but note that the
  only change is the addition of inline helpers to hide whether the
  TCG backend implements the feature.

The series is checkpatch-clean. You can fetch it from:
  https://github.com/cota/qemu/tree/tlb-dyn-v4

Thanks,

		Emilio
