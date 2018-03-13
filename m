Received: from eggs.gnu.org ([2001:4830:134:3::10]:57800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evshf-0005MC-Gq
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:47:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evshe-0002lv-7p
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:47:31 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:41584)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1evshe-0002km-1P
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:47:30 -0400
Received: by mail-wr0-x242.google.com with SMTP id f14so2516806wre.8
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 15:47:29 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 13 Mar 2018 23:46:16 +0100
Message-Id: <20180313224719.4954-7-pbonzini@redhat.com>
In-Reply-To: <20180313224719.4954-1-pbonzini@redhat.com>
References: <20180313224719.4954-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 06/69] qemu-doc: Add the paragraph about the
 -no-frame deprecation again
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>

From: Thomas Huth <thuth@redhat.com>

The section has accidentially been removed while resolving a
contextual conflict during a rebase, so add this again.

Fixes: f29d4450428fe07e9d6b0655cef2e59bfa0b2ea5
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1520405769-22179-1-git-send-email-thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qemu-doc.texi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/qemu-doc.texi b/qemu-doc.texi
index 918d97c18b..f8da9b8135 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -2732,6 +2732,12 @@ filesystem test suite. Also it requires the CAP_DAC_READ_SEARCH capability,
 which is not the recommended way to run QEMU. This backend should not be
 used and it will be removed with no replacement.
 
+@subsection -no-frame (since 2.12.0)
+
+The @code{--no-frame} argument works with SDL 1.2 only. The other user
+interfaces never implemented this in the first place. So this will be
+removed together with SDL 1.2 support.
+
 @subsection -rtc-td-hack (since 2.12.0)
 
 The @code{-rtc-td-hack} option has been replaced by
-- 
2.14.3
