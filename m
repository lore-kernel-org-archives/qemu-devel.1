Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC05AC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 07:33:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B35A1207C3
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 07:33:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oLyeeso9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B35A1207C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiYlO-0005mM-SH
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 03:33:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40310)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jiYkA-00044g-Ts
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 03:32:23 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:36942)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jiYk9-0007W1-4P
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 03:32:22 -0400
Received: by mail-wm1-x341.google.com with SMTP id y20so2032279wmi.2
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 00:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=VOrlVFRoh2C3YjJ79R+iOKQZpTb+LxcCqo4tIiRo5Xw=;
 b=oLyeeso9B8VSIgRn4mGN4gjneNUVlrB5M2ajBJWyUy4owUDzIoctZ+X6c7vL6M5lcf
 uwU+MjoBn+fpJpHtr8LxH/yEnfO8G4UogsQrg75PTaiyeZgfXEPc8OyX/4TLECQHHHKZ
 GNYOKfGenCI5CGSoypFloJqeR9oMovk0+Ll404sDQDHEhqfxYMULdmCV0Yt5/8KSFfI3
 YEywzkAZFlMbqs9LkOxlabkysAYK3tgIRluKV09yVqvuQ2K39PLtZAvYk8et1as22jcL
 4aL0MptPMOxl54JJDiFdbO0RmKo4pZNggvABZsKtYk4suOp1sGEaWkGpKbo6wXoXZGBa
 t2RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=VOrlVFRoh2C3YjJ79R+iOKQZpTb+LxcCqo4tIiRo5Xw=;
 b=SluvKx80zosoJVzL5VxN2DKZStpPpMvQR7abmjVBAKg2B0Qfn/m9J6llRxNbjks1tn
 tynEiF3VrZ9UqFskSZovGDppwyVpXEBv2PPu5ofjezTATCHe/pHMGQ9bC+iMm18Bqe1n
 UAEEScEVa6vc9noKy4e0LelrldaZ36ck7ltVhdkMGAcmrlTvqrtR/paM3I0+clzQPwK0
 Qb/7p7+t68g8LK1Y72PQMQbHtYzucg1JR6J8f07S/8spbaWmUJxxQom/tmOKLJYZyn5e
 hpVgF1nHWlTc6Uwz4YqT/Mq70tzu2ApsWzk1hB0pjsGs5gtSLnVg8hjiqgoTnrMNwPwW
 /CMA==
X-Gm-Message-State: AOAM5315NuL0q6h6QVrW97gVPyHPzNHP7sfb8q8U8GJjfa+xhGFvHDDg
 NbABPY2D2GFYGstg6twqupUMJW51
X-Google-Smtp-Source: ABdhPJyo04RwBlCfR9BKergOcMSg+jmgLGQcczrs5G5dNjw1hfnNgi9w2+jQ+8IprW8QZg6/rZhCpQ==
X-Received: by 2002:a1c:f00a:: with SMTP id a10mr2662274wmb.61.1591687936169; 
 Tue, 09 Jun 2020 00:32:16 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id m3sm2036192wmc.0.2020.06.09.00.32.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 00:32:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/16] SPARC patches for 2020-06-09
Date: Tue,  9 Jun 2020 09:31:58 +0200
Message-Id: <20200609073214.14079-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Fabien Chouteau <chouteau@adacore.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter,

These are the latest SPARC patches sent to the list.

This pull request is with authorization of Artyom and Mark:
- https://www.mail-archive.com/qemu-devel@nongnu.org/msg710154.html
- https://www.mail-archive.com/qemu-devel@nongnu.org/msg710156.html

Frederic doesn't have his GPG key signed:
- https://www.mail-archive.com/qemu-devel@nongnu.org/msg706509.html

The following changes since commit 49ee11555262a256afec592dfed7c5902d5eefd2:

  Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-5.1-pull-=
request' into staging (2020-06-08 11:04:57 +0100)

are available in the Git repository at:

  https://gitlab.com/philmd/qemu.git tags/sparc-next-20200609

for you to fetch changes up to 86e8c353f705f14f2f2fd7a6195cefa431aa24d9:

  target/sparc/int32_helper: Extract and use excp_name_str() (2020-06-09 09:2=
1:10 +0200)

----------------------------------------------------------------
SPARC patches

HW:
- Use UNIMP device instead of EMPTY_SLOT
- Make EMPTY_SLOT similar to UNIMP device
- Map UART devices unconditionally
- Pair of fixes for AHB PnP
- Add trace events to AHB PnP

TCG:
- Improve exception logging

CI:
- https://gitlab.com/philmd/qemu/-/pipelines/154231191
- https://travis-ci.org/github/philmd/qemu/builds/696321130

----------------------------------------------------------------

Philippe Mathieu-Daud=C3=A9 (16):
  hw/sparc/sun4m: Use UnimplementedDevice for I/O devices
  hw/misc/empty_slot: Lower address space priority
  hw/misc/empty_slot: Convert 'size' field as qdev property
  hw/misc/empty_slot: Add a 'name' qdev property
  hw/misc/empty_slot: Convert debug printf() to trace event
  hw/misc/empty_slot: Move the 'hw/misc' and cover in MAINTAINERS
  hw/misc/empty_slot: Name the slots when created
  hw/sparc/leon3: Map the UART device unconditionally
  hw/sparc64/niagara: Map the UART device unconditionally
  hw/sparc64/niagara: Remove duplicated NIAGARA_UART_BASE definition
  hw/misc/grlib_ahb_apb_pnp: Avoid crash when writing to AHB PnP
    registers
  hw/misc/grlib_ahb_apb_pnp: Fix AHB PnP 8-bit accesses
  hw/misc/grlib_ahb_apb_pnp: Add trace events on read accesses
  hw/timer/grlib_gptimer: Display frequency in decimal
  target/sparc/int32_helper: Remove DEBUG_PCALL definition
  target/sparc/int32_helper: Extract and use excp_name_str()

 include/hw/empty_slot.h        |  9 -------
 include/hw/misc/empty_slot.h   | 19 ++++++++++++++
 hw/mips/malta.c                |  4 +--
 hw/{core =3D> misc}/empty_slot.c | 47 +++++++++++++++++++---------------
 hw/misc/grlib_ahb_apb_pnp.c    | 24 +++++++++++++++--
 hw/sparc/leon3.c               | 18 ++++++-------
 hw/sparc/sun4m.c               | 23 +++++++++++------
 hw/sparc64/niagara.c           |  7 ++---
 target/sparc/int32_helper.c    | 23 +++++++++--------
 MAINTAINERS                    |  7 +++++
 hw/core/Makefile.objs          |  1 -
 hw/misc/Makefile.objs          |  1 +
 hw/misc/trace-events           |  8 ++++++
 hw/sparc/Kconfig               |  1 +
 hw/timer/trace-events          |  2 +-
 15 files changed, 124 insertions(+), 70 deletions(-)
 delete mode 100644 include/hw/empty_slot.h
 create mode 100644 include/hw/misc/empty_slot.h
 rename hw/{core =3D> misc}/empty_slot.c (66%)

--=20
2.21.3


