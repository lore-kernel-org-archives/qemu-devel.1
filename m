Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D36C433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 17:11:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C976D22267
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 17:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O47yN3Nm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C976D22267
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQvvS-0000zv-Pq
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 13:11:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42686)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kQvcs-0002Ze-6N
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 12:52:14 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:39158)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kQvcq-0007iA-LP
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 12:52:13 -0400
Received: by mail-wm1-x341.google.com with SMTP id d3so10489330wma.4
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2020 09:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=xxXWxKizn/lVyR11Xmdsd0GJ0izeub2T+HCp1i8nNh0=;
 b=O47yN3Nm17qWQV0H58o9A7N7YrEk4q3ZI7DxXbfWXrl0QNQhHl05Vt+DtWXAiMmhHs
 ZsdCSxRNbeqgFOXiAAemZrYEXj2bHlkn5hBNqYa5VIYzyvxGEqMUvDEPikIMLIykf+HH
 y7uVg6DGqBnikzVjtLvTS2PiLy0U+ScUFQCM6v1x2eUnvp7rbMqLxZ5F7WGS8DmCnIiZ
 OrYtDNQ17WBmCOKTXOMoHKPQ4xYyfJjfqUl8qBqzLRGQtkLx7aWpxG9rbTs0FcH3oh2H
 JdhtjaBXEsQlsrDnjSYTLTbrQeNAH5188DV/5SAgO7UXoxjugy11uEbkNtmQmzrmy2oZ
 vhSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=xxXWxKizn/lVyR11Xmdsd0GJ0izeub2T+HCp1i8nNh0=;
 b=n5O3xvGe3z0/0qy2O1KxbFiDC2g7i8qLLXJqgOGwxMfNxqhdk8NqZe6Yfr1NfqKu5b
 L5q+p9rTxrL+AHMFMDoqv8bqTuQz7JZxtNkmUgTyxZjASxO3rtzu677iQxypEcG03XVJ
 FuhiP+RjdhX+rhsmVvIU0u+0dDxpAiZW4nibsgbXAEtow/kmgx+ga7GUsMDP2LX3chbE
 BTis4GB1nvKVqbUbPj+dMlp1BlvuSXSygGvisSgRiqGwpigUJvWEFWr7UX5jxenEje2B
 MLD4XqBbkJmT2XSgk7vk0UZm9Ca6yFKwmEOv3r22Xy1lqidO+mJOiRbixNyMwjLILE3K
 XrcQ==
X-Gm-Message-State: AOAM530QLq9yqAZvqOcCLjETgIDsnjfQLWPvHJnUCvbJF1JUUR0tCTvr
 VAyoaW9a/m8asbt5DIrpa6x38fp/9KM=
X-Google-Smtp-Source: ABdhPJwzHObGhcLEkFFTjkXBVho96KxnM8Nz3gpwY+mmXWeI9uGUafxQQ5bUIDtpL2Zbua8IQVBZzA==
X-Received: by 2002:a1c:6488:: with SMTP id y130mr14887823wmb.94.1602262330751; 
 Fri, 09 Oct 2020 09:52:10 -0700 (PDT)
Received: from x1w.redhat.com (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id p13sm12777125wmb.5.2020.10.09.09.52.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2020 09:52:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/5] MAINTAINERS: Update MIPS sections
Date: Fri,  9 Oct 2020 18:52:03 +0200
Message-Id: <20201009165208.2905569-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
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
Cc: Chen Huacai <zltjiangshi@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Volunteer to maintain MIPS TCG.
As discussed on list, Huacai will likely send a similar patch.

Few more adjustments (in particular around Boston board).

Based-on: <1602103041-32017-1-git-send-email-aleksandar.qemu.devel@gmail.com>
https://lists.gnu.org/archive/html/qemu-devel/2020-10/msg01974.html

Philippe Mathieu-Daudé (5):
  MAINTAINERS: Put myself forward for MIPS target
  MAINTAINERS: Remove duplicated Malta test entries
  MAINTAINERS: Downgrade status of MIPS Boston to "Odd Fixes"
  MAINTAINERS: Update Paul Burton email address
  MAINTAINERS: Move MIPS GIC timer files to Boston board section

 MAINTAINERS | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

-- 
2.26.2


