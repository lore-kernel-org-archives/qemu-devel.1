Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45A26C04AAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 14:52:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FDF620848
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 14:52:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y863flIN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FDF620848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59496 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRHkL-00061c-90
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 10:52:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hRHfX-0002Ze-8d
	for qemu-devel@nongnu.org; Thu, 16 May 2019 10:47:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hRHfV-0008Dw-UB
	for qemu-devel@nongnu.org; Thu, 16 May 2019 10:47:39 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:41764)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hRHfV-0008Bf-HP
	for qemu-devel@nongnu.org; Thu, 16 May 2019 10:47:37 -0400
Received: by mail-wr1-x443.google.com with SMTP id g12so3446110wro.8
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 07:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=fdK5c58nnMRXpbn7bDsZcFXFZe6V1MTgfq5dHpHbPUU=;
	b=Y863flINpkjnHg8eEMKgNUbADagVXogPOlbLeGJ9smdp1s43kvQLWXTq4vYxCTht5e
	CA9AhJFMD8xGPw/mCN6g/NgxAANqX1J3RJR1Xd/UBiekM6I1MEnOCexemWRAjYObotEV
	eYZKllxuzznoFPpmWjhY3O3PHEQFDOt815OaTkqt+oE8xr+Ad6H4qn7nUCSoWRQ/4P4v
	Ys9NhaKnLcbZwkAKgO8hba00bjBF7L3Mx9/B1p6ZJnUXnJTXat2qjt2zx67n3HoiyIRX
	ldoKrIHGSKUJv+PWvs9Utms/SeZ6N31I85JC4KEcrTUMWVfrDNtbhtPaECRxbbbutHES
	m85A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=fdK5c58nnMRXpbn7bDsZcFXFZe6V1MTgfq5dHpHbPUU=;
	b=OwymSpkNBMO7+1HaRNt/dJbiapzUiTW11e7pl3/1AnJ+fhgwkIV6i36ztSSXH7DmLC
	oFOskUrHHMCBvKcgng+FRn6wSq36SswgBTHi2JLEk0/h+THCHuND6KWE9xD4hyZoQNr/
	o7g3RWKlopTv+FqjJpF2rZd7k1OWjWrESoo6tlwT1IbiMBvbWwcGbdEF+K2W7fWinvul
	CKfWmubvwslBeiAMij0nZ6brOyOSD2yyKfZ6HIqqLAyjun8+Qv+Og5Up7ubCQwNUw4Sr
	6FZr5Y2szCBTEJ0JcMttusXY0vEjlQKJbgX+A6VfwouI4QyxyQkk52T0wpNBiOHUTrH3
	Ts8A==
X-Gm-Message-State: APjAAAVz4bPDtdTX7iVfDFpZDJr0yiIfq7hHiCpwfCRyPkEaTh+DX3FT
	Rh/gT4BtVRBfc9LYQpU3lTDcpg==
X-Google-Smtp-Source: APXvYqyjGI/8Nr4nOqFbMP7HGLLaszB+rkh0BFlBd1lvdFImsUtwDnCFAizbLvXnl3Zaoq98/X5DJQ==
X-Received: by 2002:adf:f8ce:: with SMTP id f14mr2333588wrq.110.1558018055916; 
	Thu, 16 May 2019 07:47:35 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id o8sm7629018wra.4.2019.05.16.07.47.34
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 16 May 2019 07:47:34 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Thu, 16 May 2019 15:47:29 +0100
Message-Id: <20190516144733.32399-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PATCH v2 0/4] hw/arm/boot: handle large Images more
 gracefully
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


This patchset attempts to fix https://bugs.launchpad.net/qemu/+bug/1823998
which reports that we don't handle kernels larger than 128MB
correctly, because we allow the initrd to be placed over the
tail end of the kernel. AArch64 kernel Image files (since v3.17)
report the total size they require (including any BSS area that
isn't in the Image itself), so we can use that to be sure we
place the initrd sufficiently far into the RAM.

Patches 1 and 2 are new since v1; patches 3 and 4 are the old
patches 1 and 2 (and are basically unchanged since v1).

Patches 1 and 2 in this series are new. Patch 1 fixes bugs
in the existing code where we were assuming that we could
treat info->ram_size as the address of the end of RAM, which
isn't true if the RAM doesn't start at address 0. (This
generally went unnoticed thanks to the magic of unsigned integer
underflow turning end-start calculations into very large max_size
values for load_ramdisk_as() and friends.)
Patch 2 adds some explicit checks that we don't try to put things
entirely off the end of RAM (which avoids those accidental
underflows).
Patch 3 in this series adjusts our "where do we put the initrd"
heuristic so that it always places it at least after whatever
our best guess at the kernel size is. (This might still not
be right for images like self-decompressing 32-bit kernels, where
there's no way to know how big the kernel will be after
decompression.)
Patch 4 makes load_aarch64_image() return the
kernel size as indicated in the Image file header, so that for
the specific case of AArch64 Image files we will definitely not
put the initrd on top of them.

thanks
-- PMM

Peter Maydell (4):
  hw/arm/boot: Don't assume RAM starts at address zero
  hw/arm/boot: Diagnose layouts that put initrd or DTB off the end of
    RAM
  hw/arm/boot: Avoid placing the initrd on top of the kernel
  hw/arm/boot: Honour image size field in AArch64 Image format kernels

 hw/arm/boot.c | 83 ++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 62 insertions(+), 21 deletions(-)

-- 
2.20.1


