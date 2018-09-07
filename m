Received: from eggs.gnu.org ([2001:4830:134:3::10]:55906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fyBgf-0002TC-Og
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 04:00:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fyBga-0007r6-Ot
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 04:00:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43008 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fyBga-0007qE-JK
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 04:00:12 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri,  7 Sep 2018 11:59:38 +0400
Message-Id: <20180907075948.26917-3-marcandre.lureau@redhat.com>
In-Reply-To: <20180907075948.26917-1-marcandre.lureau@redhat.com>
References: <20180907075948.26917-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 02/12] cutils: add qemu_pstrcmp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Igor Mammedov <imammedo@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, eblake@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

A char** variant of strcmp().

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/qemu/cutils.h | 12 ++++++++++++
 util/cutils.c         |  5 +++++
 2 files changed, 17 insertions(+)

diff --git a/include/qemu/cutils.h b/include/qemu/cutils.h
index 47aaa3b0b9..0941639f36 100644
--- a/include/qemu/cutils.h
+++ b/include/qemu/cutils.h
@@ -169,4 +169,16 @@ bool test_buffer_is_zero_next_accel(void);
 int uleb128_encode_small(uint8_t *out, uint32_t n);
 int uleb128_decode_small(const uint8_t *in, uint32_t *n);
=20
+/**
+ * qemu_pstrcmp:
+ * @str1: a pointer to a C string
+ * @str2: a pointer to a C string
+ *
+ * Compares *str1 and *str2 with g_strcmp0().
+ *
+ * Returns: an integer less than, equal to, or greater than zero, if
+ * *str1 is <, =3D=3D or > than *str2 .
+ */
+int qemu_pstrcmp(const char **str1, const char **str2);
+
 #endif
diff --git a/util/cutils.c b/util/cutils.c
index 9205e09031..e2abc64278 100644
--- a/util/cutils.c
+++ b/util/cutils.c
@@ -769,3 +769,8 @@ char *size_to_str(uint64_t val)
=20
     return g_strdup_printf("%0.3g %sB", (double)val / div, suffixes[i]);
 }
+
+int qemu_pstrcmp(const char **str1, const char **str2)
+{
+    return g_strcmp0(*str1, *str2);
+}
--=20
2.19.0.rc1
