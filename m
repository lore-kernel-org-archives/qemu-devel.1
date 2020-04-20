Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97367C3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 17:54:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A4BE20B1F
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 17:54:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="khiSmsP8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A4BE20B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQacj-0008NH-GS
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 13:54:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36524 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jQabH-0006cc-Dt
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 13:52:55 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jQabG-0003s6-QE
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 13:52:55 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:35441)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jQabG-0003p5-F7
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 13:52:54 -0400
Received: by mail-lj1-x243.google.com with SMTP id g4so2874303ljl.2
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2020 10:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=8v91UtElPJicFLAThvniOfUGfcadw/W6ElCPNLXqIw0=;
 b=khiSmsP8jCKrPcMgbKJoP41SsFDjV+fvhi2c/GwKi3SH2Ffyjnk1fAuDI9WztxL34D
 80SuQzdnAM2B5YgWF0h0R+XKUKTc/Pm6B8MOOLLlcFPi0A1d6vqKQaIa+UcnVyOM6qxN
 FlbfS1SfV3t/1iPcgesNrILdiyawcEY5q/QnrS00GMW2gOEJiSUlBid79I/z80FLi2Ts
 aOJyYdFCTiorCtl4NYH3YTkgf9LdN8Hu6TZuO22smBNl1TrGgUcUmmXlbDewTr5rq/3P
 GHSup1ou27cIo5sRR8GVPnk/LxCqIZNVC5qsQs/+xEeSKNsTLbv4hjF5+4A34WKCjxzJ
 HUeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=8v91UtElPJicFLAThvniOfUGfcadw/W6ElCPNLXqIw0=;
 b=RGx33SLvk1TvMW5qnP6EyRw0xwmLRGLVTQIBr7Oytl5sIBGIAEqb5ZqzRAkUhzzG/d
 5LGPko7e95jdfv598knheyhhjw58InYI25pkirj1H+JcNmPTmEE5Wmk/HdsRpKmnpo2Q
 lnafmzQVMECvDidsA6mqnpoxa6kWQ3JCd5GTXeAzhen6EZSCp3mfC1boDoNZ9Z1iwyfh
 n/74MvbDBj5W7+9YUk3586ih+EtdbkHboCGnYQTx2rNwKYfH+He57FYfO/IDIOJToJWb
 vHhKBfT3+kTsN/+TJk0ZN/hDFIKo0Rpq4nySE+P4KOPxpxWzMJEUsHk8N/p2VrcD9bi6
 4EjQ==
X-Gm-Message-State: AGi0PuYd8VknvD2yzkHuzYWqb9dOVSajM0HWYGCaTSU195Mw/+Sa3O5b
 wIxqZqIWdrK6mCibaC5lj77W5CUidtU=
X-Google-Smtp-Source: APiQypJBAaMhjaw1XPaksbvSyNaCLjOLx+ceTe4kqwRwDURJ8QZC9oLsHfwDBXNYKTEp6j1y/qIn4A==
X-Received: by 2002:a2e:b4c2:: with SMTP id r2mr6437845ljm.143.1587405172062; 
 Mon, 20 Apr 2020 10:52:52 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id b73sm62831lfg.86.2020.04.20.10.52.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2020 10:52:51 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/6] target-microblaze: Misc configurability #2
Date: Mon, 20 Apr 2020 19:52:44 +0200
Message-Id: <20200420175250.25777-1-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::243;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x243.google.com
X-detected-operating-system: by eggs1p.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::243
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
Cc: figlesia@xilinx.com, peter.maydell@linaro.org, sstabellini@kernel.org,
 edgar.iglesias@xilinx.com, sai.pavan.boddu@xilinx.com,
 frasse.iglesias@gmail.com, alistair@alistair23.me,
 richard.henderson@linaro.org, frederic.konrad@adacore.com, philmd@redhat.com,
 luc.michel@greensocs.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

This is another round of conversion from hardcoded regs to
cpu properties.
The property names are taken from the device-tree bindings.

Cheers,
Edgar

ChangeLog:

v1 -> v2:
* Populate the pvr2 div-zero-exception bit

Edgar E. Iglesias (6):
  target/microblaze: Add the opcode-0x0-illegal CPU property
  target/microblaze: Add the ill-opcode-exception property
  target/microblaze: Add the div-zero-exception property
  target/microblaze: Add the unaligned-exceptions property
  target/microblaze: Add the pvr-user1 property
  target/microblaze: Add the pvr-user2 property

 target/microblaze/cpu.c       | 24 ++++++++++++++++++++++--
 target/microblaze/cpu.h       |  6 ++++++
 target/microblaze/op_helper.c |  5 +++--
 target/microblaze/translate.c |  8 ++++----
 4 files changed, 35 insertions(+), 8 deletions(-)

-- 
2.20.1


