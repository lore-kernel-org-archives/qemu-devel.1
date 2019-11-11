Return-Path: <SRS0=6DzB=ZD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A03CDC43331
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 16:00:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A8B621655
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 16:00:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C9q6T3ve"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A8B621655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUC6u-0005U5-HJ
	for qemu-devel@archiver.kernel.org; Mon, 11 Nov 2019 11:00:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37999)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iUC32-0001C4-8U
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 10:56:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iUC31-0007pr-3I
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 10:56:12 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:40173)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iUC30-0007pS-Tl
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 10:56:11 -0500
Received: by mail-wr1-x432.google.com with SMTP id i10so15194909wrs.7
 for <qemu-devel@nongnu.org>; Mon, 11 Nov 2019 07:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=G4KQCmCLTLKMF4PiZFdSpP6P3c35VB0pOwp4Cg4ys30=;
 b=C9q6T3veVoi5J4nOFxE77M0wmtQnZ++b1q+REaf0pJ50XKKCg58bmwblGKF8Gf8sWx
 cdPzFXZ/S1om0XLJUq/CfeOYbIT2eiAcmFDvAHEkEGsNPL+aU0k3CNNgMEdjBD7/K1Xo
 cI1bjsm3YBAXCrlOTxLwxcuzp6OfqeyiAguPAvmMtr1aGa1tvYSJJp4spzj71yrMlHAp
 HgTC2RlU25RfhqYCEHGi1HRnHyx+vDwUl0DcOKAyCyll2j2JeI8k7eOL4n2meGZYSysD
 w/rsupCb0Vm/pR33aZiv/le/887Dtq/gwA+ZpyGRrsugCPciiR9hMgnr6sa/Fy1Z0Hhe
 wI9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=G4KQCmCLTLKMF4PiZFdSpP6P3c35VB0pOwp4Cg4ys30=;
 b=LGj8L55shdj2O6jIwtluOZtMUWL8pcMev5so7DgZOpizaAzdbn3YAip/9pMsc1fgRp
 eGzv0STpYQNBUhscpO2yy1SavFyI6bj81JKIdcREJ57DQLshFlnrn5b5qYRM9/rqBN1T
 BPBOIYmkQVIG9ziC9jQmO9yMaZrs5KtVOuTX9vA7pelVyw58/LJ4UTGnkc9z8bQzu/B1
 z2Hg/ynFxhhY4Uhi4vQhEsNC4neKPvA3ytaC02ENfQwM7kfE3p1FDAoYSROsgSe9R/Mk
 iCCb1i4L/eaaOCLg1OOUF8NiDE4+B11FAhV46kk4onKjrFkpPkDinDgppUo56qv838j/
 xWGQ==
X-Gm-Message-State: APjAAAUx1qSmuZxniAYUwOE36V3SbU16BSt5QxSgKu0CbSXk8Kw0smYh
 8wVs5zlnducBp3MOcf5qDUrrJQET+LMAvw==
X-Google-Smtp-Source: APXvYqzfTr9fQwuUqaYTlHlAqZjNk5fVoZ1oUHEup2jkoCS/UjoHoCEgJzz5eA34zDvtmYmLbdHbrw==
X-Received: by 2002:adf:94a1:: with SMTP id 30mr16765355wrr.117.1573487769644; 
 Mon, 11 Nov 2019 07:56:09 -0800 (PST)
Received: from localhost.localdomain
 (199.red-79-149-206.dynamicip.rima-tde.net. [79.149.206.199])
 by smtp.gmail.com with ESMTPSA id f19sm30023156wrf.23.2019.11.11.07.56.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Nov 2019 07:56:09 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 4/4] tcg/LICENSE: Remove out of date claim about TCG
 subdirectory licensing
Date: Mon, 11 Nov 2019 16:55:51 +0100
Message-Id: <20191111155551.13885-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191111155551.13885-1-richard.henderson@linaro.org>
References: <20191111155551.13885-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::432
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

From: Peter Maydell <peter.maydell@linaro.org>

Since 2008 the tcg/LICENSE file has not changed: it claims that
everything under tcg/ is BSD-licensed.

This is not true and hasn't been true for years: in 2013 we
accepted the tcg/aarch64 target code under a GPLv2-or-later
license statement. We also have generic vector optimisation
code under the LGPL2.1-or-later, and the TCI backend is
GPLv2-or-later. Further, many of the files are not BSD
licensed but MIT licensed.

We don't really consider the tcg subdirectory to be a distinct part
of QEMU anyway.

Remove the LICENSE file, since claiming false information
about the license of the code is confusing.

Update the main project LICENSE file also to be clearer about
the licenses used by TCG.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20191025155848.17362-5-peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 LICENSE     | 5 +++--
 tcg/LICENSE | 3 ---
 2 files changed, 3 insertions(+), 5 deletions(-)
 delete mode 100644 tcg/LICENSE

diff --git a/LICENSE b/LICENSE
index 9389ba614f..f19b018486 100644
--- a/LICENSE
+++ b/LICENSE
@@ -18,8 +18,9 @@ As of July 2013, contributions under version 2 of the GNU General Public
 License (and no later version) are only accepted for the following files
 or directories: bsd-user/, linux-user/, hw/vfio/, hw/xen/xen_pt*.
 
-3) The Tiny Code Generator (TCG) is released under the BSD license
-   (see license headers in files).
+3) The Tiny Code Generator (TCG) is mostly under the BSD or MIT licenses;
+   but some parts may be GPLv2 or other licenses. Again, see the
+   specific licensing information in each source file.
 
 4) QEMU is a trademark of Fabrice Bellard.
 
diff --git a/tcg/LICENSE b/tcg/LICENSE
deleted file mode 100644
index be817fa162..0000000000
--- a/tcg/LICENSE
+++ /dev/null
@@ -1,3 +0,0 @@
-All the files in this directory and subdirectories are released under
-a BSD like license (see header in each file). No other license is
-accepted.
-- 
2.17.1


