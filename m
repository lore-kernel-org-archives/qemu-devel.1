Return-Path: <SRS0=Kewn=DL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A73AC4363C
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2020 18:17:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 809D8205F4
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2020 18:17:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qZfIU79y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 809D8205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kP8ZD-0000VD-LQ
	for qemu-devel@archiver.kernel.org; Sun, 04 Oct 2020 14:17:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45974)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kP8Nf-0002TJ-GX
 for qemu-devel@nongnu.org; Sun, 04 Oct 2020 14:05:07 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:37407)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kP8Nd-0008K6-R9
 for qemu-devel@nongnu.org; Sun, 04 Oct 2020 14:05:07 -0400
Received: by mail-wm1-x342.google.com with SMTP id j136so6555593wmj.2
 for <qemu-devel@nongnu.org>; Sun, 04 Oct 2020 11:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=eSsQ1tRNEnDrBinG2AD7nicmckt9bWMjE+UJknFeEd0=;
 b=qZfIU79y4dRuXEvguEqm1mv2IYG/qUyusblGAAh6OJHY5G1KrpxTTNUNau3v+0mDA3
 X0mafqerUWV9CdxX6M+Vo4SdG/6jZaniQkGgr2CYQLO4y0a4b/ee8CTdBd1OYrRwAq2B
 Jfhdb6THQZjCF0CzhIhjF624lxNzdzP/nzJMmXj0AwPEHnyjbE3yeDZZ1ethp+ttjz+l
 zl30EGl/htc27hzJsCPdIED8A2FDwxIGmNG5lBO18DYGldrbvL2DJsQibSpiOPkYpRY0
 C+iE/QBO9D4tnez2N8oLy0swvvBarYDQIiOYAlEjNuof7ntDwZmNpX/kAk1c1x6e6XSt
 wUTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=eSsQ1tRNEnDrBinG2AD7nicmckt9bWMjE+UJknFeEd0=;
 b=CP8ZgM14ImLxNOAVbtg7oWEx2tzrGPor3b4JBVzvtOcUVS/AGTGgPJwskKNYNlt7nX
 iXKiYC86FkZ/QGLYtWupj2GvECnEaXL8fkybWK7lo4/gHzLNQlGKRVT2rgOqAIpxX7s7
 YQIu80zlwxlFC/im4/DG9NQCSOETJG6VSpgRb9cV9doUoEwDi9RH9OMpr8krHJYfAvfw
 5LIAzgiKceNfQujpjnSoIz8x10BDl5fZuVq9Gr/VOPt6SHUGu4znNdJm1nO08oY5elR6
 Q+w9EZfnKKFL9WSgjQbY4QzrOrHUvYreOyBLGEoSamzVugy7ix1sYSxCgTeaISvZMR6D
 5BEg==
X-Gm-Message-State: AOAM531qE2QD3nmfzvb6FaoRQGayoPjooDAKivVx7uKZqjoLZea3gS4J
 SkidAjUzqFO/j0AxChs2xeMl51wuBiVCew==
X-Google-Smtp-Source: ABdhPJzLzYvKZs/Tx3ZPjbY8bcnfH+tZhLpOqhi9ICzuCYQSgNzD5MWis3CbSH1Rrtr8Nnn5ZEkbmw==
X-Received: by 2002:a7b:c305:: with SMTP id k5mr13416670wmj.102.1601834704310; 
 Sun, 04 Oct 2020 11:05:04 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id j10sm9593202wrn.2.2020.10.04.11.05.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2020 11:05:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 13/21] contrib/gitdm: Add more entries to the Red Hat
 domain
Date: Sun,  4 Oct 2020 20:04:35 +0200
Message-Id: <20201004180443.2035359-14-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201004180443.2035359-1-f4bug@amsat.org>
References: <20201004180443.2035359-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
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
Cc: Nir Soffer <nirsof@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Nir Soffer <nsoffer@redhat.com>, Frediano Ziglio <freddy77@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Frediano Ziglio <fziglio@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc: Frediano Ziglio <freddy77@gmail.com>
Cc: Frediano Ziglio <fziglio@redhat.com>
Cc: Nir Soffer <nirsof@gmail.com>
Cc: Nir Soffer <nsoffer@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
To the developers Cc'ed: If you agree with your entry, please
reply with a Reviewed-by/Acked-by tag. If you disagree or doesn't
care, please either reply with Nack-by or ignore this patch.
I'll repost in 2 weeks as formal patch (not RFC) with only the
entries acked by their author.
---
 contrib/gitdm/group-map-redhat | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/contrib/gitdm/group-map-redhat b/contrib/gitdm/group-map-redhat
index d15db2d35e..0419e82795 100644
--- a/contrib/gitdm/group-map-redhat
+++ b/contrib/gitdm/group-map-redhat
@@ -6,3 +6,5 @@ david@gibson.dropbear.id.au
 laurent@vivier.eu
 pjp@fedoraproject.org
 armbru@pond.sub.org
+freddy77@gmail.com
+nirsof@gmail.com
-- 
2.26.2


