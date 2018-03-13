Received: from eggs.gnu.org ([2001:4830:134:3::10]:57989)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evshx-0005e2-3D
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:47:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evshs-00035E-3W
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:47:49 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:33969)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1evshr-00034D-TG
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:47:44 -0400
Received: by mail-wr0-x241.google.com with SMTP id o8so2597949wra.1
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 15:47:43 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 13 Mar 2018 23:46:27 +0100
Message-Id: <20180313224719.4954-18-pbonzini@redhat.com>
In-Reply-To: <20180313224719.4954-1-pbonzini@redhat.com>
References: <20180313224719.4954-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 17/69] chardev: tcp: let TLS run on chardev
 context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>

From: Peter Xu <peterx@redhat.com>

Now qio_channel_tls_handshake() is ready to receive the context.  Let
socket chardev use it, then the TLS handshake of chardev will always be
with the chardev's context.

Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20180306053320.15401-9-peterx@redhat.com>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 chardev/char-socket.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index f6ad6ee4d8..36a8fcc194 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -751,7 +751,7 @@ static void tcp_chr_tls_init(Chardev *chr)
                               tcp_chr_tls_handshake,
                               chr,
                               NULL,
-                              NULL);
+                              chr->gcontext);
 }
 
 
-- 
2.14.3
