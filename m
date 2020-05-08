Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE66C47247
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 05:15:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D70E206D3
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 05:15:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20150623.gappssmtp.com header.i=@smartx-com.20150623.gappssmtp.com header.b="eQ+hHayu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D70E206D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWvLu-0004zA-QD
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 01:15:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55878)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1jWvKy-000492-3L
 for qemu-devel@nongnu.org; Fri, 08 May 2020 01:14:16 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:33113)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1jWvKw-00059s-Lf
 for qemu-devel@nongnu.org; Fri, 08 May 2020 01:14:15 -0400
Received: by mail-pj1-x1044.google.com with SMTP id 7so4754805pjo.0
 for <qemu-devel@nongnu.org>; Thu, 07 May 2020 22:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=U1L9f3dRdWOpqF8hwt16uqX6nGTTq0rfQ0pyeSsS3VY=;
 b=eQ+hHayufAHMzv2fp65pkeTRDBFR4Aat3NPbjDAWndZSNKSbS1qi+oJQw28afvEZZ+
 8ODa846DlPv+lEZql+IvfVycFUIebEzSaOJfiWH4yx9JRWacjyPXP7gOdkLSAST3HtHQ
 17xgD7HRbKn22LZDYkDSuVrU0ocUVuzAKO84+nfABn8uzHKuEJgs9ZJSbSISy1vcxT1B
 0YGtBWcg/P9WSn6R1wxb3I9Bx0nbPI8cbBNk0jTHu5ZgZablSEQHhj+3dVQ58cwad7x0
 /I+9QNpvAy80iMWiZsiB3o1Yht07uVnmccyrNDkWZvelBc5pLUafY3mhEsfiyJODg4x+
 Atmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=U1L9f3dRdWOpqF8hwt16uqX6nGTTq0rfQ0pyeSsS3VY=;
 b=Zy4y+JqQVxmBhkkeRUsCbfInBQF3F1yN64zBfZ8l700Zft3jpKH6HHTQDX++z/zqWN
 fhDlsj+5hL74MzoXfGJUAhZvWWJB1NmGXVcLCRCQNGhqRBKSc7Krq5cWYsxtwxnIQnof
 CWQ2o0tMxwPR62ZcPPbdtO2Wm19kcsfOqYNPgrDuXKqKFAZgRguUdOtuRtrOpL2JsCiT
 /eeyQA7y5Wrp+mv29t9Zh2JZXnhfBbHJyzgj1Ak/Cfvv2qFbjUbVR2+lfSXz1/0TfsS6
 48vm40Fj5erCcybIGmFJc2Z2B4LJ0Wm8SeHN0mniuqcgAtCjZ7VimBcc9Gf1JDFPcOmt
 lJKg==
X-Gm-Message-State: AGi0PubY8LVdBtxwTE0N1dSoHUbHVmggRpqazoKm9YK8D1odrIFZUCiS
 NnHYiwqkPhqbptB8wkPukcySUw==
X-Google-Smtp-Source: APiQypLQ5XEUEVDEHaDoDNvpu5D4aba5Wua64np+JJ0v9v/1FL7nx0v9iNj4p/hsjMPsZui7j7yfCw==
X-Received: by 2002:a17:90a:d56:: with SMTP id
 22mr3703685pju.187.1588914853490; 
 Thu, 07 May 2020 22:14:13 -0700 (PDT)
Received: from 31_216.localdomain ([47.240.167.159])
 by smtp.gmail.com with ESMTPSA id b15sm477050pfd.139.2020.05.07.22.14.11
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 07 May 2020 22:14:12 -0700 (PDT)
From: Li Feng <fengli@smartx.com>
To: kyle@smartx.com, lifeng1519@gmail.com, dimastep@yandex-team.ru,
 marcandre.lureau@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org (open list:All patches CC here)
Subject: [PATCH v3 2/2] char-socket: initialize reconnect timer only when the
 timer doesn't start
Date: Fri,  8 May 2020 13:14:41 +0800
Message-Id: <20200508051441.8143-3-fengli@smartx.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200508051441.8143-1-fengli@smartx.com>
References: <20200428085122.1621-1-fengli@smartx.com>
 <20200508051441.8143-1-fengli@smartx.com>
