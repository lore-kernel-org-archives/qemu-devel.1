Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 596E2C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 02:56:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18C3D207D8
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 02:56:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20150623.gappssmtp.com header.i=@smartx-com.20150623.gappssmtp.com header.b="gr/xwrkJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18C3D207D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbxrg-0001mz-Bf
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 22:56:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49402)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1jbxr7-0001Mk-08
 for qemu-devel@nongnu.org; Thu, 21 May 2020 22:56:17 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:52127)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1jbxr5-0001oz-8d
 for qemu-devel@nongnu.org; Thu, 21 May 2020 22:56:16 -0400
Received: by mail-pj1-x1042.google.com with SMTP id cx22so4320719pjb.1
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 19:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=UT4+FeU58SKbzGoF5iZUrCfGKZVCV+Szgh666WjeeRM=;
 b=gr/xwrkJahY0//aVWNx/WMKe2CvNGRM++uW45TDIFneNrIWVAQATjGRvdI6ATHWiw+
 9XrooLurXJhf7qhmJJJcI7NP9p9hAQIUT4YVeQyHLItlnryww0Xkd05b3An10ZLPk8Cz
 506RdyefZue6iQ1AvdwGqTJSAI9RUJ65agSNnaZFaIw+9TDTmQNeIcVssLoMsmOSginD
 8K1A02mGKW4dIbPcqIlVf4j+hvBEvofE/AbjZnu3ErOBRs5WyEnif54w0opFqUzVLaYy
 2tGItHA1z/qARjxNB/5DFbykP+WQ5dC97xGJwtcRQNXUjf6beqItW9MF/It42GdOViPP
 xZPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=UT4+FeU58SKbzGoF5iZUrCfGKZVCV+Szgh666WjeeRM=;
 b=OPKiMhgJdneR0LhlQG2iSJ9/O5pFX0KXNGZZiGjIDQ5XFAwVJkji0DLimL4wuPRcT7
 TC0IMhth46ZFeRlsK4trenl1siQasU0uoT7k07aCXHi5VjsHUDTkSa4imMcnJwk+OSVX
 25alp8WsfwQ0xCqx8KeoMP7OSd1UWLFT3MgPcUgxAAY55wFpIHYaDK8sjsII9kF5depU
 kJqMlIsZF1827IyQxtHvxRVe9DtnPt6IHvWZN6XVVEusxFg2V8vCW12DOWZ/cnl90Ea0
 sJGD5NjqJYbJvmOrBqkLWXaP92fFE3JWrgFjFQ5AJ4QJDmd++jSjgvYjbKv4joNPQLt2
 0tWg==
X-Gm-Message-State: AOAM533RiVg7aPTOFVE15+TAsmxTNbIFXBEe00D264jpWEItOIdLKYAJ
 8csGbxgnC4No+jnu7VClI60sjA==
X-Google-Smtp-Source: ABdhPJy414ATB4aiK5OpJ50k8pH6k1aCZyjDS8POn12eDUmtSTbhH+HU8OXIwg7F13HQ7J3tiWE7CQ==
X-Received: by 2002:a17:90a:ae0d:: with SMTP id
 t13mr1784487pjq.1.1590116172549; 
 Thu, 21 May 2020 19:56:12 -0700 (PDT)
Received: from 31_216.localdomain ([47.240.167.159])
 by smtp.gmail.com with ESMTPSA id k29sm5104934pgf.77.2020.05.21.19.56.09
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 21 May 2020 19:56:11 -0700 (PDT)
From: Li Feng <fengli@smartx.com>
To: kyle@smartx.com, lifeng1519@gmail.com, dimastep@yandex-team.ru,
 marcandre.lureau@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org (open list:All patches CC here)
Subject: [PATCH v5] char-socket: initialize reconnect timer only when the
 timer doesn't start
