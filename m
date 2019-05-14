Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F08AEC04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 19:25:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB00320873
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 19:25:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V27bejYP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB00320873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53035 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQd3a-0000xY-Ui
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 15:25:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48750)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQcv9-0002TJ-OJ
	for qemu-devel@nongnu.org; Tue, 14 May 2019 15:17:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQcv8-0006fl-Tl
	for qemu-devel@nongnu.org; Tue, 14 May 2019 15:17:03 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:38783)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hQcv8-0006e9-OA
	for qemu-devel@nongnu.org; Tue, 14 May 2019 15:17:02 -0400
Received: by mail-pl1-x643.google.com with SMTP id f97so79423plb.5
	for <qemu-devel@nongnu.org>; Tue, 14 May 2019 12:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=p/AR+QB1/uCfqQ+ytrGBnYCYqwPtnBM3b7CBgieQEw0=;
	b=V27bejYPJ1d5Edg9q46vscEtm89bOnKxzU5r7sWIv8IilaDLnIMOP8AXYgW3Xxmbfw
	SpvIgUJF5QDDrzpY7eDH6SkqZHfgFRo9iC/F0BZP3p2SuyNGN0WYELh02fK8KNKPkzTV
	77NabADkpyartaqjMMG1gZSrfKYsd2qg01kwjhEtfFSdYlr9J/Dv8/WmDvGOCe2Ug5nF
	SzFIAHLAqupumigka2FnjCWRAyN/Hci3xBBOR7CDqTrZcSyKpBeDLg9tY+Iw7WrijMhX
	CnsHMjfjs5b9A9yK1NJgABaM0qSjIHWVekLX6/8gBPa2a0RT+Lp01K+G3a3rAFwf9U3s
	YrmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=p/AR+QB1/uCfqQ+ytrGBnYCYqwPtnBM3b7CBgieQEw0=;
	b=HnhEWc6H8lVna1qB9hEKz5J3KHrlVNHg7pG9QdtQnVRu/UNBogdHkJ89YktAHWd+0Z
	JCquR8OjsKWOk96vJdPv7uBzmQn9nK+M55VitaOOmKCeJiPXjxmjTyfk386LcQ3zgZig
	AHoj0SxDGmFZ57P4HmozaZzV9nx/7Soc3bXyuKcxKmrhg+9W7jpdMERij14CnYyjnNrg
	PdlA5j5LYdfjVWRg1/ARq+AlXw4PUCJfiRqXOe6C49GGQYNlDxutBnSPejXUCKnPuUj1
	C1Blw0u1hJKALSJn715tfglOdBoYGUG2j7sypKsslILKOAlf4HLp6pj0BVp2m6Ia/xvv
	cufw==
X-Gm-Message-State: APjAAAWX0724ZpCE2+ax3IAzk2mpppkut/WtguQirdiIWBJNHRGSEdPV
	dh5uP/8A/uSPm0rhJXufaIpP8tpT6fk=
X-Google-Smtp-Source: APXvYqwyK3gkJx0xK8LNpZ45oQmm+Su+9Z+Muc0tSHRYW182TPlLzzVbxa4gQMh6pqMrZW9UCtzOfA==
X-Received: by 2002:a17:902:8b8a:: with SMTP id
	ay10mr31193869plb.74.1557861421412; 
	Tue, 14 May 2019 12:17:01 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	o6sm18682982pfa.88.2019.05.14.12.17.00
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 14 May 2019 12:17:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 14 May 2019 12:16:33 -0700
Message-Id: <20190514191653.31488-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190514191653.31488-1-richard.henderson@linaro.org>
References: <20190514191653.31488-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::643
Subject: [Qemu-devel] [PATCH v7 04/24] crypto: Use O_CLOEXEC in
 qcrypto_random_init
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: lvivier@redhat.com, berrange@redhat.com, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Avoids leaking the /dev/urandom fd into any child processes.

Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 crypto/random-platform.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/crypto/random-platform.c b/crypto/random-platform.c
index 260b64564d..6df40744c7 100644
--- a/crypto/random-platform.c
+++ b/crypto/random-platform.c
@@ -42,9 +42,9 @@ int qcrypto_random_init(Error **errp)
 #else
     /* TBD perhaps also add support for BSD getentropy / Linux
      * getrandom syscalls directly */
-    fd = open("/dev/urandom", O_RDONLY);
+    fd = open("/dev/urandom", O_RDONLY | O_CLOEXEC);
     if (fd == -1 && errno == ENOENT) {
-        fd = open("/dev/random", O_RDONLY);
+        fd = open("/dev/random", O_RDONLY | O_CLOEXEC);
     }
 
     if (fd < 0) {
-- 
2.17.1


