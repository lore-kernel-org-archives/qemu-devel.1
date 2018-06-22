Received: from eggs.gnu.org ([2001:4830:134:3::10]:38717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fWMnX-0006H0-98
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 10:12:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fWMnS-0006CZ-7k
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 10:12:23 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:42762)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fWMnS-0006By-0x
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 10:12:18 -0400
Received: by mail-wr0-x241.google.com with SMTP id w10-v6so6859609wrk.9
	for <qemu-devel@nongnu.org>; Fri, 22 Jun 2018 07:12:17 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 22 Jun 2018 15:11:54 +0100
Message-Id: <20180622141205.16306-12-alex.bennee@linaro.org>
In-Reply-To: <20180622141205.16306-1-alex.bennee@linaro.org>
References: <20180622141205.16306-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RISU PATCH v4 11/22] risugen: add dtype_msz address
 helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, richard.henderson@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 risugen_arm.pm | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/risugen_arm.pm b/risugen_arm.pm
index 696bf5f..8d423b1 100644
--- a/risugen_arm.pm
+++ b/risugen_arm.pm
@@ -765,6 +765,15 @@ sub write_get_offset()
     write_risuop($OP_GETMEMBLOCK);
 }
 
+# Return the log2 of the memory size of an operation described by dtype.
+sub dtype_msz($)
+{
+    my ($dtype) = @_;
+    my $dth = $dtype >> 2;
+    my $dtl = $dtype & 3;
+    return $dtl >= $dth ? $dth : 3 - $dth;
+}
+
 sub reg($@)
 {
     my ($base, @trashed) = @_;
-- 
2.17.1
