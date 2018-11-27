Received: from eggs.gnu.org ([2001:4830:134:3::10]:35258)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gReTz-0003pq-Cm
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 09:37:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gReTy-0001gU-KM
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 09:36:59 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:38806)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gReTy-0001ex-C0
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 09:36:58 -0500
Received: by mail-wm1-x336.google.com with SMTP id k198so22540427wmd.3
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 06:36:58 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
	by smtp.gmail.com with ESMTPSA id
	n62sm2821869wmd.25.2018.11.27.06.36.55 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 27 Nov 2018 06:36:55 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 27 Nov 2018 15:36:31 +0100
Message-Id: <1543329397-48407-10-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1543329397-48407-1-git-send-email-pbonzini@redhat.com>
References: <1543329397-48407-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 09/15] checkpatch: g_test_message does not need
 a trailing newline
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/checkpatch.pl | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 06ec14e..60f6f89 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2752,7 +2752,8 @@ sub process {
 				info_vreport|
 				error_report|
 				warn_report|
-				info_report}x;
+				info_report|
+				g_test_message}x;
 
 	if ($rawline =~ /\b(?:$qemu_error_funcs)\s*\(.*\".*\\n/) {
 		ERROR("Error messages should not contain newlines\n" . $herecurr);
-- 
1.8.3.1
