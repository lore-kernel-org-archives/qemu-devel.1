Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02624C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 14:58:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5E3420679
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 14:58:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bjZruRqj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5E3420679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlD2G-0000Qr-28
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 10:58:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58198)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlCQo-0003mn-DE; Tue, 16 Jun 2020 10:19:18 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:41885)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlCQm-0006zn-SL; Tue, 16 Jun 2020 10:19:18 -0400
Received: by mail-ot1-x344.google.com with SMTP id k15so16045045otp.8;
 Tue, 16 Jun 2020 07:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pvDvIVsYLo2LhgX9D3O1NAAgSIWbNm7XON8tX/XB+Pc=;
 b=bjZruRqjP8gjhXrNrB5WShNyrYDmmcmex0Gw5nm7lWF5Xy2Gqw3GGLtz7tjL1PI1bc
 bnjsfo14LMWExb8i/PAoNoN/zz9HWTLMsO8cIJss2gs+tEe9VUooX242aTZIdv0qq9CE
 Wut2LaJ2BUAoVpPlU5uou6bCZJt5RT7tVJdZsZbpJr3se+LTRM+2sLtUGdpaEboocBw6
 FbPtVk4jhvXdO6fBxMEiX48A0c8tyMCp/lrP+zb2637fYh8aOYX0ancxmsNYJeZ/D5ga
 xWoayi+Gqno1Jqn/LUjKGhnllwsW5qT2mYBLF7354/c2STRD+k6vID3VmOB9o8bm4rRE
 0uvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=pvDvIVsYLo2LhgX9D3O1NAAgSIWbNm7XON8tX/XB+Pc=;
 b=l3XKAj3AQ1dro9+AFk2aAdlFrtpjdwqYk4gUcc4jfqVLH+eT8U0LhVaKgJSIp/PCaB
 tIo+jO7Cu8cPEOB4Gc0teVdrnjHUwg6RO5GBpEYTuqEiB7F0r4o59mwjlsEaKIpXiQy/
 mfJ05Bo7AIGQa97BRsQ58piQM7R0RekXqYDwFmSLLMSj32Zvj5S+yC+ZIF0aifcghxXG
 0OZpCv8KEstWn6GDDlJfNEXAemulxBy4B2CGVjFyl4cJX23qOevAy3hutmNPzSZEvCSN
 kQkpKpbB1XDHCntGKihPlbumBOo2if0JLG6xz9PSHEoYMVf8kFMf3aAVuhmIkVi5OjpU
 qemA==
X-Gm-Message-State: AOAM532RmhlzK1Mruh4Q1wS4uXjIJQBGABdAQslA7DaTHol68jOev9mO
 +jxWIW3j/kg1f6gvLjjqfyD1aTHP
X-Google-Smtp-Source: ABdhPJzFNN0oMyUGfy8AmEXBticP/I4iSYzdT/5A3E1cRr59mQNcxkR9rjHiUU2IqfKXvGNTyMqNoA==
X-Received: by 2002:a05:6830:2368:: with SMTP id
 r8mr2677944oth.120.1592317154765; 
 Tue, 16 Jun 2020 07:19:14 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id l65sm4282070oig.27.2020.06.16.07.19.12
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 16 Jun 2020 07:19:13 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 62/78] qemu-ga: document vsock-listen in the man page
Date: Tue, 16 Jun 2020 09:15:31 -0500
Message-Id: <20200616141547.24664-63-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
References: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::344;
 envelope-from=flukshun@gmail.com; helo=mail-ot1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-stable@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefan Hajnoczi <stefanha@redhat.com>

Although qemu-ga has supported vsock since 2016 it was not documented on
the man page.

Also add the socket address representation to the qga --help output.

Fixes: 586ef5dee77180fc32e33bc08051600030630239
       ("qga: add vsock-listen method")
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
(cherry picked from commit 7b46aadbbfb7b06cd45a3b113b1f7c003c68f603)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 docs/interop/qemu-ga.rst | 5 +++--
 qga/main.c               | 4 +++-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/docs/interop/qemu-ga.rst b/docs/interop/qemu-ga.rst
index 1313a4ae1c..3063357bb5 100644
--- a/docs/interop/qemu-ga.rst
+++ b/docs/interop/qemu-ga.rst
@@ -36,13 +36,14 @@ Options
 .. option:: -m, --method=METHOD
 
   Transport method: one of ``unix-listen``, ``virtio-serial``, or
-  ``isa-serial`` (``virtio-serial`` is the default).
+  ``isa-serial``, or ``vsock-listen`` (``virtio-serial`` is the default).
 
 .. option:: -p, --path=PATH
 
   Device/socket path (the default for virtio-serial is
   ``/dev/virtio-ports/org.qemu.guest_agent.0``,
-  the default for isa-serial is ``/dev/ttyS0``)
+  the default for isa-serial is ``/dev/ttyS0``). Socket addresses for
+  vsock-listen are written as ``<cid>:<port>``.
 
 .. option:: -l, --logfile=PATH
 
diff --git a/qga/main.c b/qga/main.c
index c35c2a2120..6b9f025a70 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -234,7 +234,9 @@ QEMU_COPYRIGHT "\n"
 "  -p, --path        device/socket path (the default for virtio-serial is:\n"
 "                    %s,\n"
 "                    the default for isa-serial is:\n"
-"                    %s)\n"
+"                    %s).\n"
+"                    Socket addresses for vsock-listen are written as\n"
+"                    <cid>:<port>.\n"
 "  -l, --logfile     set logfile path, logs to stderr by default\n"
 "  -f, --pidfile     specify pidfile (default is %s)\n"
 #ifdef CONFIG_FSFREEZE
-- 
2.17.1


