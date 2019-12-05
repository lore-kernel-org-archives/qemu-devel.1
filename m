Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0FDAC43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 14:18:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B3152245C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 14:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b0uyW4ZC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B3152245C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icrxx-0002mQ-9Q
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 09:18:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55884)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1icrra-0006a1-Fj
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 09:12:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1icrrZ-0001R9-3J
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 09:12:14 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:36656)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1icrrY-0001L8-ST
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 09:12:13 -0500
Received: by mail-wr1-x443.google.com with SMTP id z3so3811621wru.3
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2019 06:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=iyQpQNck376ErR3JEzAl3CN8hF7hax8QdJJQ+SZHsyE=;
 b=b0uyW4ZC50er59HogBqhaq3Y0pPguOD811r9iPDe/mIIXBpcjnmvuTacxoHsyTQwmJ
 /08WClB7zD/1DO1cMrJlH1y9izzzILy+RF95d7o+v5bmJ1iejcCj7MV/RBALvnnimmEh
 frFHW6vpD/inguGyAhZLTwn/udV1KBk4yHv70alsdsG6Wgw9nyusLtmnQH3jGrzZIxXV
 dWGit84FvSxajzi8+LzIS3k6YDL4o/WimVzvRop5PCr9EgWe/vE7ABkkdnGzzWKO6EhO
 IDqLJBqLrtXJehGgaTqhW0e1XGg/0rXLtZuNigfu95GGyT0FvsifObliHeINcbzxOU+c
 DnVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=iyQpQNck376ErR3JEzAl3CN8hF7hax8QdJJQ+SZHsyE=;
 b=KT5l/gvJQjlffuTEv5U5wlXNS06f//JGQrjNjoZKCnqtYeci0Wzgm/CDODY2OBgylp
 OtcekemDke5iYzgC8/+oVTKfprFBvPo4BQjJBW0fSXW3CbcHJPsNddIaXlAVXsBPeA+y
 PZZVf/M6wmCh5As8ApmF4J0E+Rfjxb3WvWFLNEL3WAC9F3R7qbV1EC3RpbEhvmViI4s6
 E97LqSR7VS6C4jXaCRkCvtx6MV5cMI9U4NP6UKLOt6ZAn+IAxiPUJ3k2LCZ+qGu7294b
 ub46YY83Us/JUevLZ0PQu+7jLjL2j5JV+k3dpXXxHfH5HXr5gNbbc0YcQqPW3gzXktht
 U/sg==
X-Gm-Message-State: APjAAAWdxfqLvE3RIN9lhhkt05keEl1eaHjiOQtDrJHOZOEu+Lvy9vTi
 Mgb/45Q5cbMEXewAjHlx0kYcKGD1AtQ=
X-Google-Smtp-Source: APXvYqyMQACgOqQK+F3n5MWfhIM+vyJE0AxgizC4zv2HfiIj6uhMbzUnpevJv4MbsLOGWRMfNE/S8w==
X-Received: by 2002:adf:e550:: with SMTP id z16mr9795840wrm.315.1575548720065; 
 Thu, 05 Dec 2019 04:25:20 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u69sm11129614wmu.39.2019.12.05.04.25.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2019 04:25:18 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 0F1DA1FF87;
 Thu,  5 Dec 2019 12:25:18 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v2 0/6] linux-user mmap debug cleanup
Date: Thu,  5 Dec 2019 12:25:11 +0000
Message-Id: <20191205122518.10010-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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

This is a quick re-spin of the mmap tracing. I don't bother with
pretty formatting the protection/type flags as they were incomplete
and not hard to extract from just dumping the hex values. This makes
most of the patches much simpler. I've also dropped the home-made
pattern_glob routine.

The following patches need review:
   01 - linux user convert target_mprotect debug to trace
   02 - linux user convert target_mmap debug to tracepoin
   04 - linux user log page table changes under d page
   06 - trace replace hand crafted pattern_glob with g_pa

Alex Bennée (6):
  linux-user: convert target_mprotect debug to tracepoint
  linux-user: convert target_mmap debug to tracepoint
  linux-user: add target_mmap_complete tracepoint
  linux-user: log page table changes under -d page
  linux-user: convert target_munmap debug to a tracepoint
  trace: replace hand-crafted pattern_glob with g_pattern_match_simple

 include/exec/log.h      |  5 +++-
 bsd-user/main.c         |  2 +-
 linux-user/main.c       |  2 +-
 linux-user/mmap.c       | 56 ++++++++---------------------------------
 trace/control.c         | 35 +-------------------------
 linux-user/trace-events |  6 +++++
 6 files changed, 23 insertions(+), 83 deletions(-)

-- 
2.20.1


