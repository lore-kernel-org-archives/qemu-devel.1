Received: from eggs.gnu.org ([2001:4830:134:3::10]:57305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <suhang16@mails.ucas.ac.cn>) id 1epnx4-0004SR-Ic
	for qemu-devel@nongnu.org; Sat, 24 Feb 2018 23:30:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <suhang16@mails.ucas.ac.cn>) id 1epnwy-0006L1-Fd
	for qemu-devel@nongnu.org; Sat, 24 Feb 2018 23:30:18 -0500
Received: from smtp17.cstnet.cn ([159.226.251.17]:50554 helo=cstnet.cn)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <suhang16@mails.ucas.ac.cn>) id 1epnww-0006Bb-HJ
	for qemu-devel@nongnu.org; Sat, 24 Feb 2018 23:30:12 -0500
From: Su Hang <suhang16@mails.ucas.ac.cn>
Date: Sun, 25 Feb 2018 12:29:21 +0800
Message-Id: <1519532963-12976-2-git-send-email-suhang16@mails.ucas.ac.cn>
In-Reply-To: <1519532963-12976-1-git-send-email-suhang16@mails.ucas.ac.cn>
References: <1519532963-12976-1-git-send-email-suhang16@mails.ucas.ac.cn>
Subject: [Qemu-devel]  [PATCH v4 RFC 1/3] util/uri.c: Coding style check,
 Only whitespace involved. Using `clang-format -i util/uri.c` first,
 then change back few code manually, to make sure only whitespace involved.
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

Signed-off-by: Su Hang <suhang16@mails.ucas.ac.cn>
---
 util/uri.c | 1468 ++++++++++++++++++++++++++++++------------------------------
 1 file changed, 735 insertions(+), 733 deletions(-)

diff --git a/util/uri.c b/util/uri.c
index 21b18281703a..cf09f41735a1 100644
--- a/util/uri.c
+++ b/util/uri.c
@@ -63,7 +63,6 @@ static void uri_clean(URI *uri);
  */
 #define IS_ALPHA(x) (IS_LOWALPHA(x) || IS_UPALPHA(x))
 
-
 /*
  * lowalpha = "a" | "b" | "c" | "d" | "e" | "f" | "g" | "h" | "i" | "j" |
  *            "k" | "l" | "m" | "n" | "o" | "p" | "q" | "r" | "s" | "t" |
@@ -97,27 +96,27 @@ static void uri_clean(URI *uri);
  * mark = "-" | "_" | "." | "!" | "~" | "*" | "'" | "(" | ")"
  */
 
-#define IS_MARK(x) (((x) == '-') || ((x) == '_') || ((x) == '.') ||     \
-    ((x) == '!') || ((x) == '~') || ((x) == '*') || ((x) == '\'') ||    \
+#define IS_MARK(x) (((x) == '-') || ((x) == '_') || ((x) == '.') ||            \
+    ((x) == '!') || ((x) == '~') || ((x) == '*') || ((x) == '\'') ||           \
     ((x) == '(') || ((x) == ')'))
 
 /*
  * unwise = "{" | "}" | "|" | "\" | "^" | "`"
  */
 
-#define IS_UNWISE(p)                                                    \
-      (((*(p) == '{')) || ((*(p) == '}')) || ((*(p) == '|')) ||         \
-       ((*(p) == '\\')) || ((*(p) == '^')) || ((*(p) == '[')) ||        \
-       ((*(p) == ']')) || ((*(p) == '`')))
+#define IS_UNWISE(p)                                                           \
+    (((*(p) == '{')) || ((*(p) == '}')) || ((*(p) == '|')) ||                  \
+     ((*(p) == '\\')) || ((*(p) == '^')) || ((*(p) == '[')) ||                 \
+     ((*(p) == ']')) || ((*(p) == '`')))
 /*
  * reserved = ";" | "/" | "?" | ":" | "@" | "&" | "=" | "+" | "$" | "," |
  *            "[" | "]"
  */
 
-#define IS_RESERVED(x) (((x) == ';') || ((x) == '/') || ((x) == '?') || \
-        ((x) == ':') || ((x) == '@') || ((x) == '&') || ((x) == '=') || \
-        ((x) == '+') || ((x) == '$') || ((x) == ',') || ((x) == '[') || \
-        ((x) == ']'))
+#define IS_RESERVED(x) (((x) == ';') || ((x) == '/') || ((x) == '?') ||        \
+    ((x) == ':') || ((x) == '@') || ((x) == '&') || ((x) == '=') ||            \
+    ((x) == '+') || ((x) == '$') || ((x) == ',') || ((x) == '[') ||            \
+    ((x) == ']'))
 
 /*
  * unreserved = alphanum | mark
@@ -129,7 +128,7 @@ static void uri_clean(URI *uri);
  * Skip to next pointer char, handle escaped sequences
  */
 
-#define NEXT(p) ((*p == '%')? p += 3 : p++)
+#define NEXT(p) ((*p == '%') ? p += 3 : p++)
 
 /*
  * Productions from the spec.
@@ -141,37 +140,36 @@ static void uri_clean(URI *uri);
  * path          = [ abs_path | opaque_part ]
  */
 
-
 /************************************************************************
- *									*
- *                         RFC 3986 parser				*
- *									*
+ *                                                                      *
+ *                         RFC 3986 parser                              *
+ *                                                                      *
  ************************************************************************/
 
 #define ISA_DIGIT(p) ((*(p) >= '0') && (*(p) <= '9'))
-#define ISA_ALPHA(p) (((*(p) >= 'a') && (*(p) <= 'z')) ||		\
+#define ISA_ALPHA(p) (((*(p) >= 'a') && (*(p) <= 'z')) ||                      \
                       ((*(p) >= 'A') && (*(p) <= 'Z')))
-#define ISA_HEXDIG(p)							\
-       (ISA_DIGIT(p) || ((*(p) >= 'a') && (*(p) <= 'f')) ||		\
-        ((*(p) >= 'A') && (*(p) <= 'F')))
+#define ISA_HEXDIG(p)                                                          \
+    (ISA_DIGIT(p) || ((*(p) >= 'a') && (*(p) <= 'f')) ||                       \
+     ((*(p) >= 'A') && (*(p) <= 'F')))
 
 /*
  *    sub-delims    = "!" / "$" / "&" / "'" / "(" / ")"
  *                     / "*" / "+" / "," / ";" / "="
  */
-#define ISA_SUB_DELIM(p)						\
-      (((*(p) == '!')) || ((*(p) == '$')) || ((*(p) == '&')) ||		\
-       ((*(p) == '(')) || ((*(p) == ')')) || ((*(p) == '*')) ||		\
-       ((*(p) == '+')) || ((*(p) == ',')) || ((*(p) == ';')) ||		\
-       ((*(p) == '=')) || ((*(p) == '\'')))
+#define ISA_SUB_DELIM(p)                                                       \
+    (((*(p) == '!')) || ((*(p) == '$')) || ((*(p) == '&')) ||                  \
+     ((*(p) == '(')) || ((*(p) == ')')) || ((*(p) == '*')) ||                  \
+     ((*(p) == '+')) || ((*(p) == ',')) || ((*(p) == ';')) ||                  \
+     ((*(p) == '=')) || ((*(p) == '\'')))
 
 /*
  *    gen-delims    = ":" / "/" / "?" / "#" / "[" / "]" / "@"
  */
-#define ISA_GEN_DELIM(p)						\
-      (((*(p) == ':')) || ((*(p) == '/')) || ((*(p) == '?')) ||         \
-       ((*(p) == '#')) || ((*(p) == '[')) || ((*(p) == ']')) ||         \
-       ((*(p) == '@')))
+#define ISA_GEN_DELIM(p)                                                       \
+    (((*(p) == ':')) || ((*(p) == '/')) || ((*(p) == '?')) ||                  \
+     ((*(p) == '#')) || ((*(p) == '[')) || ((*(p) == ']')) ||                  \
+     ((*(p) == '@')))
 
 /*
  *    reserved      = gen-delims / sub-delims
@@ -181,22 +179,22 @@ static void uri_clean(URI *uri);
 /*
  *    unreserved    = ALPHA / DIGIT / "-" / "." / "_" / "~"
  */
-#define ISA_UNRESERVED(p)						\
-      ((ISA_ALPHA(p)) || (ISA_DIGIT(p)) || ((*(p) == '-')) ||		\
-       ((*(p) == '.')) || ((*(p) == '_')) || ((*(p) == '~')))
+#define ISA_UNRESERVED(p)                                                      \
+    ((ISA_ALPHA(p)) || (ISA_DIGIT(p)) || ((*(p) == '-')) ||                    \
+     ((*(p) == '.')) || ((*(p) == '_')) || ((*(p) == '~')))
 
 /*
  *    pct-encoded   = "%" HEXDIG HEXDIG
  */
-#define ISA_PCT_ENCODED(p)						\
-     ((*(p) == '%') && (ISA_HEXDIG(p + 1)) && (ISA_HEXDIG(p + 2)))
+#define ISA_PCT_ENCODED(p)                                                     \
+    ((*(p) == '%') && (ISA_HEXDIG(p + 1)) && (ISA_HEXDIG(p + 2)))
 
 /*
  *    pchar         = unreserved / pct-encoded / sub-delims / ":" / "@"
  */
-#define ISA_PCHAR(p)							\
-     (ISA_UNRESERVED(p) || ISA_PCT_ENCODED(p) || ISA_SUB_DELIM(p) ||	\
-      ((*(p) == ':')) || ((*(p) == '@')))
+#define ISA_PCHAR(p)                                                           \
+    (ISA_UNRESERVED(p) || ISA_PCT_ENCODED(p) || ISA_SUB_DELIM(p) ||            \
+     ((*(p) == ':')) || ((*(p) == '@')))
 
 /**
  * rfc3986_parse_scheme:
@@ -209,25 +207,26 @@ static void uri_clean(URI *uri);
  *
  * Returns 0 or the error code
  */
