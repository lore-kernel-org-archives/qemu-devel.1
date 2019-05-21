Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED873C04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 12:27:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6AF12173C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 12:27:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="npj4YbrO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6AF12173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52681 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT3rt-0002ej-Sg
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 08:27:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hT3q2-0001SG-RJ
	for qemu-devel@nongnu.org; Tue, 21 May 2019 08:25:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hT3px-0005GA-0V
	for qemu-devel@nongnu.org; Tue, 21 May 2019 08:25:48 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:50611)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hT3pw-00056N-Ii
	for qemu-devel@nongnu.org; Tue, 21 May 2019 08:25:44 -0400
Received: by mail-wm1-x329.google.com with SMTP id f204so2799900wme.0
	for <qemu-devel@nongnu.org>; Tue, 21 May 2019 05:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=6OFDFvuvQviFWUA+ErkQZRrbDM3t1pANZfkvzqmBlg8=;
	b=npj4YbrO4P/rhMjEvX/1V6DzWudQYkMfQHNy5tszxjNs7loGgjR/IyshL2nc3YjMUk
	4vi94cWZEmGyS5GlHzV5BMvAUFsI78B+ur4qTvirFuwOK4GSWsnpquL+SoFnzCn/zQTZ
	KWQlBxUgOT2uZwFHoj0kvUkHVds1h1nSoRL7oWWdIaZgL+1ww+FE7d9F8llWL5JNUiVK
	5kTpz5LzyAG2FFh3sSjdfd3P/ggiAhKnPZ8hVsYg/2+MTO7tZ6HbwlBgUWduC+4ATNM/
	omRvkt20z2Xk2Aieqv/dT7DftF9oT6/Sh1nevREJBzekv/7CBAnhlGkL8Qxyzn60Zigz
	sFWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=6OFDFvuvQviFWUA+ErkQZRrbDM3t1pANZfkvzqmBlg8=;
	b=UBWGbD44tCd3DabT/42zg7p4cuVZdbOQW7Na/T6KB1T4uEYd525K26N+MBdVaXtoDa
	+WP6t058Rn6RPNisiWKxzfdI8wp87Q3LB6B0VTC9AUXGHbYGGUABWtYVUw+ZmMlpAiqE
	1mhLbqGY+QI8NHQ36zbLf4tfqAs485BJJjYJr2J+JQ5nX3IMyHFa6KHWhJ//bH7SXsrA
	QSuT6Kb2M9TQGgcB5JOILyYzma8HqA75ccBZ4XMkx5n17L++5mt1Md1gVFIw8oRrzNxv
	RI8xUETIfvBKRsFU0Wv0JmvJKckcZgztSp8U3tthV6TW7O6jKFBCpl2bO6bLF4dZ6ZMt
	DZ5w==
X-Gm-Message-State: APjAAAUjDCBcKtcw72t9pDshurTB0IbZmpeCUFidNeAbPIJ4wdGIg/je
	bSgOqj6bh6yHpYkJHLtQrMHPeBJ0D9I=
X-Google-Smtp-Source: APXvYqzjq+WcreGHSWFCJripDUnJoHtJtqy/sJs6FhTF6YHhHKwak7m8z+8KUdSvcIvrMLtDHCd01w==
X-Received: by 2002:a1c:740d:: with SMTP id p13mr3389604wmc.2.1558441528747;
	Tue, 21 May 2019 05:25:28 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	u11sm12233393wrn.1.2019.05.21.05.25.27
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 21 May 2019 05:25:28 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 21 May 2019 13:25:13 +0100
Message-Id: <20190521122519.12573-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190521122519.12573-1-peter.maydell@linaro.org>
References: <20190521122519.12573-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::329
Subject: [Qemu-devel] [RFC 04/10] docs/conf.py: Ignore some missing
 references in nitpick mode
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
	Eduardo Habkost <ehabkost@redhat.com>,
	Gabriel Barreto <sbarreto.gabriel@gmail.com>,
	"Emilio G. Cota" <cota@braap.org>, Stefan Hajnoczi <stefanha@redhat.com>,
	Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We enable Sphinx's 'nitpick' mode via the command line -n switch, which
means it warns about references to things it doesn't know about. Add
a whitelist of expected-not-to-be-present types, to avoid false
positives when C function prototypes use standard integer types.

If this whitelist gets too long and unmanageable we might be better
off switching to non-nitpick mode instead.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/conf.py | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/docs/conf.py b/docs/conf.py
index 9109edbcb97..388299fb25b 100644
--- a/docs/conf.py
+++ b/docs/conf.py
@@ -114,6 +114,17 @@ todo_include_todos = False
 # with "option::" in the document being processed. Turn that off.
 suppress_warnings = ["ref.option"]
 
+nitpick_ignore = [
+    ("c:type", "int8_t"),
+    ("c:type", "int16_t"),
+    ("c:type", "int32_t"),
+    ("c:type", "int64_t"),
+    ("c:type", "uint8_t"),
+    ("c:type", "uint16_t"),
+    ("c:type", "uint32_t"),
+    ("c:type", "uint64_t"),
+]
+
 # -- Options for HTML output ----------------------------------------------
 
 # The theme to use for HTML and HTML Help pages.  See the documentation for
-- 
2.20.1


