Received: from eggs.gnu.org ([2001:4830:134:3::10]:48351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1ez2pq-0001xP-Tv
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 12:13:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1ez2pl-0007JD-AE
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 12:13:02 -0400
From: Laurent Vivier <lvivier@redhat.com>
Date: Thu, 22 Mar 2018 17:12:24 +0100
Message-Id: <20180322161226.29796-3-lvivier@redhat.com>
In-Reply-To: <20180322161226.29796-1-lvivier@redhat.com>
References: <20180322161226.29796-1-lvivier@redhat.com>
Subject: [Qemu-devel] [PATCH 2/4] error: Remove NULL checks on
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
Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Kevin Wolf <kwolf@redhat.com>, Richard Henderson <rth@twiddle.net>, qemu-arm@nongnu.org, Eric Blake <eblake@redhat.com>, Jason Wang <jasowang@redhat.com>, Max Reitz <mreitz@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-trivial@nongnu.org, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Igor Mitsyanko <i.mitsyanko@gmail.com>, Yongbok Kim <yongbok.kim@mips.com>, "Michael S. Tsirkin" <mst@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Eduardo Habkost <ehabkost@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>, Markus Armbruster <armbru@redhat.com>, Laurent Vivier <lvivier@redhat.com>

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
