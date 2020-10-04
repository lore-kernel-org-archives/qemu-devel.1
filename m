Return-Path: <SRS0=Kewn=DL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BBB1C4363C
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2020 17:15:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE688206B6
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2020 17:15:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pwsn3ffp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE688206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kP7bH-0008K7-Fw
	for qemu-devel@archiver.kernel.org; Sun, 04 Oct 2020 13:15:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38662)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kP7ag-0007s2-HM
 for qemu-devel@nongnu.org; Sun, 04 Oct 2020 13:14:30 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:44480)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kP7af-0002lU-3I
 for qemu-devel@nongnu.org; Sun, 04 Oct 2020 13:14:30 -0400
Received: by mail-wr1-x441.google.com with SMTP id s12so7001475wrw.11
 for <qemu-devel@nongnu.org>; Sun, 04 Oct 2020 10:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ltLeod2LiPAD8k/jT3NnKmKDXPxUjrLbzoTIDcXyXJ4=;
 b=pwsn3ffpf2FKIAttskEubnhr5Kk9N0iROTJznLBJsQX0DhzZrdAc+GTr9EdXUDBsNE
 uZlzf580g8WElzijMPc7bPSorCFKq2adVIpARDQA8g/pl6UBWZeTAUqjxZswyOWqB/KO
 YHk8VxZbClmXDbXDkf1LAhl54btlL35DIy08unr0/N/4Yg6Lrf2pg/Jr5z5y0muziowv
 iLjgIodoH2ncc7bcp/NOSX5C5rvvrpjn+Ur9Ub88XQ4x/mUa0pWjnuH3JL4I/dWI5zDM
 mxXE/yxVJG4o35XVHeE85SIsbtR+ZFmtaQ9dtOGcYm2h9PxJsK14MeyROCuJqQ4IVQbn
 NBUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=ltLeod2LiPAD8k/jT3NnKmKDXPxUjrLbzoTIDcXyXJ4=;
 b=PyvwwwDUttdlJwt5YFadnLZ41TM8gF6gncddDHHvgZfDJHTbpJMn63XJoByrvdSFlZ
 buDcdaWBZhukhiGaVAizq5rBVC83xP5k765iXNVdrqVh3YkLdfsbrkSBv49rljyd4wCb
 Dtm7IToFhGad2Wm2fMAhYR6/HtauiC6Qvm//ztNvPSPaSUfINjkcDgTEeexjRi9yCdC3
 LLplvzavv3d2t643a7y35zOSTb4uPgnihAogt0CLvE06SRBlUJpnm+0w2n9dkI3L9vrk
 0fN8Z3UkERUBrp+ntldEtQVZ+FdnMUF2/SELV04X1aBKKSmeNnrC3OxCWY0fk87qtg63
 UGRg==
X-Gm-Message-State: AOAM530UM3RTADwEnqEDhcl/8b4z7h6O5LtJhvETNkHYXXmjueYuVfEE
 Bd7Fx9g3sgjwy+4Ui9gtmejhrFuAS/k=
X-Google-Smtp-Source: ABdhPJzWEOt36YVMd0FubRnLx2OoItRxkJZmolV7RU+MhzSkKSaXl9VvJNgzZHvEhdsrG1Sgpr26vg==
X-Received: by 2002:adf:de11:: with SMTP id b17mr13279409wrm.82.1601831667609; 
 Sun, 04 Oct 2020 10:14:27 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id j14sm9827413wrr.66.2020.10.04.10.14.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2020 10:14:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] contrib/gitdm: Update file types after switch to Meson
Date: Sun,  4 Oct 2020 19:14:25 +0200
Message-Id: <20201004171425.2025680-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.248,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

- meson.build is in use since commit a56650518f
  ("configure: integrate Meson in the build system"),
- .h.inc since commit 0979ed017f
  ("meson: rename .inc.h files to .h.inc") and
- .rst.inc since commit 87c0868f46
  ("qemu-nbd: Convert invocation documentation to rST").

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
---
 contrib/gitdm/filetypes.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/contrib/gitdm/filetypes.txt b/contrib/gitdm/filetypes.txt
index d2d6f6db8d..16e2075681 100644
--- a/contrib/gitdm/filetypes.txt
+++ b/contrib/gitdm/filetypes.txt
@@ -49,6 +49,7 @@ filetype code \.c\+\+$	# C++
 filetype code \.cxx$	# C++
 filetype code \.cc$	# C++
 filetype code \.h$	# C or C++ header
+filetype code \.h.inc$	# C header
 filetype code \.hh$	# C++ header
 filetype code \.hpp$	# C++ header
 filetype code \.hxx$	# C++ header
@@ -97,6 +98,7 @@ filetype devel-doc ^BSD-3-Clause$
 filetype devel-doc ^GPL-2.0$
 filetype devel-doc \.txt$
 filetype devel-doc \.rst$
+filetype devel-doc \.rst\.inc$
 filetype devel-doc \.texi$
 filetype devel-doc \.pod$
 
@@ -108,6 +110,7 @@ filetype build Makefile$
 filetype build Makefile\.*$
 filetype build config$
 filetype build conf$
+filetype build meson.build
 filetype build \.cfg$
 filetype build \.mk$
 filetype build \.mak$
-- 
2.26.2


