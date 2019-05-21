Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61475C04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 12:28:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D1C42173C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 12:28:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AhpuxbrH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D1C42173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52685 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT3sr-0003aN-CE
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 08:28:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hT3q2-0001SJ-SH
	for qemu-devel@nongnu.org; Tue, 21 May 2019 08:25:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hT3px-0005GF-2m
	for qemu-devel@nongnu.org; Tue, 21 May 2019 08:25:48 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:39691)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hT3pw-00059K-Ik
	for qemu-devel@nongnu.org; Tue, 21 May 2019 08:25:44 -0400
Received: by mail-wr1-x443.google.com with SMTP id w8so18400434wrl.6
	for <qemu-devel@nongnu.org>; Tue, 21 May 2019 05:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=hp1runAbdQd7C9+DO77cwqbwEDr2QCIxmTa56UZ3hFs=;
	b=AhpuxbrHeNU/Dwg2zygsznoUNE1P7EkyIokpH4Mhd+mn7HR0ZpEXfqmaN8pFrVAtMG
	z5oWJzU24AM6MfUuNqkTyJja6ggTgDQlu0Rc919EBhi6yNI7u2P9LP000mg2bd7cjH7f
	m6rKf97vDJDv9XY15nDYr8BliQGE3ekUbmDby3yku3H0V0FFmGmLbWkL7rEiDNmbQ73i
	zdRrufTYQzM6F0HJ5vQlh8wsaPf2G2f4/ZSXKm25wMN1b0seZy6An7XJDYCZVO0PY1Af
	3oV9gp/sQJ8T+enW786Okp5EfA6k0Edp2DG3LYUSDeO4upOKDpwtoUHO0Jy4VH5vwsf5
	qmyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=hp1runAbdQd7C9+DO77cwqbwEDr2QCIxmTa56UZ3hFs=;
	b=Dz8LmJhhT5qUCUl7tEz82OFb+NNy86xWJt+k1s8A3wMXiFrZrFCMrR7p3XDmCxGEU9
	KpF2QmXRdIq19tZCoHCWvM25l1YUUgzkFX7lZnuYdj9wZpa1QrT1nkYi8fOfk81l7r2G
	toxintVEYL+8iakqvde+hMoPJTScUDfOUO7E0HNA5V5u2tcvlf8gfM9TRetY7weKmg3F
	6D2PYvVJy7mA/emSK88PnzcyvMG5XIYsrKHB6NIbVcmVAqjVPKdrc+vqzc/0/ecNOYNg
	0JDATLD6UFXujsn7FW0eVvd1uupmAp2ljQLf5BcWUIC0OjFRcI3KiAJoU7f+WG95XXHm
	2JUw==
X-Gm-Message-State: APjAAAXOo/TbyPTcpTK0St7mSxO7NoQtfLfGgj6r8N56jgmpAPhHhV+c
	2NyFBJK51xNQlz37ZGBjRuobv17AOuE=
X-Google-Smtp-Source: APXvYqwGAwfmk8To+B9zAVsA0MT9fUVHY59k+yfWwHAL5VD/r6pRXAPovDehsMpPzUJsph3NpX5ErQ==
X-Received: by 2002:adf:ba43:: with SMTP id t3mr43582893wrg.188.1558441533992; 
	Tue, 21 May 2019 05:25:33 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	u11sm12233393wrn.1.2019.05.21.05.25.32
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 21 May 2019 05:25:33 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 21 May 2019 13:25:17 +0100
Message-Id: <20190521122519.12573-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190521122519.12573-1-peter.maydell@linaro.org>
References: <20190521122519.12573-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [RFC 08/10] docs: Add kernel-doc API documentation to
 memory.rst
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

Add the API documentation as generated by kernel-doc to memory.rst.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Note that this generates errors that break the build, at
least with the 1.7.5 version of Sphinx I'm currently using.
---
 docs/devel/memory.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/docs/devel/memory.rst b/docs/devel/memory.rst
index b6a4c37ea5e..68bc6202797 100644
--- a/docs/devel/memory.rst
+++ b/docs/devel/memory.rst
@@ -361,3 +361,8 @@ callbacks are called:
 - .impl.unaligned specifies that the *implementation* supports unaligned
   accesses; if false, unaligned accesses will be emulated by two aligned
   accesses.
+
+Detailed API documentation
+--------------------------
+
+.. kernel-doc:: include/exec/memory.h
-- 
2.20.1


