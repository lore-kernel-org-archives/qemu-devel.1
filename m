Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AA5AC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 08:53:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6883E20734
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 08:53:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SaUzt1n7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6883E20734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jg2gG-0003vw-MT
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 04:53:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37760)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jg2fL-000342-6Y
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 04:52:59 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633]:41830)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jg2fI-0005sC-WB
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 04:52:58 -0400
Received: by mail-ej1-x633.google.com with SMTP id x1so11936056ejd.8
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2020 01:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0aiJ8SjAfjtEtfAjYJ8qRaP7+MXTNxtkis9X5xM0HYo=;
 b=SaUzt1n7mktaZnfP7kkeoJBUHU7QRhtD+BjvDJqZJ1Lu4L501qMoVWbpMw62iSu/jG
 4IB6oX6wy9ZX5sDoUKJXIraOOEFWJ8F+PN3fwRoshZJLGdjiXq1Ylcw2DFd65+OlOQvU
 YpkIzchXS/XhShenggPR7CB8C7Fx24hWtOZePovzg4lqozS31OxiaxnbGngMdfXAkF0g
 MOYeIZiqnTrUlleuLSNX9ttduYEDWApp9iTtBO/a9UETZ6E3W+d4TTbUoQKMugOg4ae/
 BwFRPPzOzXspV4i4j8rrH7S62YQYPNxgknckj6daxPypwjY7ELjCKL6CniKeOUmvKXBD
 70uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0aiJ8SjAfjtEtfAjYJ8qRaP7+MXTNxtkis9X5xM0HYo=;
 b=C9ggoI4jHxIJ6Gskgc9HY0Y+Rr+36pBgSAc+5kmE3D0/ip5jDLB5O2oltga5CElpW/
 WCi9Tr1QICRdYYJlx54iJJeQJqdB70Mwk3CJ9idG4MLP3al6mnLqaG3YJRaWWv3ClUou
 s2vRUSTYUPdivYEOyfiySNLDdUwLcXM/k1yXwy6u7SuV0hwxDQuicdLoZxHj+NdL01xo
 nG0mxnoqlf0wAYnp8rsrQdpT4zm8hFHCInzP+jN+MaLeRbE0Vb670lKteTYU9lpFt4Iy
 QxCDupa1gbfQW+TCDg4L9RpUD2UHg10E+PD07xYWnkWy0x8hl9MwjlT7b/HddOPB3jdR
 Q1Sg==
X-Gm-Message-State: AOAM531lr9Mbr2lXEyUSsnStfiUi2dG/rIKzk5n31Cvc4i2HmLpaEYpe
 gry1PWy6wwc4TXlETCDt1ciA+jj2MV8=
X-Google-Smtp-Source: ABdhPJyePaVTTDqu/l1YJUfqlDqBd5xGjY+41Nw4b31AWgn7MOr8w63IHeqJJEUlyzH/BwypNcoLBQ==
X-Received: by 2002:a17:906:1b1b:: with SMTP id
 o27mr213601ejg.264.1591087975014; 
 Tue, 02 Jun 2020 01:52:55 -0700 (PDT)
Received: from localhost.localdomain (net202-35-245-109.mbb.telenor.rs.
 [109.245.35.202])
 by smtp.gmail.com with ESMTPSA id qp15sm1363601ejb.69.2020.06.02.01.52.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2020 01:52:54 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] mailmap: Change email address of Filip Bozuta
Date: Tue,  2 Jun 2020 10:52:14 +0200
Message-Id: <20200602085215.12585-2-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200602085215.12585-1-aleksandar.qemu.devel@gmail.com>
References: <20200602085215.12585-1-aleksandar.qemu.devel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-ej1-x633.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: aleksandar.qemu.devel@gmail.com, Filip Bozuta <filip.bozuta@syrmia.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Filip Buzuta wants to use his new email address for his future
work in QEMU.

CC: Filip Bozuta <filip.bozuta@syrmia.com>
Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index e3628c7a66..9f2a3a55f9 100644
--- a/.mailmap
+++ b/.mailmap
@@ -45,6 +45,7 @@ Aleksandar Markovic <aleksandar.qemu.devel@gmail.com> <amarkovic@wavecomp.com>
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com> <arikalo@wavecomp.com>
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com> <aleksandar.rikalo@rt-rk.com>
 Anthony Liguori <anthony@codemonkey.ws> Anthony Liguori <aliguori@us.ibm.com>
+Filip Bozuta <filip.bozuta@syrmia.com> <filip.bozuta@rt-rk.com.com>
 James Hogan <jhogan@kernel.org> <james.hogan@imgtec.com>
 Leif Lindholm <leif@nuviainc.com> <leif.lindholm@linaro.org>
 Paul Burton <pburton@wavecomp.com> <paul.burton@mips.com>
-- 
2.20.1


