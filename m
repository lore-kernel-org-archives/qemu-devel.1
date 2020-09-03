Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB32C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 07:27:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97A0B20737
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 07:27:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eJpn4d9a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97A0B20737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDjez-0003eg-Lm
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 03:27:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39490)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDje4-0001m1-9i
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 03:26:56 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035]:54567)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDje2-0001l5-Hv
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 03:26:55 -0400
Received: by mail-pj1-x1035.google.com with SMTP id mm21so1076801pjb.4
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 00:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=E37UotUtOz5dvnD7S9FR16Zmq6QemgVgH7XlEdh+vAk=;
 b=eJpn4d9aldD/oKrN+UKJbQXHbY4rZSa3Y4FbNTcnJQAb3jhduKQQfr4TGH3/XodOn3
 RQRv0Q0Km+an6WCefqoD6oW5RcYPdNpDq0uANoHCd1GQ2h3yTcpsuIB4Ir7LqmP+EGci
 LlfjkKW4IS1Hb2Ba2kd6NaTSSx0+dp/tUKgya8AVIO6jTYvl2DRP2TUwflX/v5cyYwcI
 qSBWpBZTZGsqBfECR2PiC1BwzXkO9518VM+YMbren8yj51OOkra1oQA7Xps6AxJTlrT3
 rRHUUDAeQmTlkkWqjohxDEEfuQ2GKOK2HI8v/Lec0wMAMd2n9S/Drck6OhuCh7RnslPX
 0ruw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=E37UotUtOz5dvnD7S9FR16Zmq6QemgVgH7XlEdh+vAk=;
 b=BlGVXA4tOd9wdA8iQWNTkvEfOzxm6LgwqPO7iB7/E4DADTINOVL3JBw7gLf+neU1s4
 crC5cMdUtGT3L8cnjr5nfEylbtxfHF0XuQQQCuXPSj/vxNsgD2KSspZ+Zuy4SQJN4AYJ
 BotrfAmy+PTjrzwvqpTQI7ZY2qEiUAj+myLv0PzzbnRo8CD7fi/ELzu8PIOp/HSTJgW2
 eRm0UceQwVLzCpZ+ZoXgeiH7rd0iH/oCABSwW1QM29tBresyaouP3gUdfyYMPPFcYwj+
 UDnOUj4ccidfPTi7gNOidy0B5k0KZ4Yx2opLPTgsHpmuI/oiMJZ1xe4Vk7f3KoGpUVBh
 2rIA==
X-Gm-Message-State: AOAM532sWyD63MTZgl9vWvMrHWuu79q9u9Z0ifCi/i9suGSnqfJwAbJ4
 ehpXB/wSQ/zAFJa5l2xqsQRsfBUIyW3xpQ==
X-Google-Smtp-Source: ABdhPJwOWChwQ5TloJvhCRAsnuFbOFCYXESeOjnckGqh4A279A7qWzvzHi6Xlzkml/OwyJSqtPLlaw==
X-Received: by 2002:a17:90a:3486:: with SMTP id
 p6mr1956982pjb.44.1599118012537; 
 Thu, 03 Sep 2020 00:26:52 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id x185sm1930229pfc.188.2020.09.03.00.26.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 00:26:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 00/12] target/microblaze improvements
Date: Thu,  3 Sep 2020 00:26:38 -0700
Message-Id: <20200903072650.1360454-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: edgar.iglesias@xilinx.com, thuth@redhat.com, f4bug@amsat.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Version 2 includes fixes for iflags that could cause lockups.

It seems it was easier to do so with icount=7, which is what we do during
the replay acceptance tests.  This causes TBs to contain no more than 7
insns, and often less to make up for an incomplete count elsewhere.
Which stressed the iflags bits around delay slots and imm in ways that
pure single-step doesn't.

In addition, cpu vmstate is filled in and interrupt logging is tidied.


r~


Richard Henderson (12):
  target/microblaze: Collected fixes for env->iflags
  target/microblaze: Renumber D_FLAG
  target/microblaze: Cleanup mb_cpu_do_interrupt
  target/microblaze: Rename mmu structs
  target/microblaze: Fill in VMStateDescription for cpu
  target/microblaze: Rename DISAS_UPDATE to DISAS_EXIT
  target/microblaze: Introduce DISAS_EXIT_NEXT, DISAS_EXIT_JUMP
  target/microblaze: Replace cpustate_changed with DISAS_EXIT_NEXT
  target/microblaze: Handle DISAS_EXIT_NEXT in delay slot
  target/microblaze: Force rtid, rted, rtbd to exit
  target/microblaze: Use tcg_gen_lookup_and_goto_ptr
  target/microblaze: Diagnose invalid insns in delay slots

 target/microblaze/cpu.h       |  11 +-
 target/microblaze/mmu.h       |  15 +--
 target/microblaze/cpu.c       |  19 +--
 target/microblaze/helper.c    | 216 +++++++++++++++-------------------
 target/microblaze/machine.c   | 112 ++++++++++++++++++
 target/microblaze/mmu.c       |  11 +-
 target/microblaze/translate.c | 166 ++++++++++++++++++--------
 target/microblaze/meson.build |   5 +-
 8 files changed, 362 insertions(+), 193 deletions(-)
 create mode 100644 target/microblaze/machine.c

-- 
2.25.1


