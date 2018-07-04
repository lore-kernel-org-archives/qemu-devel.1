Received: from eggs.gnu.org ([2001:4830:134:3::10]:39807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1faind-0003sh-CZ
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 10:30:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fainX-0006xE-MJ
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 10:30:29 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:45498)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fainX-0006x8-Go
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 10:30:23 -0400
Received: by mail-qk0-x242.google.com with SMTP id c192-v6so2933884qkg.12
	for <qemu-devel@nongnu.org>; Wed, 04 Jul 2018 07:30:23 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed,  4 Jul 2018 11:30:14 -0300
Message-Id: <20180704143014.8670-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] configure: Do not display host compilers as
 cross-compilers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>

This silent (since d75402b5ee2):

  ./configure
  [...]
  NOTE: cross-compilers enabled:  'cc'

Reported-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reported-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 configure | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure b/configure
index b99ebdde24..fbb53ab6bb 100755
--- a/configure
+++ b/configure
@@ -7328,7 +7328,7 @@ echo "QEMU_CFLAGS+=$cflags" >> $config_target_mak
 
 done # for target in $targets
 
-if test -n "$enabled_cross_compilers"; then
+if test -n "$target_compiler" -a -n "$enabled_cross_compilers"; then
     echo
     echo "NOTE: cross-compilers enabled: $enabled_cross_compilers"
 fi
-- 
2.18.0
