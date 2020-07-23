Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5537DC433E4
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 11:19:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21F97206F4
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 11:19:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uRSrXdGA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21F97206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyZFw-0004C5-A4
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 07:19:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35918)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jyZFM-0003kd-Lq
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 07:18:44 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:43429)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jyZFL-0006ok-Aj
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 07:18:44 -0400
Received: by mail-wr1-x441.google.com with SMTP id a15so4770576wrh.10
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2020 04:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=aLvcWRQgITp382d3UZsBk/qwMeXtqhkfan9BdjQD9e0=;
 b=uRSrXdGAwwkbm0c65poMcgCA38J0C+Dpse5N6Ynud0In8plzfHPtKrLIM+bFo5Wf31
 fPDxanjQI5zWgNg2702dlYbCAW0996+OX17wo29m6Mo/mWhAKJlBRZFNj5h/VvG/0bIb
 Zkqrf5w22x/zN6iq88xUEX1ArxRKzZNnjn7AvpvhPaTdcijd9hoT1PSojCE4+G7uZ3aX
 ncdAei2BVE5dq/UjdBiJuiCwm4cwFULJokG+rBYMTZWYI6QDF7ZzHhCO5QnWybO+osnO
 nSI7l4h6hGlVqk7fyF4jGmpfDTe8wizACGnQmOFG1BLumnx/+oj6XwpZH8kpFXb9gZqr
 lgug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=aLvcWRQgITp382d3UZsBk/qwMeXtqhkfan9BdjQD9e0=;
 b=MsZjnm5+dba5MFhf9rnlRz0/APLDz+JNGbuODTAb+s2Bad/fU1K6ufHchQ5pkcYF2A
 DcKK5nMN8PW95kObCL1ywa5iinmr5pQ9mCjNKs6CwB/a2voOpJSlOnh3tbuBybazAqlq
 8KDRsXqsVBMmTVqbB1UFvvilVmOElB5pVCa83fst3BOqLJs3TP85s2g8cwkoGXihHuQD
 OAxRjf94QIuIvPAQBXQrI3XS8/DXuZn5WU/U4dXhSQEareHYu/AXEZegVKVcGkrb5QKB
 NXm1mdR4VHcnKbXTJDyb983bdG4ysnvAv0UpB4D11SLzFmGFvhWFLdkqNMUqUSYWEyrz
 1STA==
X-Gm-Message-State: AOAM5333yRHwFHgNpL6bB7fqsArdw0uNiuvFGzYCIKz15Txa94EQ6lr4
 6IfQgcbMEXCR4OYt0vZfIf7GQ/h4XXs=
X-Google-Smtp-Source: ABdhPJz8nRcT4XOIe5xlFdthVCKTYNWjSU/n2FBtN5eZMsyfxPIhnQM9qg5cjhpD35KT1lza4q3P+g==
X-Received: by 2002:adf:f08a:: with SMTP id n10mr3811456wro.351.1595503121024; 
 Thu, 23 Jul 2020 04:18:41 -0700 (PDT)
Received: from localhost.localdomain
 (138.red-83-57-170.dynamicip.rima-tde.net. [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id y84sm3261917wmg.38.2020.07.23.04.18.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2020 04:18:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.1?] exec/memory: Fix memory_region_init_alias()
 documentation
Date: Thu, 23 Jul 2020 13:18:38 +0200
Message-Id: <20200723111838.32398-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The @size argument refers to the size of the aliased
section, not the original region.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/exec/memory.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 307e527835..10a809ee10 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -980,8 +980,8 @@ void memory_region_init_ram_device_ptr(MemoryRegion *mr,
  * @name: used for debugging; not visible to the user or ABI
  * @orig: the region to be referenced; @mr will be equivalent to
  *        @orig between @offset and @offset + @size - 1.
- * @offset: start of the section in @orig to be referenced.
- * @size: size of the region.
+ * @offset: start of the section in @orig.
+ * @size: size of the section in @orig.
  */
 void memory_region_init_alias(MemoryRegion *mr,
                               struct Object *owner,
-- 
2.21.3


