Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 728DEC31E40
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 15:51:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 305382089E
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 15:51:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wz5CxMsI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 305382089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw7Av-000216-CS
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 11:51:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52498)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hw7AJ-0000pN-UO
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 11:50:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hw7AI-00067J-U5
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 11:50:51 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:43795)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hw7AI-00066D-Kg
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 11:50:50 -0400
Received: by mail-wr1-x442.google.com with SMTP id p13so24103843wru.10
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2019 08:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ygRfiXcw8nu+FWMinQnK0wJ2K/Utz7SUuc0zdF1It3I=;
 b=Wz5CxMsI8TrMEOPWWkDVb3eeLuiBSvlSp6dkQOpIRA4zUlKrxTxtpYwyCB9qaTLKme
 C4RgWq+OuBlWoJkaDZpVijY4gTXbd4C3KgNM8JPgZ69ZZ0h4PRSXw0Njw19Ga+VX3Px3
 2lrhS0glUlkmln2mbDgKAZeoR4MpkEwjf39LTcBml833mMC7UD5DAg94Rxf66hHPJrTw
 S8lsn33IFwOdLWWmqyZ69C5aKLtR9IdfFfNzPtt0t6i9yBOP8GTf1367nwmhKKCl3Yq1
 y0H334VaQ0lcUMON6/WyK42SkDZv5UFYwrgRiSWTGzi0ptP7ej1AptMY5Ob/96ZESyQ/
 zz8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ygRfiXcw8nu+FWMinQnK0wJ2K/Utz7SUuc0zdF1It3I=;
 b=M+hHLrLLe6QS6u2/dEdFmGYlcsqS/wieRMMTXWNVGE8xIJuMz8I7S0OAr/BtM+5Rb5
 +vne3Kl88fqb7hIC0HcRWNVry4jAxSbZRjN1DaYNqDAzG5leIKw/XVHgDKlZziL26O9t
 tfDVtpU6iOjGMISUQnhyR8x+YwT6qQhPVTpT6WpqaSJ3sLqS9Cv9ttZyvFmeP1muxTgN
 jIvxsOUZXxk12Jw7GcRZbWsy8o/PMeMT+rkkb762M+WuJPbxazVCN4GM9R4GOLpo8pCT
 sIC28JxxKLqMacq+/UfYftxV+4D3/tB0mnSojbXH/OIC1jW5+UyJQGIUCA1D/wsRuoGM
 lGCQ==
X-Gm-Message-State: APjAAAXOVl0FNWGJkTcnHfdDsxr0DKrfzFiwKg3k+oXKN0rFnuYhHIYK
 8j5XFiQLCHfrAGSpcFlvLwND+Q==
X-Google-Smtp-Source: APXvYqyZ5WF0UY7iG0G/OBTjYouIdjlwwdl5r5eO+XoVPpgQ18ZDi6wCA8L3MRZw2D1pWy5h4s9RWQ==
X-Received: by 2002:adf:c594:: with SMTP id m20mr26409506wrg.126.1565365848819; 
 Fri, 09 Aug 2019 08:50:48 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id g25sm6725874wmk.18.2019.08.09.08.50.47
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 09 Aug 2019 08:50:47 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 839AF1FF87;
 Fri,  9 Aug 2019 16:50:47 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri,  9 Aug 2019 16:50:45 +0100
Message-Id: <20190809155047.24526-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH  v1 0/2] docker DEF_TARGET_LIST cleanup
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, armbru@redhat.com,
 f4bug@amsat.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

While reviewing Markus' header cleanups I realised my advice to use:

  make docker-test-build

to run through all the various builds would miss some of the cases
that shippable catches. This is because the default target list is
hard-coded into the tests. This series allows it to be over-ridden by
each docker image by setting the DEF_TARGET_LIST env variable. The user
still has full control of the target list by calling:

  make docker-test-build TARGET_LIST=foo


Alex Bennée (2):
  tests/docker: move DEF_TARGET_LIST setting to common.rc
  tests/docker: set DEF_TARGET_LIST for some containers

 tests/docker/common.rc                                | 4 ++++
 tests/docker/dockerfiles/debian-arm64-cross.docker    | 1 +
 tests/docker/dockerfiles/debian-armel-cross.docker    | 1 +
 tests/docker/dockerfiles/debian-armhf-cross.docker    | 1 +
 tests/docker/dockerfiles/debian-mips-cross.docker     | 1 +
 tests/docker/dockerfiles/debian-mips64el-cross.docker | 1 +
 tests/docker/dockerfiles/debian-ppc64el-cross.docker  | 1 +
 tests/docker/dockerfiles/debian-s390x-cross.docker    | 1 +
 tests/docker/test-build                               | 1 -
 tests/docker/test-mingw                               | 1 -
 tests/docker/test-quick                               | 1 -
 11 files changed, 11 insertions(+), 3 deletions(-)

-- 
2.20.1


