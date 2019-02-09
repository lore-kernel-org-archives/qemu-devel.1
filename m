Received: from eggs.gnu.org ([209.51.188.92]:42002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gsVTw-0003hA-CE
	for qemu-devel@nongnu.org; Sat, 09 Feb 2019 11:27:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gsVTu-0000kb-Fr
	for qemu-devel@nongnu.org; Sat, 09 Feb 2019 11:27:56 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:59583)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gsVTs-0000i7-48
	for qemu-devel@nongnu.org; Sat, 09 Feb 2019 11:27:52 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Sat,  9 Feb 2019 11:27:43 -0500
Message-Id: <20190209162745.12668-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH 0/2]
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Richard Henderson <richard.henderson@linaro.org>

Fix a bug introduced with dynamic TLB sizing -- we forgot to account
for possible TLB resizes during tlb_fill().

Max reported the bug and provided a reproducer here:
  https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg02283.html

Thanks,

		Emilio