Received-SPF: none client-ip=2607:f8b0:4864:20::1044;
 envelope-from=fengli@smartx.com; helo=mail-pj1-x1044.google.com
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
 chardev/char-socket.c |  2 +-
 tests/test-char.c     | 68 ++++++++++++++++++++++++++++++++++++++++-----------
 2 files changed, 55 insertions(+), 15 deletions(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 1f14c2c7c8..d84330b3c9 100644
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
index 8d39bdc9fa..d5c9049eec 100644
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
+static int
 char_socket_ping_pong(QIOChannel *ioc)
 {
     char greeting[sizeof(SOCKET_PING)];
     const char *response = SOCKET_PONG;
 
-    qio_channel_read_all(ioc, greeting, sizeof(greeting), &error_abort);
+    int ret;
+    ret = qio_channel_read_all(ioc, greeting, sizeof(greeting), &error_abort);
+    if (ret != 0) {
+        object_unref(OBJECT(ioc));
+        return -1;
+    }
 
     g_assert(memcmp(greeting, SOCKET_PING, sizeof(greeting)) == 0);
 
     qio_channel_write_all(ioc, response, sizeof(SOCKET_PONG), &error_abort);
-
     object_unref(OBJECT(ioc));
+    return 0;
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
+    if (char_socket_ping_pong(QIO_CHANNEL(cioc)) != 0) {
+        goto retry;
+    }
 
     return NULL;
 }
@@ -869,6 +901,7 @@ typedef struct {
     const char *reconnect;
     bool wait_connected;
     bool fd_pass;
+    char_socket_cb event_cb;
 } CharSocketClientTestConfig;
 
 static void char_socket_client_dupid_test(gconstpointer opaque)
@@ -920,6 +953,7 @@ static void char_socket_client_dupid_test(gconstpointer opaque)
 static void char_socket_client_test(gconstpointer opaque)
 {
     const CharSocketClientTestConfig *config = opaque;
+    const char_socket_cb event_cb = config->event_cb;
     QIOChannelSocket *ioc;
     char *optstr;
     Chardev *chr;
@@ -983,8 +1017,9 @@ static void char_socket_client_test(gconstpointer opaque)
 
  reconnect:
     data.event = -1;
+    data.be = &be;
     qemu_chr_fe_set_handlers(&be, NULL, NULL,
-                             char_socket_event, NULL,
+                             event_cb, NULL,
                              &data, NULL, true);
     if (config->reconnect) {
         g_assert(data.event == -1);
@@ -1022,7 +1057,7 @@ static void char_socket_client_test(gconstpointer opaque)
     /* Setup a callback to receive the reply to our greeting */
     qemu_chr_fe_set_handlers(&be, char_socket_can_read,
                              char_socket_read,
-                             char_socket_event, NULL,
+                             event_cb, NULL,
                              &data, NULL, true);
     g_assert(data.event == CHR_EVENT_OPENED);
     data.event = -1;
@@ -1467,19 +1502,22 @@ int main(int argc, char **argv)
 
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
     static CharSocketClientTestConfig client7 ## name =                 \
-        { addr, ",reconnect=1", false, false };                         \
+        { addr, ",reconnect=1", false, false, char_socket_event };      \
+    static CharSocketClientTestConfig client8 ## name =                 \
+        { addr, ",reconnect=1", true, false,                            \
+            char_socket_event_with_error };                             \
     g_test_add_data_func("/char/socket/client/mainloop/" # name,        \
                          &client1 ##name, char_socket_client_test);     \
     g_test_add_data_func("/char/socket/client/wait-conn/" # name,       \
@@ -1493,7 +1531,9 @@ int main(int argc, char **argv)
     g_test_add_data_func("/char/socket/client/wait-conn-fdpass/" # name, \
                          &client6 ##name, char_socket_client_test);     \
     g_test_add_data_func("/char/socket/client/dupid-reconnect/" # name, \
-                         &client7 ##name, char_socket_client_dupid_test)
+                         &client7 ##name, char_socket_client_dupid_test);\
+    g_test_add_data_func("/char/socket/client/reconnect-error/" # name, \
+                         &client8 ##name, char_socket_client_test)
 
     if (has_ipv4) {
         SOCKET_SERVER_TEST(tcp, &tcpaddr);
-- 
2.11.0


