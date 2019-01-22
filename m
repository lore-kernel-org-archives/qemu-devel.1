Received: from eggs.gnu.org ([209.51.188.92]:60096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gm2O1-0007dU-KG
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 15:11:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gm2O0-0005yM-1T
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 15:11:05 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:39783)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gm2Nz-0005qE-Fg
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 15:11:03 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Tue, 22 Jan 2019 15:10:39 -0500
Message-Id: <20190122201042.26394-2-cota@braap.org>
In-Reply-To: <20190122201042.26394-1-cota@braap.org>
References: <20190122201042.26394-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH 1/4] berkeley-testfloat-3: pull 'fail: constify
 fail_programName'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Pull just one change: 5a59dce ("fail: constify fail_programName",
2019-01-17).

This gets rid of a warning when building fp-test on some hosts, e.g.:

/var/tmp/qemu-test.Z0AmK8/tests/fp/berkeley-testfloat-3/source/fail.c:44:7:
warning: initializing 'char *' with an expression of type 'const char
[1]' discards qualifiers
[-Wincompatible-pointer-types-discards-qualifiers]
char *fail_programName = "";
      ^                  ~~

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 tests/fp/berkeley-testfloat-3 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/fp/berkeley-testfloat-3 b/tests/fp/berkeley-testfloat-3
index ca9fa2ba05..5a59dcec19 160000
--- a/tests/fp/berkeley-testfloat-3
+++ b/tests/fp/berkeley-testfloat-3
@@ -1 +1 @@
-Subproject commit ca9fa2ba05625ba929958f163b01747e07dd39cc
+Subproject commit 5a59dcec19327396a011a17fd924aed4fec416b3
-- 
2.17.1
