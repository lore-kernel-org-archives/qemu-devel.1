Return-Path: <SRS0=Dt9u=7G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B235FC433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2020 11:03:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BCF42075F
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2020 11:03:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rEzSSZnN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BCF42075F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcoPa-0004H1-Fk
	for qemu-devel@archiver.kernel.org; Sun, 24 May 2020 07:03:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56872)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jcoNi-0002ZN-Rs; Sun, 24 May 2020 07:01:26 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:50360)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jcoNh-0007lV-Um; Sun, 24 May 2020 07:01:26 -0400
Received: by mail-wm1-x334.google.com with SMTP id v19so7148204wmj.0;
 Sun, 24 May 2020 04:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=587uGWBeh2u8pEjvdLajav7ErpcNGmzE+u6D/+rFLyg=;
 b=rEzSSZnNIniD8A3vAOLlolTIoqU9qOf2PbD5KHFcALvuHnin8UxLBgDwelMMNooNo0
 RgNxFIdfIFSGOfQLikPOQGUCSycJMzFaESjZ5IDg4cap2QmKpSLGXGG9ymSTmPNoi77L
 47zOxYlkU9BAxxRtbeuvYdnybNvtcRuESO5DYY0KY+hFlXg3fUGGWyPUZKfWhAAwQJRH
 oDd8VJKrfk7QmGiXFqbqyhcV/WNwCeqL1PJ3IHx27eXJpmxstq6iT6pqmMu/MxebEbx5
 trmxeB4lah0gkUG1bCPfzC/dKgwmYRDYBeXrTz5qYRW81KxJFVlu6UelWLDxu6uhDvYd
 e6oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=587uGWBeh2u8pEjvdLajav7ErpcNGmzE+u6D/+rFLyg=;
 b=gU3LuRMsMOaFF3ghWMFhBIoGh6fj2SV7Eu9qL7SByUPAzzR2f/DYXqKDsM6CFHe/wN
 EXC+VNpa4xqhlF3eV3AYQHoDvmyrbEhzBLwYx6yESGBmt4TL/u9vyN/cWHmv2CqrAMm4
 Aczj6AiZBszYNn2gZ5F+FiF/Z8FptZzNULDkd8DHGJTrCRqWBSt6q9rnAorUe5AZB7MZ
 9vDoFWPX+cpd8VmvaoqkGRqVssSnSAqjG2+cYHPuaEKhnY4Ra4KLSZmvGU72g7vFPDjM
 TuMgdBSaoMou2YWrF/BxrcwmORJ8481Y48Gj2hE2dEu2IX7gJn8oWmnugDz5Yk3uyIrq
 fCpQ==
X-Gm-Message-State: AOAM532jBldb57DxcdDn5tIgl0Rlsrnodirs8w/EXy5qC4keIwUM1wq2
 ZiecLyO5PURX1bRBbLB82rFYm5v8DXY=
X-Google-Smtp-Source: ABdhPJzbxaX2dRQAYnDegrLdY8KTLWZPQAU9KS1ep/fe11/ijKWgujDysNYrZWhm+5wecv1s78ZJtQ==
X-Received: by 2002:a05:600c:290f:: with SMTP id
 i15mr21158188wmd.153.1590318083539; 
 Sun, 24 May 2020 04:01:23 -0700 (PDT)
Received: from localhost.localdomain (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id r3sm14321555wmh.48.2020.05.24.04.01.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 May 2020 04:01:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/4] hw/display/cirrus_vga: Convert debug printf() to
 qemu_log_mask & trace
Date: Sun, 24 May 2020 13:01:17 +0200
Message-Id: <20200524110121.12686-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x334.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-trivial@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Replace debug ifdef'ry by qemu_log_mask() and trace events
when appropriate.

Philippe Mathieu-Daudé (4):
  hw/display/cirrus_vga: Convert debug printf() to trace event
  hw/display/cirrus_vga: Use qemu_log_mask(UNIMP) instead of debug
    printf
  hw/display/cirrus_vga: Use qemu_log_mask(ERROR) instead of debug
    printf
  hw/display/cirrus_vga: Convert debug printf() to trace event

 hw/display/cirrus_vga.c | 119 ++++++++++++++++++----------------------
 hw/display/trace-events |   2 +
 2 files changed, 54 insertions(+), 67 deletions(-)

-- 
2.21.3


