Received: from eggs.gnu.org ([2001:4830:134:3::10]:41856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1elZHY-0004J1-RB
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:02:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1elZHP-0007bk-AO
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:01:56 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:36566)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1elZHP-0007bV-4Q
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:01:47 -0500
Received: by mail-wm0-x241.google.com with SMTP id f3so15603026wmc.1
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 04:01:46 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 13 Feb 2018 13:00:16 +0100
Message-Id: <1518523252-49106-13-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1518523252-49106-1-git-send-email-pbonzini@redhat.com>
References: <1518523252-49106-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 12/48] build-sys: remove useless extra*flags
 variables
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

Only EXTRA_LDFLAGS seems to be used during configure Xen checks.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20180208162343.30809-1-marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/configure b/configure
index fe9eea9..0a53562 100755
--- a/configure
+++ b/configure
@@ -471,10 +471,8 @@ for opt do
   --cpu=*) cpu="$optarg"
   ;;
   --extra-cflags=*) QEMU_CFLAGS="$QEMU_CFLAGS $optarg"
-                    EXTRA_CFLAGS="$optarg"
   ;;
   --extra-cxxflags=*) QEMU_CXXFLAGS="$QEMU_CXXFLAGS $optarg"
-                      EXTRA_CXXFLAGS="$optarg"
   ;;
   --extra-ldflags=*) LDFLAGS="$LDFLAGS $optarg"
                      EXTRA_LDFLAGS="$optarg"
@@ -1424,7 +1422,6 @@ case "$cpu" in
 esac
 
 QEMU_CFLAGS="$CPU_CFLAGS $QEMU_CFLAGS"
-EXTRA_CFLAGS="$CPU_CFLAGS $EXTRA_CFLAGS"
 
 # For user-mode emulation the host arch has to be one we explicitly
 # support, even if we're using TCI.
@@ -5877,9 +5874,6 @@ if test "$mingw32" = "no" ; then
   echo "qemu_localstatedir=$local_statedir" >> $config_host_mak
 fi
 echo "qemu_helperdir=$libexecdir" >> $config_host_mak
-echo "extra_cflags=$EXTRA_CFLAGS" >> $config_host_mak
-echo "extra_cxxflags=$EXTRA_CXXFLAGS" >> $config_host_mak
-echo "extra_ldflags=$EXTRA_LDFLAGS" >> $config_host_mak
 echo "qemu_localedir=$qemu_localedir" >> $config_host_mak
 echo "libs_softmmu=$libs_softmmu" >> $config_host_mak
 echo "GIT=$git" >> $config_host_mak
-- 
1.8.3.1
