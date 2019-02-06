Received: from eggs.gnu.org ([209.51.188.92]:33175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1grKEL-0005dc-0x
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 05:14:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1grKEK-0007iZ-E3
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 05:14:57 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:45612)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1grKEK-0007iD-81
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 05:14:56 -0500
Received: by mail-wr1-x433.google.com with SMTP id q15so6804258wro.12
	for <qemu-devel@nongnu.org>; Wed, 06 Feb 2019 02:14:56 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  6 Feb 2019 10:14:46 +0000
Message-Id: <20190206101446.6898-3-richard.henderson@linaro.org>
In-Reply-To: <20190206101446.6898-1-richard.henderson@linaro.org>
References: <20190206101446.6898-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH RISU 2/2] risugen: Default to sve off
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

We had an --sve switch, which would also enable sve,
but no way to turn sve off.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 risugen | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/risugen b/risugen
index de3f5ea..e690b18 100755
--- a/risugen
+++ b/risugen
@@ -308,6 +308,7 @@ Valid options:
                    a general set you have excluded.
     --no-fp      : disable floating point: no fp init, randomization etc.
                    Useful to test before support for FP is available.
+    --sve        : enable sve floating point
     --be         : generate instructions in Big-Endian byte order (ppc64 only).
     --help       : print this message
 EOT
@@ -319,7 +320,7 @@ sub main()
     my $condprob = 0;
     my $fpscr = 0;
     my $fp_enabled = 1;
-    my $sve_enabled = 1;
+    my $sve_enabled = 0;
     my $big_endian = 0;
     my ($infile, $outfile);
 
-- 
2.17.2
