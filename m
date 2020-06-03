Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42765C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 12:39:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07FD120678
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 12:39:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dAn5yiax"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07FD120678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgSfo-0006qg-5B
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 08:39:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49154)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jgSei-0005dt-UF; Wed, 03 Jun 2020 08:38:04 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:36872)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jgSee-0006OO-Dl; Wed, 03 Jun 2020 08:38:02 -0400
Received: by mail-wr1-x441.google.com with SMTP id x13so2193053wrv.4;
 Wed, 03 Jun 2020 05:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ac+9C3hXCYIKboqKG/Gxdg5RbUyXr3fNOMpH5cOaPJg=;
 b=dAn5yiax3BDfYEMOthmqiFpzlDJ2FcVknMuuh8LaJX9ICxavIbsgXi3G/iyNNyyvnK
 uNQ8QuJOEmxCh5yfWd7WUnRDJhbuGXjeNeGTwbOIfohnknJKL4XpdyldrjQWObbTSYFA
 g0OimCAVlDpbhuZmb7wajwp1RuM/O+Av7AvVZBFjHYo9+t1bMWkGevLQgvOfFFOFaxNY
 qrPvEcZKAMx3/DNklDKRdBeklflCR+UnGVVkBkfx+3eldqTeZlWsNyWZK4dNHB8YgKaO
 f28oaJafOGUeT69DV9sOsUS+o2zd488kvxj72wAyp1Ui6IXFcxKGdVZabSTVf7Fv9VWK
 xTVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=ac+9C3hXCYIKboqKG/Gxdg5RbUyXr3fNOMpH5cOaPJg=;
 b=Ptc19QQ4G3vKxrYqhjvYm7TG/akl6ViTx+oaDUXJqE+sSDjS9sU9aWzwSyk111APjh
 W7h8gHqKbXEUJxKoNbBVgfnNAjeCHrFVJ9CpA7r0mOh1KxLJILXPMfQwOff0Jzt7vvyM
 WpJpA66Y5XRZphTWb7B2KXgNn8GSj2/xu9Tk4EPOx/cfkKTLOa89YHx2FA3yIJUXlHT5
 2wpsm8bI9xBhMQ/XIkiCCfKQp0qwk23YH+f0EVP3oCBhH7fRr5/I5fmFGtr8FZsafxyB
 hv5imLJ1j2OnXvPIkKWFhF6IeDRTQu2yHvFK8a5pEk28Tr8bgM6YGrEXd3vRzkbsw7+O
 VdSQ==
X-Gm-Message-State: AOAM531/C2UeXgZY5ueBenfHXLMoOZglyrs6o0LvPjQlC2IBMdw710Y5
 FPEYxwO/earSv0H04G5Q3xwmweoN
X-Google-Smtp-Source: ABdhPJxE/bacFXzAo+0CK347tVAdAzvJ2Gxc8e1tHWWG6illF1eDX3JoXa9S57K6hjbSD5E3QgZ4/w==
X-Received: by 2002:a05:6000:1192:: with SMTP id
 g18mr32472936wrx.326.1591187878361; 
 Wed, 03 Jun 2020 05:37:58 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id r5sm3370983wrq.0.2020.06.03.05.37.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2020 05:37:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/3] target/unicore32: Semihosting cleanup
Date: Wed,  3 Jun 2020 14:37:51 +0200
Message-Id: <20200603123754.19059-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
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
Cc: Thomas Huth <thuth@redhat.com>, qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Trivial cleanups around semihosting code.

Guan: Do you have binaries to run testing?

I couldn't rebuild anything from https://github.com/gxt/UniCore32
that you referenced here:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg608054.html
- u-boot patches are missing
- which gnu-toolchain-unicore should we use?
- your webpage is down: http://mprc.pku.edu.cn/~guanxuetao/
- there are too many warnings reported for QEMU 2.7-stable.

Philippe Mathieu-Daudé (3):
  target/unicore32: Remove unused headers
  target/unicore32: Replace DPRINTF() by qemu_log_mask(GUEST_ERROR)
  target/unicore32: Prefer qemu_semihosting_log_out() over curses

 default-configs/unicore32-softmmu.mak |  1 +
 target/unicore32/helper.c             | 70 +++++----------------------
 2 files changed, 13 insertions(+), 58 deletions(-)

-- 
2.21.3


