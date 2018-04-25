Received: from eggs.gnu.org ([2001:4830:134:3::10]:37853)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fBDB1-0000mo-4g
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 01:41:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fBDAx-0001J2-KB
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 01:41:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60734 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fBDAx-0001I4-Ga
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 01:41:07 -0400
From: Peter Xu <peterx@redhat.com>
Date: Wed, 25 Apr 2018 13:40:46 +0800
Message-Id: <20180425054046.21519-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] checkpatch.pl: add common glib defines to
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
Cc: peterx@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Fam Zheng <famz@redhat.com>

Otherwise it can warn this:

  ERROR: space prohibited between function name and open parenthesis '('

When with things like this:

  typedef gboolean (*it_tree_iterator)(ITValue start, ITValue end);

CC: Paolo Bonzini <pbonzini@redhat.com>
CC: Stefan Hajnoczi <stefanha@redhat.com>
CC: "Daniel P. Berrang=C3=A9" <berrange@redhat.com>
CC: Markus Armbruster <armbru@redhat.com>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
CC: Fam Zheng <famz@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 scripts/checkpatch.pl | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index d52207a3cc..6c25449cd3 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -266,6 +266,20 @@ our @typeList =3D (
 	qr{target_(?:u)?long},
 	qr{hwaddr},
 	qr{xml${Ident}},
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
 );
=20
 # This can be modified by sub possible.  Since it can be empty, be caref=
ul
--=20
2.14.3
