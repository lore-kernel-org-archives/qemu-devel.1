Received: from eggs.gnu.org ([209.51.188.92]:50218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1guEYl-0002He-0k
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 05:48:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1guEYj-0002ii-4m
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 05:48:02 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Thu, 14 Feb 2019 11:47:12 +0100
Message-Id: <20190214104717.3543-10-laurent@vivier.eu>
In-Reply-To: <20190214104717.3543-1-laurent@vivier.eu>
References: <20190214104717.3543-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 09/14] HMP: Prepend errors with 'Error:'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, libvir-list@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-trivial@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Kamil Rytarowski <kamil@netbsd.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Always make error messages start with 'Error:' as a fallback
to make sure that anything parsing them can tell it failed.

Note: Some places don't use hmp_handle_error

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20190212134758.10514-3-dgilbert@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hmp.c b/hmp.c
index b2a2b1f84e33..4d14718fea4a 100644
--- a/hmp.c
+++ b/hmp.c
@@ -62,7 +62,7 @@ static void hmp_handle_error(Monitor *mon, Error **errp)
 {
     assert(errp);
     if (*errp) {
-        error_report_err(*errp);
+        error_reportf_err(*errp, "Error: ");
     }
 }
 
-- 
2.20.1
