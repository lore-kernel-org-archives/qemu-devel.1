Received: from eggs.gnu.org ([2001:4830:134:3::10]:45566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dV0Jj-0005bO-K4
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 14:55:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dV0Jg-0001Kw-JR
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 14:55:27 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:34850)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dV0Jg-0001Km-FB
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 14:55:24 -0400
Received: by mail-qt0-x243.google.com with SMTP id w12so152231qta.2
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 11:55:24 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 11 Jul 2017 15:55:11 -0300
Message-Id: <20170711185511.3033-1-f4bug@amsat.org>
In-Reply-To: <1499765477-10541-1-git-send-email-thuth@redhat.com>
References: <1499765477-10541-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] tcg: move atomic_template.h to accel/tcg/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
same as Thomas previous patch. this file had no entry in MAINTAINERS.

 atomic_template.h => accel/tcg/atomic_template.h | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename atomic_template.h => accel/tcg/atomic_template.h (100%)

diff --git a/atomic_template.h b/accel/tcg/atomic_template.h
similarity index 100%
rename from atomic_template.h
rename to accel/tcg/atomic_template.h
-- 
2.13.2
