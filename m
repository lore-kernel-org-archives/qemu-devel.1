Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 991A4C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 17:49:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 663EC20702
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 17:49:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qPzkEK85"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 663EC20702
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr3KV-0004yL-Hz
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 13:48:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49562)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jr3Ab-00041I-IO; Thu, 02 Jul 2020 13:38:45 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:44521)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jr3AX-0007Pl-Sy; Thu, 02 Jul 2020 13:38:45 -0400
Received: by mail-ed1-x542.google.com with SMTP id by13so14968392edb.11;
 Thu, 02 Jul 2020 10:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=48yCxchPLYjLZkO39SOQxJyD4cijxC1/mOpXB9e1+y4=;
 b=qPzkEK85sBjqcC3I5uZpipsPAxgb3hJKK7XpR54xnXTLUkn+K5R9bxQRHIzJ3uaFYB
 fxVuqaOzKo5NfTdBuIpxYhYBiuaiu5H4ohWw8S4VuzI+2uuMKzg/XQpOyY6OD44SYPNk
 V/ys/Kvwh/rvYQ21JjRaeUeFCSAXhQdNnnnbml5F2Q8O35mrpf/6kr53FRJUCBK2bQ+J
 BAzAZAUdw4pJfuNiqxI/oG9vj+GZVX1FzncwnbSuvXie/evNmC11Iqu6sdEbTf3iM8wP
 lDdLmm+TPX6Uc3TpPnY1JL3DvaBrCLgf+p6X3aG1SM33zUCSBNsa7pRRFVJ0Q3JPVRWW
 /NJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=48yCxchPLYjLZkO39SOQxJyD4cijxC1/mOpXB9e1+y4=;
 b=Yvio2fGq6np3mY0UUauflFQVkdVaSQhrgAQiRkmW2QPa1YMUE2TqgU+4T8vgDa5OQj
 JIELuf5xRYseEZUDIAjNu4MgKUsk/VHIT2Pl/P78lq6XWORyqnq+X7D0XzEl6yOI2YIZ
 OdMMoE/M6h2nNwKg7yhWjsbF060XH66hLq61ig/t1IFMY9zuMPaFGN4Psr5Gfx/FC+sw
 WgICfZzJQ6O3I5GGGVIRX6diloJxtb5r2qx7iAMxJX4RigbRP+4PJzdynkOUfsq8mcod
 VCaFHCYFvU403I9IkTsYBVIfNCeVF46ah95ITsO/RAfURpIr40z5GmpPrfpIHinsKaiD
 gGIw==
X-Gm-Message-State: AOAM5323v+5ctI+S7Wx3xgubBuWYNZVywiEbKNVRBdbBFFXXJXQP5Ka0
 17K+TDjAKoXZWXslU/kb3wpOmpfkkb0=
X-Google-Smtp-Source: ABdhPJwYMPW9lnYOZvMZdnbSvz+g6B+yPYhdJWvh/sgpo2MHJ7rXmIyBwHFN8PGYplipwgD/Wg9QJA==
X-Received: by 2002:a05:6402:1597:: with SMTP id
 c23mr34570324edv.243.1593711519165; 
 Thu, 02 Jul 2020 10:38:39 -0700 (PDT)
Received: from x1w.redhat.com (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id w20sm5710344eds.21.2020.07.02.10.38.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2020 10:38:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 16/19] .mailmap: Display correct email address for Richard
 Henderson
Date: Thu,  2 Jul 2020 19:38:15 +0200
Message-Id: <20200702173818.14651-17-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200702173818.14651-1-f4bug@amsat.org>
References: <20200702173818.14651-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::542;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x542.google.com
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
Cc: qemu-trivial@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix Richard Henderson email address in the following commit:

  $ git log --author=rth@anchor.twiddle.home --oneline
  7c5a90dd41 target-alpha: Fix gdb access to fpcr and unique.

Cc: Richard Henderson <rth@twiddle.net>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 2fa882d239..b06baa094e 100644
--- a/.mailmap
+++ b/.mailmap
@@ -150,6 +150,7 @@ Prasad J Pandit <ppandit@redhat.com>
 Qiao Nuohan <qiaonuohan@cn.fujitsu.com>
 Reimar Döffinger <Reimar.Doeffinger@gmx.de>
 Remy Noel <remy.noel@blade-group.com>
+Richard Henderson <rth@twiddle.net> <rth@anchor.twiddle.home>
 Roger Pau Monné <roger.pau@citrix.com>
 Shin'ichiro Kawasaki <kawasaki@juno.dti.ne.jp>
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
-- 
2.21.3


