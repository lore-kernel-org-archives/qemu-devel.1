Received: from eggs.gnu.org ([2001:4830:134:3::10]:58636)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1g8PEf-00086L-Sf
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 08:29:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1g8PEc-0005go-Hw
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 08:29:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53224)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1g8PEc-0005gC-Aa
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 08:29:34 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri,  5 Oct 2018 16:29:00 +0400
Message-Id: <20181005122910.11745-3-marcandre.lureau@redhat.com>
In-Reply-To: <20181005122910.11745-1-marcandre.lureau@redhat.com>
References: <20181005122910.11745-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 02/12] cutils: add qemu_pstrcmp0()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

A char** variant of g_strcmp0().

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 include/qemu/cutils.h | 12 ++++++++++++
 util/cutils.c         |  5 +++++
 2 files changed, 17 insertions(+)

diff --git a/include/qemu/cutils.h b/include/qemu/cutils.h
index 47aaa3b0b9..7071bfe2d4 100644
--- a/include/qemu/cutils.h
+++ b/include/qemu/cutils.h
@@ -169,4 +169,16 @@ bool test_buffer_is_zero_next_accel(void);
 int uleb128_encode_small(uint8_t *out, uint32_t n);
 int uleb128_decode_small(const uint8_t *in, uint32_t *n);
=20
+/**
+ * qemu_pstrcmp0:
+ * @str1: a non-NULL pointer to a C string (*str1 can be NULL)
+ * @str2: a non-NULL pointer to a C string (*str2 can be NULL)
+ *
+ * Compares *str1 and *str2 with g_strcmp0().
+ *
+ * Returns: an integer less than, equal to, or greater than zero, if
+ * *str1 is <, =3D=3D or > than *str2.
+ */
+int qemu_pstrcmp0(const char **str1, const char **str2);
+
 #endif
diff --git a/util/cutils.c b/util/cutils.c
index 9205e09031..698bd315bd 100644
--- a/util/cutils.c
+++ b/util/cutils.c
@@ -769,3 +769,8 @@ char *size_to_str(uint64_t val)
=20
     return g_strdup_printf("%0.3g %sB", (double)val / div, suffixes[i]);
 }
+
+int qemu_pstrcmp0(const char **str1, const char **str2)
+{
+    return g_strcmp0(*str1, *str2);
+}
--=20
2.19.0.271.gfe8321ec05
