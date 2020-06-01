Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2853FC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 16:16:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED03F206C3
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 16:16:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WckEipYG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED03F206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfn6p-0006hd-4H
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 12:16:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50882)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jfn5L-0004zh-NR
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 12:14:47 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:41186)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jfn5L-0001VU-1o
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 12:14:47 -0400
Received: by mail-wr1-x434.google.com with SMTP id j10so393963wrw.8
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 09:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NA3HxowRBgdQR4zG7dIwLOdIlhd4o6KOpVFcc0np+Vo=;
 b=WckEipYGy4BfVRPLGjCUxIyU0D8m7ewYNeKhLc8YF5dhV9jVorEXOzOjZxYTUYzi9v
 RIo1eaLselpStkiiNqk5lzpEB4IN6IvR+t3wULrTE6HXj0aTYwTAdddhU9jjv3rigOII
 v8Quc3LXUOMIDtV32sqybeaXAZNraFCAOSSg4RmTc0RBKsL10UroyDNPtaiMP/osVzco
 FzO5HSWKVD4PChhoN/OFsh1oqW86g31WwPMblJwotXS6bH73k8lMW9wI9Y3MPWxDKH2D
 HDfSp2cb09sgH0SDQTum3gXaJEaEkh8iKdoEVXGpudtsGaqYVUnJew5h7B4W3T9uF9dc
 gOfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=NA3HxowRBgdQR4zG7dIwLOdIlhd4o6KOpVFcc0np+Vo=;
 b=WScANjg05p5zfcr26cGMtNwCdHEb9vPNcZtZCihk3VAbaqR9RtJAodkPXNQNHODUR+
 LKxCEuEWWwhkqgrzmNkBx/Cx6A+sGeVVfrbq/9uQqCg8+QSi8C5cdBFzPyOtdJicFoVM
 2wSL58cJd22NNMw9v9cEIU2gQ2fdZ+g9OmvkMFVT0nNVdsOiDEcc8CLxOnWAPzU2ECyw
 xD/eGzUrWJm/S7UIBv9rlgut538oVIUMOt2mqi5ikO+xkJY5Pv5o4eBrf44gak2pAPfo
 ho+novOapNilKlfUhQ8S+MtmgtjTPhnM4+HpqfKvYFxF+bFL6epMCHmzADMeV0IZVf5B
 VDhQ==
X-Gm-Message-State: AOAM5326+VjaS0njqr/ruoLc789Ers1MjJcXeF5uzC0Uef7+jvxMZFiU
 u/nO+DeIq8iPidnDo6UPhnA=
X-Google-Smtp-Source: ABdhPJztnxojnXyvsP0e2owtr8EjZZGKlhm/iPr+/2vC8upbYpinr992XBlMhAur04oQzHftRtnRlw==
X-Received: by 2002:adf:9e03:: with SMTP id u3mr17697473wre.413.1591028085926; 
 Mon, 01 Jun 2020 09:14:45 -0700 (PDT)
Received: from localhost.localdomain (43.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.43])
 by smtp.gmail.com with ESMTPSA id a6sm21309896wrn.38.2020.06.01.09.14.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 09:14:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH 02/12] MAINTAINERS: Add entry for RX hardware
Date: Mon,  1 Jun 2020 18:14:31 +0200
Message-Id: <20200601161441.8086-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200601161441.8086-1-f4bug@amsat.org>
References: <20200601161441.8086-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x434.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yoshinori Sato <ysato@users.sourceforge.jp>

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200224141923.82118-2-ysato@users.sourceforge.jp>
[PMD: Renamed as gdbsim, add acceptance test file and rST doc]
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 MAINTAINERS | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0944d9c731..ac2e82eb19 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1238,6 +1238,21 @@ F: pc-bios/canyonlands.dt[sb]
 F: pc-bios/u-boot-sam460ex-20100605.bin
 F: roms/u-boot-sam460ex
 
+RX Machines
+-----------
+rx-gdbsim
+M: Yoshinori Sato <ysato@users.sourceforge.jp>
+S: Maintained
+F: docs/system/target-rx.rst
+F: hw/rx/
+F: hw/intc/rx_icu.c
+F: hw/timer/renesas_*.c
+F: hw/char/renesas_sci.c
+F: include/hw/rx/
+F: include/hw/timer/renesas_*.h
+F: include/hw/char/renesas_sci.h
+F: tests/acceptance/machine_rx_gdbsim.py
+
 SH4 Machines
 ------------
 R2D
-- 
2.21.3


