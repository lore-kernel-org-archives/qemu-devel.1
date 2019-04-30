Received: from eggs.gnu.org ([209.51.188.92]:39137)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hLW2I-00048d-M2
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:55:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hLVzi-0000fS-Hg
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:52:39 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:38048)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hLVzi-0000av-Bq
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:52:38 -0400
Received: by mail-wr1-x443.google.com with SMTP id k16so21859542wrn.5
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 09:52:38 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 30 Apr 2019 17:52:23 +0100
Message-Id: <20190430165234.32272-5-alex.bennee@linaro.org>
In-Reply-To: <20190430165234.32272-1-alex.bennee@linaro.org>
References: <20190430165234.32272-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 04/15] tests/tcg/multiarch: move the system
 memory test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, mark.cave-ayland@ilande.co.uk, cota@braap.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

There is nothing inherently architecture specific about the memory
test although we may have to manage different restrictions of
unaligned access across architectures.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/{i386 => multiarch}/system/memory.c | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename tests/tcg/{i386 => multiarch}/system/memory.c (100%)

diff --git a/tests/tcg/i386/system/memory.c b/tests/tcg/multiarch/system/memory.c
similarity index 100%
rename from tests/tcg/i386/system/memory.c
rename to tests/tcg/multiarch/system/memory.c
-- 
2.20.1
