Received: from eggs.gnu.org ([2001:4830:134:3::10]:41116)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fGAss-0002qq-Nh
	for qemu-devel@nongnu.org; Tue, 08 May 2018 18:14:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fGAsr-0001Iq-7d
	for qemu-devel@nongnu.org; Tue, 08 May 2018 18:14:58 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:35365)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fGAsr-0001Hu-1u
	for qemu-devel@nongnu.org; Tue, 08 May 2018 18:14:57 -0400
Received: by mail-wm0-x242.google.com with SMTP id o78-v6so24237585wmg.0
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 15:14:57 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed,  9 May 2018 00:14:21 +0200
Message-Id: <1525817687-34620-5-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1525817687-34620-1-git-send-email-pbonzini@redhat.com>
References: <1525817687-34620-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 04/30] checkpatch.pl: add common glib defines to
 typelist
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=83=C2=A9?= <berrange@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Fam Zheng <famz@redhat.com>

From: Peter Xu <peterx@redhat.com>

Otherwise it can warn this:

  ERROR: space prohibited between function name and open parenthesis '('

When with things like this:

  typedef gboolean (*it_tree_iterator)(ITValue start, ITValue end);

CC: Paolo Bonzini <pbonzini@redhat.com>
CC: "Daniel P. BerrangÃ©" <berrange@redhat.com>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
CC: Fam Zheng <famz@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20180425070103.23723-1-peterx@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/checkpatch.pl | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 5b8735d..e73b4ef 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -265,8 +265,36 @@ our @typeList = (
 	qr{${Ident}_handler_fn},
 	qr{target_(?:u)?long},
 	qr{hwaddr},
+        # external libraries
 	qr{xml${Ident}},
 	qr{xendevicemodel_handle},
+	# Glib definitions
+	qr{gchar},
+	qr{gshort},
+	qr{glong},
+	qr{gint},
+	qr{gboolean},
+	qr{guchar},
+	qr{gushort},
+	qr{gulong},
+	qr{guint},
+	qr{gfloat},
+	qr{gdouble},
+	qr{gpointer},
+	qr{gconstpointer},
+	qr{gint8},
+	qr{guint8},
+	qr{gint16},
+	qr{guint16},
+	qr{gint32},
+	qr{guint32},
+	qr{gint64},
+	qr{guint64},
+	qr{gsize},
+	qr{gssize},
+	qr{goffset},
+	qr{gintptr},
+	qr{guintptr},
 );
 
 # This can be modified by sub possible.  Since it can be empty, be careful
-- 
1.8.3.1
