Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56AB6C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 09:00:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1733D204FD
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 09:00:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="NbAQ3rFa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1733D204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5Q9S-0005Ym-8Q
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 05:00:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48908)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chihmin.chao@sifive.com>)
 id 1k5Q8P-0003up-8v
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 04:59:53 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529]:46534)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chihmin.chao@sifive.com>)
 id 1k5Q8M-0005TA-Sw
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 04:59:53 -0400
Received: by mail-pg1-x529.google.com with SMTP id p8so6387706pgn.13
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2020 01:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=8Oa1NMTa30y2wMEwqzgmHnRPPsrYFPcBXMzRuwI3Bf4=;
 b=NbAQ3rFaLfb2y2xQf+774lG4hxAqAVBoBqUlOZ3T5aHP5hhX4SSclXz3ztQzR+p1ob
 JHjent55JjqoDIJHMyr74SGCdc8YTozabS2HKV/bHZ9vCtxMJmWsGAmmlc9+WYdDnCQk
 qUGRj/mNliqw4YRhMgln/vCj8TPBwPeOBLk8vGVLgnTS3+7amGrEHc/esTKR8nPkZKsx
 53BZUkM9XZ+GwMMNKwmyp2bmYWMcwxkHd17UVBGzIMI+MyW92GbtedgSVhra0wSEdqbA
 SrXlWZddYCgZd896zYDu7RHydx4SQj3X7kMg3RwlPqWJSU2jb1zDImjB8roRgf5U4lkC
 AlGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=8Oa1NMTa30y2wMEwqzgmHnRPPsrYFPcBXMzRuwI3Bf4=;
 b=ntzZG/7RKG29Knz0BoEvVMAHxzcHhtF4c4Jjf2BypOOmwH6glq+h2tV3v3maAwTraV
 CkyJ4PVKxJcNIF7x4RSGDbg6s+SUCCLpQkJcAP4kfkVAdk/xfGOAZiW6qxDivePqaq1J
 /WgaIlWen3UfiCrtA9Q8cLWQAUQHK1EqG6zm5aII05DQtiOECpIaXgMOvchMUpfUZPhP
 tpL9sVw7qENlLzl13Qb74ZVn7BCIUdmX5ReppnMAMQbtGdRSWZanRrnvZJJ2vq1Aq2o8
 T3GLLgz+K8tPrP/FZqJen6mhgOgNQIG3ZoTWbdi1uvRgEod2taGSVDBhr8NqZy88w4lv
 L1HA==
X-Gm-Message-State: AOAM531KQ4MpVkuHtLkKqI8wK30fKIYIylzkyT6gnvAExzSceqGgPhjT
 rGUgj/wD2zP5IGJNZqJPMmPqHWVwpKGALw==
X-Google-Smtp-Source: ABdhPJxYXlTrwuFJGx6EvTr0dN6ILxLk9QtWXCyUNfK4TNtuI2Q4ytOdkUdT5acwjBjOsJuqNHHL2g==
X-Received: by 2002:a63:4d8:: with SMTP id 207mr32132pge.146.1597136388443;
 Tue, 11 Aug 2020 01:59:48 -0700 (PDT)
Received: from gamma11.internal.sifive.com ([64.62.193.194])
 by smtp.gmail.com with ESMTPSA id w10sm1282499pjq.46.2020.08.11.01.59.47
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 11 Aug 2020 01:59:47 -0700 (PDT)
From: Chih-Min Chao <chihmin.chao@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH 0/3] RFC: target/riscv: add half-precision floating-point
 extension
Date: Tue, 11 Aug 2020 01:59:23 -0700
Message-Id: <1597136381-17296-1-git-send-email-chihmin.chao@sifive.com>
X-Mailer: git-send-email 2.7.4
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=chihmin.chao@sifive.com; helo=mail-pg1-x529.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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
Cc: Chih-Min Chao <chihmin.chao@sifive.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The spec is a draft but required by vector extension.  The reference is 
availabe at
   https://github.com/riscv/riscv-isa-manual/tree/zfh

The patch depends two unmerged patch set
  1. extend softfloat to support int8 and alternative NaN probagapation
  2. NaNBox fix

Based-on: <1596102747-20226-1-git-send-email-chihmin.chao@sifive.com>
Based-on: <20200724002807.441147-1-richard.henderson@linaro.org>

Chih-Min Chao (2):
  target/riscv: add NaN-Boxing helper for half-float
  target/riscv: support 'x-k' in cpu option

Kito Cheng (1):
  target/riscv: Implement zfh extension

 target/riscv/cpu.c                        |   4 +
 target/riscv/cpu.h                        |   2 +
 target/riscv/fpu_helper.c                 | 180 ++++++++++
 target/riscv/helper.h                     |  34 ++
 target/riscv/insn32-64.decode             |   6 +
 target/riscv/insn32.decode                |  32 ++
 target/riscv/insn_trans/trans_rvzfh.inc.c | 531 ++++++++++++++++++++++++++++++
 target/riscv/internals.h                  |  16 +
 target/riscv/translate.c                  |  16 +
 9 files changed, 821 insertions(+)
 create mode 100644 target/riscv/insn_trans/trans_rvzfh.inc.c

-- 
2.7.4


