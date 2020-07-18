Return-Path: <SRS0=NumX=A5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D657C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2020 13:22:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 481242070E
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2020 13:22:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DObcIK9D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 481242070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwmn8-00074k-2I
	for qemu-devel@archiver.kernel.org; Sat, 18 Jul 2020 09:22:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36776)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <devnexen@gmail.com>)
 id 1jwmm6-0006EZ-6F; Sat, 18 Jul 2020 09:21:10 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630]:45743)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <devnexen@gmail.com>)
 id 1jwmm4-0007Me-I9; Sat, 18 Jul 2020 09:21:09 -0400
Received: by mail-ej1-x630.google.com with SMTP id a1so13671644ejg.12;
 Sat, 18 Jul 2020 06:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=XcgRvqpT/zuK2I8QULDKzDPp0EbZm3OHA5PQZ3s3xYI=;
 b=DObcIK9D99TsI8A6ysy0vC1ft1tXR3vZ5tUu0e/7jCSM+9u0iSdWIRfqSDdvh6tle0
 thiWt4R43mGo80xJh0kdM5oNW3I15pvF+W5pL8h7afvm15C68mU34mXuXA/vPGfJOrev
 eQqsEfRtTLff+e2p/V+GMslCt3QuT+D2yTkNSxM8o840twdoLzhkWKqr1xHdBmtjmgPZ
 Sgs10FhatRQenQ+L/jQEFaNgr+E/N4LzCycsdBhPG3eMQso/gFNfN7E9EDiA5HVVBHeT
 Fy0yWBUZCvG9y1G7FDsI5A16nF/47CRdhykNylTzTYilLl0Q24qFnDehELi4acegGuPz
 VsHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=XcgRvqpT/zuK2I8QULDKzDPp0EbZm3OHA5PQZ3s3xYI=;
 b=Sa+fxmImhJXYtjyqQERc6rmpoQZEp4xAT0gS87jomIq+G220/+B8WD7cWJODnpeib+
 j+DZ2gTAdqcQZI/GQLSP082bsGvjaQa6MX7CdBkC2GCkCRXo0SPJM0yx2a1FaNLDQMVz
 DsFk9kelS6tP4hgVN+oC7U/4m0waYy/yeC+IPp/+lN2t4X6ZDJR3IhnhL5TNCJ/Xz+zL
 zB7h+2CpzXVlNEP+kp3ipwn7SRomrcvm+RDALo4DjjRwP8kKVKwVsIfZis/WiXez3j/k
 1aJK4+xe5lhi8nRkMvmT2Bllpv9GSkfwsCfkx8FTKwd3hLLqF4auluPSQyVxZw61j50O
 V4gw==
X-Gm-Message-State: AOAM530pBZUWApGoLuQtGYTn/tisqz99y4asdNCrQ/roVeG8CJ0Z31G0
 U0jbNIvHt7y4RVM2IWSEF2BSKccJ2Pu+CcVL1gRAbfUMPBM=
X-Google-Smtp-Source: ABdhPJxeRhY3Wn2l1ebZa/dsva9KenrsOZSGUrJQl9GiaWFddA04OVZBd4Z2G39CHGPRVDZw/envxT6Z7TymZW34HFA=
X-Received: by 2002:a17:907:100a:: with SMTP id
 ox10mr12576469ejb.351.1595078466385; 
 Sat, 18 Jul 2020 06:21:06 -0700 (PDT)
MIME-Version: 1.0
From: David CARLIER <devnexen@gmail.com>
Date: Sat, 18 Jul 2020 14:20:55 +0100
Message-ID: <CA+XhMqzHPG5ezqY-YxbA+tMoadA3VDFWBX8_LaLC5YsQOMrz+A@mail.gmail.com>
Subject: [PATCH 3/3] contrib: ivshmem client and server build fix for SunOS.
To: qemu-devel <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=devnexen@gmail.com; helo=mail-ej1-x630.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From 1c5225132a01ad67c87d603659ef4e4bcd46a16d Mon Sep 17 00:00:00 2001
From: David Carlier <devnexen@gmail.com>
Date: Sat, 18 Jul 2020 13:32:47 +0100
Subject: [PATCH 3/3] contrib: ivshmem client and server build fix for SunOS.

