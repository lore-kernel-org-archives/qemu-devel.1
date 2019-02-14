Received: from eggs.gnu.org ([209.51.188.92]:50552)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1guEYx-0002QE-9l
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 05:48:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1guEYt-0002xQ-GQ
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 05:48:14 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Thu, 14 Feb 2019 11:47:06 +0100
Message-Id: <20190214104717.3543-4-laurent@vivier.eu>
In-Reply-To: <20190214104717.3543-1-laurent@vivier.eu>
References: <20190214104717.3543-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 03/14] qemu-options: Remove deprecated option
 -clock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, libvir-list@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-trivial@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Kamil Rytarowski <kamil@netbsd.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Thomas Huth <thuth@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

From: Thomas Huth <thuth@redhat.com>

The option is only a dummy since a long time. We've finally deprecated
it in QEMU v3.0, so it's time to remove it now.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <1549545296-18903-3-git-send-email-thuth@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 qemu-deprecated.texi | 5 -----
 qemu-options.hx      | 3 ---
 vl.c                 | 6 ------
 3 files changed, 14 deletions(-)

diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
index 90e5860fd1a6..fe905551c598 100644
--- a/qemu-deprecated.texi
+++ b/qemu-deprecated.texi
@@ -37,11 +37,6 @@ would automatically enable USB support on the machine type.
 If using the new syntax, USB support must be explicitly
 enabled via the ``-machine usb=on'' argument.
 
-@subsection -clock (since 3.0.0)
-
-The @code{-clock} option is ignored since QEMU version 1.7.0. There is no
-replacement since it is not needed anymore.
-
 @subsection -drive file=json:@{...@{'driver':'file'@}@} (since 3.0)
 
 The 'file' driver for drives is no longer appropriate for character or host
diff --git a/qemu-options.hx b/qemu-options.hx
index 06ef1a7c5c72..77bd98e20b14 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3444,9 +3444,6 @@ Load the contents of @var{file} as an option ROM.
 This option is useful to load things like EtherBoot.
 ETEXI
 
-HXCOMM Silently ignored for compatibility
-DEF("clock", HAS_ARG, QEMU_OPTION_clock, "", QEMU_ARCH_ALL)
-
 DEF("rtc", HAS_ARG, QEMU_OPTION_rtc, \
     "-rtc [base=utc|localtime|<datetime>][,clock=host|rt|vm][,driftfix=none|slew]\n" \
     "                set the RTC base and clock, enable drift fix for clock ticks (x86 only)\n",
diff --git a/vl.c b/vl.c
index 9e4dba7f92f2..90ff23333dd9 100644
--- a/vl.c
+++ b/vl.c
@@ -3735,12 +3735,6 @@ int main(int argc, char **argv, char **envp)
             case QEMU_OPTION_old_param:
                 old_param = 1;
                 break;
-            case QEMU_OPTION_clock:
-                /* Clock options no longer exist.  Keep this option for
-                 * backward compatibility.
-                 */
-                warn_report("This option is ignored and will be removed soon");
-                break;
             case QEMU_OPTION_rtc:
                 opts = qemu_opts_parse_noisily(qemu_find_opts("rtc"), optarg,
                                                false);
-- 
2.20.1
