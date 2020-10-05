Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F09BC4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 16:43:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26CE320774
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 16:43:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KoDujKor"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26CE320774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPTaB-0004fF-8x
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 12:43:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40700)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kPTLu-0007qF-2f
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 12:28:42 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b]:39797)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kPTLq-0006qt-AN
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 12:28:41 -0400
Received: by mail-pf1-x42b.google.com with SMTP id n14so7271692pff.6
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2020 09:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9ZjByY0MppOyobXen+0uddzbK8uVuelULUAbb8n9Gk0=;
 b=KoDujKorsvEv1J7uudO209ayCuD999q97L4tBQ/VUKhjQOAe9D1hw+Ooow8wGOY0M5
 +Qj00shF5N6QO5ydq2hS4Y01hLmd2gqeWa8N3Jyrvr2GUHh/Vkh4xtFIXb2TDEKT2jgy
 Fc9OfQ47JpO1/tOW23oCSfpby/BCcEm0tt3PQDaVTDnwjM/35yolJggtJTpoMzXPGIyJ
 OiLFSoaLK0udv6se+E4E/Xlz3Qv2gn5nA3bSOyirV8nUztqWz2S1MHtIMMKmJPfTyPqX
 Hj8+e5GSFby6zcQzFS96e1+5Drmi2aIW1ijF5nan6XbUkm3Jht0tyxcJYyLZdW5w48lV
 bUdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9ZjByY0MppOyobXen+0uddzbK8uVuelULUAbb8n9Gk0=;
 b=prcVlp3Fgvf0NN7EERKgxVysVbnocWO/xgfucD8m+Z8aoIdWUFi8wAVbWCnCWWbQz0
 Rq8RlVndZxzCsHNoozKz5vJT+TfRSgcbCfif5RslDHzLbMW9E3RGMXtXEfu3UEIWKqLf
 VFdrmXRDKloYv8Ut2+AKfX7OTSD5IWWLVgfhHajhgmWpO6dfQhaGEHeaLViBxaQJheub
 hd9LzRipfcojVxhBSemev5VsRcHqrxPxCJ8L5Bu7BiUXgv4UuiPVPDYU4Fb83e2z+puN
 X/xRwrkbjVTBgC4LqemaRAVVbSsqLlW1UVfL2HEOGlh1m7EWEtiRsShH7sqHCQ2hDnzD
 Rx9g==
X-Gm-Message-State: AOAM5325u8guz5gR+d/ox0iNhKbwAzVeF+DhE9zsVExaIVu8ed6lbTGL
 8M5QcaET/4+ZNGgWvPOZmdddwA7DFL1pFQ==
X-Google-Smtp-Source: ABdhPJyEvO3LKXmWtQaGfutHRe1mX1OVEq9cnTLorZS/gNn2uEqdB3S/XDI6BSURt95jwwOmKrk+Ow==
X-Received: by 2002:aa7:8397:0:b029:13e:d13d:a07c with SMTP id
 u23-20020aa783970000b029013ed13da07cmr303829pfm.19.1601915316232; 
 Mon, 05 Oct 2020 09:28:36 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id x13sm374725pfj.199.2020.10.05.09.28.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2020 09:28:35 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 6/6] cirrus: Enable plugin in cirrus for windows
Date: Tue,  6 Oct 2020 00:28:06 +0800
Message-Id: <20201005162806.1350-7-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20201005162806.1350-1-luoyonggang@gmail.com>
References: <20201005162806.1350-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=luoyonggang@gmail.com; helo=mail-pf1-x42b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 .cirrus.yml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/.cirrus.yml b/.cirrus.yml
index 86ea33926a..5363142373 100644
--- a/.cirrus.yml
+++ b/.cirrus.yml
@@ -104,7 +104,8 @@ windows_msys2_task:
     - C:\tools\msys64\usr\bin\bash.exe -lc "mkdir build"
     - C:\tools\msys64\usr\bin\bash.exe -lc "cd build && ../configure
       --python=python3 --ninja=ninja
-      --target-list-exclude=i386-softmmu,arm-softmmu,ppc-softmmu,mips-softmmu"
+      --target-list-exclude=i386-softmmu,arm-softmmu,ppc-softmmu,mips-softmmu
+      --enable-plugins"
     - C:\tools\msys64\usr\bin\bash.exe -lc "cd build && make -j$NUMBER_OF_PROCESSORS"
   test_script:
     - C:\tools\msys64\usr\bin\bash.exe -lc "cd build && make V=1 check"
-- 
2.28.0.windows.1


