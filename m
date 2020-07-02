Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD6AC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 17:42:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BFB22084C
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 17:42:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vQt6ybBr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BFB22084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr3EJ-0001iG-7Q
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 13:42:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49358)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jr3AJ-0003pm-TA; Thu, 02 Jul 2020 13:38:28 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630]:34033)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jr3AG-00077P-L6; Thu, 02 Jul 2020 13:38:27 -0400
Received: by mail-ej1-x630.google.com with SMTP id y10so30710221eje.1;
 Thu, 02 Jul 2020 10:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NbDpYQtpN2i4s7h0UV7Panm1xJtD5WgUzdK+4fpnuUU=;
 b=vQt6ybBr9wWLh0WiWpOA8evDletDnH3VlTyovTUmMU1FadZlYI60vWEbTrC0ix0j3w
 4fNDAyJYUAtcU64O03PoEAvuxIf+Lge3pC061Cy6bSCCUkQqLqB/hSi7mK+VopsbHBPm
 OpKflPSr+wwQ94Luk+emM1yAc1GsfXicEhN4FPN/lw570RYq0dhTtqvdeJOD9X6xccMr
 P6HpL55rqG5Nn+TR1IQWvvC3XgM27EdBsQ3TgpCRYeai9JU941OB36cz8kwAR6hDZp96
 l23ic3w3eLIEOn/ZeeIs0+iSjv/iwZqTDdm5bKSrTElLCxzvXY2cVa21lbnmOQn6Kac+
 lS/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=NbDpYQtpN2i4s7h0UV7Panm1xJtD5WgUzdK+4fpnuUU=;
 b=RGiTCcbxln5mtevgrEehVkrNZF9FWwVJXZ1BfDBnJxziW96BwvD6YBZU/TaQ7T9O63
 yJRfMuNIOaLnmNOKQ5bc0wp9CSoGRLyuTE7Jsz/BkDz0FOf3iaVs7jpPb6hK5ZaTKPcN
 bntYfhMbmZ4S4yu+3/OEDklb8MUZqob9LJdNlU7JBdrA4d4uVBVX1jgFq6/KlkXwsSuH
 c6Dr8kL0KQ53xVDLQsS0M13MkgLKFXbiaxeHiSgSJGdJjnzTYdFd5t3aGrvGEe3is+xF
 dGTehycaZIhhJZnWZFMeapcpq3bMDOwfKNe/UR5nETmPl5McyiYu8UXFCeTF5HbzOq+t
 xNrQ==
X-Gm-Message-State: AOAM533wcj1QB66N3G80A8qB4zf8Tc2K04Jyv68wLDzTFDTY3rzjMwMb
 QijDUHVR48UKQN9J+c5jVKptSEAyJ2Q=
X-Google-Smtp-Source: ABdhPJxlTHwNmSEqGlUaTml+1CgMmw4TbxU+tGBdCjMNjR+ymRPMlu3W6AIEpZiNcq7rl/4xD9v7Hw==
X-Received: by 2002:a17:906:8316:: with SMTP id
 j22mr27870192ejx.97.1593711502558; 
 Thu, 02 Jul 2020 10:38:22 -0700 (PDT)
Received: from x1w.redhat.com (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id w20sm5710344eds.21.2020.07.02.10.38.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2020 10:38:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 02/19] .mailmap: Update Paul Burton email address
Date: Thu,  2 Jul 2020 19:38:01 +0200
Message-Id: <20200702173818.14651-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200702173818.14651-1-f4bug@amsat.org>
References: <20200702173818.14651-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x630.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Paul Burton <paulburton@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Update Paul Burton email address to avoid emails bouncing.

Cc: Paul Burton <paulburton@kernel.org>
Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 .mailmap | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/.mailmap b/.mailmap
index e46e6c7302..b1e4cd97ad 100644
--- a/.mailmap
+++ b/.mailmap
@@ -50,9 +50,10 @@ Filip Bozuta <filip.bozuta@syrmia.com> <filip.bozuta@rt-rk.com.com>
 Frederic Konrad <konrad@adacore.com> <fred.konrad@greensocs.com>
 James Hogan <jhogan@kernel.org> <james.hogan@imgtec.com>
 Leif Lindholm <leif@nuviainc.com> <leif.lindholm@linaro.org>
-Paul Burton <pburton@wavecomp.com> <paul.burton@mips.com>
-Paul Burton <pburton@wavecomp.com> <paul.burton@imgtec.com>
-Paul Burton <pburton@wavecomp.com> <paul@archlinuxmips.org>
+Paul Burton <paulburton@kernel.org> <paul.burton@mips.com>
+Paul Burton <paulburton@kernel.org> <paul.burton@imgtec.com>
+Paul Burton <paulburton@kernel.org> <paul@archlinuxmips.org>
+Paul Burton <paulburton@kernel.org> <pburton@wavecomp.com>
 Philippe Mathieu-Daudé <philmd@redhat.com> <f4bug@amsat.org>
 Stefan Brankovic <stefan.brankovic@syrmia.com> <stefan.brankovic@rt-rk.com.com>
 Yongbok Kim <yongbok.kim@mips.com> <yongbok.kim@imgtec.com>
-- 
2.21.3


