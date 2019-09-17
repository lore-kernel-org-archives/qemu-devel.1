Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C3DC4CECD
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 01:06:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AB13206C2
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 01:06:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AB13206C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=246tNt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAOQ1-00073t-Vs
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 21:06:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33796)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tnt@246tnt.com>) id 1iAL5V-000449-1d
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 17:32:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tnt@246tnt.com>) id 1iAL5S-0002Sz-UJ
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 17:32:40 -0400
Received: from mailrelay116.isp.belgacom.be ([195.238.20.143]:57589)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tnt@246tnt.com>) id 1iAL5S-0002OQ-Bg
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 17:32:38 -0400
X-Belgacom-Dynamic: yes
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2D1AQA1UIFd/6SgQldlGwEBAQEDAQE?=
 =?us-ascii?q?BBwMBAQGBZ4IYWYEHEiqNHYYTTAEBAQEBB4FrAYk9kSgJAQECAQEBAQE3AQG?=
 =?us-ascii?q?EP4J7JjgTAgwBAQUBAQEBAQUEbYRrT4V4CwEjI09vARKDIoF3GLAIM4pPgTS?=
 =?us-ascii?q?HH4RxeIEHgRGCZGyBBIMqhXkEjGaIMJdZCIIklHUMG5kZAYIGg3mIC5sVIYF?=
 =?us-ascii?q?YMxoIGxWDJ4JLAxeOJEEwkHYBAQ?=
X-IPAS-Result: =?us-ascii?q?A2D1AQA1UIFd/6SgQldlGwEBAQEDAQEBBwMBAQGBZ4IYW?=
 =?us-ascii?q?YEHEiqNHYYTTAEBAQEBB4FrAYk9kSgJAQECAQEBAQE3AQGEP4J7JjgTAgwBA?=
 =?us-ascii?q?QUBAQEBAQUEbYRrT4V4CwEjI09vARKDIoF3GLAIM4pPgTSHH4RxeIEHgRGCZ?=
 =?us-ascii?q?GyBBIMqhXkEjGaIMJdZCIIklHUMG5kZAYIGg3mIC5sVIYFYMxoIGxWDJ4JLA?=
 =?us-ascii?q?xeOJEEwkHYBAQ?=
Received: from 164.160-66-87.adsl-dyn.isp.belgacom.be (HELO
 rei.home.246tnt.com) ([87.66.160.164])
 by relay.skynet.be with ESMTP; 17 Sep 2019 23:32:30 +0200
From: Sylvain Munaut <tnt@246tNt.com>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Date: Tue, 17 Sep 2019 23:32:41 +0200
Message-Id: <20190917213241.2276-1-tnt@246tNt.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 195.238.20.143
X-Mailman-Approved-At: Tue, 17 Sep 2019 21:04:42 -0400
Subject: [Qemu-devel] [PATCH] chardev: Add RFC2217 support for telnet client
 mode
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
Cc: Sylvain Munaut <tnt@246tNt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This allow remote control of the baudrate and other comms
parameters.

