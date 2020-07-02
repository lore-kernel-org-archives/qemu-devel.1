Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA8BC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 17:45:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85E9620885
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 17:45:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FIBd8uki"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85E9620885
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr3Ge-0006JM-Mz
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 13:45:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49472)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jr3AV-0003xZ-SV; Thu, 02 Jul 2020 13:38:41 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:43151)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jr3AR-0007Gx-En; Thu, 02 Jul 2020 13:38:36 -0400
Received: by mail-ej1-x641.google.com with SMTP id l12so30696277ejn.10;
 Thu, 02 Jul 2020 10:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lJEClF0ykPmA0zMPpk63shaNECrfZX7s+G5FZ1QSs2g=;
 b=FIBd8ukicr2bdCVFgJk5zpGqcvoGIOnGJPAOlpoNG3Q76Vt2qAWpvBaN32P1/WZchD
 VmzMGJ0H6FalfaE5v/gMks7GaGl+e0ynbmKpDOLZNZVaq7eBjGIXiAh3ZqVnFm1yTYmw
 MGbZHr+dDQ8mPP24tr8MmZmrsvTKY3WtofYavh6/EJcVEyxubF6wBUqkj9ug2XLEzBHa
 T5iYQgLXUqp5TXYus5I0CD+wi69JH0a0mkRHg3IFhEnbtkoYBB88Yigdfo+cyB/0h7v+
 J9+xNNTCPmVNtmYd//5+7SpItSsTBr1rbVsDnRG+Ey2RhqEwhdlcQtHuVQafioVwnW4T
 hasw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=lJEClF0ykPmA0zMPpk63shaNECrfZX7s+G5FZ1QSs2g=;
 b=mo1fwbCmTgIfbgCeeM6ztBiP9z10P7N/sILG9Av+tlntfIzzwz9sgDKWB+ykA2NoxF
 6GSOFwae2anE8jJVYVuIj3XlH+N46qpnBVGGW370QLpDCm9TDEC8yjJ1F6vJaEBehO9h
 fBtmkS6NKsMCqnOhB0ebkNXdMR/ObRJ5OuNevoG4bwkvkT+7Ig28dXU0YQ2jBBODU6n5
 ObneC77hWGfJi1aVjAgXSbhyRUQstHmnqOMM7yGBez5EOdzFfyg2ceE7xb99gwgDXODN
 o5FMK8CG8Oo+2Z5MzIYA3RCqv+1947zuky5MwO0Vvq2EJLQQfvacifFG/CgJGUn4c51E
 jacA==
X-Gm-Message-State: AOAM5325+t0jzy04l9pgcUnCGzOlKmp5sTuEAW4uC4r5MfCMp9somzwZ
 Eo+4Gb6qOQwwCj/tvAg7McJ57VTOhjk=
X-Google-Smtp-Source: ABdhPJwog5FyynGEdDwbXmOHx95JP2BSH0BRlC65qTyFKMDrwX5K9oaf+r4eNaUyHXWW78QmcBmJzA==
X-Received: by 2002:a17:906:a449:: with SMTP id
 cb9mr9327234ejb.115.1593711511097; 
 Thu, 02 Jul 2020 10:38:31 -0700 (PDT)
Received: from x1w.redhat.com (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id w20sm5710344eds.21.2020.07.02.10.38.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2020 10:38:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 09/19] .mailmap: Display correct email address for
 Jean-Christophe Dubois
Date: Thu,  2 Jul 2020 19:38:08 +0200
Message-Id: <20200702173818.14651-10-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200702173818.14651-1-f4bug@amsat.org>
References: <20200702173818.14651-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x641.google.com
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
Cc: qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix Jean-Christophe Dubois email address in the following commit:

  $ git log --author='jcd@jcd-laptop.(none)' --oneline
  5d92886792 fix qemu_alloc/qemu_free for audio subsystem

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 4e9e54368d..66118f3d1e 100644
--- a/.mailmap
+++ b/.mailmap
@@ -102,6 +102,7 @@ Hiroyuki Obinata <hiroyuki.obinata@gmail.com>
 Jakub Jermář <jakub@jermar.eu>
 Jakub Jermář <jakub.jermar@kernkonzept.com>
 Jean-Christophe Dubois <jcd@tribudubois.net>
+Jean-Christophe Dubois <jcd@tribudubois.net> <jcd@jcd-laptop.(none)>
 Jindřich Makovička <makovick@gmail.com>
 John Arbuckle <programmingkidx@gmail.com>
 Juha Riihimäki <juha.riihimaki@nokia.com>
-- 
2.21.3


