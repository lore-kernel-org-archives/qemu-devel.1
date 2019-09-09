Return-Path: <SRS0=McoT=XE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E83F9C4740A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 13:59:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B773921479
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 13:59:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="apfXsj9q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B773921479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7KCZ-0001wI-Sp
	for qemu-devel@archiver.kernel.org; Mon, 09 Sep 2019 09:59:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36009)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i7KBv-0001Xp-J3
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 09:58:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i7KBu-0008NK-Bc
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 09:58:51 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:37363)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i7KBu-0008MJ-6P
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 09:58:50 -0400
Received: by mail-wr1-x435.google.com with SMTP id i1so13388236wro.4
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2019 06:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=NcRkfxNGkCAOj5xV0MBZt2PYLqISwIWbDzdwhNpPETM=;
 b=apfXsj9qxu5u4/6BDCJ3bveoDw7s+sxetWLScNdWWIfuU82+ql7etqc16UGzOsaHwd
 hCdJw8gH+kV/tLQ5ENoDRpX3pF+E7E68OmDXfjCJIRsH18hyME3dH/AM/UvrNzivdzF+
 9AfvCKo6hbIUUy3p8uUhkWaLzhqB3osPu7rDgsi/gAMNE/886gqX9vdf+4Kpu0aQf/VC
 VtEbkfX67LD8xjE3sqSjmx9WMJ41fWu54DTRwLD1b+hjbfwKBDc9TgldNNc84Blx3BEs
 tJe6m6vR7gh+FhCbt7N3arwD9s9RmJ9hj9B/nQmFAph6ZG6mKQZ/Ml4Y5SPKWA3YqsJN
 AWFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=NcRkfxNGkCAOj5xV0MBZt2PYLqISwIWbDzdwhNpPETM=;
 b=CkcyZ/ZDakgjOd9DUFJZm/XLWLMAmm90chjG05L1cOJO5qJ+CZRyEsgfk/kDBhZQzP
 uCYmbnX0ky2Ntj1xLczQVvAXlJ/TE93/4Bd6C7UlERh0oYztafr5j6t7wDHgjDmbumvc
 iG4gQgaQgcT9VdhrViV8uAs2Euw0kZH21IcEEVKg6T42+Oqg3JMPQmg2WW57zacirYUd
 PLJ/n+JPeW3V9raCjh848vkj+JXWeFma7yYuO6GMfipcpopljL1Su5V/xf7nEYGld4xk
 KntYT6dThwSDUqAzuUueW/zDfNoESP5phABZuiT2RZ91FUanU2fWj3kjh39CrR0hsmet
 kx5A==
X-Gm-Message-State: APjAAAWUMTC2lzfInsPU6jFPEeaOD0w5+vKzSA9NbxoNTLK6BdEDJCv0
 vYADjv+9Krkq7OjFDj30vH8GvQ==
X-Google-Smtp-Source: APXvYqziXRG6zMoVmYoC8eB6k58qJzUXUUPoqN1KmZ9MbCJas5ve9Z3LxvhJXRoa7ZFt6Q0Y3paEaw==
X-Received: by 2002:a5d:6811:: with SMTP id w17mr14952656wru.181.1568037529022; 
 Mon, 09 Sep 2019 06:58:49 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id x5sm19851027wrg.69.2019.09.09.06.58.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2019 06:58:48 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id CE7991FF87;
 Mon,  9 Sep 2019 14:58:47 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon,  9 Sep 2019 14:58:42 +0100
Message-Id: <20190909135842.25469-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::435
Subject: [Qemu-devel] [qemu-web PATCH v2] add support page
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
Cc: pbonzini@redhat.com, thuth@redhat.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is intended to be a useful page we can link to in the banner of
the IRC channel explaining the various support options someone might
have.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

---
v2
  - add cleanups suggested by Stefan
---
 support.md | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 support.md

diff --git a/support.md b/support.md
new file mode 100644
index 0000000..9174bbb
--- /dev/null
+++ b/support.md
@@ -0,0 +1,40 @@
+---
+title: Support
+permalink: /support/
+---
+
+If you have a support question that is not answered by our
+[documentation](/documentation) you have a number of options available
+to you.
+
+If the question is specifically about the integration of QEMU with the
+rest of your Linux distribution you may be better served by asking
+through your distribution's support channels. This includes questions
+about a specifically packaged version of QEMU. The QEMU developers are
+generally concerned with the latest release and the current state of
+the [master branch](https://git.qemu.org/?p=qemu.git) and do not
+provide support for QEMU binaries shipped by Linux distributions.
+
+Questions about complex configurations of networking and storage are
+usually met with a recommendation to use management tools like
+[virt-manager](https://virt-manager.org/) from the [libvirt
+project](https://libvirt.org/) to configure and run QEMU. Management
+tools handle the low-level details of setting up devices that most
+users should not need to learn.
+
+* There is a
+[qemu-discuss@nongnu.org](https://lists.nongnu.org/mailman/listinfo/qemu-discuss)
+mailing list for user focused questions<br>
+If your question is more technical or architecture specific you may
+want to send your question to another of [QEMU's mailing
+lists](https://wiki.qemu.org/MailingLists)
+
+* A lot of developers hang around on IRC (network: irc.oftc.net,
+channel #qemu)<br> QEMU developers tend to hold normal office hours
+and are distributed around the world. Please be patient as you may
+have to wait some time for a response. If you can't leave IRC open and
+wait you may be better served by a mailing list.
+
+* If you think you have found a bug you can report it on [our bug
+  tracker](https://bugs.launchpad.net/qemu/)<br>
+Please see our guide on [how to report a bug](/contribute/report-a-bug/)
-- 
2.20.1


