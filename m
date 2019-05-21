Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8357C04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 12:33:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 901982173C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 12:33:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X+NOGgcj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 901982173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52770 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT3xo-00083y-Q8
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 08:33:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hT3q2-0001SK-S6
	for qemu-devel@nongnu.org; Tue, 21 May 2019 08:25:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hT3px-0005Gy-FE
	for qemu-devel@nongnu.org; Tue, 21 May 2019 08:25:48 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:46306)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hT3px-0005B2-6a
	for qemu-devel@nongnu.org; Tue, 21 May 2019 08:25:45 -0400
Received: by mail-wr1-x429.google.com with SMTP id r7so18343869wrr.13
	for <qemu-devel@nongnu.org>; Tue, 21 May 2019 05:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=tvS0J2CCwmAI9jtVGUfQ7GO5klgsA9PYzQhj1JC24zc=;
	b=X+NOGgcjaXldgBS/tExqO4E64kbpEgbQAvgU9otTba+JyKhxqxB4dLmshB1r0Auxw4
	PryiKx9CzgQKF6CzfjDu+oVq2xNltjxH5geoKY2/Kem/EtnvpWD6qY4AVgdRcZRcLvHu
	J2uL1ofVtN+cJZRed+HBolGal9Fe/+Qsao3T1+PHewwoaOpIAiLY76XS5frjOvQWYG+i
	Gb0SfcNcTLyzfpysxQjd+XTCR+dTiA7Yz1jYq7VUAUpWVn92rpG34naxisEvsSQqWTZi
	uKzreecXSnfme+hleSj5P2roFD83GJ21FiW8gwREmsFUK8pBcBxp8tYYvJMom3SGdSXZ
	xLrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=tvS0J2CCwmAI9jtVGUfQ7GO5klgsA9PYzQhj1JC24zc=;
	b=czXhYVpNeIPat5MbvXQm/psoynpFZjpofV+1c2WHkRkI5Njwii9vp317XEweSQ9aB2
	u2PDaKa9PdgIJIqO0W0s8z4a150wnfwHQFGSDFHanYXR+f2v8aQnoRJgHe4PT1JMpaBu
	Yh5Aw7daTCaFq1uRUV/j3En0MI1Lm/B+YmEINaVQfh7OyB2ZoxrD2YbFBFEqdrwL6bmC
	uranViGVtTsaUxFaMGmH4QVIFNyIri4OIfxN29t924xC12o10wZT29cICbPIdizwafzY
	iYfXtKq7vAkb8RQbOejncLXyyvLloGHt0ZZKi81RGM0HPA3eIqVtCb+kvnXhbkxK/3FE
	DKoA==
X-Gm-Message-State: APjAAAV0J48WpD6lWv+2f7eGpguCTQZgSD1KVhHUPESkT+q1ffot2hoF
	wqPE3r85ymR89XUGm1YscYH1dSkBw5Q=
X-Google-Smtp-Source: APXvYqxxe+PwXfDEANRKCMnkI5mgr+PlLszaJrWn37UWC69YKCLeRqQt3QrngqmM7xqYb+i0rhf0AA==
X-Received: by 2002:adf:8bc5:: with SMTP id w5mr7235335wra.132.1558441536416; 
	Tue, 21 May 2019 05:25:36 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	u11sm12233393wrn.1.2019.05.21.05.25.35
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 21 May 2019 05:25:35 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 21 May 2019 13:25:19 +0100
Message-Id: <20190521122519.12573-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190521122519.12573-1-peter.maydell@linaro.org>
References: <20190521122519.12573-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::429
Subject: [Qemu-devel] [RFC 10/10] Makefile: disable Sphinx nitpicking
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

Turn off Sphinx nitpicking as a temporary measure so
sphinx builds complete even with warnings about missing
references.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 155f066a206..b4be96ce9a6 100644
--- a/Makefile
+++ b/Makefile
@@ -932,7 +932,7 @@ docs/version.texi: $(SRC_PATH)/VERSION config-host.mak
 sphinxdocs: $(MANUAL_BUILDDIR)/devel/index.html $(MANUAL_BUILDDIR)/interop/index.html
 
 # Canned command to build a single manual
-build-manual = $(call quiet-command,sphinx-build $(if $(V),,-q) -W -n -b html -D version=$(VERSION) -D release="$(FULL_VERSION)" -d .doctrees/$1 $(SRC_PATH)/docs/$1 $(MANUAL_BUILDDIR)/$1 ,"SPHINX","$(MANUAL_BUILDDIR)/$1")
+build-manual = $(call quiet-command,sphinx-build $(if $(V),,-q) -W -b html -D version=$(VERSION) -D release="$(FULL_VERSION)" -d .doctrees/$1 $(SRC_PATH)/docs/$1 $(MANUAL_BUILDDIR)/$1 ,"SPHINX","$(MANUAL_BUILDDIR)/$1")
 # We assume all RST files in the manual's directory are used in it
 manual-deps = $(wildcard $(SRC_PATH)/docs/$1/*.rst) $(SRC_PATH)/docs/$1/conf.py $(SRC_PATH)/docs/conf.py
 
-- 
2.20.1