Signed-off-by: Sylvain Munaut <tnt@246tNt.com>
---
 chardev/char-socket.c | 232 ++++++++++++++++++++++++++++++++++--------
 chardev/char.c        |   6 ++
 qapi/char.json        |   3 +
 3 files changed, 201 insertions(+), 40 deletions(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 185fe38dda..47e04357a0 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -36,6 +36,7 @@
 #include "qapi/qapi-visit-sockets.h"
 
 #include "chardev/char-io.h"
+#include "chardev/char-serial.h"
 
 /***********************************************************/
 /* TCP Net console */
@@ -74,6 +75,7 @@ typedef struct {
     bool is_listen;
     bool is_telnet;
     bool is_tn3270;
+    bool is_rfc2217;
     GSource *telnet_source;
     TCPChardevTelnetInit *telnet_init;
 
@@ -152,8 +154,8 @@ static void tcp_chr_accept(QIONetListener *listener,
 static int tcp_chr_read_poll(void *opaque);
 static void tcp_chr_disconnect_locked(Chardev *chr);
 
-/* Called with chr_write_lock held.  */
-static int tcp_chr_write(Chardev *chr, const uint8_t *buf, int len)
+/* Must be called with chr_write_lock held.  */
+static int tcp_chr_write_raw(Chardev *chr, const uint8_t *buf, int len)
 {
     SocketChardev *s = SOCKET_CHARDEV(chr);
 
@@ -186,6 +188,45 @@ static int tcp_chr_write(Chardev *chr, const uint8_t *buf, int len)
     }
 }
 
+/* Must be called with chr_write_lock held.  */
+static int tcp_chr_write_telnet(Chardev *chr, const uint8_t *buf, int len)
+{
+    const uint8_t buf_esc[] = { IAC, IAC };
+    int wlen = 0;
+
+    /* Send chunks between IAC bytes */
+    while (len) {
+        uint8_t *end = memchr(buf, IAC, len);
+        int clen = end ? (end - buf) : len;
+
+        if (clen) {
+            wlen += tcp_chr_write_raw(chr, buf, clen);
+            buf += clen;
+            len -= clen;
+        }
+
+        if (end) {
+            wlen += tcp_chr_write_raw(chr, buf_esc, 2);
+            buf += 1;
+            len -= 1;
+        }
+    }
+
+    return wlen;
+}
+
+/* Called with chr_write_lock held.  */
+static int tcp_chr_write(Chardev *chr, const uint8_t *buf, int len)
+{
+    SocketChardev *s = SOCKET_CHARDEV(chr);
+
+    if (s->do_telnetopt) {
+        return tcp_chr_write_telnet(chr, buf, len);
+    } else {
+        return tcp_chr_write_raw(chr, buf, len);
+    }
+}
+
 static int tcp_chr_read_poll(void *opaque)
 {
     Chardev *chr = CHARDEV(opaque);
@@ -222,37 +263,74 @@ static void tcp_chr_process_IAC_bytes(Chardev *chr,
     int j = 0;
 
     for (i = 0; i < *size; i++) {
-        if (s->do_telnetopt > 1) {
-            if ((unsigned char)buf[i] == IAC && s->do_telnetopt == 2) {
+        if (s->do_telnetopt == 2) {
+            /* Generic options */
+            if ((unsigned char)buf[i] == IAC) {
                 /* Double IAC means send an IAC */
                 if (j != i) {
                     buf[j] = buf[i];
                 }
                 j++;
                 s->do_telnetopt = 1;
-            } else {
-                if ((unsigned char)buf[i] == IAC_BREAK
-                    && s->do_telnetopt == 2) {
-                    /* Handle IAC break commands by sending a serial break */
-                    qemu_chr_be_event(chr, CHR_EVENT_BREAK);
-                    s->do_telnetopt++;
-                } else if (s->is_tn3270 && ((unsigned char)buf[i] == IAC_EOR
-                           || (unsigned char)buf[i] == IAC_SB
-                           || (unsigned char)buf[i] == IAC_SE)
-                           && s->do_telnetopt == 2) {
+            } else if ((unsigned char)buf[i] == IAC_BREAK) {
+                /* Handle IAC break commands by sending a serial break */
+                qemu_chr_be_event(chr, CHR_EVENT_BREAK);
+                s->do_telnetopt = 1;
+            } else if (s->is_tn3270) {
+                /* TN3270 specific */
+                if ((unsigned char)buf[i] == IAC_EOR
+                 || (unsigned char)buf[i] == IAC_SB
+                 || (unsigned char)buf[i] == IAC_SE) {
                     buf[j++] = IAC;
                     buf[j++] = buf[i];
-                    s->do_telnetopt++;
-                } else if (s->is_tn3270 && ((unsigned char)buf[i] == IAC_IP
-                           || (unsigned char)buf[i] == IAC_NOP)
-                           && s->do_telnetopt == 2) {
+                    s->do_telnetopt = 1;
+                } else if ((unsigned char)buf[i] == IAC_IP
+                        || (unsigned char)buf[i] == IAC_NOP) {
                     /* TODO: IP and NOP need to be implemented later. */
-                    s->do_telnetopt++;
+                    s->do_telnetopt = 1;
+                }
+            } else if (s->is_rfc2217) {
+                /* RFC2217 specific */
+                if ((unsigned char)buf[i] == IAC_SE) {
+                    /* Shouldn't happen but ... */
+                    s->do_telnetopt = 1;
+                } else if ((unsigned char)buf[i] == IAC_SB) {
+                    s->do_telnetopt = 50;
                 }
-                s->do_telnetopt++;
             }
-            if (s->do_telnetopt >= 4) {
-                s->do_telnetopt = 1;
+        } else if (s->do_telnetopt > 2) {
+            if (s->is_rfc2217) {
+                if (s->do_telnetopt > 100) { /* Skip mode */
+                    s->do_telnetopt--;
+                } else if (s->do_telnetopt == 50) { /* Post-SB */
+                    if ((unsigned char)buf[i] == 0x2c) {
+                        /* This is a COM-Port-Option, look at next byte */
+                        s->do_telnetopt = 51;
+                    } else {
+                        /*
+                         * Unknown option, just skip 1 and wait for IAC SE and
+                         * hope it doesn't happen in the option stream
+                         */
+                        s->do_telnetopt = 101;
+                    }
+                } else if (s->do_telnetopt == 51) { /* SB Options */
+                    /*
+                     * Skip 4 next bytes if this is baudrate option,
+                     * else skip 1 byte
+                     */
+                    s->do_telnetopt = (buf[i] == 0x65) ? 104 : 101;
+                } else if (s->do_telnetopt == 100) { /* Wait for IAC */
+                    if ((unsigned char)buf[i] == IAC) {
+                        s->do_telnetopt = 99;
+                    }
+                } else if (s->do_telnetopt == 99) { /* Wait for SE */
+                    if ((unsigned char)buf[i] == IAC_SE)
+                        s->do_telnetopt = 1;
+                    else if ((unsigned char)buf[i] == IAC)
+                        s->do_telnetopt = 99;
+                    else
+                        s->do_telnetopt = 100;
+                }
             }
         } else {
             if ((unsigned char)buf[i] == IAC) {
@@ -558,6 +636,57 @@ static int tcp_chr_sync_read(Chardev *chr, const uint8_t *buf, int len)
     return size;
 }
 
+static int tcp_chr_ioctl(Chardev *chr, int cmd, void *arg)
+{
+    SocketChardev *s = SOCKET_CHARDEV(chr);
+
+    if (s->is_rfc2217 == 0) {
+        return -ENOTSUP;
+    }
+    if (s->state != TCP_CHARDEV_STATE_CONNECTED) {
+        return 0;
+    }
+
+    switch (cmd) {
+    case CHR_IOCTL_SERIAL_SET_PARAMS:
+        {
+            QEMUSerialSetParams *ssp = arg;
+            const uint8_t buf[] = {
+                /* IAC SB COM-PORT-OPTION SET-BAUD <value(4)> IAC SE */
+                0xff, 0xfa, 0x2c, 0x01,
+                (ssp->speed >> 24) & 0xff,
+                (ssp->speed >> 16) & 0xff,
+                (ssp->speed >>  8) & 0xff,
+                (ssp->speed >>  0) & 0xff,
+                0xff, 0xf0,
+
+                /* IAC SB COM-PORT-OPTION SET-DATASIZE <value> IAC SE */
+                0xff, 0xfa, 0x2c, 0x02,
+                ssp->data_bits,
+                0xff, 0xf0,
+
+                /* IAC SB COM-PORT-OPTION SET-PARITY <value> IAC SE */
+                0xff, 0xfa, 0x2c, 0x03,
+                (ssp->parity == 'O') ? 2 : (ssp->parity == 'E' ? 3 : 1),
+                0xff, 0xf0,
+
+                /* IAC SB COM-PORT-OPTION SET-STOPSIZE <value> IAC SE */
+                0xff, 0xfa, 0x2c, 0x04,
+                ssp->stop_bits,
+                0xff, 0xf0,
+            };
+
+            qemu_mutex_lock(&chr->chr_write_lock);
+            tcp_chr_write_raw(chr, buf, sizeof(buf));
+            qemu_mutex_unlock(&chr->chr_write_lock);
+        }
+        break;
+    default:
+        return -ENOTSUP;
+    }
+    return 0;
+}
+
 static char *qemu_chr_compute_filename(SocketChardev *s)
 {
     struct sockaddr_storage *ss = &s->sioc->localAddr;
@@ -722,16 +851,7 @@ static void tcp_chr_telnet_init(Chardev *chr)
         x[n++] = c;                             \
     } while (0)
 
-    if (!s->is_tn3270) {
-        init->buflen = 12;
-        /* Prep the telnet negotion to put telnet in binary,
-         * no echo, single char mode */
-        IACSET(init->buf, 0xff, 0xfb, 0x01);  /* IAC WILL ECHO */
-        IACSET(init->buf, 0xff, 0xfb, 0x03);  /* IAC WILL Suppress go ahead */
-        IACSET(init->buf, 0xff, 0xfb, 0x00);  /* IAC WILL Binary */
-        IACSET(init->buf, 0xff, 0xfd, 0x00);  /* IAC DO Binary */
-    } else {
-        init->buflen = 21;
+    if (s->is_tn3270) {
         /* Prep the TN3270 negotion based on RFC1576 */
         IACSET(init->buf, 0xff, 0xfd, 0x19);  /* IAC DO EOR */
         IACSET(init->buf, 0xff, 0xfb, 0x19);  /* IAC WILL EOR */
@@ -740,6 +860,30 @@ static void tcp_chr_telnet_init(Chardev *chr)
         IACSET(init->buf, 0xff, 0xfd, 0x18);  /* IAC DO TERMINAL TYPE */
         IACSET(init->buf, 0xff, 0xfa, 0x18);  /* IAC SB TERMINAL TYPE */
         IACSET(init->buf, 0x01, 0xff, 0xf0);  /* SEND IAC SE */
+        init->buflen = n;
+    } else if (s->is_rfc2217) {
+        /*
+         * Prep the telnet negotion to put telnet in binary,
+         * no echo, single char mode with COM port options
+         */
+        IACSET(init->buf, 0xff, 0xfb, 0x00);  /* IAC WILL Binary */
+        IACSET(init->buf, 0xff, 0xfd, 0x00);  /* IAC DO Binary */
+        IACSET(init->buf, 0xff, 0xfc, 0x01);  /* IAC WON'T ECHO */
+        IACSET(init->buf, 0xff, 0xfe, 0x01);  /* IAC DON'T ECHO */
+        IACSET(init->buf, 0xff, 0xfb, 0x03);  /* IAC WILL Suppress go ahead */
+        IACSET(init->buf, 0xff, 0xfd, 0x03);  /* IAC DO Suppress go ahead */
+        IACSET(init->buf, 0xff, 0xfb, 0x2c);  /* IAC WILL COM-Port-Option */
+        init->buflen = n;
+    } else {
+        /*
+         * Prep the telnet negotion to put telnet in binary,
+         * no echo, single char mode
+         */
+        IACSET(init->buf, 0xff, 0xfb, 0x01);  /* IAC WILL ECHO */
+        IACSET(init->buf, 0xff, 0xfb, 0x03);  /* IAC WILL Suppress go ahead */
+        IACSET(init->buf, 0xff, 0xfb, 0x00);  /* IAC WILL Binary */
+        IACSET(init->buf, 0xff, 0xfd, 0x00);  /* IAC DO Binary */
+        init->buflen = n;
     }
 
 #undef IACSET
@@ -964,8 +1108,12 @@ static void tcp_chr_accept_server_sync(Chardev *chr)
 static int tcp_chr_wait_connected(Chardev *chr, Error **errp)
 {
     SocketChardev *s = SOCKET_CHARDEV(chr);
-    const char *opts[] = { "telnet", "tn3270", "websock", "tls-creds" };
-    bool optset[] = { s->is_telnet, s->is_tn3270, s->is_websock, s->tls_creds };
+    const char *opts[] = {
+        "telnet", "tn3270", "rfc2217", "websock", "tls-creds"
+    };
+    bool optset[] = {
+        s->is_telnet, s->is_tn3270, s->is_rfc2217, s->is_websock, s->tls_creds
+    };
     size_t i;
 
     QEMU_BUILD_BUG_ON(G_N_ELEMENTS(opts) != G_N_ELEMENTS(optset));
@@ -1155,15 +1303,11 @@ static gboolean socket_reconnect_timeout(gpointer opaque)
 
 
 static int qmp_chardev_open_socket_server(Chardev *chr,
-                                          bool is_telnet,
                                           bool is_waitconnect,
                                           Error **errp)
 {
     SocketChardev *s = SOCKET_CHARDEV(chr);
     char *name;
-    if (is_telnet) {
-        s->do_telnetopt = 1;
-    }
     s->listener = qio_net_listener_new();
 
     name = g_strdup_printf("chardev-tcp-listener-%s", chr->label);
@@ -1300,6 +1444,7 @@ static void qmp_chardev_open_socket(Chardev *chr,
     bool is_listen      = sock->has_server  ? sock->server  : true;
     bool is_telnet      = sock->has_telnet  ? sock->telnet  : false;
     bool is_tn3270      = sock->has_tn3270  ? sock->tn3270  : false;
+    bool is_rfc2217     = sock->has_rfc2217 ? sock->rfc2217 : false;
     bool is_waitconnect = sock->has_wait    ? sock->wait    : false;
     bool is_websock     = sock->has_websocket ? sock->websocket : false;
     int64_t reconnect   = sock->has_reconnect ? sock->reconnect : 0;
@@ -1308,6 +1453,7 @@ static void qmp_chardev_open_socket(Chardev *chr,
     s->is_listen = is_listen;
     s->is_telnet = is_telnet;
     s->is_tn3270 = is_tn3270;
+    s->is_rfc2217 = is_rfc2217;
     s->is_websock = is_websock;
     s->do_nodelay = do_nodelay;
     if (sock->tls_creds) {
@@ -1361,9 +1507,12 @@ static void qmp_chardev_open_socket(Chardev *chr,
 
     update_disconnected_filename(s);
 
+    if (s->is_listen ? (is_telnet || is_tn3270) : is_rfc2217) {
+        s->do_telnetopt = 1;
+    }
+
     if (s->is_listen) {
-        if (qmp_chardev_open_socket_server(chr, is_telnet || is_tn3270,
-                                           is_waitconnect, errp) < 0) {
+        if (qmp_chardev_open_socket_server(chr, is_waitconnect, errp) < 0) {
             return;
         }
     } else {
@@ -1410,6 +1559,8 @@ static void qemu_chr_parse_socket(QemuOpts *opts, ChardevBackend *backend,
     sock->telnet = qemu_opt_get_bool(opts, "telnet", false);
     sock->has_tn3270 = qemu_opt_get(opts, "tn3270");
     sock->tn3270 = qemu_opt_get_bool(opts, "tn3270", false);
+    sock->has_rfc2217 = qemu_opt_get(opts, "rfc2217");
+    sock->rfc2217 = qemu_opt_get_bool(opts, "rfc2217", false);
     sock->has_websocket = qemu_opt_get(opts, "websocket");
     sock->websocket = qemu_opt_get_bool(opts, "websocket", false);
     /*
@@ -1480,6 +1631,7 @@ static void char_socket_class_init(ObjectClass *oc, void *data)
     cc->chr_wait_connected = tcp_chr_wait_connected;
     cc->chr_write = tcp_chr_write;
     cc->chr_sync_read = tcp_chr_sync_read;
+    cc->chr_ioctl = tcp_chr_ioctl;
     cc->chr_disconnect = tcp_chr_disconnect;
     cc->get_msgfds = tcp_get_msgfds;
     cc->set_msgfds = tcp_set_msgfds;
diff --git a/chardev/char.c b/chardev/char.c
index 7b6b2cb123..b101641784 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -423,6 +423,7 @@ QemuOpts *qemu_chr_parse_compat(const char *label, const char *filename,
     if (strstart(filename, "tcp:", &p) ||
         strstart(filename, "telnet:", &p) ||
         strstart(filename, "tn3270:", &p) ||
+        strstart(filename, "rfc2217:", &p) ||
         strstart(filename, "websocket:", &p)) {
         if (sscanf(p, "%64[^:]:%32[^,]%n", host, port, &pos) < 2) {
             host[0] = 0;
@@ -443,6 +444,8 @@ QemuOpts *qemu_chr_parse_compat(const char *label, const char *filename,
             qemu_opt_set(opts, "telnet", "on", &error_abort);
         } else if (strstart(filename, "tn3270:", &p)) {
             qemu_opt_set(opts, "tn3270", "on", &error_abort);
+        } else if (strstart(filename, "rfc2217:", &p)) {
+            qemu_opt_set(opts, "rfc2217", "on", &error_abort);
         } else if (strstart(filename, "websocket:", &p)) {
             qemu_opt_set(opts, "websocket", "on", &error_abort);
         }
@@ -879,6 +882,9 @@ QemuOptsList qemu_chardev_opts = {
         },{
             .name = "tn3270",
             .type = QEMU_OPT_BOOL,
+        },{
+            .name = "rfc2217",
+            .type = QEMU_OPT_BOOL,
         },{
             .name = "tls-creds",
             .type = QEMU_OPT_STRING,
diff --git a/qapi/char.json b/qapi/char.json
index a6e81ac7bc..4a6b50bc3e 100644
--- a/qapi/char.json
+++ b/qapi/char.json
@@ -261,6 +261,8 @@
 #          sockets (default: false)
 # @tn3270: enable tn3270 protocol on server
 #          sockets (default: false) (Since: 2.10)
+# @rfc2217: enable RFC2217 protocol on client
+#          sockets (default: false) (Since: ???)
 # @websocket: enable websocket protocol on server
 #           sockets (default: false) (Since: 3.1)
 # @reconnect: For a client socket, if a socket is disconnected,
@@ -279,6 +281,7 @@
             '*nodelay': 'bool',
             '*telnet': 'bool',
             '*tn3270': 'bool',
+            '*rfc2217': 'bool',
             '*websocket': 'bool',
             '*reconnect': 'int' },
   'base': 'ChardevCommon' }
-- 
2.21.0


