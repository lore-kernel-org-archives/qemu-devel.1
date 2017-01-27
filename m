Received: from eggs.gnu.org ([2001:4830:134:3::10]:33609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cX6r2-000595-7A
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:46:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cX6r0-00045a-QZ
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:46:16 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:33252)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cX6r0-00044F-KF
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 08:46:14 -0500
Received: by mail-wm0-x244.google.com with SMTP id r144so58440618wme.0
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 05:46:14 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 27 Jan 2017 14:45:30 +0100
Message-Id: <1485524749-118532-23-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1485524749-118532-1-git-send-email-pbonzini@redhat.com>
References: <1485524749-118532-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 22/41] qemu-options: stdio is available on win32
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Available since commit db418a0a7ef5887ea0f3d167584e6f500bb0c4c5
(October 2011, qemu 1.0)

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qemu-options.hx | 2 --
 1 file changed, 2 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 1b4f7d6..a23a137 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -2431,8 +2431,6 @@ Connect to standard input and standard output of the QEMU process.
 exiting QEMU with the key sequence @key{Control-c}. This option is enabled by
 default, use @option{signal=off} to disable it.
 
-@option{stdio} is not available on Windows hosts.
-
 @item -chardev braille ,id=@var{id}
 
 Connect to a local BrlAPI server. @option{braille} does not take any options.
-- 
1.8.3.1