Date: Fri, 22 May 2020 10:55:54 +0800
Message-Id: <20200522025554.41063-1-fengli@smartx.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200428085122.1621-1-fengli@smarx.com>
References: <20200428085122.1621-1-fengli@smarx.com>
Received-SPF: none client-ip=2607:f8b0:4864:20::1042;
 envelope-from=fengli@smartx.com; helo=mail-pj1-x1042.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Li Feng <fengli@smartx.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When the disconnect event is triggered in the connecting stage,
the tcp_chr_disconnect_locked may be called twice.

The first call:
    #0  qemu_chr_socket_restart_timer (chr=0x55555582ee90) at chardev/char-socket.c:120
    #1  0x000055555558e38c in tcp_chr_disconnect_locked (chr=<optimized out>) at chardev/char-socket.c:490
    #2  0x000055555558e3cd in tcp_chr_disconnect (chr=0x55555582ee90) at chardev/char-socket.c:497
    #3  0x000055555558ea32 in tcp_chr_new_client (chr=chr@entry=0x55555582ee90, sioc=sioc@entry=0x55555582f0b0) at chardev/char-socket.c:892
    #4  0x000055555558eeb8 in qemu_chr_socket_connected (task=0x55555582f300, opaque=<optimized out>) at chardev/char-socket.c:1090
    #5  0x0000555555574352 in qio_task_complete (task=task@entry=0x55555582f300) at io/task.c:196
    #6  0x00005555555745f4 in qio_task_thread_result (opaque=0x55555582f300) at io/task.c:111
    #7  qio_task_wait_thread (task=0x55555582f300) at io/task.c:190
    #8  0x000055555558f17e in tcp_chr_wait_connected (chr=0x55555582ee90, errp=0x555555802a08 <error_abort>) at chardev/char-socket.c:1013
    #9  0x0000555555567cbd in char_socket_client_reconnect_test (opaque=0x5555557fe020 <client8unix>) at tests/test-char.c:1152
The second call:
    #0  0x00007ffff5ac3277 in raise () from /lib64/libc.so.6
    #1  0x00007ffff5ac4968 in abort () from /lib64/libc.so.6
    #2  0x00007ffff5abc096 in __assert_fail_base () from /lib64/libc.so.6
    #3  0x00007ffff5abc142 in __assert_fail () from /lib64/libc.so.6
    #4  0x000055555558d10a in qemu_chr_socket_restart_timer (chr=0x55555582ee90) at chardev/char-socket.c:125
    #5  0x000055555558df0c in tcp_chr_disconnect_locked (chr=<optimized out>) at chardev/char-socket.c:490
    #6  0x000055555558df4d in tcp_chr_disconnect (chr=0x55555582ee90) at chardev/char-socket.c:497
    #7  0x000055555558e5b2 in tcp_chr_new_client (chr=chr@entry=0x55555582ee90, sioc=sioc@entry=0x55555582f0b0) at chardev/char-socket.c:892
    #8  0x000055555558e93a in tcp_chr_connect_client_sync (chr=chr@entry=0x55555582ee90, errp=errp@entry=0x7fffffffd178) at chardev/char-socket.c:944
    #9  0x000055555558ec78 in tcp_chr_wait_connected (chr=0x55555582ee90, errp=0x555555802a08 <error_abort>) at chardev/char-socket.c:1035
    #10 0x000055555556804b in char_socket_client_test (opaque=0x5555557fe020 <client8unix>) at tests/test-char.c:1023

Run test/test-char to reproduce this issue.

