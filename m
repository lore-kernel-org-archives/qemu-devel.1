Received: from eggs.gnu.org ([2001:4830:134:3::10]:58161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <suhang16@mails.ucas.ac.cn>) id 1epo3N-0007Wc-2g
	for qemu-devel@nongnu.org; Sat, 24 Feb 2018 23:36:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <suhang16@mails.ucas.ac.cn>) id 1epo3J-0001tP-3m
	for qemu-devel@nongnu.org; Sat, 24 Feb 2018 23:36:49 -0500
Received: from smtp17.cstnet.cn ([159.226.251.17]:53745 helo=cstnet.cn)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <suhang16@mails.ucas.ac.cn>) id 1epo3I-0001sh-8M
	for qemu-devel@nongnu.org; Sat, 24 Feb 2018 23:36:45 -0500
From: Su Hang <suhang16@mails.ucas.ac.cn>
Date: Sun, 25 Feb 2018 12:35:57 +0800
Message-Id: <1519533358-13759-3-git-send-email-suhang16@mails.ucas.ac.cn>
In-Reply-To: <1519533358-13759-1-git-send-email-suhang16@mails.ucas.ac.cn>
References: <1519533358-13759-1-git-send-email-suhang16@mails.ucas.ac.cn>
Subject: [Qemu-devel] [PATCH v4 RFC 2/3] util/uri.c: remove brackets that
 wrap `return` statement's content.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: boxafox@163.com
Cc: qemu-devel@nongnu.org

only remove brackets that wrap `return` statements' content.

use `perl -pi -e "s/return \((.*?)\);/return \1;/g" util/uri.c`
to remove pattern like this: "return (1);"

Signed-off-by: Su Hang <suhang16@mails.ucas.ac.cn>
---
 util/uri.c | 160 ++++++++++++++++++++++++++++++-------------------------------
 1 file changed, 80 insertions(+), 80 deletions(-)

diff --git a/util/uri.c b/util/uri.c
index cf09f41735a1..bb2576cf2190 100644
--- a/util/uri.c
+++ b/util/uri.c
@@ -212,11 +212,11 @@ static int rfc3986_parse_scheme(URI *uri, const char **str)
     const char *cur;
 
     if (str == NULL)
-        return (-1);
+        return -1;
 
     cur = *str;
     if (!ISA_ALPHA(cur))
-        return (2);
+        return 2;
     cur++;
     while (ISA_ALPHA(cur) || ISA_DIGIT(cur) || (*cur == '+') || (*cur == '-') ||
            (*cur == '.'))
@@ -226,7 +226,7 @@ static int rfc3986_parse_scheme(URI *uri, const char **str)
         uri->scheme = g_strndup(*str, cur - *str);
     }
     *str = cur;