-static int
-rfc3986_parse_scheme(URI *uri, const char **str) {
+static int rfc3986_parse_scheme(URI *uri, const char **str)
+{
     const char *cur;
 
     if (str == NULL)
-	return(-1);
+        return (-1);
 
     cur = *str;
     if (!ISA_ALPHA(cur))
-	return(2);
+        return (2);
     cur++;
-    while (ISA_ALPHA(cur) || ISA_DIGIT(cur) ||
-           (*cur == '+') || (*cur == '-') || (*cur == '.')) cur++;
+    while (ISA_ALPHA(cur) || ISA_DIGIT(cur) || (*cur == '+') || (*cur == '-') ||
+           (*cur == '.'))
+        cur++;
     if (uri != NULL) {
         g_free(uri->scheme);
-	uri->scheme = g_strndup(*str, cur - *str);
+        uri->scheme = g_strndup(*str, cur - *str);
     }
     *str = cur;
-    return(0);
+    return (0);
 }
 
 /**
@@ -245,8 +244,7 @@ rfc3986_parse_scheme(URI *uri, const char **str) {
  *
  * Returns 0 or the error code
  */
-static int
-rfc3986_parse_fragment(URI *uri, const char **str)
+static int rfc3986_parse_fragment(URI *uri, const char **str)
 {
     const char *cur;
 
@@ -261,10 +259,10 @@ rfc3986_parse_fragment(URI *uri, const char **str)
         NEXT(cur);
     if (uri != NULL) {
         g_free(uri->fragment);
-	if (uri->cleanup & 2)
-	    uri->fragment = g_strndup(*str, cur - *str);
-	else
-	    uri->fragment = uri_string_unescape(*str, cur - *str, NULL);
+        if (uri->cleanup & 2)
+            uri->fragment = g_strndup(*str, cur - *str);
+        else
+            uri->fragment = uri_string_unescape(*str, cur - *str, NULL);
     }
     *str = cur;
     return (0);
@@ -281,8 +279,7 @@ rfc3986_parse_fragment(URI *uri, const char **str)
  *
  * Returns 0 or the error code
  */
-static int
-rfc3986_parse_query(URI *uri, const char **str)
+static int rfc3986_parse_query(URI *uri, const char **str)
 {
     const char *cur;
 
@@ -296,7 +293,7 @@ rfc3986_parse_query(URI *uri, const char **str)
         NEXT(cur);
     if (uri != NULL) {
         g_free(uri->query);
-	uri->query = g_strndup (*str, cur - *str);
+        uri->query = g_strndup(*str, cur - *str);
     }
     *str = cur;
     return (0);
@@ -314,8 +311,7 @@ rfc3986_parse_query(URI *uri, const char **str)
  *
  * Returns 0 or the error code
  */
-static int
-rfc3986_parse_port(URI *uri, const char **str)
+static int rfc3986_parse_port(URI *uri, const char **str)
 {
     const char *cur = *str;
     int port = 0;
@@ -349,27 +345,26 @@ rfc3986_parse_port(URI *uri, const char **str)
  *
  * Returns 0 or the error code
  */
-static int
-rfc3986_parse_user_info(URI *uri, const char **str)
+static int rfc3986_parse_user_info(URI *uri, const char **str)
 {
     const char *cur;
 
     cur = *str;
-    while (ISA_UNRESERVED(cur) || ISA_PCT_ENCODED(cur) ||
-           ISA_SUB_DELIM(cur) || (*cur == ':'))
-	NEXT(cur);
+    while (ISA_UNRESERVED(cur) || ISA_PCT_ENCODED(cur) || ISA_SUB_DELIM(cur) ||
+           (*cur == ':'))
+        NEXT(cur);
     if (*cur == '@') {
-	if (uri != NULL) {
+        if (uri != NULL) {
             g_free(uri->user);
-	    if (uri->cleanup & 2)
-		uri->user = g_strndup(*str, cur - *str);
-	    else
-		uri->user = uri_string_unescape(*str, cur - *str, NULL);
-	}
-	*str = cur;
-	return(0);
-    }
-    return(1);
+            if (uri->cleanup & 2)
+                uri->user = g_strndup(*str, cur - *str);
+            else
+                uri->user = uri_string_unescape(*str, cur - *str, NULL);
+        }
+        *str = cur;
+        return (0);
+    }
+    return (1);
 }
 
 /**
@@ -386,28 +381,28 @@ rfc3986_parse_user_info(URI *uri, const char **str)
  *
  * Returns 0 if found and skipped, 1 otherwise
  */
-static int
-rfc3986_parse_dec_octet(const char **str) {
+static int rfc3986_parse_dec_octet(const char **str)
+{
     const char *cur = *str;
 
     if (!(ISA_DIGIT(cur)))
-        return(1);
-    if (!ISA_DIGIT(cur+1))
-	cur++;
-    else if ((*cur != '0') && (ISA_DIGIT(cur + 1)) && (!ISA_DIGIT(cur+2)))
-	cur += 2;
+        return (1);
+    if (!ISA_DIGIT(cur + 1))
+        cur++;
+    else if ((*cur != '0') && (ISA_DIGIT(cur + 1)) && (!ISA_DIGIT(cur + 2)))
+        cur += 2;
     else if ((*cur == '1') && (ISA_DIGIT(cur + 1)) && (ISA_DIGIT(cur + 2)))
-	cur += 3;
-    else if ((*cur == '2') && (*(cur + 1) >= '0') &&
-	     (*(cur + 1) <= '4') && (ISA_DIGIT(cur + 2)))
-	cur += 3;
-    else if ((*cur == '2') && (*(cur + 1) == '5') &&
-	     (*(cur + 2) >= '0') && (*(cur + 1) <= '5'))
-	cur += 3;
+        cur += 3;
+    else if ((*cur == '2') && (*(cur + 1) >= '0') && (*(cur + 1) <= '4') &&
+             (ISA_DIGIT(cur + 2)))
+        cur += 3;
+    else if ((*cur == '2') && (*(cur + 1) == '5') && (*(cur + 2) >= '0') &&
+             (*(cur + 1) <= '5'))
+        cur += 3;
     else
-        return(1);
+        return (1);
     *str = cur;
-    return(0);
+    return (0);
 }
 /**
  * rfc3986_parse_host:
@@ -424,8 +419,7 @@ rfc3986_parse_dec_octet(const char **str) {
  *
  * Returns 0 or the error code
  */
-static int
-rfc3986_parse_host(URI *uri, const char **str)
+static int rfc3986_parse_host(URI *uri, const char **str)
 {
     const char *cur = *str;
     const char *host;
@@ -436,34 +430,34 @@ rfc3986_parse_host(URI *uri, const char **str)
      */
     if (*cur == '[') {
         cur++;
-	while ((*cur != ']') && (*cur != 0))
-	    cur++;
-	if (*cur != ']')
-	    return(1);
-	cur++;
-	goto found;
+        while ((*cur != ']') && (*cur != 0))
+            cur++;
+        if (*cur != ']')
+            return (1);
+        cur++;
+        goto found;
     }
     /*
      * try to parse an IPv4
      */
     if (ISA_DIGIT(cur)) {
         if (rfc3986_parse_dec_octet(&cur) != 0)
-	    goto not_ipv4;
-	if (*cur != '.')
-	    goto not_ipv4;
-	cur++;
+            goto not_ipv4;
+        if (*cur != '.')
+            goto not_ipv4;
+        cur++;
         if (rfc3986_parse_dec_octet(&cur) != 0)
-	    goto not_ipv4;
-	if (*cur != '.')
-	    goto not_ipv4;
+            goto not_ipv4;
+        if (*cur != '.')
+            goto not_ipv4;
         if (rfc3986_parse_dec_octet(&cur) != 0)
-	    goto not_ipv4;
-	if (*cur != '.')
-	    goto not_ipv4;
+            goto not_ipv4;
+        if (*cur != '.')
+            goto not_ipv4;
         if (rfc3986_parse_dec_octet(&cur) != 0)
-	    goto not_ipv4;
-	goto found;
-not_ipv4:
+            goto not_ipv4;
+        goto found;
+    not_ipv4:
         cur = *str;
     }
     /*
@@ -474,18 +468,18 @@ not_ipv4:
 found:
     if (uri != NULL) {
         g_free(uri->authority);
-	uri->authority = NULL;
+        uri->authority = NULL;
         g_free(uri->server);
-	if (cur != host) {
-	    if (uri->cleanup & 2)
-		uri->server = g_strndup(host, cur - host);
-	    else
-		uri->server = uri_string_unescape(host, cur - host, NULL);
-	} else
-	    uri->server = NULL;
+        if (cur != host) {
+            if (uri->cleanup & 2)
+                uri->server = g_strndup(host, cur - host);
+            else
+                uri->server = uri_string_unescape(host, cur - host, NULL);
+        } else
+            uri->server = NULL;
     }
     *str = cur;
-    return(0);
+    return (0);
 }
 
 /**
@@ -500,8 +494,7 @@ found:
  *
  * Returns 0 or the error code
  */
-static int
-rfc3986_parse_authority(URI *uri, const char **str)
+static int rfc3986_parse_authority(URI *uri, const char **str)
 {
     const char *cur;
     int ret;
@@ -516,14 +509,16 @@ rfc3986_parse_authority(URI *uri, const char **str)
     else
         cur++;
     ret = rfc3986_parse_host(uri, &cur);
-    if (ret != 0) return(ret);
+    if (ret != 0)
+        return (ret);
     if (*cur == ':') {
         cur++;
         ret = rfc3986_parse_port(uri, &cur);
-	if (ret != 0) return(ret);
+        if (ret != 0)
+            return (ret);
     }
     *str = cur;
-    return(0);
+    return (0);
 }
 
 /**
@@ -542,16 +537,15 @@ rfc3986_parse_authority(URI *uri, const char **str)
  *
  * Returns 0 or the error code
  */
-static int
-rfc3986_parse_segment(const char **str, char forbid, int empty)
+static int rfc3986_parse_segment(const char **str, char forbid, int empty)
 {
     const char *cur;
 
     cur = *str;
     if (!ISA_PCHAR(cur)) {
         if (empty)
-	    return(0);
-	return(1);
+            return (0);
+        return (1);
     }
     while (ISA_PCHAR(cur) && (*cur != forbid))
         NEXT(cur);
@@ -571,8 +565,7 @@ rfc3986_parse_segment(const char **str, char forbid, int empty)
  *
  * Returns 0 or the error code
  */
-static int
-rfc3986_parse_path_ab_empty(URI *uri, const char **str)
+static int rfc3986_parse_path_ab_empty(URI *uri, const char **str)
 {
     const char *cur;
     int ret;
@@ -581,8 +574,9 @@ rfc3986_parse_path_ab_empty(URI *uri, const char **str)
 
     while (*cur == '/') {
         cur++;
-	ret = rfc3986_parse_segment(&cur, 0, 1);
-	if (ret != 0) return(ret);
+        ret = rfc3986_parse_segment(&cur, 0, 1);
+        if (ret != 0)
+            return (ret);
     }
     if (uri != NULL) {
         g_free(uri->path);
@@ -611,8 +605,7 @@ rfc3986_parse_path_ab_empty(URI *uri, const char **str)
  *
  * Returns 0 or the error code
  */
-static int
-rfc3986_parse_path_absolute(URI *uri, const char **str)
+static int rfc3986_parse_path_absolute(URI *uri, const char **str)
 {
     const char *cur;
     int ret;
@@ -620,15 +613,16 @@ rfc3986_parse_path_absolute(URI *uri, const char **str)
     cur = *str;
 
     if (*cur != '/')
-        return(1);
+        return (1);
     cur++;
     ret = rfc3986_parse_segment(&cur, 0, 0);
     if (ret == 0) {
-	while (*cur == '/') {
-	    cur++;
-	    ret = rfc3986_parse_segment(&cur, 0, 1);
-	    if (ret != 0) return(ret);
-	}
+        while (*cur == '/') {
+            cur++;
+            ret = rfc3986_parse_segment(&cur, 0, 1);
+            if (ret != 0)
+                return (ret);
+        }
     }
     if (uri != NULL) {
         g_free(uri->path);
@@ -657,8 +651,7 @@ rfc3986_parse_path_absolute(URI *uri, const char **str)
  *
  * Returns 0 or the error code
  */
-static int
-rfc3986_parse_path_rootless(URI *uri, const char **str)
+static int rfc3986_parse_path_rootless(URI *uri, const char **str)
 {
     const char *cur;
     int ret;
@@ -666,11 +659,13 @@ rfc3986_parse_path_rootless(URI *uri, const char **str)
     cur = *str;
 
     ret = rfc3986_parse_segment(&cur, 0, 0);
-    if (ret != 0) return(ret);
+    if (ret != 0)
+        return (ret);
     while (*cur == '/') {
         cur++;
-	ret = rfc3986_parse_segment(&cur, 0, 1);
-	if (ret != 0) return(ret);
+        ret = rfc3986_parse_segment(&cur, 0, 1);
+        if (ret != 0)
+            return (ret);
     }
     if (uri != NULL) {
         g_free(uri->path);
@@ -699,8 +694,7 @@ rfc3986_parse_path_rootless(URI *uri, const char **str)
  *
  * Returns 0 or the error code
  */
-static int
-rfc3986_parse_path_no_scheme(URI *uri, const char **str)
+static int rfc3986_parse_path_no_scheme(URI *uri, const char **str)
 {
     const char *cur;
     int ret;
@@ -708,11 +702,13 @@ rfc3986_parse_path_no_scheme(URI *uri, const char **str)
     cur = *str;
 
     ret = rfc3986_parse_segment(&cur, ':', 0);
-    if (ret != 0) return(ret);
+    if (ret != 0)
+        return (ret);
     while (*cur == '/') {
         cur++;
-	ret = rfc3986_parse_segment(&cur, 0, 1);
-	if (ret != 0) return(ret);
+        ret = rfc3986_parse_segment(&cur, 0, 1);
+        if (ret != 0)
+            return (ret);
     }
     if (uri != NULL) {
         g_free(uri->path);
@@ -744,8 +740,7 @@ rfc3986_parse_path_no_scheme(URI *uri, const char **str)
  *
  * Returns 0 or the error code
  */
-static int
-rfc3986_parse_hier_part(URI *uri, const char **str)
+static int rfc3986_parse_hier_part(URI *uri, const char **str)
 {
     const char *cur;
     int ret;
@@ -754,24 +749,28 @@ rfc3986_parse_hier_part(URI *uri, const char **str)
 
     if ((*cur == '/') && (*(cur + 1) == '/')) {
         cur += 2;
-	ret = rfc3986_parse_authority(uri, &cur);
-	if (ret != 0) return(ret);
-	ret = rfc3986_parse_path_ab_empty(uri, &cur);
-	if (ret != 0) return(ret);
-	*str = cur;
-	return(0);
+        ret = rfc3986_parse_authority(uri, &cur);
+        if (ret != 0)
+            return (ret);
+        ret = rfc3986_parse_path_ab_empty(uri, &cur);
+        if (ret != 0)
+            return (ret);
+        *str = cur;
+        return (0);
     } else if (*cur == '/') {
         ret = rfc3986_parse_path_absolute(uri, &cur);
-	if (ret != 0) return(ret);
+        if (ret != 0)
+            return (ret);
     } else if (ISA_PCHAR(cur)) {
         ret = rfc3986_parse_path_rootless(uri, &cur);
-	if (ret != 0) return(ret);
+        if (ret != 0)
+            return (ret);
     } else {
-	/* path-empty is effectively empty */
-	if (uri != NULL) {
+        /* path-empty is effectively empty */
+        if (uri != NULL) {
             g_free(uri->path);
-	    uri->path = NULL;
-	}
+            uri->path = NULL;
+        }
     }
     *str = cur;
     return (0);
@@ -793,48 +792,53 @@ rfc3986_parse_hier_part(URI *uri, const char **str)
  *
  * Returns 0 or the error code
  */
-static int
-rfc3986_parse_relative_ref(URI *uri, const char *str) {
+static int rfc3986_parse_relative_ref(URI *uri, const char *str)
+{
     int ret;
 
     if ((*str == '/') && (*(str + 1) == '/')) {
         str += 2;
-	ret = rfc3986_parse_authority(uri, &str);
-	if (ret != 0) return(ret);
-	ret = rfc3986_parse_path_ab_empty(uri, &str);
-	if (ret != 0) return(ret);
+        ret = rfc3986_parse_authority(uri, &str);
+        if (ret != 0)
+            return (ret);
+        ret = rfc3986_parse_path_ab_empty(uri, &str);
+        if (ret != 0)
+            return (ret);
     } else if (*str == '/') {
-	ret = rfc3986_parse_path_absolute(uri, &str);
-	if (ret != 0) return(ret);
+        ret = rfc3986_parse_path_absolute(uri, &str);
+        if (ret != 0)
+            return (ret);
     } else if (ISA_PCHAR(str)) {
         ret = rfc3986_parse_path_no_scheme(uri, &str);
-	if (ret != 0) return(ret);
+        if (ret != 0)
+            return (ret);
     } else {
-	/* path-empty is effectively empty */
-	if (uri != NULL) {
+        /* path-empty is effectively empty */
+        if (uri != NULL) {
             g_free(uri->path);
-	    uri->path = NULL;
-	}
+            uri->path = NULL;
+        }
     }
 
     if (*str == '?') {
-	str++;
-	ret = rfc3986_parse_query(uri, &str);
-	if (ret != 0) return(ret);
+        str++;
+        ret = rfc3986_parse_query(uri, &str);
+        if (ret != 0)
+            return (ret);
     }
     if (*str == '#') {
-	str++;
-	ret = rfc3986_parse_fragment(uri, &str);
-	if (ret != 0) return(ret);
+        str++;
+        ret = rfc3986_parse_fragment(uri, &str);
+        if (ret != 0)
+            return (ret);
     }
     if (*str != 0) {
-	uri_clean(uri);
-	return(1);
+        uri_clean(uri);
+        return (1);
     }
-    return(0);
+    return (0);
 }
 
-
 /**
  * rfc3986_parse:
  * @uri:  pointer to an URI structure
@@ -847,33 +851,37 @@ rfc3986_parse_relative_ref(URI *uri, const char *str) {
  *
  * Returns 0 or the error code
  */
-static int
-rfc3986_parse(URI *uri, const char *str) {
+static int rfc3986_parse(URI *uri, const char *str)
+{
     int ret;
 
     ret = rfc3986_parse_scheme(uri, &str);
-    if (ret != 0) return(ret);
+    if (ret != 0)
+        return (ret);
     if (*str != ':') {
-	return(1);
+        return (1);
     }
     str++;
     ret = rfc3986_parse_hier_part(uri, &str);
-    if (ret != 0) return(ret);
+    if (ret != 0)
+        return (ret);
     if (*str == '?') {
-	str++;
-	ret = rfc3986_parse_query(uri, &str);
-	if (ret != 0) return(ret);
+        str++;
+        ret = rfc3986_parse_query(uri, &str);
+        if (ret != 0)
+            return (ret);
     }
     if (*str == '#') {
-	str++;
-	ret = rfc3986_parse_fragment(uri, &str);
-	if (ret != 0) return(ret);
+        str++;
+        ret = rfc3986_parse_fragment(uri, &str);
+        if (ret != 0)
+            return (ret);
     }
     if (*str != 0) {
-	uri_clean(uri);
-	return(1);
+        uri_clean(uri);
+        return (1);
     }
-    return(0);
+    return (0);
 }
 
 /**
@@ -888,12 +896,12 @@ rfc3986_parse(URI *uri, const char *str) {
  *
  * Returns 0 or the error code
  */
-static int
-rfc3986_parse_uri_reference(URI *uri, const char *str) {
+static int rfc3986_parse_uri_reference(URI *uri, const char *str)
+{
     int ret;
 
     if (str == NULL)
-	return(-1);
+        return (-1);
     uri_clean(uri);
 
     /*
@@ -902,14 +910,14 @@ rfc3986_parse_uri_reference(URI *uri, const char *str) {
      */
     ret = rfc3986_parse(uri, str);
     if (ret != 0) {
-	uri_clean(uri);
+        uri_clean(uri);
         ret = rfc3986_parse_relative_ref(uri, str);
-	if (ret != 0) {
-	    uri_clean(uri);
-	    return(ret);
-	}
+        if (ret != 0) {
+            uri_clean(uri);
+            return (ret);
+        }
     }
-    return(0);
+    return (0);
 }
 
 /**
@@ -922,20 +930,20 @@ rfc3986_parse_uri_reference(URI *uri, const char *str) {
  *
  * Returns a newly built URI or NULL in case of error
  */
-URI *
-uri_parse(const char *str) {
+URI *uri_parse(const char *str)
+{
     URI *uri;
     int ret;
 
     if (str == NULL)
-	return(NULL);
+        return (NULL);
     uri = uri_new();
     ret = rfc3986_parse_uri_reference(uri, str);
     if (ret) {
         uri_free(uri);
-        return(NULL);
+        return (NULL);
     }
-    return(uri);
+    return (uri);
 }
 
 /**
@@ -950,9 +958,9 @@ uri_parse(const char *str) {
  *
  * Returns 0 or the error code
  */
-int
-uri_parse_into(URI *uri, const char *str) {
-    return(rfc3986_parse_uri_reference(uri, str));
+int uri_parse_into(URI *uri, const char *str)
+{
+    return (rfc3986_parse_uri_reference(uri, str));
 }
 
 /**
@@ -966,13 +974,13 @@ uri_parse_into(URI *uri, const char *str) {
  *
  * Returns a newly built URI or NULL in case of error
  */
-URI *
-uri_parse_raw(const char *str, int raw) {
+URI *uri_parse_raw(const char *str, int raw)
+{
     URI *uri;
     int ret;
 
     if (str == NULL)
-	return(NULL);
+        return (NULL);
     uri = uri_new();
     if (raw) {
         uri->cleanup |= 2;
@@ -980,15 +988,15 @@ uri_parse_raw(const char *str, int raw) {
     ret = uri_parse_into(uri, str);
     if (ret) {
         uri_free(uri);
-        return(NULL);
+        return (NULL);
     }
-    return(uri);
+    return (uri);
 }
 
 /************************************************************************
- *									*
- *			Generic URI structure functions			*
- *									*
+ *                                                                      *
+ *                    Generic URI structure functions                   *
+ *                                                                      *
  ************************************************************************/
 
 /**
@@ -998,12 +1006,12 @@ uri_parse_raw(const char *str, int raw) {
  *
  * Returns the new structure or NULL in case of error
  */
-URI *
-uri_new(void) {
+URI *uri_new(void)
+{
     URI *ret;
 
     ret = g_new0(URI, 1);
-    return(ret);
+    return (ret);
 }
 
 /**
@@ -1012,15 +1020,15 @@ uri_new(void) {
  * Function to handle properly a reallocation when saving an URI
  * Also imposes some limit on the length of an URI string output
  */
-static char *
-realloc2n(char *ret, int *max) {
+static char *realloc2n(char *ret, int *max)
+{
     char *temp;
     int tmp;
 
     tmp = *max * 2;
     temp = g_realloc(ret, (tmp + 1));
     *max = tmp;
-    return(temp);
+    return (temp);
 }
 
 /**
@@ -1031,221 +1039,217 @@ realloc2n(char *ret, int *max) {
  *
  * Returns a new string (to be deallocated by caller)
  */
-char *
-uri_to_string(URI *uri) {
+char *uri_to_string(URI *uri)
+{
     char *ret = NULL;
     char *temp;
     const char *p;
     int len;
     int max;
 
-    if (uri == NULL) return(NULL);
-
+    if (uri == NULL)
+        return (NULL);
 
     max = 80;
     ret = g_malloc(max + 1);
     len = 0;
 
     if (uri->scheme != NULL) {
-	p = uri->scheme;
-	while (*p != 0) {
-	    if (len >= max) {
+        p = uri->scheme;
+        while (*p != 0) {
+            if (len >= max) {
                 temp = realloc2n(ret, &max);
-		ret = temp;
-	    }
-	    ret[len++] = *p++;
-	}
-	if (len >= max) {
+                ret = temp;
+            }
+            ret[len++] = *p++;
+        }
+        if (len >= max) {
             temp = realloc2n(ret, &max);
             ret = temp;
-	}
-	ret[len++] = ':';
+        }
+        ret[len++] = ':';
     }
     if (uri->opaque != NULL) {
-	p = uri->opaque;
-	while (*p != 0) {
-	    if (len + 3 >= max) {
+        p = uri->opaque;
+        while (*p != 0) {
+            if (len + 3 >= max) {
                 temp = realloc2n(ret, &max);
                 ret = temp;
-	    }
-	    if (IS_RESERVED(*(p)) || IS_UNRESERVED(*(p)))
-		ret[len++] = *p++;
-	    else {
-		int val = *(unsigned char *)p++;
-		int hi = val / 0x10, lo = val % 0x10;
-		ret[len++] = '%';
-		ret[len++] = hi + (hi > 9? 'A'-10 : '0');
-		ret[len++] = lo + (lo > 9? 'A'-10 : '0');
-	    }
-	}
+            }
+            if (IS_RESERVED(*(p)) || IS_UNRESERVED(*(p)))
+                ret[len++] = *p++;
+            else {
+                int val = *(unsigned char *)p++;
+                int hi = val / 0x10, lo = val % 0x10;
+                ret[len++] = '%';
+                ret[len++] = hi + (hi > 9 ? 'A' - 10 : '0');
+                ret[len++] = lo + (lo > 9 ? 'A' - 10 : '0');
+            }
+        }
     } else {
-	if (uri->server != NULL) {
-	    if (len + 3 >= max) {
+        if (uri->server != NULL) {
+            if (len + 3 >= max) {
                 temp = realloc2n(ret, &max);
                 ret = temp;
-	    }
-	    ret[len++] = '/';
-	    ret[len++] = '/';
-	    if (uri->user != NULL) {
-		p = uri->user;
-		while (*p != 0) {
-		    if (len + 3 >= max) {
+            }
+            ret[len++] = '/';
+            ret[len++] = '/';
+            if (uri->user != NULL) {
+                p = uri->user;
+                while (*p != 0) {
+                    if (len + 3 >= max) {
                         temp = realloc2n(ret, &max);
                         ret = temp;
-		    }
-		    if ((IS_UNRESERVED(*(p))) ||
-			((*(p) == ';')) || ((*(p) == ':')) ||
-			((*(p) == '&')) || ((*(p) == '=')) ||
-			((*(p) == '+')) || ((*(p) == '$')) ||
-			((*(p) == ',')))
-			ret[len++] = *p++;
-		    else {
-			int val = *(unsigned char *)p++;
-			int hi = val / 0x10, lo = val % 0x10;
-			ret[len++] = '%';
-			ret[len++] = hi + (hi > 9? 'A'-10 : '0');
-			ret[len++] = lo + (lo > 9? 'A'-10 : '0');
-		    }
-		}
-		if (len + 3 >= max) {
+                    }
+                    if ((IS_UNRESERVED(*(p))) || ((*(p) == ';')) ||
+                        ((*(p) == ':')) || ((*(p) == '&')) || ((*(p) == '=')) ||
+                        ((*(p) == '+')) || ((*(p) == '$')) || ((*(p) == ',')))
+                        ret[len++] = *p++;
+                    else {
+                        int val = *(unsigned char *)p++;
+                        int hi = val / 0x10, lo = val % 0x10;
+                        ret[len++] = '%';
+                        ret[len++] = hi + (hi > 9 ? 'A' - 10 : '0');
+                        ret[len++] = lo + (lo > 9 ? 'A' - 10 : '0');
+                    }
+                }
+                if (len + 3 >= max) {
                     temp = realloc2n(ret, &max);
                     ret = temp;
-		}
-		ret[len++] = '@';
-	    }
-	    p = uri->server;
-	    while (*p != 0) {
-		if (len >= max) {
+                }
+                ret[len++] = '@';
+            }
+            p = uri->server;
+            while (*p != 0) {
+                if (len >= max) {
                     temp = realloc2n(ret, &max);
                     ret = temp;
-		}
-		ret[len++] = *p++;
-	    }
-	    if (uri->port > 0) {
-		if (len + 10 >= max) {
+                }
+                ret[len++] = *p++;
+            }
+            if (uri->port > 0) {
+                if (len + 10 >= max) {
                     temp = realloc2n(ret, &max);
                     ret = temp;
-		}
-		len += snprintf(&ret[len], max - len, ":%d", uri->port);
-	    }
-	} else if (uri->authority != NULL) {
-	    if (len + 3 >= max) {
+                }
+                len += snprintf(&ret[len], max - len, ":%d", uri->port);
+            }
+        } else if (uri->authority != NULL) {
+            if (len + 3 >= max) {
                 temp = realloc2n(ret, &max);
                 ret = temp;
-	    }
-	    ret[len++] = '/';
-	    ret[len++] = '/';
-	    p = uri->authority;
-	    while (*p != 0) {
-		if (len + 3 >= max) {
+            }
+            ret[len++] = '/';
+            ret[len++] = '/';
+            p = uri->authority;
+            while (*p != 0) {
+                if (len + 3 >= max) {
                     temp = realloc2n(ret, &max);
                     ret = temp;
-		}
-		if ((IS_UNRESERVED(*(p))) ||
-                    ((*(p) == '$')) || ((*(p) == ',')) || ((*(p) == ';')) ||
-                    ((*(p) == ':')) || ((*(p) == '@')) || ((*(p) == '&')) ||
-                    ((*(p) == '=')) || ((*(p) == '+')))
-		    ret[len++] = *p++;
-		else {
-		    int val = *(unsigned char *)p++;
-		    int hi = val / 0x10, lo = val % 0x10;
-		    ret[len++] = '%';
-		    ret[len++] = hi + (hi > 9? 'A'-10 : '0');
-		    ret[len++] = lo + (lo > 9? 'A'-10 : '0');
-		}
-	    }
-	} else if (uri->scheme != NULL) {
-	    if (len + 3 >= max) {
+                }
+                if ((IS_UNRESERVED(*(p))) || ((*(p) == '$')) ||
+                    ((*(p) == ',')) || ((*(p) == ';')) || ((*(p) == ':')) ||
+                    ((*(p) == '@')) || ((*(p) == '&')) || ((*(p) == '=')) ||
+                    ((*(p) == '+')))
+                    ret[len++] = *p++;
+                else {
+                    int val = *(unsigned char *)p++;
+                    int hi = val / 0x10, lo = val % 0x10;
+                    ret[len++] = '%';
+                    ret[len++] = hi + (hi > 9 ? 'A' - 10 : '0');
+                    ret[len++] = lo + (lo > 9 ? 'A' - 10 : '0');
+                }
+            }
+        } else if (uri->scheme != NULL) {
+            if (len + 3 >= max) {
                 temp = realloc2n(ret, &max);
                 ret = temp;
-	    }
-	    ret[len++] = '/';
-	    ret[len++] = '/';
-	}
-	if (uri->path != NULL) {
-	    p = uri->path;
-	    /*
-	     * the colon in file:///d: should not be escaped or
-	     * Windows accesses fail later.
-	     */
-	    if ((uri->scheme != NULL) &&
-		(p[0] == '/') &&
-		(((p[1] >= 'a') && (p[1] <= 'z')) ||
-		 ((p[1] >= 'A') && (p[1] <= 'Z'))) &&
-		(p[2] == ':') &&
-	        (!strcmp(uri->scheme, "file"))) {
-		if (len + 3 >= max) {
+            }
+            ret[len++] = '/';
+            ret[len++] = '/';
+        }
+        if (uri->path != NULL) {
+            p = uri->path;
+            /*
+             * the colon in file:///d: should not be escaped or
+             * Windows accesses fail later.
+             */
+            if ((uri->scheme != NULL) && (p[0] == '/') &&
+                (((p[1] >= 'a') && (p[1] <= 'z')) ||
+                 ((p[1] >= 'A') && (p[1] <= 'Z'))) &&
+                (p[2] == ':') && (!strcmp(uri->scheme, "file"))) {
+                if (len + 3 >= max) {
                     temp = realloc2n(ret, &max);
                     ret = temp;
-		}
-		ret[len++] = *p++;
-		ret[len++] = *p++;
-		ret[len++] = *p++;
-	    }
-	    while (*p != 0) {
-		if (len + 3 >= max) {
+                }
+                ret[len++] = *p++;
+                ret[len++] = *p++;
+                ret[len++] = *p++;
+            }
+            while (*p != 0) {
+                if (len + 3 >= max) {
                     temp = realloc2n(ret, &max);
                     ret = temp;
-		}
-		if ((IS_UNRESERVED(*(p))) || ((*(p) == '/')) ||
+                }
+                if ((IS_UNRESERVED(*(p))) || ((*(p) == '/')) ||
                     ((*(p) == ';')) || ((*(p) == '@')) || ((*(p) == '&')) ||
-	            ((*(p) == '=')) || ((*(p) == '+')) || ((*(p) == '$')) ||
-	            ((*(p) == ',')))
-		    ret[len++] = *p++;
-		else {
-		    int val = *(unsigned char *)p++;
-		    int hi = val / 0x10, lo = val % 0x10;
-		    ret[len++] = '%';
-		    ret[len++] = hi + (hi > 9? 'A'-10 : '0');
-		    ret[len++] = lo + (lo > 9? 'A'-10 : '0');
-		}
-	    }
-	}
-	if (uri->query != NULL) {
-	    if (len + 1 >= max) {
+                    ((*(p) == '=')) || ((*(p) == '+')) || ((*(p) == '$')) ||
+                    ((*(p) == ',')))
+                    ret[len++] = *p++;
+                else {
+                    int val = *(unsigned char *)p++;
+                    int hi = val / 0x10, lo = val % 0x10;
+                    ret[len++] = '%';
+                    ret[len++] = hi + (hi > 9 ? 'A' - 10 : '0');
+                    ret[len++] = lo + (lo > 9 ? 'A' - 10 : '0');
+                }
+            }
+        }
+        if (uri->query != NULL) {
+            if (len + 1 >= max) {
                 temp = realloc2n(ret, &max);
                 ret = temp;
-	    }
-	    ret[len++] = '?';
-	    p = uri->query;
-	    while (*p != 0) {
-		if (len + 1 >= max) {
+            }
+            ret[len++] = '?';
+            p = uri->query;
+            while (*p != 0) {
+                if (len + 1 >= max) {
                     temp = realloc2n(ret, &max);
                     ret = temp;
-		}
-		ret[len++] = *p++;
-	    }
-	}
+                }
+                ret[len++] = *p++;
+            }
+        }
     }
     if (uri->fragment != NULL) {
-	if (len + 3 >= max) {
+        if (len + 3 >= max) {
             temp = realloc2n(ret, &max);
             ret = temp;
-	}
-	ret[len++] = '#';
-	p = uri->fragment;
-	while (*p != 0) {
-	    if (len + 3 >= max) {
+        }
+        ret[len++] = '#';
+        p = uri->fragment;
+        while (*p != 0) {
+            if (len + 3 >= max) {
                 temp = realloc2n(ret, &max);
                 ret = temp;
-	    }
-	    if ((IS_UNRESERVED(*(p))) || (IS_RESERVED(*(p))))
-		ret[len++] = *p++;
-	    else {
-		int val = *(unsigned char *)p++;
-		int hi = val / 0x10, lo = val % 0x10;
-		ret[len++] = '%';
-		ret[len++] = hi + (hi > 9? 'A'-10 : '0');
-		ret[len++] = lo + (lo > 9? 'A'-10 : '0');
-	    }
-	}
+            }
+            if ((IS_UNRESERVED(*(p))) || (IS_RESERVED(*(p))))
+                ret[len++] = *p++;
+            else {
+                int val = *(unsigned char *)p++;
+                int hi = val / 0x10, lo = val % 0x10;
+                ret[len++] = '%';
+                ret[len++] = hi + (hi > 9 ? 'A' - 10 : '0');
+                ret[len++] = lo + (lo > 9 ? 'A' - 10 : '0');
+            }
+        }
     }
     if (len >= max) {
         temp = realloc2n(ret, &max);
         ret = temp;
     }
     ret[len] = 0;
-    return(ret);
+    return (ret);
 }
 
 /**
@@ -1254,9 +1258,10 @@ uri_to_string(URI *uri) {
  *
  * Make sure the URI struct is free of content
  */
-static void
-uri_clean(URI *uri) {
-    if (uri == NULL) return;
+static void uri_clean(URI *uri)
+{
+    if (uri == NULL)
+        return;
 
     g_free(uri->scheme);
     uri->scheme = NULL;
@@ -1282,16 +1287,16 @@ uri_clean(URI *uri) {
  *
  * Free up the URI struct
  */
-void
-uri_free(URI *uri) {
+void uri_free(URI *uri)
+{
     uri_clean(uri);
     g_free(uri);
 }
 
 /************************************************************************
- *									*
- *			Helper functions				*
- *									*
+ *                                                                      *
+ *                           Helper functions                           *
+ *                                                                      *
  ************************************************************************/
 
 /**
@@ -1305,21 +1310,21 @@ uri_free(URI *uri) {
  *
  * Returns 0 or an error code
  */
-static int
-normalize_uri_path(char *path) {
+static int normalize_uri_path(char *path)
+{
     char *cur, *out;
 
     if (path == NULL)
-	return(-1);
+        return (-1);
 
     /* Skip all initial "/" chars.  We want to get to the beginning of the
      * first non-empty segment.
      */
     cur = path;
     while (cur[0] == '/')
-      ++cur;
+        ++cur;
     if (cur[0] == '\0')
-      return(0);
+        return (0);
 
     /* Keep everything we've seen so far.  */
     out = cur;
@@ -1328,46 +1333,46 @@ normalize_uri_path(char *path) {
      * Analyze each segment in sequence for cases (c) and (d).
      */
     while (cur[0] != '\0') {
-	/*
-	 * c) All occurrences of "./", where "." is a complete path segment,
-	 *    are removed from the buffer string.
-	 */
-	if ((cur[0] == '.') && (cur[1] == '/')) {
-	    cur += 2;
-	    /* '//' normalization should be done at this point too */
-	    while (cur[0] == '/')
-		cur++;
-	    continue;
-	}
-
-	/*
-	 * d) If the buffer string ends with "." as a complete path segment,
-	 *    that "." is removed.
-	 */
-	if ((cur[0] == '.') && (cur[1] == '\0'))
-	    break;
-
-	/* Otherwise keep the segment.  */
-	while (cur[0] != '/') {
+        /*
+         * c) All occurrences of "./", where "." is a complete path segment,
+         *    are removed from the buffer string.
+         */
+        if ((cur[0] == '.') && (cur[1] == '/')) {
+            cur += 2;
+            /* '//' normalization should be done at this point too */
+            while (cur[0] == '/')
+                cur++;
+            continue;
+        }
+
+        /*
+         * d) If the buffer string ends with "." as a complete path segment,
+         *    that "." is removed.
+         */
+        if ((cur[0] == '.') && (cur[1] == '\0'))
+            break;
+
+        /* Otherwise keep the segment.  */
+        while (cur[0] != '/') {
             if (cur[0] == '\0')
-              goto done_cd;
-	    (out++)[0] = (cur++)[0];
-	}
-	/* nomalize // */
-	while ((cur[0] == '/') && (cur[1] == '/'))
-	    cur++;
+                goto done_cd;
+            (out++)[0] = (cur++)[0];
+        }
+        /* nomalize // */
+        while ((cur[0] == '/') && (cur[1] == '/'))
+            cur++;
 
         (out++)[0] = (cur++)[0];
     }
- done_cd:
+done_cd:
     out[0] = '\0';
 
     /* Reset to the beginning of the first segment for the next sequence.  */
     cur = path;
     while (cur[0] == '/')
-      ++cur;
+        ++cur;
     if (cur[0] == '\0')
-	return(0);
+        return (0);
 
     /*
      * Analyze each segment in sequence for cases (e) and (f).
@@ -1397,23 +1402,23 @@ normalize_uri_path(char *path) {
         /* Find the end of the current segment.  */
         segp = cur;
         while ((segp[0] != '/') && (segp[0] != '\0'))
-          ++segp;
+            ++segp;
 
         /* If this is the last segment, we're done (we need at least two
          * segments to meet the criteria for the (e) and (f) cases).
          */
         if (segp[0] == '\0')
-          break;
+            break;
 
         /* If the first segment is "..", or if the next segment _isn't_ "..",
          * keep this segment and try the next one.
          */
         ++segp;
-        if (((cur[0] == '.') && (cur[1] == '.') && (segp == cur+3))
-            || ((segp[0] != '.') || (segp[1] != '.')
-                || ((segp[2] != '/') && (segp[2] != '\0')))) {
-          cur = segp;
-          continue;
+        if (((cur[0] == '.') && (cur[1] == '.') && (segp == cur + 3)) ||
+            ((segp[0] != '.') || (segp[1] != '.') ||
+             ((segp[2] != '/') && (segp[2] != '\0')))) {
+            cur = segp;
+            continue;
         }
 
         /* If we get here, remove this segment and the next one and back up
@@ -1425,22 +1430,22 @@ normalize_uri_path(char *path) {
 
         /* If this is the end of the buffer, we're done.  */
         if (segp[2] == '\0') {
-          cur[0] = '\0';
-          break;
+            cur[0] = '\0';
+            break;
         }
         /* Valgrind complained, strcpy(cur, segp + 3); */
         /* string will overlap, do not use strcpy */
         tmp = cur;
         segp += 3;
         while ((*tmp++ = *segp++) != 0)
-          ;
+            ;
 
         /* If there are no previous segments, then keep going from here.  */
         segp = cur;
         while ((segp > path) && ((--segp)[0] == '/'))
-          ;
+            ;
         if (segp == path)
-          continue;
+            continue;
 
         /* "segp" is pointing to the end of a previous segment; find it's
          * start.  We need to back up to the previous segment and start
@@ -1451,7 +1456,7 @@ normalize_uri_path(char *path) {
          */
         cur = segp;
         while ((cur > path) && (cur[-1] != '/'))
-          --cur;
+            --cur;
     }
     out[0] = '\0';
 
@@ -1467,31 +1472,30 @@ normalize_uri_path(char *path) {
      * We discard them from the final path.
      */
     if (path[0] == '/') {
-      cur = path;
-      while ((cur[0] == '/') && (cur[1] == '.') && (cur[2] == '.')
-             && ((cur[3] == '/') || (cur[3] == '\0')))
-	cur += 3;
-
-      if (cur != path) {
-	out = path;
-	while (cur[0] != '\0')
-          (out++)[0] = (cur++)[0];
-	out[0] = 0;
-      }
+        cur = path;
+        while ((cur[0] == '/') && (cur[1] == '.') && (cur[2] == '.') &&
+               ((cur[3] == '/') || (cur[3] == '\0')))
+            cur += 3;
+
+        if (cur != path) {
+            out = path;
+            while (cur[0] != '\0')
+                (out++)[0] = (cur++)[0];
+            out[0] = 0;
+        }
     }
 
-    return(0);
+    return (0);
 }
 
-static int is_hex(char c) {
-    if (((c >= '0') && (c <= '9')) ||
-        ((c >= 'a') && (c <= 'f')) ||
+static int is_hex(char c)
+{
+    if (((c >= '0') && (c <= '9')) || ((c >= 'a') && (c <= 'f')) ||
         ((c >= 'A') && (c <= 'F')))
-	return(1);
-    return(0);
+        return (1);
+    return (0);
 }
 
-
 /**
  * uri_string_unescape:
  * @str:  the string to unescape
@@ -1506,48 +1510,50 @@ static int is_hex(char c) {
  * Returns a copy of the string, but unescaped, will return NULL only in case
  * of error
  */
-char *
-uri_string_unescape(const char *str, int len, char *target) {
+char *uri_string_unescape(const char *str, int len, char *target)
+{
     char *ret, *out;
     const char *in;
 
     if (str == NULL)
-	return(NULL);
-    if (len <= 0) len = strlen(str);
-    if (len < 0) return(NULL);
+        return (NULL);
+    if (len <= 0)
+        len = strlen(str);
+    if (len < 0)
+        return (NULL);
 
     if (target == NULL) {
-	ret = g_malloc(len + 1);
+        ret = g_malloc(len + 1);
     } else
-	ret = target;
+        ret = target;
     in = str;
     out = ret;
-    while(len > 0) {
-	if ((len > 2) && (*in == '%') && (is_hex(in[1])) && (is_hex(in[2]))) {
-	    in++;
-	    if ((*in >= '0') && (*in <= '9'))
-	        *out = (*in - '0');
-	    else if ((*in >= 'a') && (*in <= 'f'))
-	        *out = (*in - 'a') + 10;
-	    else if ((*in >= 'A') && (*in <= 'F'))
-	        *out = (*in - 'A') + 10;
-	    in++;
-	    if ((*in >= '0') && (*in <= '9'))
-	        *out = *out * 16 + (*in - '0');
-	    else if ((*in >= 'a') && (*in <= 'f'))
-	        *out = *out * 16 + (*in - 'a') + 10;
-	    else if ((*in >= 'A') && (*in <= 'F'))
-	        *out = *out * 16 + (*in - 'A') + 10;
-	    in++;
-	    len -= 3;
-	    out++;
-	} else {
-	    *out++ = *in++;
-	    len--;
-	}
+    while (len > 0) {
+        if ((len > 2) && (*in == '%') && (is_hex(in[1])) && (is_hex(in[2]))) {
+            in++;
+            if ((*in >= '0') && (*in <= '9'))
+                *out = (*in - '0');
+            else if ((*in >= 'a') && (*in <= 'f'))
+                *out = (*in - 'a') + 10;
+            else if ((*in >= 'A') && (*in <= 'F'))
+                *out = (*in - 'A') + 10;
+            in++;
+            if ((*in >= '0') && (*in <= '9'))
+                *out = *out * 16 + (*in - '0');
+            else if ((*in >= 'a') && (*in <= 'f'))
+                *out = *out * 16 + (*in - 'a') + 10;
+            else if ((*in >= 'A') && (*in <= 'F'))
+                *out = *out * 16 + (*in - 'A') + 10;
+            in++;
+            len -= 3;
+            out++;
+        } else {
+            *out++ = *in++;
+            len--;
+        }
     }
     *out = 0;
-    return(ret);
+    return (ret);
 }
 
 /**
@@ -1560,59 +1566,59 @@ uri_string_unescape(const char *str, int len, char *target) {
  *
  * Returns a new escaped string or NULL in case of error.
  */
-char *
-uri_string_escape(const char *str, const char *list) {
+char *uri_string_escape(const char *str, const char *list)
+{
     char *ret, ch;
     char *temp;
     const char *in;
     int len, out;
 
     if (str == NULL)
-	return(NULL);
+        return (NULL);
     if (str[0] == 0)
-	return(g_strdup(str));
+        return (g_strdup(str));
     len = strlen(str);
-    if (!(len > 0)) return(NULL);
+    if (!(len > 0))
+        return (NULL);
 
     len += 20;
     ret = g_malloc(len);
     in = str;
     out = 0;
-    while(*in != 0) {
-	if (len - out <= 3) {
+    while (*in != 0) {
+        if (len - out <= 3) {
             temp = realloc2n(ret, &len);
-	    ret = temp;
-	}
-
-	ch = *in;
-
-	if ((ch != '@') && (!IS_UNRESERVED(ch)) && (!strchr(list, ch))) {
-	    unsigned char val;
-	    ret[out++] = '%';
-	    val = ch >> 4;
-	    if (val <= 9)
-		ret[out++] = '0' + val;
-	    else
-		ret[out++] = 'A' + val - 0xA;
-	    val = ch & 0xF;
-	    if (val <= 9)
-		ret[out++] = '0' + val;
-	    else
-		ret[out++] = 'A' + val - 0xA;
-	    in++;
-	} else {
-	    ret[out++] = *in++;
-	}
+            ret = temp;
+        }
 
+        ch = *in;
+
+        if ((ch != '@') && (!IS_UNRESERVED(ch)) && (!strchr(list, ch))) {
+            unsigned char val;
+            ret[out++] = '%';
+            val = ch >> 4;
+            if (val <= 9)
+                ret[out++] = '0' + val;
+            else
+                ret[out++] = 'A' + val - 0xA;
+            val = ch & 0xF;
+            if (val <= 9)
+                ret[out++] = '0' + val;
+            else
+                ret[out++] = 'A' + val - 0xA;
+            in++;
+        } else {
+            ret[out++] = *in++;
+        }
     }
     ret[out] = 0;
-    return(ret);
+    return (ret);
 }
 
 /************************************************************************
- *									*
- *			Public functions				*
- *									*
+ *                                                                      *
+ *                           Public functions                           *
+ *                                                                      *
  ************************************************************************/
 
 /**
@@ -1630,8 +1636,8 @@ uri_string_escape(const char *str, const char *list) {
  * Returns a new URI string (to be freed by the caller) or NULL in case
  *         of error.
  */
-char *
-uri_resolve(const char *uri, const char *base) {
+char *uri_resolve(const char *uri, const char *base)
+{
     char *val = NULL;
     int ret, len, indx, cur, out;
     URI *ref = NULL;
@@ -1647,43 +1653,42 @@ uri_resolve(const char *uri, const char *base) {
      *    URI.  Should we do that here?
      */
     if (uri == NULL)
-	ret = -1;
+        ret = -1;
     else {
-	if (*uri) {
-	    ref = uri_new();
-	    ret = uri_parse_into(ref, uri);
-	}
-	else
-	    ret = 0;
+        if (*uri) {
+            ref = uri_new();
+            ret = uri_parse_into(ref, uri);
+        } else
+            ret = 0;
     }
     if (ret != 0)
-	goto done;
+        goto done;
     if ((ref != NULL) && (ref->scheme != NULL)) {
-	/*
-	 * The URI is absolute don't modify.
-	 */
-	val = g_strdup(uri);
-	goto done;
+        /*
+         * The URI is absolute don't modify.
+         */
+        val = g_strdup(uri);
+        goto done;
     }
     if (base == NULL)
-	ret = -1;
+        ret = -1;
     else {
-	bas = uri_new();
-	ret = uri_parse_into(bas, base);
+        bas = uri_new();
+        ret = uri_parse_into(bas, base);
     }
     if (ret != 0) {
-	if (ref)
-	    val = uri_to_string(ref);
-	goto done;
+        if (ref)
+            val = uri_to_string(ref);
+        goto done;
     }
     if (ref == NULL) {
-	/*
-	 * the base fragment must be ignored
-	 */
+        /*
+         * the base fragment must be ignored
+         */
         g_free(bas->fragment);
         bas->fragment = NULL;
-	val = uri_to_string(bas);
-	goto done;
+        val = uri_to_string(bas);
+        goto done;
     }
 
     /*
@@ -1700,23 +1705,23 @@ uri_resolve(const char *uri, const char *base) {
      */
     res = uri_new();
     if ((ref->scheme == NULL) && (ref->path == NULL) &&
-	((ref->authority == NULL) && (ref->server == NULL))) {
+        ((ref->authority == NULL) && (ref->server == NULL))) {
         res->scheme = g_strdup(bas->scheme);
-	if (bas->authority != NULL)
-	    res->authority = g_strdup(bas->authority);
-	else if (bas->server != NULL) {
+        if (bas->authority != NULL)
+            res->authority = g_strdup(bas->authority);
+        else if (bas->server != NULL) {
             res->server = g_strdup(bas->server);
             res->user = g_strdup(bas->user);
             res->port = bas->port;
-	}
+        }
         res->path = g_strdup(bas->path);
         if (ref->query != NULL) {
-	    res->query = g_strdup (ref->query);
+            res->query = g_strdup(ref->query);
         } else {
             res->query = g_strdup(bas->query);
         }
         res->fragment = g_strdup(ref->fragment);
-	goto step_7;
+        goto step_7;
     }
 
     /*
@@ -1726,8 +1731,8 @@ uri_resolve(const char *uri, const char *base) {
      *    scheme is inherited from the base URI's scheme component.
      */
     if (ref->scheme != NULL) {
-	val = uri_to_string(ref);
-	goto done;
+        val = uri_to_string(ref);
+        goto done;
     }
     res->scheme = g_strdup(bas->scheme);
 
@@ -1742,22 +1747,22 @@ uri_resolve(const char *uri, const char *base) {
      *    use an authority component.
      */
     if ((ref->authority != NULL) || (ref->server != NULL)) {
-	if (ref->authority != NULL)
-	    res->authority = g_strdup(ref->authority);
-	else {
-	    res->server = g_strdup(ref->server);
+        if (ref->authority != NULL)
+            res->authority = g_strdup(ref->authority);
+        else {
+            res->server = g_strdup(ref->server);
             res->user = g_strdup(ref->user);
             res->port = ref->port;
-	}
+        }
         res->path = g_strdup(ref->path);
-	goto step_7;
+        goto step_7;
     }
     if (bas->authority != NULL)
-	res->authority = g_strdup(bas->authority);
+        res->authority = g_strdup(bas->authority);
     else if (bas->server != NULL) {
         res->server = g_strdup(bas->server);
         res->user = g_strdup(bas->user);
-	res->port = bas->port;
+        res->port = bas->port;
     }
 
     /*
@@ -1765,11 +1770,10 @@ uri_resolve(const char *uri, const char *base) {
      *    the reference is an absolute-path and we skip to step 7.
      */
     if ((ref->path != NULL) && (ref->path[0] == '/')) {
-	res->path = g_strdup(ref->path);
-	goto step_7;
+        res->path = g_strdup(ref->path);
+        goto step_7;
     }
 
-
     /*
      * 6) If this step is reached, then we are resolving a relative-path
      *    reference.  The relative path needs to be merged with the base
@@ -1780,9 +1784,9 @@ uri_resolve(const char *uri, const char *base) {
      */
     len = 2; /* extra / and 0 */
     if (ref->path != NULL)
-	len += strlen(ref->path);
+        len += strlen(ref->path);
     if (bas->path != NULL)
-	len += strlen(bas->path);
+        len += strlen(bas->path);
     res->path = g_malloc(len);
     res->path[0] = 0;
 
@@ -1794,18 +1798,18 @@ uri_resolve(const char *uri, const char *base) {
     cur = 0;
     out = 0;
     if (bas->path != NULL) {
-	while (bas->path[cur] != 0) {
-	    while ((bas->path[cur] != 0) && (bas->path[cur] != '/'))
-		cur++;
-	    if (bas->path[cur] == 0)
-		break;
-
-	    cur++;
-	    while (out < cur) {
-		res->path[out] = bas->path[out];
-		out++;
-	    }
-	}
+        while (bas->path[cur] != 0) {
+            while ((bas->path[cur] != 0) && (bas->path[cur] != '/'))
+                cur++;
+            if (bas->path[cur] == 0)
+                break;
+
+            cur++;
+            while (out < cur) {
+                res->path[out] = bas->path[out];
+                out++;
+            }
+        }
     }
     res->path[out] = 0;
 
@@ -1814,15 +1818,15 @@ uri_resolve(const char *uri, const char *base) {
      *    string.
      */
     if (ref->path != NULL && ref->path[0] != 0) {
-	indx = 0;
-	/*
-	 * Ensure the path includes a '/'
-	 */
-	if ((out == 0) && (bas->server != NULL))
-	    res->path[out++] = '/';
-	while (ref->path[indx] != 0) {
-	    res->path[out++] = ref->path[indx++];
-	}
+        indx = 0;
+        /*
+         * Ensure the path includes a '/'
+         */
+        if ((out == 0) && (bas->server != NULL))
+            res->path[out++] = '/';
+        while (ref->path[indx] != 0) {
+            res->path[out++] = ref->path[indx++];
+        }
     }
     res->path[out] = 0;
 
@@ -1842,12 +1846,12 @@ step_7:
 
 done:
     if (ref != NULL)
-	uri_free(ref);
+        uri_free(ref);
     if (bas != NULL)
-	uri_free(bas);
+        uri_free(bas);
     if (res != NULL)
-	uri_free(res);
-    return(val);
+        uri_free(res);
+    return (val);
 }
 
 /**
@@ -1882,8 +1886,7 @@ done:
  * Returns a new URI string (to be freed by the caller) or NULL in case
  * error.
  */
-char *
-uri_resolve_relative (const char *uri, const char * base)
+char *uri_resolve_relative(const char *uri, const char *base)
 {
     char *val = NULL;
     int ret;
@@ -1897,58 +1900,57 @@ uri_resolve_relative (const char *uri, const char * base)
     int remove_path = 0;
 
     if ((uri == NULL) || (*uri == 0))
-	return NULL;
+        return NULL;
 
     /*
      * First parse URI into a standard form
      */
-    ref = uri_new ();
+    ref = uri_new();
     /* If URI not already in "relative" form */
     if (uri[0] != '.') {
-	ret = uri_parse_into (ref, uri);
-	if (ret != 0)
-	    goto done;		/* Error in URI, return NULL */
+        ret = uri_parse_into(ref, uri);
+        if (ret != 0)
+            goto done; /* Error in URI, return NULL */
     } else
-	ref->path = g_strdup(uri);
+        ref->path = g_strdup(uri);
 
     /*
      * Next parse base into the same standard form
      */
     if ((base == NULL) || (*base == 0)) {
-	val = g_strdup (uri);
-	goto done;
+        val = g_strdup(uri);
+        goto done;
     }
-    bas = uri_new ();
+    bas = uri_new();
     if (base[0] != '.') {
-	ret = uri_parse_into (bas, base);
-	if (ret != 0)
-	    goto done;		/* Error in base, return NULL */
+        ret = uri_parse_into(bas, base);
+        if (ret != 0)
+            goto done; /* Error in base, return NULL */
     } else
-	bas->path = g_strdup(base);
+        bas->path = g_strdup(base);
 
     /*
      * If the scheme / server on the URI differs from the base,
      * just return the URI
      */
     if ((ref->scheme != NULL) &&
-	((bas->scheme == NULL) ||
-	 (strcmp (bas->scheme, ref->scheme)) ||
-	 (strcmp (bas->server, ref->server)))) {
-	val = g_strdup (uri);
-	goto done;
+        ((bas->scheme == NULL) || (strcmp(bas->scheme, ref->scheme)) ||
+         (strcmp(bas->server, ref->server)))) {
+        val = g_strdup(uri);
+        goto done;
     }
     if (bas->path == ref->path ||
         (bas->path && ref->path && !strcmp(bas->path, ref->path))) {
-	val = g_strdup("");
-	goto done;
+        val = g_strdup("");
+        goto done;
     }
     if (bas->path == NULL) {
-	val = g_strdup(ref->path);
-	goto done;
+        val = g_strdup(ref->path);
+        goto done;
     }
     if (ref->path == NULL) {
-        ref->path = (char *) "/";
-	remove_path = 1;
+        ref->path = (char *)"/";
+        remove_path = 1;
     }
 
     /*
@@ -1958,78 +1960,78 @@ uri_resolve_relative (const char *uri, const char * base)
      * two path components may be missing (bug 316224)
      */
     if (bas->path == NULL) {
-	if (ref->path != NULL) {
-	    uptr = ref->path;
-	    if (*uptr == '/')
-		uptr++;
-	    /* exception characters from uri_to_string */
-	    val = uri_string_escape(uptr, "/;&=+$,");
-	}
-	goto done;
+        if (ref->path != NULL) {
+            uptr = ref->path;
+            if (*uptr == '/')
+                uptr++;
+            /* exception characters from uri_to_string */
+            val = uri_string_escape(uptr, "/;&=+$,");
+        }
+        goto done;
     }
     bptr = bas->path;
     if (ref->path == NULL) {
-	for (ix = 0; bptr[ix] != 0; ix++) {
-	    if (bptr[ix] == '/')
-		nbslash++;
-	}
-	uptr = NULL;
-	len = 1;	/* this is for a string terminator only */
+        for (ix = 0; bptr[ix] != 0; ix++) {
+            if (bptr[ix] == '/')
+                nbslash++;
+        }
+        uptr = NULL;
+        len = 1; /* this is for a string terminator only */
     } else {
-    /*
-     * Next we compare the two strings and find where they first differ
-     */
-	if ((ref->path[pos] == '.') && (ref->path[pos+1] == '/'))
+        /*
+         * Next we compare the two strings and find where they first differ
+         */
+        if ((ref->path[pos] == '.') && (ref->path[pos + 1] == '/'))
             pos += 2;
-	if ((*bptr == '.') && (bptr[1] == '/'))
+        if ((*bptr == '.') && (bptr[1] == '/'))
             bptr += 2;
-	else if ((*bptr == '/') && (ref->path[pos] != '/'))
-	    bptr++;
-	while ((bptr[pos] == ref->path[pos]) && (bptr[pos] != 0))
-	    pos++;
-
-	if (bptr[pos] == ref->path[pos]) {
-	    val = g_strdup("");
-	    goto done;		/* (I can't imagine why anyone would do this) */
-	}
-
-	/*
-	 * In URI, "back up" to the last '/' encountered.  This will be the
-	 * beginning of the "unique" suffix of URI
-	 */
-	ix = pos;
-	if ((ref->path[ix] == '/') && (ix > 0))
-	    ix--;
-	else if ((ref->path[ix] == 0) && (ix > 1) && (ref->path[ix - 1] == '/'))
-	    ix -= 2;
-	for (; ix > 0; ix--) {
-	    if (ref->path[ix] == '/')
-		break;
-	}
-	if (ix == 0) {
-	    uptr = ref->path;
-	} else {
-	    ix++;
-	    uptr = &ref->path[ix];
-	}
-
-	/*
-	 * In base, count the number of '/' from the differing point
-	 */
-	if (bptr[pos] != ref->path[pos]) {/* check for trivial URI == base */
-	    for (; bptr[ix] != 0; ix++) {
-		if (bptr[ix] == '/')
-		    nbslash++;
-	    }
-	}
-	len = strlen (uptr) + 1;
+        else if ((*bptr == '/') && (ref->path[pos] != '/'))
+            bptr++;
+        while ((bptr[pos] == ref->path[pos]) && (bptr[pos] != 0))
+            pos++;
+
+        if (bptr[pos] == ref->path[pos]) {
+            val = g_strdup("");
+            goto done; /* (I can't imagine why anyone would do this) */
+        }
+
+        /*
+         * In URI, "back up" to the last '/' encountered.  This will be the
+         * beginning of the "unique" suffix of URI
+         */
+        ix = pos;
+        if ((ref->path[ix] == '/') && (ix > 0))
+            ix--;
+        else if ((ref->path[ix] == 0) && (ix > 1) && (ref->path[ix - 1] == '/'))
+            ix -= 2;
+        for (; ix > 0; ix--) {
+            if (ref->path[ix] == '/')
+                break;
+        }
+        if (ix == 0) {
+            uptr = ref->path;
+        } else {
+            ix++;
+            uptr = &ref->path[ix];
+        }
+
+        /*
+         * In base, count the number of '/' from the differing point
+         */
+        if (bptr[pos] != ref->path[pos]) { /* check for trivial URI == base */
+            for (; bptr[ix] != 0; ix++) {
+                if (bptr[ix] == '/')
+                    nbslash++;
+            }
+        }
+        len = strlen(uptr) + 1;
     }
 
     if (nbslash == 0) {
-	if (uptr != NULL)
-	    /* exception characters from uri_to_string */
-	    val = uri_string_escape(uptr, "/;&=+$,");
-	goto done;
+        if (uptr != NULL)
+            /* exception characters from uri_to_string */
+            val = uri_string_escape(uptr, "/;&=+$,");
+        goto done;
     }
 
     /*
@@ -2037,35 +2039,35 @@ uri_resolve_relative (const char *uri, const char * base)
      * length of the remainder of the URI, plus enough space
      * for the "../" groups, plus one for the terminator
      */
-    val = g_malloc (len + 3 * nbslash);
+    val = g_malloc(len + 3 * nbslash);
     vptr = val;
     /*
      * Put in as many "../" as needed
      */
-    for (; nbslash>0; nbslash--) {
-	*vptr++ = '.';
-	*vptr++ = '.';
-	*vptr++ = '/';
+    for (; nbslash > 0; nbslash--) {
+        *vptr++ = '.';
+        *vptr++ = '.';
+        *vptr++ = '/';
     }
     /*
      * Finish up with the end of the URI
      */
     if (uptr != NULL) {
-        if ((vptr > val) && (len > 0) &&
-	    (uptr[0] == '/') && (vptr[-1] == '/')) {
-	    memcpy (vptr, uptr + 1, len - 1);
-	    vptr[len - 2] = 0;
-	} else {
-	    memcpy (vptr, uptr, len);
-	    vptr[len - 1] = 0;
-	}
+        if ((vptr > val) && (len > 0) && (uptr[0] == '/') &&
+            (vptr[-1] == '/')) {
+            memcpy(vptr, uptr + 1, len - 1);
+            vptr[len - 2] = 0;
+        } else {
+            memcpy(vptr, uptr, len);
+            vptr[len - 1] = 0;
+        }
     } else {
-	vptr[len - 1] = 0;
+        vptr[len - 1] = 0;
     }
 
     /* escape the freshly-built path */
     vptr = val;
-	/* exception characters from uri_to_string */
+    /* exception characters from uri_to_string */
     val = uri_string_escape(vptr, "/;&=+$,");
     g_free(vptr);
 
@@ -2076,9 +2078,9 @@ done:
     if (remove_path != 0)
         ref->path = NULL;
     if (ref != NULL)
-	uri_free (ref);
+        uri_free(ref);
     if (bas != NULL)
-	uri_free (bas);
+        uri_free(bas);
 
     return val;
 }
@@ -2087,12 +2089,12 @@ done:
  * Utility functions to help parse and assemble query strings.
  */
 
-struct QueryParams *
-query_params_new (int init_alloc)
+struct QueryParams *query_params_new(int init_alloc)
 {
     struct QueryParams *ps;
 
-    if (init_alloc <= 0) init_alloc = 1;
+    if (init_alloc <= 0)
+        init_alloc = 1;
 
     ps = g_new(QueryParams, 1);
     ps->n = 0;
@@ -2105,9 +2107,8 @@ query_params_new (int init_alloc)
 /* Ensure there is space to store at least one more parameter
  * at the end of the set.
  */
-static int
-query_params_append (struct QueryParams *ps,
-               const char *name, const char *value)
+static int query_params_append(struct QueryParams *ps, const char *name,
+                               const char *value)
 {
     if (ps->n >= ps->alloc) {
         ps->p = g_renew(QueryParam, ps->p, ps->alloc * 2);
@@ -2122,41 +2123,41 @@ query_params_append (struct QueryParams *ps,
     return 0;
 }
 
-void
-query_params_free (struct QueryParams *ps)
+void query_params_free(struct QueryParams *ps)
 {
     int i;
 
     for (i = 0; i < ps->n; ++i) {
-        g_free (ps->p[i].name);
-        g_free (ps->p[i].value);
+        g_free(ps->p[i].name);
+        g_free(ps->p[i].value);
     }
-    g_free (ps->p);
-    g_free (ps);
+    g_free(ps->p);
+    g_free(ps);
 }
 
-struct QueryParams *
-query_params_parse (const char *query)
+struct QueryParams *query_params_parse(const char *query)
 {
     struct QueryParams *ps;
     const char *end, *eq;
 
-    ps = query_params_new (0);
-    if (!query || query[0] == '\0') return ps;
+    ps = query_params_new(0);
+    if (!query || query[0] == '\0')
+        return ps;
 
     while (*query) {
         char *name = NULL, *value = NULL;
 
         /* Find the next separator, or end of the string. */
-        end = strchr (query, '&');
+        end = strchr(query, '&');
         if (!end)
-            end = strchr (query, ';');
+            end = strchr(query, ';');
         if (!end)
-            end = query + strlen (query);
+            end = query + strlen(query);
 
         /* Find the first '=' character between here and end. */
-        eq = strchr (query, '=');
-        if (eq && eq >= end) eq = NULL;
+        eq = strchr(query, '=');
+        if (eq && eq >= end)
+            eq = NULL;
 
         /* Empty section (eg. "&&"). */
         if (end == query)
@@ -2166,14 +2167,14 @@ query_params_parse (const char *query)
          * and consistent with CGI.pm we assume value is "".
          */
         else if (!eq) {
-            name = uri_string_unescape (query, end - query, NULL);
+            name = uri_string_unescape(query, end - query, NULL);
             value = NULL;
         }
         /* Or if we have "name=" here (works around annoying
          * problem when calling uri_string_unescape with len = 0).
          */
-        else if (eq+1 == end) {
-            name = uri_string_unescape (query, eq - query, NULL);
+        else if (eq + 1 == end) {
+            name = uri_string_unescape(query, eq - query, NULL);
             value = g_new0(char, 1);
         }
         /* If the '=' character is at the beginning then we have
@@ -2184,18 +2185,19 @@ query_params_parse (const char *query)
 
         /* Otherwise it's "name=value". */
         else {
-            name = uri_string_unescape (query, eq - query, NULL);
-            value = uri_string_unescape (eq+1, end - (eq+1), NULL);
+            name = uri_string_unescape(query, eq - query, NULL);
+            value = uri_string_unescape(eq + 1, end - (eq + 1), NULL);
         }
 
         /* Append to the parameter set. */
-        query_params_append (ps, name, value);
+        query_params_append(ps, name, value);
         g_free(name);
         g_free(value);
 
     next:
         query = end;
-        if (*query) query ++; /* skip '&' separator */
+        if (*query)
+            query++; /* skip '&' separator */
     }
 
     return ps;
-- 
2.7.4
