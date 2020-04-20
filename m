Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04FBAC55182
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 21:23:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C518520782
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 21:23:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VQoiLqSx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C518520782
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQdt5-0008ID-VD
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 17:23:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42064)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jQdro-0006nR-5N
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 17:22:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jQdrn-0006kG-Fw
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 17:22:11 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:42853)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jQdrn-0006gf-3o
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 17:22:11 -0400
Received: by mail-wr1-x444.google.com with SMTP id j2so13992079wrs.9
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2020 14:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=jR1xP74Qc41hrsGlhwi6bPFQ+EgssQ3e/OSS6cjeibE=;
 b=VQoiLqSxqNcwNBHqL+X6tVNTcAUM0cvZnZ2mGUO1yLnBrYBVmmH5kmR85yWDlinRSp
 0fj3+yknAVmi/8gUoE5C+HXd1vp5VcJnm+W24LJs/pO1ibHnbAaHsRslBsa1iuK6ejOT
 0Zph/nMjQuP/d/urfsirDD9dNAE86en7AzpkwuSIf5CVKQO5PwujdKQVpXcQ4yeXflt0
 eKXJNDyTkDnrHkxH/Rt0anaGeKsG8BkT0KBIgiW84GtFNPOZkdkuqpRSlogPARlIyg/e
 wTOycxRSK6M1bwjsXhbqNw3tTf1TyvOuP/wFfRpA9o89mJVP0arxliIc+5KD5f2ugfgM
 oyNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=jR1xP74Qc41hrsGlhwi6bPFQ+EgssQ3e/OSS6cjeibE=;
 b=dzOV3dcf+5H+LOA+N5pLOp5pyVKQVEM7yZFphtDvq7MA3A+rd31hJe11bNWIQRIAfY
 M12xftinG/wI3f6kbxPRDlPolYSH3Gh0vBWK5cvRpshZkr0L9U1ppORs4GOHWsJ6S/6a
 bIftpJXNfWCpJDycaQutaS2zLyhSX6t045pVmtiEJGJaKilnygt9XPM0eZLpoYCzt7wC
 PAehG5/ZFePmFWv9kVUda+wWxgKKyqdCmrTGWsG3CXPXKqN/haq21E23NkJsrAEyg9c6
 IJjanhTWfVBfGwH7EiH46JgRcCzVSOiP/On4tuiBcU6FtR6Lu+nr7OfwtdrwxVTNQDW0
 aK+A==
X-Gm-Message-State: AGi0PuZ4AGC8GzEf6HBbPbBfyDZrdGSiQAt20RGRlJdepRbKtuihEoy1
 yOFVV6EqyvHdSVxYgWJnhlNDBw==
X-Google-Smtp-Source: APiQypJmE/Dxhu5iAMAogk/wYtPZ4kiAU43T6RwbljtmkMsWKOo03bsjJ7nOz75HIu2bGpo1EXwtaA==
X-Received: by 2002:a05:6000:f:: with SMTP id
 h15mr20403789wrx.408.1587417729496; 
 Mon, 20 Apr 2020 14:22:09 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id j10sm823663wmi.18.2020.04.20.14.22.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2020 14:22:08 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 0/4] linux-user/arm: Fix BKPT, SVC immediate handling
Date: Mon, 20 Apr 2020 22:22:02 +0100
Message-Id: <20200420212206.12776-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::444
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
Cc: omerg681@gmail.com, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patchseries fixes issues with the code in linux-user/arm/cpu_loop.c:
 * it incorrectly thinks BKPT is a syscall instruction
   (https://bugs.launchpad.net/qemu/+bug/1873898, reported via irc)
 * a stale line of code means we incorrectly NOP SVC #0xf0002
 * we don't implement the distinction between 0x9f0000..0x9f07ff
   (should return -ENOSYS if not implemented) and higher numbers
   (should cause a SIGILL)
 * we abort() for bad immediate values to SVC (ie not the 0 of EABI
   or the >0x9f0000 of OABI); the kernel delivers a SIGILL for these
 * for Thumb mode, we never use the immediate value from the insn,
   but we always read it anyway

This patchseries fixes all those things. (I started out fixing the
BKPT bug; everything else is problems I spotted along the way while
I was reading this bit of code...)

thanks
-- PMM

Peter Maydell (4):
  linux-user/arm: BKPT should cause SIGTRAP, not be a syscall
  linux-user/arm: Remove bogus SVC 0xf0002 handling
  linux-user/arm: Handle invalid arm-specific syscalls correctly
  linux-user/arm: Fix identification of syscall numbers

 linux-user/arm/cpu_loop.c | 145 +++++++++++++++++++++-----------------
 1 file changed, 81 insertions(+), 64 deletions(-)

-- 
2.20.1