-    return (0);
+    return 0;
 }
 
 /**
@@ -249,7 +249,7 @@ static int rfc3986_parse_fragment(URI *uri, const char **str)
     const char *cur;
 
     if (str == NULL)
-        return (-1);
+        return -1;
 
     cur = *str;
 
@@ -265,7 +265,7 @@ static int rfc3986_parse_fragment(URI *uri, const char **str)
             uri->fragment = uri_string_unescape(*str, cur - *str, NULL);
     }
     *str = cur;
-    return (0);
+    return 0;
 }
 
 /**
@@ -284,7 +284,7 @@ static int rfc3986_parse_query(URI *uri, const char **str)
     const char *cur;
 
     if (str == NULL)
-        return (-1);
+        return -1;
 
     cur = *str;
 
@@ -296,7 +296,7 @@ static int rfc3986_parse_query(URI *uri, const char **str)
         uri->query = g_strndup(*str, cur - *str);
     }
     *str = cur;
-    return (0);
+    return 0;
 }
 
 /**
@@ -362,9 +362,9 @@ static int rfc3986_parse_user_info(URI *uri, const char **str)
                 uri->user = uri_string_unescape(*str, cur - *str, NULL);
         }
         *str = cur;
-        return (0);
+        return 0;
     }
-    return (1);
+    return 1;
 }
 
 /**
@@ -386,7 +386,7 @@ static int rfc3986_parse_dec_octet(const char **str)
     const char *cur = *str;
 
     if (!(ISA_DIGIT(cur)))
-        return (1);
+        return 1;
     if (!ISA_DIGIT(cur + 1))
         cur++;
     else if ((*cur != '0') && (ISA_DIGIT(cur + 1)) && (!ISA_DIGIT(cur + 2)))
@@ -400,9 +400,9 @@ static int rfc3986_parse_dec_octet(const char **str)
              (*(cur + 1) <= '5'))
         cur += 3;
     else
-        return (1);
+        return 1;
     *str = cur;
-    return (0);
+    return 0;
 }
 /**
  * rfc3986_parse_host:
@@ -433,7 +433,7 @@ static int rfc3986_parse_host(URI *uri, const char **str)
         while ((*cur != ']') && (*cur != 0))
             cur++;
         if (*cur != ']')
-            return (1);
+            return 1;
         cur++;
         goto found;
     }
@@ -479,7 +479,7 @@ found:
             uri->server = NULL;
     }
     *str = cur;
-    return (0);
+    return 0;
 }
 
 /**
@@ -510,15 +510,15 @@ static int rfc3986_parse_authority(URI *uri, const char **str)
         cur++;
     ret = rfc3986_parse_host(uri, &cur);
     if (ret != 0)
-        return (ret);
+        return ret;
     if (*cur == ':') {
         cur++;
         ret = rfc3986_parse_port(uri, &cur);
         if (ret != 0)
-            return (ret);
+            return ret;
     }
     *str = cur;
-    return (0);
+    return 0;
 }
 
 /**
@@ -544,13 +544,13 @@ static int rfc3986_parse_segment(const char **str, char forbid, int empty)
     cur = *str;
     if (!ISA_PCHAR(cur)) {
         if (empty)
-            return (0);
-        return (1);
+            return 0;
+        return 1;
     }
     while (ISA_PCHAR(cur) && (*cur != forbid))
         NEXT(cur);
     *str = cur;
-    return (0);
+    return 0;
 }
 
 /**
@@ -576,7 +576,7 @@ static int rfc3986_parse_path_ab_empty(URI *uri, const char **str)
         cur++;
         ret = rfc3986_parse_segment(&cur, 0, 1);
         if (ret != 0)
-            return (ret);
+            return ret;
     }
     if (uri != NULL) {
         g_free(uri->path);
@@ -590,7 +590,7 @@ static int rfc3986_parse_path_ab_empty(URI *uri, const char **str)
         }
     }
     *str = cur;
-    return (0);
+    return 0;
 }
 
 /**
@@ -613,7 +613,7 @@ static int rfc3986_parse_path_absolute(URI *uri, const char **str)
     cur = *str;
 
     if (*cur != '/')
-        return (1);
+        return 1;
     cur++;
     ret = rfc3986_parse_segment(&cur, 0, 0);
     if (ret == 0) {
@@ -621,7 +621,7 @@ static int rfc3986_parse_path_absolute(URI *uri, const char **str)
             cur++;
             ret = rfc3986_parse_segment(&cur, 0, 1);
             if (ret != 0)
-                return (ret);
+                return ret;
         }
     }
     if (uri != NULL) {
@@ -636,7 +636,7 @@ static int rfc3986_parse_path_absolute(URI *uri, const char **str)
         }
     }
     *str = cur;
-    return (0);
+    return 0;
 }
 
 /**
@@ -660,12 +660,12 @@ static int rfc3986_parse_path_rootless(URI *uri, const char **str)
 
     ret = rfc3986_parse_segment(&cur, 0, 0);
     if (ret != 0)
-        return (ret);
+        return ret;
     while (*cur == '/') {
         cur++;
         ret = rfc3986_parse_segment(&cur, 0, 1);
         if (ret != 0)
-            return (ret);
+            return ret;
     }
     if (uri != NULL) {
         g_free(uri->path);
@@ -679,7 +679,7 @@ static int rfc3986_parse_path_rootless(URI *uri, const char **str)
         }
     }
     *str = cur;
-    return (0);
+    return 0;
 }
 
 /**
@@ -703,12 +703,12 @@ static int rfc3986_parse_path_no_scheme(URI *uri, const char **str)
 
     ret = rfc3986_parse_segment(&cur, ':', 0);
     if (ret != 0)
-        return (ret);
+        return ret;
     while (*cur == '/') {
         cur++;
         ret = rfc3986_parse_segment(&cur, 0, 1);
         if (ret != 0)
-            return (ret);
+            return ret;
     }
     if (uri != NULL) {
         g_free(uri->path);
@@ -722,7 +722,7 @@ static int rfc3986_parse_path_no_scheme(URI *uri, const char **str)
         }
     }
     *str = cur;
-    return (0);
+    return 0;
 }
 
 /**
@@ -751,20 +751,20 @@ static int rfc3986_parse_hier_part(URI *uri, const char **str)
         cur += 2;
         ret = rfc3986_parse_authority(uri, &cur);
         if (ret != 0)
-            return (ret);
+            return ret;
         ret = rfc3986_parse_path_ab_empty(uri, &cur);
         if (ret != 0)
-            return (ret);
+            return ret;
         *str = cur;
-        return (0);
+        return 0;
     } else if (*cur == '/') {
         ret = rfc3986_parse_path_absolute(uri, &cur);
         if (ret != 0)
-            return (ret);
+            return ret;
     } else if (ISA_PCHAR(cur)) {
         ret = rfc3986_parse_path_rootless(uri, &cur);
         if (ret != 0)
-            return (ret);
+            return ret;
     } else {
         /* path-empty is effectively empty */
         if (uri != NULL) {
@@ -773,7 +773,7 @@ static int rfc3986_parse_hier_part(URI *uri, const char **str)
         }
     }
     *str = cur;
