Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE554C4724C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 11:16:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9926F20787
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 11:16:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vIVkgILN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9926F20787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUTed-00074X-IY
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 07:16:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36090)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jUTdP-0004ZM-AU
 for qemu-devel@nongnu.org; Fri, 01 May 2020 07:15:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jUTdO-0002TS-9I
 for qemu-devel@nongnu.org; Fri, 01 May 2020 07:15:10 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:44536)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jUTdN-0002P3-Q3
 for qemu-devel@nongnu.org; Fri, 01 May 2020 07:15:09 -0400
Received: by mail-wr1-x429.google.com with SMTP id d17so11139797wrg.11
 for <qemu-devel@nongnu.org>; Fri, 01 May 2020 04:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=crXfayG3glGSZC7e0t+04dr7EPKzammTLcrrEHLza/Y=;
 b=vIVkgILN5/yEnGo6Gh5FC/JZrPwWxL6NmtS4Pp5JNBQ+Qj5dUNKkHC6BENqENiyRyr
 UwfLx9XaxrpUiGeAF7ZNb3Y92fNOdygt3ZmH6P1KH/8Eh0mX7fxsBRsJAEE7oWxGiTvw
 Dwl9MkT30hVXuQY90d9aUPfJzXpafrlO042MJiZJ3g22yRTKFZMRM9Kqa8kaAG6pQsox
 T7n6FrEr6C0askoaxuVxVMMWlvdq9XvuOiiRV7tEtR6nRlJ9Pjywbg87DdOaw96hro3k
 gKv14eabDAhQlSnntKAhSXX9nJngC0x4xZ2vR1UCOK2Sd9c6nMQUBGV42r3GjMG3ZcfH
 2oFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=crXfayG3glGSZC7e0t+04dr7EPKzammTLcrrEHLza/Y=;
 b=LhYge85ezbOhKBFGOciys3re+FNC1TPuaX5MZQ2dW7OUoTyu0mh7iR3dCgoWlydsMH
 H6g2qQU3q/ih8R4LLv1yFrNlb4IBeHxhPsmhJSBhvkQysdhxEv0LECmNvTdNY5soTS6E
 nHk2FSSy7wUyTTSkxR2M6z5HRpTNlxWiQ3nNTwPTFeGKkR9VDbmn8kIIOcH7+ViALBwg
 abKEJXiV8+uxXVcrj/T5TBVz5LdxGocpJoYyfMhHsx9VFWzDIlfrQtrfe63CpUYTlxOt
 3+IpK41N7BiIyRYZ356NZaur26QmUpXIbLCEOAD6nTlgN/3e8IfGxId5QjFDVeHLmp9f
 EG0g==
X-Gm-Message-State: AGi0PuYS6Wz7ytdlqXxluKiwa+yK7m2qkeYgFZLQnMCALtiGJg5wemnQ
 UP45Mzz/isNYZIZKdmFv877f3w==
X-Google-Smtp-Source: APiQypIzh/zl1RYyjKgUajifIKw0xLH7VRM85aHzjlBmUYe/0gSdDTilNEcGy7dhBlmNKzOIdjbMDQ==
X-Received: by 2002:a05:6000:1007:: with SMTP id
 a7mr3478462wrx.279.1588331707827; 
 Fri, 01 May 2020 04:15:07 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id s6sm3506384wmh.17.2020.05.01.04.15.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 May 2020 04:15:06 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 7D2CA1FF7E;
 Fri,  1 May 2020 12:15:05 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 0/4] testing/next updates
Date: Fri,  1 May 2020 12:15:01 +0100
Message-Id: <20200501111505.4225-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x429.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::429
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

The following updates bring us to green across the board again. MacOSX
has been getting continually flakey on Travis but we still have
coverage on Cirrus. Please review.

Alex Bennée (4):
  .travis.yml: show free disk space at end of run
  .travis.yml: drop MacOSX
  .cirrus.yml: bump FreeBSD to the current stable release
  .travis.yml: reduce the load on [ppc64] GCC check-tcg

 .cirrus.yml |  2 +-
 .travis.yml | 31 +++----------------------------
 2 files changed, 4 insertions(+), 29 deletions(-)

-- 
2.20.1


