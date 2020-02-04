Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E82C35247
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 21:20:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D95DF2082E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 21:20:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D95DF2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iz5cc-00084a-UD
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 16:20:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51523)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iz5bH-0007EQ-QO
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 16:19:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iz5bG-0008QX-Gu
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 16:19:15 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:41075)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iz5bF-0008Ex-EE
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 16:19:14 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M8hlZ-1iuOdd3edN-004hVN; Tue, 04 Feb 2020 22:19:05 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] linux-user: implement TARGET_SO_PEERSEC
Date: Tue,  4 Feb 2020 22:19:01 +0100
Message-Id: <20200204211901.1731821-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:5eErrupiYmsKUulWaHIpMq++a/iqtWgwPK9P0ZZRVbL+d28F0Fr
 7BNw+0rRBNWDVe2Ebt4u4cx6yGpDQJrhev2GbWv3+XAPLfGvAd2cTUpxWV/w0igbeLenRUv
 d24uNE6qhXC5gesisizpqKb6fKJxBFJC94S0hm6R8Ny63+wQkwjHmFvSF7jdP/nsHOAYuFx
 TAOz/lukqlX1wi0i4YEXQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zQ0oSMqNtI0=:c8CFX7Zscjn6iLlWmfjV3h
 xEaBpYp5qA6T/eJXkKHe+rwTMNmpkjHQOBVVJX00T8UEHaVKjp/k5+cjiXqafskQscoglkJYK
 ysefsfOgYcboqU6MjAdJIUhVoRmrTmkoY4ItFLmW+OetMOfq07aKsIU9ChjHWKknhJj1YqIV+
 U/hIpZaVds9aqcoo3iPnw8K431c22u0hqQ45NUbJ6hTuQzWzYldGav4TXuZkqslSrQxCWbqjV
 iJFGxoKpmcd9WXXlp7vgzXP1VGaHujKEIwQT1+5ErM1/ljHJmG3vIUDM+N4/OYLvYnaI0FFPL
 4eVAOLEi8G26+CpUD8hbeBApUyj2uCkDJBXTl2VDM4Ra3GtS71spXHvwWHrB6basy5fz6ent/
 qO7xCB1gMQvMftmxl0AWrnaRwimSPTn52Yl8P1WqEUk1WVreycNZWvq2rWPsizT1ESx5D+2HK
 aibXfV4ZVC2hEo11sFVfQDHTjUl0F5WkqLgSVMvQW6K9Ncmbhc9yvTxNZfaEzaXhEvw6Z+TlO
 5o6OEEhdgntd4fES4oWnocNqo1/7sq+gC5cQlKZp7W8XmTAxk7dICJIfNTNswsUG/omoHiV0+
 VNqh359yGAKUQCDNpsa+X0n0N1h2zsdk58E3RcczH0gVHAz7DXxKt4dtK0iyQb6SfkrqUAZoz
 OPF8vSHLu77Tn5PDb3k2ywZ26iArpOxEaKmXmk3pSbeZm2on+X39S++f165waXe3mwF7OYJ6h
 Olhdg9hcEIH9AoNLoEZbLHz70TUiGhKyzmAMq3GDy1EYnkfYy4rB8UvkI8kJqqyuzGSKH9Gg8
 F5x+SkEB3+jvINhhR7jwLDKg7zpPyW5D7xtx2mi5dfiHXhMLN2VMfSjwpnyOiX3iX0OOMdJ
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.134
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
Cc: Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Matthias=20L=C3=BCscher?= <lueschem@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

"The purpose of this option is to allow an application to obtain the
security credentials of a Unix stream socket peer.  It is analogous to
SO_PEERCRED (which provides authentication using standard Unix credentials
of pid, uid and gid), and extends this concept to other security
models." -- https://lwn.net/Articles/62370/

Until now it was passed to the kernel with an "int" argument and
fails when it was supported by the host because the parameter is
like a filename: it is always a \0-terminated string with no embedded
\0 characters, but is not guaranteed to be ASCII or UTF-8.

I've tested the option with the following program:

    /*
     * cc -o getpeercon getpeercon.c
     */

    #include <stdio.h>
    #include <sys/types.h>
    #include <sys/socket.h>
    #include <netinet/in.h>
    #include <arpa/inet.h>

    int main(void)
    {
        int fd;
        struct sockaddr_in server, addr;
        int ret;
        socklen_t len;
        char buf[256];

        fd = socket(PF_INET, SOCK_STREAM, 0);
        if (fd == -1) {
            perror("socket");
            return 1;
        }

        server.sin_family = AF_INET;
        inet_aton("127.0.0.1", &server.sin_addr);
        server.sin_port = htons(40390);

        connect(fd, (struct sockaddr*)&server, sizeof(server));

        len = sizeof(buf);
        ret = getsockopt(fd, SOL_SOCKET, SO_PEERSEC, buf, &len);
        if (ret == -1) {
            perror("getsockopt");
            return 1;
        }
        printf("%d %s\n", len, buf);
        return 0;
    }

On host:

  $ ./getpeercon
  33 system_u:object_r:unlabeled_t:s0

With qemu-aarch64/bionic without the patch:

  $ ./getpeercon
  getsockopt: Numerical result out of range

With the patch:

  $ ./getpeercon
  33 system_u:object_r:unlabeled_t:s0

Bug: https://bugs.launchpad.net/qemu/+bug/1823790
Reported-by: Matthias Lüscher <lueschem@gmail.com>
Tested-by: Matthias Lüscher <lueschem@gmail.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---

Notes:
    v2: use correct length in unlock_user()

 linux-user/syscall.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index d60142f0691c..c930577686da 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -2344,6 +2344,28 @@ static abi_long do_getsockopt(int sockfd, int level, int optname,
             }
             break;
         }
+        case TARGET_SO_PEERSEC: {
+            char *name;
+
+            if (get_user_u32(len, optlen)) {
+                return -TARGET_EFAULT;
+            }
+            if (len < 0) {
+                return -TARGET_EINVAL;
+            }
+            name = lock_user(VERIFY_WRITE, optval_addr, len, 0);
+            if (!name) {
+                return -TARGET_EFAULT;
+            }
+            lv = len;
+            ret = get_errno(getsockopt(sockfd, level, SO_PEERSEC,
+                                       name, &lv));
+            if (put_user_u32(lv, optlen)) {
+                ret = -TARGET_EFAULT;
+            }
+            unlock_user(name, optval_addr, lv);
+            break;
+        }
         case TARGET_SO_LINGER:
         {
             struct linger lg;
-- 
2.24.1


