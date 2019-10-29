Return-Path: <SRS0=qR42=YW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA42CA9EAE
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 16:24:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4A5520717
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 16:24:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OvHKKNiY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4A5520717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPUIY-0004K6-Th
	for qemu-devel@archiver.kernel.org; Tue, 29 Oct 2019 12:24:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50642)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iPUGi-00020A-DG
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 12:22:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iPUGh-0004pD-85
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 12:22:52 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:40182)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iPUGh-0004oq-2g
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 12:22:51 -0400
Received: by mail-wr1-x436.google.com with SMTP id o28so14334833wro.7
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2019 09:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=UeVkw/7D/E7poDnCSpi2Pj+kV5RWb92e+pvvASuYJfg=;
 b=OvHKKNiYrwLiuXOtC4wdagrJf5telL1iHnqHE3xvQFicC3YiFQBh+J48pxeFrZhMgA
 bOlDeRPNl91Jt+1aPPgJq8JLFmaVtSLjNBLnOrJgJivlhLlPH2jsbRKnWSbWthdzfoNg
 XJBBtxt6bqyN46Cle34JWzafPbq5VbThvoVZoST8bufdQziTMOf7MOLEdxaPyZmAXVZb
 YfFiJwZCdYBeO6g12O8nUK9aXgNov7FsBI0AL3PlhQIAfRWyzdphQ8L9UuwaW+ftQ99o
 PoVD+fiu7DGW0NMIdOhKZMSd8m68UVqDJB8ndCVhIHZWwuUnwBKhNoI/EPQApCJifUs/
 cUiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=UeVkw/7D/E7poDnCSpi2Pj+kV5RWb92e+pvvASuYJfg=;
 b=JsIZiu7/Yz3ST0q+AWJXPlqHXK6BQtmyppia4p/MPkrbbXP8CpiTjYJS/6GUm+EgQu
 8WxjTy7WGWRO3bkYWmJevHOAAofdA5xTQD7i/tWi3l+PDC1gwQ20rzcTDtb4+MlF6TXJ
 fpSFf+b70pCCU6lXOSPboBuqQqkBRl6ehnePQLxPGnYdD+PE7C0aPxxwLefE6RSROMYU
 rKLKiTDxDLuz6KsXaTdNsmpbj9RL11McbdGsMdGESOIbv2Ncl1aoX6gqUhqwFT1knNgI
 377cf1HtNT8hpGTrtmAUptUaeZJN3hGtK3BcRS1qgVp57KpHZmhViUd2hSqUmapEVG3e
 YO1A==
X-Gm-Message-State: APjAAAVi8EbeWVZy6lInV2ecEKwreGMTIo1e6H74cdTRBCViUlc9o/sJ
 Yg2qVtVLEfcQoa4u9O3tHVxX1AI+jBI=
X-Google-Smtp-Source: APXvYqwjCN5BG+bSmd/bgxAIBJjPpApBTAkwmS2thIH8HArzKfDJtSegM8u/wVmV2K4Z5xiV6UQ9qA==
X-Received: by 2002:a5d:5742:: with SMTP id q2mr3291837wrw.311.1572366169302; 
 Tue, 29 Oct 2019 09:22:49 -0700 (PDT)
Received: from donizetti.metropole.lan (94.222.26.109.rev.sfr.net.
 [109.26.222.94])
 by smtp.gmail.com with ESMTPSA id q12sm9285661wrw.91.2019.10.29.09.22.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2019 09:22:48 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 0/6] docs: integrate doc comments with Sphinx build
Date: Tue, 29 Oct 2019 17:22:42 +0100
Message-Id: <20191029162248.13383-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,

this is an attempt at including kernel-doc, with small tweaks (see patch
2) to support QEMU's doc comment format, in the Sphinx documentation pipeline.

The ugly part is patch 3, which disables Sphinx's "nitpicking" (warn on
invalid cross-reference) mode.  It would probably be possible to use
the nitpick_ignore configuration entry instead.

Paolo

Paolo Bonzini (6):
  docs: import Linux kernel-doc script and extension
  docs: tweak kernel-doc for QEMU coding standards
  docs: disable sphinx warning about missing cross references
  memory: adjust API documentation to (modified) kerneldoc format
  docs: add memory API reference
  memory: include MemoryListener documentation and some missing function
    parameters

 Makefile                 |    2 +-
 docs/conf.py             |    7 +-
 docs/devel/memory.rst    |    5 +
 docs/sphinx/kernellog.py |   28 +
 include/exec/memory.h    |  227 +++-
 scripts/kernel-doc       | 2236 ++++++++++++++++++++++++++++++++++++++
 6 files changed, 2495 insertions(+), 10 deletions(-)
 create mode 100644 docs/sphinx/kernellog.py
 create mode 100755 scripts/kernel-doc

-- 
2.21.0