-    return (0);
+    return 0;
 }
 
 /**
@@ -800,18 +800,18 @@ static int rfc3986_parse_relative_ref(URI *uri, const char *str)
         str += 2;
         ret = rfc3986_parse_authority(uri, &str);
         if (ret != 0)
-            return (ret);
+            return ret;
         ret = rfc3986_parse_path_ab_empty(uri, &str);
         if (ret != 0)
-            return (ret);
+            return ret;
     } else if (*str == '/') {
         ret = rfc3986_parse_path_absolute(uri, &str);
         if (ret != 0)
-            return (ret);
+            return ret;
     } else if (ISA_PCHAR(str)) {
         ret = rfc3986_parse_path_no_scheme(uri, &str);
         if (ret != 0)
-            return (ret);
+            return ret;
     } else {
         /* path-empty is effectively empty */
         if (uri != NULL) {
@@ -824,19 +824,19 @@ static int rfc3986_parse_relative_ref(URI *uri, const char *str)
         str++;
         ret = rfc3986_parse_query(uri, &str);
         if (ret != 0)
-            return (ret);
+            return ret;
     }
     if (*str == '#') {
         str++;
         ret = rfc3986_parse_fragment(uri, &str);
         if (ret != 0)
-            return (ret);
+            return ret;
     }
     if (*str != 0) {
         uri_clean(uri);
-        return (1);
+        return 1;
     }
