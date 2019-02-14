Received: from eggs.gnu.org ([209.51.188.92]:50247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1guEYl-0002I0-Gv
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 05:48:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1guEYi-0002ho-NL
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 05:48:03 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Thu, 14 Feb 2019 11:47:05 +0100
Message-Id: <20190214104717.3543-3-laurent@vivier.eu>
In-Reply-To: <20190214104717.3543-1-laurent@vivier.eu>
References: <20190214104717.3543-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 02/14] qemu-deprecated: Remove -virtioconsole
 and -no-frame for good
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, libvir-list@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-trivial@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Kamil Rytarowski <kamil@netbsd.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

From: Thomas Huth <thuth@redhat.com>

The two sections have accidentally been added again during the
merge of Paolo's and Gerd's trees.

Fixes: 3e29da9fd81002a0c03041aaa26dea6d9dd9bd65
Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <1549545296-18903-2-git-send-email-thuth@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 qemu-deprecated.texi | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
index 80b0702ad5b2..90e5860fd1a6 100644
--- a/qemu-deprecated.texi
+++ b/qemu-deprecated.texi
@@ -37,18 +37,6 @@ would automatically enable USB support on the machine type.
 If using the new syntax, USB support must be explicitly
 enabled via the ``-machine usb=on'' argument.
 
-@subsection -virtioconsole (since 3.0.0)
-
-Option @option{-virtioconsole} has been replaced by
-@option{-device virtconsole}.
-
-@subsection -no-frame (since 2.12.0)
-
-The @code{--no-frame} argument works with SDL 1.2 only. The other user
-interfaces never implemented this in the first place. So this will be
-removed together with SDL 1.2 support.
->>>>>>> remotes/bonzini/tags/for-upstream
-
 @subsection -clock (since 3.0.0)
 
 The @code{-clock} option is ignored since QEMU version 1.7.0. There is no
-- 
2.20.1
