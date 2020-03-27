Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95488C43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 09:50:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6058F20717
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 09:50:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MsQ+T8dL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6058F20717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHldf-000565-IZ
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 05:50:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37787)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jHlcc-0003Lu-K7
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 05:49:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jHlcb-0003fc-Ie
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 05:49:50 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:51458)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jHlcb-0003ab-Ce
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 05:49:49 -0400
Received: by mail-wm1-x342.google.com with SMTP id c187so10763654wme.1
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2020 02:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=BsUpDE4oeBA2w3/5bPCV+g7M+jRgEGbqhA5stb7PRU4=;
 b=MsQ+T8dLVfbXuB9S7ioYlbQWG38QDRfpgAw850xmINPXnQLFJs0Z1IxwMCyiQgNKWF
 7KGAJvvi88bqEDZLmZZdZNIEdRxIQkwnf5s6JadrOAkUNYIHN7wMg7aJUkhSRcZQoiPf
 qC5snCIIgf4D9OnfLILxdgReqRSz/gumQqlyMfN52ltkVY4RgxSzRnSDh0lvYJPGaT9U
 TXGaZkdgDG+npIjFazxMuP/jiDz6yf0/rO1nS5vz0XzWjXVE7dM3Xj5nDiGQZHJwSISS
 cZGVb/P8ltSIsKoOapYXNBW9dN2zhsq0cIG/rYaAaV+lNuupzCIexjV8ODZ/SAPlTcOp
 Cz1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=BsUpDE4oeBA2w3/5bPCV+g7M+jRgEGbqhA5stb7PRU4=;
 b=NF+ex7rqucd9Omsj+zmCUbFJsT/NfnmMgmpvw8cqtALv35+VBZRaaeTPCIA6DO2kIr
 jjKNEmTpZmOWxhbH6T9S3a2mjZc91uKqG+F5ltuRzhB/vo+bCWB6oMIJ0kHQcEbz5IsK
 mIMf6nLWhVryLrUCTtywLYPQ0/JRJ6k36bQXfB2xwW3ZJ07Ja117v5fpnYpoieL1ixCd
 1WkX9LuVxg+zh++Y+lPPIiGQqcrhQqE2mCYZekasQWUdjVEZtXj4ksJ1wgQEEICo3gze
 lgW5OtIOJ+/mgnLnq8UNpGLknLdFhH+YqftnMfvD3r59oQ5edZnhC2JKGfY5lcxhYHJZ
 zFog==
X-Gm-Message-State: ANhLgQ1reaL+VRV6wGozvKu22EzZTVFWFknaZyFR/NwwNaW8f3IAOPaL
 /AdF2GEIknKX5tyYMbFaJ69ENg==
X-Google-Smtp-Source: ADFU+vvtj6xYXF8rwF02b2r5yuVWcwMzzKpRMQtY0ZOc07NcQdV/Q3jtY1FDImC8TyZQAx4SiGkc2Q==
X-Received: by 2002:a1c:6282:: with SMTP id w124mr4443772wmb.27.1585302588215; 
 Fri, 27 Mar 2020 02:49:48 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 9sm7022189wmm.6.2020.03.27.02.49.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2020 02:49:46 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 634781FF7E;
 Fri, 27 Mar 2020 09:49:45 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH for 5.0 v1 0/7] A selection of sanitiser fixes
Date: Fri, 27 Mar 2020 09:49:38 +0000
Message-Id: <20200327094945.23768-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

I gave the rc0 a spin on the clang sanitiser and found a number of
small issues. One issue is that init_guest_space doesn't play nice
with the sanitiser for some guests but that is going to be a more
involved fix. For now I've just enhanced the debug output a little. I
also didn't attempt to fix the memory leak in xtensa as the code is
pretty unfamiliar to me. Please review and NACK anything you don't
think should be 5.0 material.

Alex Bennée (6):
  elf-ops: bail out if we have no function symbols
  linux-user: protect fcntl64 with an #ifdef
  tests/tcg: remove extraneous pasting macros
  linux-user: more debug for init_guest_space
  fpu/softfloat: avoid undefined behaviour when normalising empty sigs
  target/xtensa: add FIXME for translation memory leak

Denis Plotnikov (1):
  gdbstub: fix compiler complaining

 include/hw/elf_ops.h           |  7 ++++++-
 fpu/softfloat.c                | 11 ++++++++---
 gdbstub.c                      |  4 ++--
 linux-user/elfload.c           |  8 +++++++-
 linux-user/syscall.c           |  8 ++++----
 target/xtensa/translate.c      |  5 +++++
 tests/tcg/x86_64/system/boot.S |  5 +----
 7 files changed, 33 insertions(+), 15 deletions(-)

-- 
2.20.1


