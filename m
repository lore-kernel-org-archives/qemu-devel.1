Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AAFFC33CAC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 17:45:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB3FC20659
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 17:45:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bf1X+gN/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB3FC20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izlDj-0005jj-Cv
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 12:45:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43684)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1izl0A-0006yR-U7
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 12:31:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1izl09-00079B-Oi
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 12:31:42 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:37433)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1izl09-00075g-Gp
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 12:31:41 -0500
Received: by mail-wr1-x441.google.com with SMTP id w15so8201938wru.4
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 09:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=t+6Sog2K+ZVcTg/jfh6NF1pfex6NujGk7p8MyQqFuec=;
 b=Bf1X+gN/uCwdxcYq+OcHFKR1c9QWhrjpWTwJdEDrkBDo5Tn85GshAXuMf6HN0WtlvD
 dH9YQsOyywi4A5RQO7z4PasqkiQJWTPWULmMGSjORF+4CJR16R2PETfTxjaDJpgG4EkQ
 SF1YoCOu1nuIQKnvR8JSKQUrWOnS77QZaMFpQE4jM+bS7bvf1ZS7Xm2Bu8QbNh0EStv9
 7WDNdT7mHiByKpvWUxUA2RG4b0z9Pyyo/fBz87++LZsG6ozEsgzS3n1XAJR42f5hY9Si
 XFKj/8vaJDsOjon3q50cTBXl2acpSl8RyeiXuE9ffTzGHRojLfvWp7CP7W7krPZ34qC1
 +N4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=t+6Sog2K+ZVcTg/jfh6NF1pfex6NujGk7p8MyQqFuec=;
 b=I2MeTXnJopbJ/7Byc7CvAY87YWoiEoep8u+3vH39EyTIIC3MHzw70Eoz499td/Ok6z
 anc3GlOhCYgq+yPpjPfoIpF19l31kodPfPsY65S1AAP44zNkZaFOY7IRYoKoIc5fxPdP
 7vCOxO4njq25+gpypdZThXbOKtYr9TTsGHpxFQtud7UrEztat40pbM4D9QlAqyKuaHnP
 vgVeiD/R8wu+zAGm2hIRymgDjCsXrnQlDRSztkBH8I+73diKrkY4B7uJFRmuZ69wsmef
 KsQ7BgxKPymAHPgMe/eyY4Hs17daE+DzG3Mr6H7AR8c/DRwcJH5GofdTCDeCcGvWI45A
 C/RQ==
X-Gm-Message-State: APjAAAWZDNmczoxDK/97ufHeSa79XzqScmuj3sXpgmoVueI6e8Mbc2Yd
 tW5/TFVxHN/M9aOaP4FbEels/hu44/w=
X-Google-Smtp-Source: APXvYqwCtpfqX+Jea/VquSzYnL0uKV1Q7m8Mk7t7kZBqDu22fFyuNenK7FW33hqS9duLO5jRVaUlxg==
X-Received: by 2002:adf:df0e:: with SMTP id y14mr4670915wrl.377.1581010300052; 
 Thu, 06 Feb 2020 09:31:40 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w15sm5204214wrs.80.2020.02.06.09.31.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2020 09:31:39 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 27/29] qga/qapi-schema.json: Add some headings
Date: Thu,  6 Feb 2020 17:30:38 +0000
Message-Id: <20200206173040.17337-28-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200206173040.17337-1-peter.maydell@linaro.org>
References: <20200206173040.17337-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add some section headings to the QGA json; this is purely so that we
have some H1 headings, as otherwise each command ends up being
visible in the interop/ manual's table of contents.  In an ideal
world there might be a proper 'Introduction' section the way there is
in qapi/qapi-schema.json.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 qga/qapi-schema.json | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index 0e3a00ee052..0b44da359b6 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -1,14 +1,18 @@
 # *-*- Mode: Python -*-*
 
 ##
-#
-# General note concerning the use of guest agent interfaces:
-#
+# = General note concerning the use of guest agent interfaces
+##
+
+##
 # "unsupported" is a higher-level error than the errors that individual
 # commands might document. The caller should always be prepared to receive
 # QERR_UNSUPPORTED, even if the given command doesn't specify it, or doesn't
 # document any failure mode at all.
-#
+##
+
+##
+# = QEMU guest agent protocol commands and structs
 ##
 
 { 'pragma': { 'doc-required': true } }
-- 
2.20.1


