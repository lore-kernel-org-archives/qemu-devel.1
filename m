Received: from eggs.gnu.org ([2001:4830:134:3::10]:52046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gX6MO-0000f6-FA
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:23:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gX6MH-0008TV-4P
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:23:38 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:42670)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gX6MG-0008KO-Pb
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:23:32 -0500
Received: by mail-wr1-x436.google.com with SMTP id q18so18081052wrx.9
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 07:23:23 -0800 (PST)
Received: from 640k.lan ([93.56.166.5]) by smtp.gmail.com with ESMTPSA id
	u10sm15878859wrr.33.2018.12.12.07.23.21 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 12 Dec 2018 07:23:21 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 12 Dec 2018 16:22:25 +0100
Message-Id: <1544628195-37728-5-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1544628195-37728-1-git-send-email-pbonzini@redhat.com>
References: <1544628195-37728-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 04/54] checkpatch: check Signed-off-by in
 --mailback mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Pull the test before the anticipated exits from the process sub.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/checkpatch.pl | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index b9974f0..506aa6c 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2817,6 +2817,10 @@ sub process {
 		}
 	}
 
+	if ($is_patch && $chk_signoff && $signoff == 0) {
+		ERROR("Missing Signed-off-by: line(s)\n");
+	}
+
 	# If we have no input at all, then there is nothing to report on
 	# so just keep quiet.
 	if ($#rawlines == -1) {
@@ -2838,9 +2842,6 @@ sub process {
 	if (!$is_patch) {
 		ERROR("Does not appear to be a unified-diff format patch\n");
 	}
-	if ($is_patch && $chk_signoff && $signoff == 0) {
-		ERROR("Missing Signed-off-by: line(s)\n");
-	}
 
 	print report_dump();
 	if ($summary && !($clean == 1 && $quiet == 1)) {
-- 
1.8.3.1
