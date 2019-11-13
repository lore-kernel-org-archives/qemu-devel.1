Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 513DAC43331
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 12:01:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14DC0206BA
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 12:01:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pk41Y/1I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14DC0206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUrLL-0006KV-P3
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 07:01:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33039)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iUrJV-0004zf-Ny
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 06:59:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iUrJU-0004Ca-KJ
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 06:59:57 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:35149)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iUrJU-0004Bs-CT
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 06:59:56 -0500
Received: by mail-wr1-x436.google.com with SMTP id s5so2061757wrw.2
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2019 03:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=XZm//FR402++/40OAV99MLaFGsdjvlFJuEDpJ6skPCQ=;
 b=pk41Y/1IMa0nVf3Rvi8R1pg+h44Ew7iI1WBN5gNTqVtPEPhdQ4cXafWxwlmBEIAns1
 ORF+Gib1AL9aN0gUrKnl3IKqEL5NJ16ZWYNLs/ngV9WyZpiJ5UtjzMyuQLudAwsP+li0
 HszM//mRuSFXpqyBzHWA2uKXC3m5BAJaEYn++CgvnaPmvrHu5ycCwVujEp0Hn9qczjZk
 qScqegzz/TR+Vb37nuveR6WZVcXrB0oevoq04H6MHrQWx9n8HYQoK1TB5/iAyivyV2xL
 tmr0IbZLQrQX2YHbM4wVf9tz+8UcoSOJz129lfHe2y7E+owhM2r2fn49D6itEMjvTsDH
 3YgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=XZm//FR402++/40OAV99MLaFGsdjvlFJuEDpJ6skPCQ=;
 b=KcmPDOIumj3UqTL92XloAAd8R9aJeVyBJ/84pjpBxPSp96e7q328794bK1LGGSffFF
 wF3B7B4R8+NPRhXuVWaduW61uMcW2egCGljZQISAJuQa0JrtgFh3OGzQ9CdOWszahrJ9
 uwJlkA2TlnceN//lqxvgkG9cGHAYrLbAX0QsSWs42rUaqAqdykb3mP/vTpAA8c+wtQhD
 t0LK43zZLt9CO1DyFuDZcg5BxSkH/0QTBfgIqSFe54sPCsvR37lL/2Vhwn3ljMvanNTG
 F39YA1TfZMwRcXTYO21Zw9Ps0gw1lZ9by8O8ktpWx6D8Vg/kT4cRaiWUw+KYyi/F3sWS
 1fTA==
X-Gm-Message-State: APjAAAU1o/B22dafVU4lR52PTQZmqQL+p8DZoSc5xUwm3px3bFMBLks2
 a4RrV6jGY8T5sUAm3aOTkdIR6g==
X-Google-Smtp-Source: APXvYqyuJC7H3ZhH7CR/sKnor5rIBRokfPxfZM+ow20Du4ioeOPpzk2sbOtm+Tjt0VhYjy2X0QvPDw==
X-Received: by 2002:adf:da4a:: with SMTP id r10mr2585069wrl.356.1573646394917; 
 Wed, 13 Nov 2019 03:59:54 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id y2sm2296395wmy.2.2019.11.13.03.59.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2019 03:59:52 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 2B8C91FF87;
 Wed, 13 Nov 2019 11:59:52 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH for 4.2-rc2 v1 0/5] misc doc and testing fixes
Date: Wed, 13 Nov 2019 11:59:47 +0000
Message-Id: <20191113115952.775-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::436
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

As we approach release I'm just bundling up my random fixes for 4.2
into one tree for each release candidate. This has a minor fix for
debugging vm builds and a number of minor documentation fixes
including moving the MTTCG docs across to rst format. The final patch
is a tweak to Travis to drop the 32 bit targets from
MAIN_SOFTMMU_TARGETS. This may be too controversial although the 32
bit targets still get built and tested under GCC.

Please review.

Alex Bennée (5):
  tests/vm: make --interactive (and therefore DEBUG=1) unconditional
  docs/devel: rename plugins.rst to tcg-plugins.rst
  docs/devel: update tcg-plugins.rst with API versioning details
  docs/devel: convert multi-thread-tcg to a .rst document
  .travis.yml: drop 32 bit systems from MAIN_SOFTMMU_TARGETS

 docs/devel/index.rst                          |  3 +-
 ...ti-thread-tcg.txt => multi-thread-tcg.rst} | 28 ++++++++++++-------
 docs/devel/{plugins.rst => tcg-plugins.rst}   | 27 ++++++++++++++----
 .travis.yml                                   |  2 +-
 MAINTAINERS                                   |  1 +
 tests/vm/basevm.py                            |  2 +-
 6 files changed, 44 insertions(+), 19 deletions(-)
 rename docs/devel/{multi-thread-tcg.txt => multi-thread-tcg.rst} (96%)
 rename docs/devel/{plugins.rst => tcg-plugins.rst} (83%)

-- 
2.20.1


