Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92053C352AA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 17:07:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 628312086A
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 17:07:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QKkS8f+7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 628312086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFi64-0005Nh-0r
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 13:07:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35522)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iFhrV-0005fP-Ie
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 12:52:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iFhrU-0003bG-8v
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 12:52:25 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:35043)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iFhrU-0003aU-2o
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 12:52:24 -0400
Received: by mail-wm1-x330.google.com with SMTP id y21so7719816wmi.0
 for <qemu-devel@nongnu.org>; Wed, 02 Oct 2019 09:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=EdmGHfqAaar2VkfjETjdywF+GwsiDwVFg4LO4quUL88=;
 b=QKkS8f+72AoBw4GM1ve5VKEAFO8EBGZdgbHdmcqXRRqyx5B4pbgwdPAHJ11FtzBqye
 nBckuCVjI4i20UOKmVUP+l/nwttfAsHzcWw2btoTsPgCSE0tQrWCCGQ+aohnhienxRXo
 28G6c/KH0+S4JFkPsIS+kkdYv0YaeMJAYj34TX5yp4mncsgiaTlu2sLM6n0JZBx9l37j
 iQUzaBjrmpp8nWnr6RcGbPSXl/fbaVH11tjj7jYaDelTeae8Q73zapKus5Shu5yLmgcA
 +MD5W+8HfwdJQHCfdIKK76MS+kGRxjEhLXGkEDsRqhzwAes4oP/b+wa3FFOAwpPtg/ip
 bzvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=EdmGHfqAaar2VkfjETjdywF+GwsiDwVFg4LO4quUL88=;
 b=NC6qywyt+JVD30+8dhEKtALHzrHrUEzbYO1p0hYKA79au4SAOyoqaJkO7Jws5bC21c
 TidzJrB0pGV23XikHKd1IZ03BJI/7glMkJSYW2GXixORoUfBcnJH1isrN2LRtLvJlVWX
 OxyGQh1H81o0La7eN4jV+cNQXV966mDRM0PYemO83EQlVOiu5ZUqzlZ+pBZMmLfTd2gY
 JZ+fh1JlgshXojvwT38xYs7GaenuXFE7ARWq805fIRA1nDAsYuy/luoTo6W9UEqNS4NS
 kV9Yczj4WQOaOKDq0Ikg+Wz/+r1pdtOnU1OejiRCdeT5hR9Ipm6sNoR6E9ohdw+n3ssf
 5Gbw==
X-Gm-Message-State: APjAAAXmut8bMIOYl9D92rHhEG8CrRQLA2i5EBjoayCTOXA3N9g9YKHI
 8Y+TNgNWPdyKyDEfsNPjY7LBu2Cj
X-Google-Smtp-Source: APXvYqxP8tUdUrGNbSgz8AYfuJh4Tu38RXMuMg1Q5YXjtK90l7hxHn0wTWPN/MziKavuw26RATVLmA==
X-Received: by 2002:a1c:4383:: with SMTP id q125mr3422048wma.122.1570035142792; 
 Wed, 02 Oct 2019 09:52:22 -0700 (PDT)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id g4sm27303990wrw.9.2019.10.02.09.52.21
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 02 Oct 2019 09:52:21 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 26/30] util: WSAEWOULDBLOCK on connect should map to EINPROGRESS
Date: Wed,  2 Oct 2019 18:51:49 +0200
Message-Id: <1570035113-56848-27-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1570035113-56848-1-git-send-email-pbonzini@redhat.com>
References: <1570035113-56848-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::330
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

In general, WSAEWOULDBLOCK can be mapped to EAGAIN as done by
socket_error() (or EWOULDBLOCK). But for connect() with non-blocking
sockets, it actually means the operation is in progress:

https://docs.microsoft.com/en-us/windows/win32/api/winsock2/nf-winsock2-connect
"The socket is marked as nonblocking and the connection cannot be completed immediately."

(this is also the behaviour implemented by GLib GSocket)

This fixes socket_can_bind_connect() test on win32.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 util/oslib-win32.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/util/oslib-win32.c b/util/oslib-win32.c
index c62cd43..886e400 100644
--- a/util/oslib-win32.c
+++ b/util/oslib-win32.c
@@ -585,7 +585,11 @@ int qemu_connect_wrap(int sockfd, const struct sockaddr *addr,
     int ret;
     ret = connect(sockfd, addr, addrlen);
     if (ret < 0) {
-        errno = socket_error();
+        if (WSAGetLastError() == WSAEWOULDBLOCK) {
+            errno = EINPROGRESS;
+        } else {
+            errno = socket_error();
+        }
     }
     return ret;
 }
-- 
1.8.3.1



