Received: from eggs.gnu.org ([2001:4830:134:3::10]:54502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fVt8X-0005le-E0
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 02:32:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fVt8U-0003qy-96
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 02:32:05 -0400
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:37128)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fVt8U-0003qJ-3B
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 02:32:02 -0400
Received: by mail-wm0-x230.google.com with SMTP id r125-v6so3641173wmg.2
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 23:32:01 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 21 Jun 2018 07:25:57 +0100
Message-Id: <20180621062605.941-50-alex.bennee@linaro.org>
In-Reply-To: <20180621062605.941-1-alex.bennee@linaro.org>
References: <20180621062605.941-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v2 49/57] tests/tcg/i386: extend timeout for
 runcom test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

The Travis hardware can be a little slow and the runcom test is fairly
heavy in calculating pi. Lets double the timeout so we don't trip up
during CI by mistake.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/tcg/i386/Makefile.target b/tests/tcg/i386/Makefile.target
index 97b7c23cf1..c1997a1624 100644
--- a/tests/tcg/i386/Makefile.target
+++ b/tests/tcg/i386/Makefile.target
@@ -30,6 +30,7 @@ test-i386: test-i386.c test-i386-code16.S test-i386-vm86.S test-i386.h test-i386
 	   $(<D)/test-i386.c $(<D)/test-i386-code16.S $(<D)/test-i386-vm86.S -lm
 
 # Specialist test runners
+run-runcom: TIMEOUT=30
 run-runcom: runcom pi_10.com
 	$(call run-test,$<,$(QEMU) ./runcom $(I386_SRC)/pi_10.com,"$< on $(TARGET_NAME)")
 
-- 
2.17.1
