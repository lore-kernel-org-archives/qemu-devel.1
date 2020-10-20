Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF6BC4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 16:15:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA4182224A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 16:15:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FDFhhZi5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA4182224A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUuIH-00030E-VF
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 12:15:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37654)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUu10-00055k-UQ
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 11:57:34 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:33401)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUu0z-0003vG-66
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 11:57:34 -0400
Received: by mail-wm1-x32a.google.com with SMTP id z22so1452718wmi.0
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 08:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=j7iHUHHmz4RqWM4N7aL1RyNr3+GkDqXbbSx38e4eHPk=;
 b=FDFhhZi552G8FOW7VGye7skGMFplaIeIkGpSIrjLAipuhcxJ2LiDWQT5GLPk2alpG8
 VvidlP6SyB9WeqEX4oBPv7/dra1j/QwbpqVrzMvMV6yH82RytcAAQjgvUK7VDlTIZbj9
 OV4HUl8iyb8Zm9Ka4J1r/1D+Y1XAASGhomqH58gPi1dUhcUr1UQiP7LmbrwASQW69Ndh
 pUfGSO/+e/jTjsztyMCOlz/LVApttd+/vO/cgs6bf8xuJ+9LxexnaXgwWbzEpt2HoxF6
 Ai3KCrNtXv0qpvPmuSdhtA6Qd8wxjMmde/x/BTZzDVeapzkBIxREAFDYdrCEhU32xHat
 0sig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=j7iHUHHmz4RqWM4N7aL1RyNr3+GkDqXbbSx38e4eHPk=;
 b=kaXNz4ZtdhrdbggYxw2XLeL2WzPjXB2qowuQyCRYSsvJNrGK7C0DUULbgGTawOFBlh
 wl3raSIrbYwJRcEMsHguy7bH0RWaPPHy9MzAEsoBtrkgEmpTxSUWDuBolOjE2wXegERx
 walo8I8lRkyB6GzkYxJQ1f7Q8+z1ZtiFxutw+TSVsqP/uOSNxfd0I9otpq7Zg+Xc58JS
 rSPV8lLWE9/nMadGOkKEUgBHGpk2yufy5xo3Nbk1AYJu8kz6vAirMiy53HJRFQPoqa3G
 9psVS9c+1xfGq9PELHKe3temiRrzJAFFEdHanXg+ph3bqw2tcGjEj2FdWhVobP0/dQYl
 +tgQ==
X-Gm-Message-State: AOAM532AunQ8bdPcFm35ui89FXK1BCMXesWnhJYzc5JIfjB9D4FfFo7I
 u46TTH4a8FMHDV7ayZU0YWzUG7hEUMXJ/A==
X-Google-Smtp-Source: ABdhPJw69PPnfpgH/b51BCXEhsOGBDodEkHEcE/DCRJul8Hekp64jpPLuAuLl+XedIcARyxoXmXAbQ==
X-Received: by 2002:a1c:2b05:: with SMTP id r5mr3592839wmr.179.1603209451522; 
 Tue, 20 Oct 2020 08:57:31 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id v6sm3780205wrp.69.2020.10.20.08.57.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2020 08:57:30 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/41] decodetree: Fix codegen for non-overlapping group inside
 overlapping group
Date: Tue, 20 Oct 2020 16:56:35 +0100
Message-Id: <20201020155656.8045-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201020155656.8045-1-peter.maydell@linaro.org>
References: <20201020155656.8045-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For nested groups like:

  {
    [
      pattern 1
      pattern 2
    ]
    pattern 3
  }

the intended behaviour is that patterns 1 and 2 must not
overlap with each other; if the insn matches neither then
we fall through to pattern 3 as the next thing in the
outer overlapping group.

Currently we generate incorrect code for this situation,
because in the code path for a failed match inside the
inner non-overlapping group we generate a "return" statement,
which causes decode to stop entirely rather than continuing
to the next thing in the outer group.

Generate a "break" instead, so that decode flow behaves
as required for this nested group case.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20201019151301.2046-2-peter.maydell@linaro.org
---
 scripts/decodetree.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/decodetree.py b/scripts/decodetree.py
index 60fd3b5e5f6..c1bf3cfa85f 100644
--- a/scripts/decodetree.py
+++ b/scripts/decodetree.py
@@ -548,7 +548,7 @@ class Tree:
             output(ind, '    /* ',
                    str_match_bits(innerbits, innermask), ' */\n')
             s.output_code(i + 4, extracted, innerbits, innermask)
-            output(ind, '    return false;\n')
+            output(ind, '    break;\n')
         output(ind, '}\n')
 # end Tree
 
-- 
2.20.1


