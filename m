Received: from eggs.gnu.org ([2001:4830:134:3::10]:54889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1g9Zzm-0001d5-Pm
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 14:11:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1g9ZhB-0003UE-Mg
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 13:52:00 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:36801)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1g9ZhB-0003SL-0b
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 13:51:53 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Mon,  8 Oct 2018 13:51:44 -0400
Message-Id: <20181008175148.15018-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH v4 0/4] per-TLB lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

v3: https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg01087.html

Changes since v3:

- Add R-b's

- Add comment to copy_tlb_helper_locked to note that it can
  only be called from the TLB owner thread.

The series is checkpatch-clean. You can fetch it from:
  https://github.com/cota/qemu/tree/tlb-lock-v4

Thanks,

		Emilio
