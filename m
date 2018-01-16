Received: from eggs.gnu.org ([2001:4830:134:3::10]:50144)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ebS3m-0002jL-L2
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:17:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ebS3l-0004WN-KS
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:17:54 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:46241)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1ebS3l-0004Vx-Dd
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:17:53 -0500
Received: by mail-wm0-x244.google.com with SMTP id 143so8636917wma.5
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 06:17:53 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 16 Jan 2018 15:16:52 +0100
Message-Id: <1516112253-14480-11-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1516112253-14480-1-git-send-email-pbonzini@redhat.com>
References: <1516112253-14480-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 10/51] build-sys: silence make by default or V=0
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

Move generic make flags in MAKEFLAGS (SUBDIR_MAKEFLAGS is more qemu specific).

Use --quiet to silence make 'is up to date' message.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Tested-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20180104160523.22995-3-marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile  | 2 +-
 rules.mak | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index d86ecd2..1671db3 100644
--- a/Makefile
+++ b/Makefile
@@ -277,7 +277,7 @@ else
 DOCS=
 endif
 
-SUBDIR_MAKEFLAGS=$(if $(V),,--no-print-directory) BUILD_DIR=$(BUILD_DIR)
+SUBDIR_MAKEFLAGS=BUILD_DIR=$(BUILD_DIR)
 SUBDIR_DEVICES_MAK=$(patsubst %, %/config-devices.mak, $(TARGET_DIRS))
 SUBDIR_DEVICES_MAK_DEP=$(patsubst %, %-config-devices.mak.d, $(TARGET_DIRS))
 
diff --git a/rules.mak b/rules.mak
index 6e94333..5fb4951 100644
--- a/rules.mak
+++ b/rules.mak
@@ -131,6 +131,8 @@ modules:
 # If called with only a single argument, will print nothing in quiet mode.
 quiet-command = $(if $(V),$1,$(if $(2),@printf "  %-7s %s\n" $2 $3 && $1, @$1))
 
+MAKEFLAGS += $(if $(V),,--no-print-directory --quiet)
+
 # cc-option
 # Usage: CFLAGS+=$(call cc-option, -falign-functions=0, -malign-functions=0)
 
-- 
1.8.3.1
