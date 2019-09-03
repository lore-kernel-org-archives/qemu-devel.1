Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB4BC3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 15:52:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBE9722CF8
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 15:52:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qun0RvSY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBE9722CF8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5B6N-0000Lo-IU
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 11:52:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59318)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i5ArZ-00032v-4n
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 11:36:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i5ArY-00062S-59
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 11:36:56 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:33966)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i5ArX-000626-VY
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 11:36:56 -0400
Received: by mail-wm1-x32d.google.com with SMTP id y135so317617wmc.1
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2019 08:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=zfQZN+w0EL38uUZUufAKEIUIh1fjw2w5B/j+/inz4Vo=;
 b=Qun0RvSYQ9BP0q+i6s1Hywx4IUDRnV7hAiEksFstrvODhvU0xlRJRPKtADPk82TGA/
 uuFexQ3vM1eleDcXX+NCcH2A00lYaK1VxznwPwlMKEMcozlalFOSJPexv2cnvd9f3oaL
 N6NUXaSz/yBkJPkUZbhXzH1xJqI9SPYjmmUgaXztoYjZWeB8elg3tOJKbQoS0fhOXAqU
 buQIhB48OGG7zt4+gps8U33JMK+dRnTzGBU2I+1dhoWSE9+Ic44W/PqQzK/LnwPwKr7Z
 4C3h3W8xdY2cilioYAn4TDBQW/1/T5IcT7Iz/7QLJdpo65nHURV3af/k7O70EG/uYHwl
 Pvcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zfQZN+w0EL38uUZUufAKEIUIh1fjw2w5B/j+/inz4Vo=;
 b=p8pFGVSD87FQ7i4O9H8ZBkMiVnKMd9Mz3b0MtuwafA1Dlh+baCRlz1Gmub6P9cazsn
 fKftaWuNves3FkNR6RM47NsI/FjzOL9W3vuvZg4o7dwGkncuLa8AsOJY+daowetpAIym
 MO53XFWg8Dbyb73pLsiiwZlRw6Ylf8bLzj8efR5vLODRWXcmacIZBcyXlA6+OezeOEQy
 7s48nG0OK9WZwo6PtmML1fWzDX2SxXdr43JHRG8mEMyC2PIeB/XUhxPWoN50tp26SWa8
 igkn+CxuNJmF2FwmpVCbToTSaqTrWyXs4YG2r8Ax2tJCv0mNPoFe+h4HLIuVCh1RjwYe
 PdDw==
X-Gm-Message-State: APjAAAUBC+B5K3Fs0z4SUTOm/5f+rM0DNZ49o0v3E1WVY9GuGb2GOxRN
 14aRzcwowi/stq2oXoQXq1u7BvienCT/Ag==
X-Google-Smtp-Source: APXvYqy8DpRW8R0o1yBZVXE/LwvsRPHufSh6V++aObJsmXg/Nf7IYBWWPmfgBSFNP78sZp5kJpvuug==
X-Received: by 2002:a7b:c922:: with SMTP id h2mr833701wml.63.1567525014850;
 Tue, 03 Sep 2019 08:36:54 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id a18sm24435188wrt.18.2019.09.03.08.36.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2019 08:36:54 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  3 Sep 2019 16:36:28 +0100
Message-Id: <20190903153633.6651-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190903153633.6651-1-peter.maydell@linaro.org>
References: <20190903153633.6651-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32d
Subject: [Qemu-devel] [PULL 16/21] includes: remove stale [smp|max]_cpus
 externs
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alex Bennée <alex.bennee@linaro.org>

Commit a5e0b3311 removed these in favour of querying machine
properties. Remove the extern declarations as well.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190828165307.18321-6-alex.bennee@linaro.org
Cc: Like Xu <like.xu@linux.intel.com>
Message-Id: <20190711130546.18578-1-alex.bennee@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/sysemu/sysemu.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index d2c38f611a3..44f18eb7394 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -42,8 +42,6 @@ extern const char *keyboard_layout;
 extern int win2k_install_hack;
 extern int alt_grab;
 extern int ctrl_grab;
-extern int smp_cpus;
-extern unsigned int max_cpus;
 extern int cursor_hide;
 extern int graphic_rotate;
 extern int no_quit;
-- 
2.20.1