sun is a macro on these systems, thus renaming the variables on the
 client and server.

Signed-off-by: David Carlier <devnexen@gmail.com>
---
 contrib/ivshmem-client/ivshmem-client.c | 12 ++++++------
 contrib/ivshmem-server/ivshmem-server.c | 12 ++++++------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/contrib/ivshmem-client/ivshmem-client.c
b/contrib/ivshmem-client/ivshmem-client.c
index b1274b236a..182c79d27c 100644
--- a/contrib/ivshmem-client/ivshmem-client.c
+++ b/contrib/ivshmem-client/ivshmem-client.c
@@ -178,7 +178,7 @@ ivshmem_client_init(IvshmemClient *client, const
char *unix_sock_path,
 int
 ivshmem_client_connect(IvshmemClient *client)
 {
-    struct sockaddr_un sun;
+    struct sockaddr_un s_un;
     int fd, ret;
     int64_t tmp;

@@ -192,16 +192,16 @@ ivshmem_client_connect(IvshmemClient *client)
         return -1;
     }

-    sun.sun_family = AF_UNIX;
-    ret = snprintf(sun.sun_path, sizeof(sun.sun_path), "%s",
+    s_un.sun_family = AF_UNIX;
+    ret = snprintf(s_un.sun_path, sizeof(s_un.sun_path), "%s",
                    client->unix_sock_path);
-    if (ret < 0 || ret >= sizeof(sun.sun_path)) {
+    if (ret < 0 || ret >= sizeof(s_un.sun_path)) {
         IVSHMEM_CLIENT_DEBUG(client, "could not copy unix socket path\n");
         goto err_close;
     }

-    if (connect(client->sock_fd, (struct sockaddr *)&sun, sizeof(sun)) < 0) {
-        IVSHMEM_CLIENT_DEBUG(client, "cannot connect to %s: %s\n",
sun.sun_path,
+    if (connect(client->sock_fd, (struct sockaddr *)&s_un, sizeof(s_un)) < 0) {
+        IVSHMEM_CLIENT_DEBUG(client, "cannot connect to %s: %s\n",
s_un.sun_path,
                              strerror(errno));
         goto err_close;
     }
diff --git a/contrib/ivshmem-server/ivshmem-server.c
b/contrib/ivshmem-server/ivshmem-server.c
index 88daee812d..39a6ffdb5d 100644
--- a/contrib/ivshmem-server/ivshmem-server.c
+++ b/contrib/ivshmem-server/ivshmem-server.c
@@ -288,7 +288,7 @@ ivshmem_server_init(IvshmemServer *server, const
char *unix_sock_path,
 int
 ivshmem_server_start(IvshmemServer *server)
 {
-    struct sockaddr_un sun;
+    struct sockaddr_un s_un;
     int shm_fd, sock_fd, ret;

     /* open shm file */
@@ -327,15 +327,15 @@ ivshmem_server_start(IvshmemServer *server)
         goto err_close_shm;
     }

-    sun.sun_family = AF_UNIX;
-    ret = snprintf(sun.sun_path, sizeof(sun.sun_path), "%s",
+    s_un.sun_family = AF_UNIX;
+    ret = snprintf(s_un.sun_path, sizeof(s_un.sun_path), "%s",
                    server->unix_sock_path);
-    if (ret < 0 || ret >= sizeof(sun.sun_path)) {
+    if (ret < 0 || ret >= sizeof(s_un.sun_path)) {
         IVSHMEM_SERVER_DEBUG(server, "could not copy unix socket path\n");
         goto err_close_sock;
     }
-    if (bind(sock_fd, (struct sockaddr *)&sun, sizeof(sun)) < 0) {
-        IVSHMEM_SERVER_DEBUG(server, "cannot connect to %s: %s\n",
sun.sun_path,
+    if (bind(sock_fd, (struct sockaddr *)&s_un, sizeof(s_un)) < 0) {
+        IVSHMEM_SERVER_DEBUG(server, "cannot connect to %s: %s\n",
s_un.sun_path,
                              strerror(errno));
         goto err_close_sock;
     }
-- 
2.25.4