test-char: chardev/char-socket.c:125: qemu_chr_socket_restart_timer: Assertion `!s->reconnect_timer' failed.

Signed-off-by: Li Feng <fengli@smartx.com>
---
v5:
- rebase to master

v4:
- remove the wrong patch
- fix the char_socket_ping_pong to support the reconnect exception test

v3:
- add a patch to fix a crash when recvmsg return 0
- make the tests reproduce the two crash

v2:
- add unit test

 chardev/char-socket.c |  2 +-
 tests/test-char.c     | 73 +++++++++++++++++++++++++++++++++++++++------------
 2 files changed, 57 insertions(+), 18 deletions(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index e77699db48..8af7fdce88 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -486,7 +486,7 @@ static void tcp_chr_disconnect_locked(Chardev *chr)
     if (emit_close) {
         qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
     }
-    if (s->reconnect_time) {
+    if (s->reconnect_time && !s->reconnect_timer) {
         qemu_chr_socket_restart_timer(chr);
     }
 }
diff --git a/tests/test-char.c b/tests/test-char.c
index 3afc9b1b8d..73ba1cf601 100644
--- a/tests/test-char.c
+++ b/tests/test-char.c
@@ -625,12 +625,14 @@ static void char_udp_test(void)
 typedef struct {
     int event;
     bool got_pong;
+    CharBackend *be;
 } CharSocketTestData;
 
 
 #define SOCKET_PING "Hello"
 #define SOCKET_PONG "World"
 
+typedef void (*char_socket_cb)(void *opaque, QEMUChrEvent event);
 
 static void
 char_socket_event(void *opaque, QEMUChrEvent event)
@@ -639,6 +641,27 @@ char_socket_event(void *opaque, QEMUChrEvent event)
     data->event = event;
 }
 
+static void
+char_socket_event_with_error(void *opaque, QEMUChrEvent event)
+{
+    static bool first_error;
+    CharSocketTestData *data = opaque;
+    CharBackend *be = data->be;
+    data->event = event;
+    switch (event) {
+    case CHR_EVENT_OPENED:
+        if (!first_error) {
+            first_error = true;
+            qemu_chr_fe_disconnect(be);
+        }
+        return;
+    case CHR_EVENT_CLOSED:
+        return;
+    default:
+        return;
+    }
+}
+
 
 static void
 char_socket_read(void *opaque, const uint8_t *buf, int size)
@@ -699,19 +722,24 @@ char_socket_addr_to_opt_str(SocketAddress *addr, bool fd_pass,
 }
 
 
-static void
-char_socket_ping_pong(QIOChannel *ioc)
+static int
+char_socket_ping_pong(QIOChannel *ioc, Error **errp)
 {
     char greeting[sizeof(SOCKET_PING)];
     const char *response = SOCKET_PONG;
 
-    qio_channel_read_all(ioc, greeting, sizeof(greeting), &error_abort);
+    int ret;
+    ret = qio_channel_read_all(ioc, greeting, sizeof(greeting), errp);
+    if (ret != 0) {
+        object_unref(OBJECT(ioc));
+        return -1;
+    }
 
     g_assert(memcmp(greeting, SOCKET_PING, sizeof(greeting)) == 0);
 
-    qio_channel_write_all(ioc, response, sizeof(SOCKET_PONG), &error_abort);
-
+    qio_channel_write_all(ioc, response, sizeof(SOCKET_PONG), errp);
     object_unref(OBJECT(ioc));
+    return 0;
 }
 
 
@@ -723,7 +751,7 @@ char_socket_server_client_thread(gpointer data)
 
     qio_channel_socket_connect_sync(ioc, addr, &error_abort);
 
-    char_socket_ping_pong(QIO_CHANNEL(ioc));
+    char_socket_ping_pong(QIO_CHANNEL(ioc), &error_abort);
 
     return NULL;
 }
@@ -783,6 +811,7 @@ static void char_socket_server_test(gconstpointer opaque)
 
  reconnect:
     data.event = -1;
+    data.be = &be;
     qemu_chr_fe_set_handlers(&be, NULL, NULL,
                              char_socket_event, NULL,
                              &data, NULL, true);
@@ -855,10 +884,13 @@ char_socket_client_server_thread(gpointer data)
     QIOChannelSocket *ioc = data;
     QIOChannelSocket *cioc;
 
+retry:
     cioc = qio_channel_socket_accept(ioc, &error_abort);
     g_assert_nonnull(cioc);
 
-    char_socket_ping_pong(QIO_CHANNEL(cioc));
+    if (char_socket_ping_pong(QIO_CHANNEL(cioc), NULL) != 0) {
+        goto retry;
+    }
 
     return NULL;
 }
@@ -869,12 +901,13 @@ typedef struct {
     const char *reconnect;
     bool wait_connected;
     bool fd_pass;
+    char_socket_cb event_cb;
 } CharSocketClientTestConfig;
 
-
 static void char_socket_client_test(gconstpointer opaque)
 {
     const CharSocketClientTestConfig *config = opaque;
+    const char_socket_cb event_cb = config->event_cb;
     QIOChannelSocket *ioc;
     char *optstr;
     Chardev *chr;
@@ -938,8 +971,9 @@ static void char_socket_client_test(gconstpointer opaque)
 
  reconnect:
     data.event = -1;
+    data.be = &be;
     qemu_chr_fe_set_handlers(&be, NULL, NULL,
-                             char_socket_event, NULL,
+                             event_cb, NULL,
                              &data, NULL, true);
     if (config->reconnect) {
         g_assert(data.event == -1);
@@ -977,7 +1011,7 @@ static void char_socket_client_test(gconstpointer opaque)
     /* Setup a callback to receive the reply to our greeting */
     qemu_chr_fe_set_handlers(&be, char_socket_can_read,
                              char_socket_read,
-                             char_socket_event, NULL,
+                             event_cb, NULL,
                              &data, NULL, true);
     g_assert(data.event == CHR_EVENT_OPENED);
     data.event = -1;
@@ -1422,17 +1456,20 @@ int main(int argc, char **argv)
 
 #define SOCKET_CLIENT_TEST(name, addr)                                  \
     static CharSocketClientTestConfig client1 ## name =                 \
-        { addr, NULL, false, false };                                   \
+        { addr, NULL, false, false, char_socket_event};                 \
     static CharSocketClientTestConfig client2 ## name =                 \
-        { addr, NULL, true, false };                                    \
+        { addr, NULL, true, false, char_socket_event };                 \
     static CharSocketClientTestConfig client3 ## name =                 \
-        { addr, ",reconnect=1", false };                                \
+        { addr, ",reconnect=1", false, false, char_socket_event };      \
     static CharSocketClientTestConfig client4 ## name =                 \
-        { addr, ",reconnect=1", true };                                 \
+        { addr, ",reconnect=1", true, false, char_socket_event };       \
     static CharSocketClientTestConfig client5 ## name =                 \
-        { addr, NULL, false, true };                                    \
+        { addr, NULL, false, true, char_socket_event };                 \
     static CharSocketClientTestConfig client6 ## name =                 \
-        { addr, NULL, true, true };                                     \
+        { addr, NULL, true, true, char_socket_event };                  \
+    static CharSocketClientTestConfig client7 ## name =                 \
+        { addr, ",reconnect=1", true, false,                            \
+            char_socket_event_with_error };                             \
     g_test_add_data_func("/char/socket/client/mainloop/" # name,        \
                          &client1 ##name, char_socket_client_test);     \
     g_test_add_data_func("/char/socket/client/wait-conn/" # name,       \
@@ -1444,7 +1481,9 @@ int main(int argc, char **argv)
     g_test_add_data_func("/char/socket/client/mainloop-fdpass/" # name, \
                          &client5 ##name, char_socket_client_test);     \
     g_test_add_data_func("/char/socket/client/wait-conn-fdpass/" # name, \
-                         &client6 ##name, char_socket_client_test)
+                         &client6 ##name, char_socket_client_test);     \
+    g_test_add_data_func("/char/socket/client/reconnect-error/" # name, \
+                         &client7 ##name, char_socket_client_test)
 
     if (has_ipv4) {
         SOCKET_SERVER_TEST(tcp, &tcpaddr);
-- 
2.11.0