-    return (0);
+    return 0;
 }
 
 /**
@@ -857,31 +857,31 @@ static int rfc3986_parse(URI *uri, const char *str)
 
     ret = rfc3986_parse_scheme(uri, &str);
     if (ret != 0)
-        return (ret);
+        return ret;
     if (*str != ':') {
-        return (1);
+        return 1;
     }
     str++;
     ret = rfc3986_parse_hier_part(uri, &str);
     if (ret != 0)
-        return (ret);
+        return ret;
     if (*str == '?') {
         str++;
         ret = rfc3986_parse_query(uri, &str);
         if (ret != 0)
-            return (ret);
+            return ret;
     }
     if (*str == '#') {
         str++;
         ret = rfc3986_parse_fragment(uri, &str);
         if (ret != 0)
-            return (ret);
+            return ret;
     }
     if (*str != 0) {
         uri_clean(uri);
-        return (1);
+        return 1;
     }
-    return (0);
+    return 0;
 }
 
 /**
@@ -901,7 +901,7 @@ static int rfc3986_parse_uri_reference(URI *uri, const char *str)
     int ret;
 
     if (str == NULL)
-        return (-1);
+        return -1;
     uri_clean(uri);
 
     /*
@@ -914,10 +914,10 @@ static int rfc3986_parse_uri_reference(URI *uri, const char *str)
         ret = rfc3986_parse_relative_ref(uri, str);
         if (ret != 0) {
             uri_clean(uri);
-            return (ret);
+            return ret;
         }
     }
-    return (0);
+    return 0;
 }
 
 /**
@@ -936,14 +936,14 @@ URI *uri_parse(const char *str)
     int ret;
 
     if (str == NULL)
-        return (NULL);
+        return NULL;
     uri = uri_new();
     ret = rfc3986_parse_uri_reference(uri, str);
     if (ret) {
         uri_free(uri);
-        return (NULL);
+        return NULL;
     }
-    return (uri);
+    return uri;
 }
 
 /**
@@ -960,7 +960,7 @@ URI *uri_parse(const char *str)
  */
 int uri_parse_into(URI *uri, const char *str)
 {
-    return (rfc3986_parse_uri_reference(uri, str));
+    return rfc3986_parse_uri_reference(uri, str);
 }
 
 /**
@@ -980,7 +980,7 @@ URI *uri_parse_raw(const char *str, int raw)
     int ret;
 
     if (str == NULL)
-        return (NULL);
+        return NULL;
     uri = uri_new();
     if (raw) {
         uri->cleanup |= 2;
@@ -988,9 +988,9 @@ URI *uri_parse_raw(const char *str, int raw)
     ret = uri_parse_into(uri, str);
     if (ret) {
         uri_free(uri);
-        return (NULL);
+        return NULL;
     }
-    return (uri);
+    return uri;
 }
 
 /************************************************************************
@@ -1011,7 +1011,7 @@ URI *uri_new(void)
     URI *ret;
 
     ret = g_new0(URI, 1);
-    return (ret);
+    return ret;
 }
 
 /**
@@ -1028,7 +1028,7 @@ static char *realloc2n(char *ret, int *max)
     tmp = *max * 2;
     temp = g_realloc(ret, (tmp + 1));
     *max = tmp;
-    return (temp);
+    return temp;
 }
 
 /**
@@ -1048,7 +1048,7 @@ char *uri_to_string(URI *uri)
     int max;
 
     if (uri == NULL)
-        return (NULL);
+        return NULL;
 
     max = 80;
     ret = g_malloc(max + 1);
@@ -1249,7 +1249,7 @@ char *uri_to_string(URI *uri)
         ret = temp;
     }
     ret[len] = 0;
-    return (ret);
+    return ret;
 }
 
 /**
@@ -1315,7 +1315,7 @@ static int normalize_uri_path(char *path)
     char *cur, *out;
 
     if (path == NULL)
-        return (-1);
+        return -1;
 
     /* Skip all initial "/" chars.  We want to get to the beginning of the
      * first non-empty segment.
@@ -1324,7 +1324,7 @@ static int normalize_uri_path(char *path)
     while (cur[0] == '/')
         ++cur;
     if (cur[0] == '\0')
-        return (0);
+        return 0;
 
     /* Keep everything we've seen so far.  */
     out = cur;
@@ -1372,7 +1372,7 @@ done_cd:
     while (cur[0] == '/')
         ++cur;
     if (cur[0] == '\0')
-        return (0);
+        return 0;
 
     /*
      * Analyze each segment in sequence for cases (e) and (f).
@@ -1485,15 +1485,15 @@ done_cd:
         }
     }
 
-    return (0);
+    return 0;
 }
 
 static int is_hex(char c)
 {
     if (((c >= '0') && (c <= '9')) || ((c >= 'a') && (c <= 'f')) ||
         ((c >= 'A') && (c <= 'F')))
-        return (1);
-    return (0);
+        return 1;
+    return 0;
 }
 
 /**
@@ -1516,11 +1516,11 @@ char *uri_string_unescape(const char *str, int len, char *target)
     const char *in;
 
     if (str == NULL)
-        return (NULL);
+        return NULL;
     if (len <= 0)
         len = strlen(str);
     if (len < 0)
-        return (NULL);
+        return NULL;
 
     if (target == NULL) {
         ret = g_malloc(len + 1);
@@ -1553,7 +1553,7 @@ char *uri_string_unescape(const char *str, int len, char *target)
         }
     }
     *out = 0;
-    return (ret);
+    return ret;
 }
 
 /**
@@ -1574,12 +1574,12 @@ char *uri_string_escape(const char *str, const char *list)
     int len, out;
 
     if (str == NULL)
-        return (NULL);
+        return NULL;
     if (str[0] == 0)
-        return (g_strdup(str));
+        return g_strdup(str);
     len = strlen(str);
     if (!(len > 0))
-        return (NULL);
+        return NULL;
 
     len += 20;
     ret = g_malloc(len);
@@ -1612,7 +1612,7 @@ char *uri_string_escape(const char *str, const char *list)
         }
     }
     ret[out] = 0;
-    return (ret);
+    return ret;
 }
 
 /************************************************************************
@@ -1851,7 +1851,7 @@ done:
         uri_free(bas);
     if (res != NULL)
         uri_free(res);
-    return (val);
+    return val;
 }
 
 /**
-- 
2.7.4
