Received: from eggs.gnu.org ([209.51.188.92]:52710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gydSp-00087u-0I
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 09:12:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gydSn-0003Jf-US
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 09:12:06 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:45784)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gydSn-0003GO-6S
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 09:12:05 -0500
Received: by mail-wr1-x432.google.com with SMTP id w17so14089763wrn.12
	for <qemu-devel@nongnu.org>; Tue, 26 Feb 2019 06:12:05 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 26 Feb 2019 14:11:55 +0000
Message-Id: <20190226141201.16999-2-alex.bennee@linaro.org>
In-Reply-To: <20190226141201.16999-1-alex.bennee@linaro.org>
References: <20190226141201.16999-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 1/7] tests: Ignore fp test outputs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, david@redhat.com, Eric Blake <eblake@redhat.com>, "Emilio G . Cota" <cota@braap.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

From: Eric Blake <eblake@redhat.com>

Commit 2cade3d wired up new tests, but did not exclude the
new *.out files produced by running the tests.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/.gitignore b/tests/.gitignore
index 72c18aaab0..f2bf85c8c4 100644
--- a/tests/.gitignore
+++ b/tests/.gitignore
@@ -5,6 +5,7 @@ benchmark-crypto-hmac
 check-*
 !check-*.c
 !check-*.sh
+fp/*.out
 qht-bench
 rcutorture
 test-*
-- 
2.20.1
