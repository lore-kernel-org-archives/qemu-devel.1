Received: from eggs.gnu.org ([2001:4830:134:3::10]:33587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eCCLO-0000Al-Ai
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 17:27:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eCCLM-0004f3-NG
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 17:27:42 -0500
From: Jeff Cody <jcody@redhat.com>
Date: Tue,  7 Nov 2017 17:27:24 -0500
Message-Id: <41ed8543e005205118438328c7e162532729d9c7.1510093478.git.jcody@redhat.com>
In-Reply-To: <cover.1510093478.git.jcody@redhat.com>
References: <cover.1510093478.git.jcody@redhat.com>
In-Reply-To: <cover.1510093478.git.jcody@redhat.com>
References: <cover.1510093478.git.jcody@redhat.com>
Subject: [Qemu-devel] [PATCH v3 7/7] block/curl: code cleanup to comply with
 coding style
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, rjones@redhat.com, kwolf@redhat.com, eblake@redhat.com

This addresses non-functional changes to help curl.c better comply
with the coding styles (comments, indentation, brackets, etc.).

One minor code change is the combination of two if statements into
a single if statement.

Signed-off-by: Jeff Cody <jcody@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block/curl.c | 100 +++++++++++++++++++++++++++++++----------------------------
 1 file changed, 52 insertions(+), 48 deletions(-)

diff --git a/block/curl.c b/block/curl.c
index 35cf417..7a6dd44 100644
--- a/block/curl.c
+++ b/block/curl.c
@@ -32,8 +32,10 @@
 #include <curl/curl.h>
 #include "qemu/cutils.h"
 
-// #define DEBUG_CURL
-// #define DEBUG_VERBOSE
+/*
+ #define DEBUG_CURL
+ #define DEBUG_VERBOSE
+*/
 
 #ifdef DEBUG_CURL
 #define DEBUG_CURL_PRINT 1
@@ -76,15 +78,15 @@ static CURLMcode __curl_multi_socket_action(CURLM *multi_handle,
 #define CURL_TIMEOUT_DEFAULT 5
 #define CURL_TIMEOUT_MAX 10000
 
-#define CURL_BLOCK_OPT_URL       "url"
-#define CURL_BLOCK_OPT_READAHEAD "readahead"
-#define CURL_BLOCK_OPT_SSLVERIFY "sslverify"
-#define CURL_BLOCK_OPT_TIMEOUT "timeout"
-#define CURL_BLOCK_OPT_COOKIE    "cookie"
-#define CURL_BLOCK_OPT_COOKIE_SECRET "cookie-secret"
-#define CURL_BLOCK_OPT_USERNAME "username"
-#define CURL_BLOCK_OPT_PASSWORD_SECRET "password-secret"
-#define CURL_BLOCK_OPT_PROXY_USERNAME "proxy-username"
+#define CURL_BLOCK_OPT_URL                   "url"
+#define CURL_BLOCK_OPT_READAHEAD             "readahead"
+#define CURL_BLOCK_OPT_SSLVERIFY             "sslverify"
+#define CURL_BLOCK_OPT_TIMEOUT               "timeout"
+#define CURL_BLOCK_OPT_COOKIE                "cookie"
+#define CURL_BLOCK_OPT_COOKIE_SECRET         "cookie-secret"
+#define CURL_BLOCK_OPT_USERNAME              "username"
+#define CURL_BLOCK_OPT_PASSWORD_SECRET       "password-secret"
+#define CURL_BLOCK_OPT_PROXY_USERNAME        "proxy-username"
 #define CURL_BLOCK_OPT_PROXY_PASSWORD_SECRET "proxy-password-secret"
 
 struct BDRVCURLState;
@@ -110,8 +112,7 @@ typedef struct CURLSocket {
     QLIST_ENTRY(CURLSocket) next;
 } CURLSocket;
 
-typedef struct CURLState
-{
+typedef struct CURLState {
     struct BDRVCURLState *s;
     CURLAIOCB *acb[CURL_NUM_ACB];
     CURL *curl;
@@ -196,22 +197,22 @@ static int curl_sock_cb(CURL *curl, curl_socket_t fd, int action,
 
     DPRINTF("CURL (AIO): Sock action %d on fd %d\n", action, (int)fd);
     switch (action) {
-        case CURL_POLL_IN:
-            aio_set_fd_handler(s->aio_context, fd, false,
-                               curl_multi_read, NULL, NULL, state);
-            break;
-        case CURL_POLL_OUT:
-            aio_set_fd_handler(s->aio_context, fd, false,
-                               NULL, curl_multi_do, NULL, state);
-            break;
-        case CURL_POLL_INOUT:
-            aio_set_fd_handler(s->aio_context, fd, false,
-                               curl_multi_read, curl_multi_do, NULL, state);
-            break;
-        case CURL_POLL_REMOVE:
-            aio_set_fd_handler(s->aio_context, fd, false,
-                               NULL, NULL, NULL, NULL);
-            break;
+    case CURL_POLL_IN:
+        aio_set_fd_handler(s->aio_context, fd, false,
+                           curl_multi_read, NULL, NULL, state);
+        break;
+    case CURL_POLL_OUT:
+        aio_set_fd_handler(s->aio_context, fd, false,
+                           NULL, curl_multi_do, NULL, state);
+        break;
+    case CURL_POLL_INOUT:
+        aio_set_fd_handler(s->aio_context, fd, false,
+                           curl_multi_read, curl_multi_do, NULL, state);
+        break;
+    case CURL_POLL_REMOVE:
+        aio_set_fd_handler(s->aio_context, fd, false,
+                           NULL, NULL, NULL, NULL);
+        break;
     }
 
     return 0;
@@ -235,7 +236,7 @@ static size_t curl_header_cb(void *ptr, size_t size, size_t nmemb, void *opaque)
 /* Called from curl_multi_do_locked, with s->mutex held.  */
 static size_t curl_read_cb(void *ptr, size_t size, size_t nmemb, void *opaque)
 {
-    CURLState *s = ((CURLState*)opaque);
+    CURLState *s = opaque;
     size_t realsize = size * nmemb;
     int i;
 
@@ -253,11 +254,12 @@ static size_t curl_read_cb(void *ptr, size_t size, size_t nmemb, void *opaque)
     memcpy(s->orig_buf + s->buf_off, ptr, realsize);
     s->buf_off += realsize;
 
-    for(i=0; i<CURL_NUM_ACB; i++) {
+    for (i = 0; i < CURL_NUM_ACB; i++) {
         CURLAIOCB *acb = s->acb[i];
 
-        if (!acb)
+        if (!acb) {
             continue;
+        }
 
         if ((s->buf_off >= acb->end)) {
             size_t request_length = acb->bytes;
@@ -293,17 +295,16 @@ static bool curl_find_buf(BDRVCURLState *s, uint64_t start, uint64_t len,
     uint64_t clamped_end = MIN(end, s->len);
     uint64_t clamped_len = clamped_end - start;
 
-    for (i=0; i<CURL_NUM_STATES; i++) {
+    for (i = 0; i < CURL_NUM_STATES; i++) {
         CURLState *state = &s->states[i];
         uint64_t buf_end = (state->buf_start + state->buf_off);
         uint64_t buf_fend = (state->buf_start + state->buf_len);
 
-        if (!state->orig_buf)
-            continue;
-        if (!state->buf_off)
+        if (!state->orig_buf || !state->buf_off) {
             continue;
+        }
 
-        // Does the existing buffer cover our section?
+        /* Does the existing buffer cover our section? */
         if ((start >= state->buf_start) &&
             (start <= buf_end) &&
             (clamped_end >= state->buf_start) &&
@@ -319,7 +320,7 @@ static bool curl_find_buf(BDRVCURLState *s, uint64_t start, uint64_t len,
             return true;
         }
 
-        // Wait for unfinished chunks
+        /* Wait for unfinished chunks */
         if (state->in_use &&
             (start >= state->buf_start) &&
             (start <= buf_fend) &&
@@ -331,7 +332,7 @@ static bool curl_find_buf(BDRVCURLState *s, uint64_t start, uint64_t len,
             acb->start = start - state->buf_start;
             acb->end = acb->start + clamped_len;
 
-            for (j=0; j<CURL_NUM_ACB; j++) {
+            for (j = 0; j < CURL_NUM_ACB; j++) {
                 if (!state->acb[j]) {
                     state->acb[j] = acb;
                     return true;
@@ -355,8 +356,9 @@ static void curl_multi_check_completion(BDRVCURLState *s)
         msg = curl_multi_info_read(s->multi, &msgs_in_queue);
 
         /* Quit when there are no more completions */
-        if (!msg)
+        if (!msg) {
             break;
+        }
 
         if (msg->msg == CURLMSG_DONE) {
             CURLState *state = NULL;
@@ -540,12 +542,14 @@ static void curl_clean_state(CURLState *s)
 {
     CURLAIOCB *next;
     int j;
+
     for (j = 0; j < CURL_NUM_ACB; j++) {
         assert(!s->acb[j]);
     }
 
-    if (s->s->multi)
+    if (s->s->multi) {
         curl_multi_remove_handle(s->s->multi, s->curl);
+    }
 
     while (!QLIST_EMPTY(&s->sockets)) {
         CURLSocket *socket = QLIST_FIRST(&s->sockets);
@@ -794,7 +798,7 @@ static int curl_open(BlockDriverState *bs, QDict *options, int flags,
         goto out_noclean;
     }
 
-    // Get file size
+    /* Get file size */
 
     if (curl_init_state(s, state) < 0) {
         goto out;
@@ -802,11 +806,11 @@ static int curl_open(BlockDriverState *bs, QDict *options, int flags,
 
     s->accept_range = false;
     curl_easy_setopt(state->curl, CURLOPT_NOBODY, 1);
-    curl_easy_setopt(state->curl, CURLOPT_HEADERFUNCTION,
-                     curl_header_cb);
+    curl_easy_setopt(state->curl, CURLOPT_HEADERFUNCTION, curl_header_cb);
     curl_easy_setopt(state->curl, CURLOPT_HEADERDATA, s);
-    if (curl_easy_perform(state->curl))
+    if (curl_easy_perform(state->curl)) {
         goto out;
+    }
     if (curl_easy_getinfo(state->curl, CURLINFO_CONTENT_LENGTH_DOWNLOAD, &d)) {
         goto out;
     }
@@ -876,13 +880,13 @@ static void curl_setup_preadv(BlockDriverState *bs, CURLAIOCB *acb)
 
     qemu_mutex_lock(&s->mutex);
 
-    // In case we have the requested data already (e.g. read-ahead),
-    // we can just call the callback and be done.
+    /* In case we have the requested data already (e.g. read-ahead),
+       we can just call the callback and be done. */
     if (curl_find_buf(s, start, acb->bytes, acb)) {
         goto out;
     }
 
-    // No cache found, so let's start a new request
+    /* No cache found, so let's start a new request */
     for (;;) {
         state = curl_find_state(s);
         if (state) {
-- 
2.9.5
