Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF4D6C742A1
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 22:35:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA2D420872
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 22:35:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qOyQBIRx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA2D420872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlhfO-0002Ke-K4
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 18:35:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40529)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.bobek@gmail.com>) id 1hlhdP-0002Dk-BI
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 18:33:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hlhdO-00049o-5H
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 18:33:51 -0400
Received: from mail-yw1-xc41.google.com ([2607:f8b0:4864:20::c41]:36083)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hlhdL-0003ex-Pi
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 18:33:47 -0400
Received: by mail-yw1-xc41.google.com with SMTP id x67so3129377ywd.3
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2019 15:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=p8Rb02xdn2cFJX2nERS/g1PcKR1NF5p4AWJrFwb0S5I=;
 b=qOyQBIRxz7BUTd1bOeLnpFoU1J21KkvJMaDCqmUUT6aETKq7HZVBIb1iTYDYJIiSyt
 Jik2BFMzlAgcWCLqnUgJK6vUc6iuRXxfdemIYsfeIJaKou1cSD+CeqhRuyqTbQRhKHsH
 0L3A8FrDl5hX8csFVTo+xqZ2bnAXb0BN3yPD1lqHudS7I8y5pMIPBLCGavf5qATCr0Cp
 yQfrR6iK+lBpolYKHsOJ4Wr4yQrvmttPyZgyFtquIY3GX0c+Ew7QX5pyvw6Tnmo6excm
 LSsje0kcbYTTKUVTkxA9N6bBgfyUH5iVQwBOItyPFAgzQyDCqBgGrX/mFNmyBNg+dD7G
 L46A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=p8Rb02xdn2cFJX2nERS/g1PcKR1NF5p4AWJrFwb0S5I=;
 b=JSctrLlQMF5Bvcv4Uw+uCiJxPh+aVXBRmBESxPww0dh4D3rcYJTNJK7UUvPcTT8AN3
 jk0KloX4vuru/7Vd84vKm6FcOoUmwuxWcJyi4SBueRHAMCzRkCOe0x+3QF6Ex2gjKHU2
 S3jKybesGwVrEbV34ILZxnUM1ttjnpHd99X5zrHACgZ9u11xh8z/IM+ka6RActk1FFXu
 /q69Nc+42SYWZd1IdW7xZC5MGNH32B/GOzE49YC6gAo6oDmAU9WzXz/HTGDYxNociDhT
 4I44ZYhLzABrLRVY2bPUB/yntRTOPAuF3nZr7t/bNSS2E/YrOlNlZuvxZ9XDmP4karPt
 LG4w==
X-Gm-Message-State: APjAAAUrBVx3ucDFKnAZeaiNAn6lbgIyzxOqqHgFJo5a9ZDGrqe9zvXq
 s3SdI5DS45nAYanfHL+sZ9px/pWv
X-Google-Smtp-Source: APXvYqzsvB7WLw/q+tfun7YT/LHji9KRFPtAyPKGVH69+T3Bsgn+GAqozFTP4E6o9Iew8RWSItbMlw==
X-Received: by 2002:a81:710a:: with SMTP id m10mr3518292ywc.277.1562884397492; 
 Thu, 11 Jul 2019 15:33:17 -0700 (PDT)
Received: from dionysus.attlocal.net
 (69-222-133-165.lightspeed.tukrga.sbcglobal.net. [69.222.133.165])
 by smtp.gmail.com with ESMTPSA id z191sm1676728ywa.31.2019.07.11.15.33.16
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 11 Jul 2019 15:33:17 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu, 11 Jul 2019 18:32:49 -0400
Message-Id: <20190711223300.6061-8-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190711223300.6061-1-jan.bobek@gmail.com>
References: <20190711223300.6061-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c41
Subject: [Qemu-devel] [RISU PATCH v3 07/18] risugen: allow all byte-aligned
 instructions
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
Cc: Jan Bobek <jan.bobek@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Accept all instructions whose bit length is divisible by 8. Note that
the maximum instruction length (as specified in the config file) is 32
bits, hence this change permits instructions which are 8 bits or 24
bits long (16-bit instructions have already been considered valid).

Note that while valid x86 instructions may be up to 15 bytes long, the
length constraint described above only applies to the main opcode
field, which is usually only 1 or 2 bytes long. Therefore, the primary
purpose of this change is to allow 1-byte x86 opcodes.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 risugen | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/risugen b/risugen
index e690b18..0c859aa 100755
--- a/risugen
+++ b/risugen
@@ -229,12 +229,11 @@ sub parse_config_file($)
                 push @fields, [ $var, $bitpos, $bitmask ];
             }
         }
-        if ($bitpos == 16) {
-            # assume this is a half-width thumb instruction
+        if ($bitpos % 8 == 0) {
             # Note that we don't fiddle with the bitmasks or positions,
             # which means the generated insn will be in the high halfword!
-            $insnwidth = 16;
-        } elsif ($bitpos != 0) {
+            $insnwidth -= $bitpos;
+        } else {
             print STDERR "$file:$.: ($insn $enc) not enough bits specified\n";
             exit(1);
         }
-- 
2.20.1


