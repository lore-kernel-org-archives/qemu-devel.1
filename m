Received: from eggs.gnu.org ([2001:4830:134:3::10]:38998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fVIvO-0004CL-PJ
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 11:52:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fVIvF-0001oF-8w
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 11:52:06 -0400
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:37139)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fVIvE-0001mc-TV
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 11:51:57 -0400
Received: by mail-wr0-x233.google.com with SMTP id d8-v6so179224wro.4
	for <qemu-devel@nongnu.org>; Tue, 19 Jun 2018 08:51:56 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 19 Jun 2018 16:44:27 +0100
Message-Id: <20180619154435.18898-49-alex.bennee@linaro.org>
In-Reply-To: <20180619154435.18898-1-alex.bennee@linaro.org>
References: <20180619154435.18898-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 48/56] tests/tcg/i386: extend timeout for runcom
 test
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
