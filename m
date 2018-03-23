Received: from eggs.gnu.org ([2001:4830:134:3::10]:36419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1ezNkG-0004Bc-9F
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 10:32:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1ezNkF-0003Fe-IC
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 10:32:40 -0400
From: Laurent Vivier <lvivier@redhat.com>
Date: Fri, 23 Mar 2018 15:32:00 +0100
Message-Id: <20180323143202.28879-4-lvivier@redhat.com>
In-Reply-To: <20180323143202.28879-1-lvivier@redhat.com>
References: <20180323143202.28879-1-lvivier@redhat.com>
Subject: [Qemu-devel] [PATCH v2 3/5] error: Remove NULL checks on
 error_propagate() calls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@suse.de>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-trivial@nongnu.org, Alberto Garcia <berto@igalia.com>, qemu-ppc@nongnu.org, Kevin Wolf <kwolf@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Max Reitz <mreitz@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, qemu-arm@nongnu.org, Yongbok Kim <yongbok.kim@mips.com>, Aurelien Jarno <aurelien@aurel32.net>, Markus Armbruster <armbru@redhat.com>, Jason Wang <jasowang@redhat.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <rth@twiddle.net>, Laurent Vivier <lvivier@redhat.com>

Re-run Coccinelle patch
scripts/coccinelle/error_propagate_null.cocci

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 io/channel-websock.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/io/channel-websock.c b/io/channel-websock.c
index ec48a305f0..e6608b969d 100644
--- a/io/channel-websock.c
+++ b/io/channel-websock.c
@@ -586,9 +586,7 @@ static gboolean qio_channel_websock_handshake_io(QIOChannel *ioc,
         return TRUE;
     }
 
-    if (err) {
-        error_propagate(&wioc->io_err, err);
-    }
+    error_propagate(&wioc->io_err, err);
 
     trace_qio_channel_websock_handshake_reply(ioc);
     qio_channel_add_watch(
-- 
2.14.3
