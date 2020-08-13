Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 374D6C433E3
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 07:54:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B005520716
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 07:54:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nGkV6kFy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B005520716
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k684P-0008K7-Ka
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 03:54:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44050)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k683S-0007QV-7Q
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 03:53:42 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:42772)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k683Q-0003hH-Eu
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 03:53:41 -0400
Received: by mail-wr1-x432.google.com with SMTP id r4so4349387wrx.9
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2020 00:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:references:cc:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=VryNuQpXeWiH5WU29tTxI6GLH1zeaY8QVaIuFAFhGmk=;
 b=nGkV6kFy/gBv4a6A2MQ/53FLPkOXO2Y7HzvnbINNNo3ff6Ph5Jg3fMRozX/2I9WGgs
 XrCaS84dj+9ndXOOxJGivYrr1OT+q6zFrSVJK/SWwDY9pR2Vv8/TIDGiOhuPE8ly2v1v
 cZ6SCRaKWYLRGGZFLxFBFGqgmLZwnobL37JzvUjoTf+VPIPMolxrLqeYQ2mXtP3hmdw1
 1UA06qd+knbklsQmfm22nWAJqfl0wpS6f6jUftTuTLqUhkfPHzn71UaMGNkJdXYx/3Zz
 7M3uTXP0NGodv2IH/76si8qgqDkJfPu17qB06emPaj9YENSu7UpV04pSvc3FaSP7rWaT
 94JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:references:cc:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VryNuQpXeWiH5WU29tTxI6GLH1zeaY8QVaIuFAFhGmk=;
 b=sf80zInZAan3YwyVJ4aAsD+q+N0OAGSSkF53AbkrWrHAVYsbB9idJcmAX7wzKPuhaM
 ImLnLQ9LgjCy+pGcBwm1S+XRjJo3+eC1H6XtzElkFKR7aN6C0u+ibfmIh1zzs0OysAuD
 sjZzh5mcrcuBfwE+eCd245XHq5ufYKGND6k3f9AJQrfI/zjkY86fHg4Fjf1XkfNpAHDV
 0KnjnIY61yge2n9cxvhM4cTcdIjCC8JEXHcMBw+89xQ3Ws0hIoTFdPBYtPIa7ryXl8dU
 fP8qB6ZU/PLzhJBMKd8mTBQLzURYex0UTTW69wML1Y+yqW7qC3ae/S0kVKD6bjFcyEVq
 tIXA==
X-Gm-Message-State: AOAM530Mv0wqPouDCF8hZxwuu8LScXwTDrFjo1MQhdCLwizkLUMmRDiW
 WBE61pPGdDzDZ962gsdwm40=
X-Google-Smtp-Source: ABdhPJy5I+Qo+vT1H/1ihKDdpUGAh03oIdp6zTS2jXPNF0gRFJ/H31sIJMx7iPkSlidnle3YnSk/kw==
X-Received: by 2002:adf:dcc9:: with SMTP id x9mr3002369wrm.153.1597305218640; 
 Thu, 13 Aug 2020 00:53:38 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id a3sm7983676wme.34.2020.08.13.00.53.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Aug 2020 00:53:38 -0700 (PDT)
Subject: Re: [PULL 00/20] riscv-to-apply queue
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200812223045.96803-1-alistair.francis@wdc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <4b6e707d-405e-dfb2-d804-2252b13df2be@amsat.org>
Date: Thu, 13 Aug 2020 09:53:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200812223045.96803-1-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x432.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-devel@nongnu.org,
 LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/13/20 12:30 AM, Alistair Francis wrote:
> The following changes since commit d0ed6a69d399ae193959225cdeaa9382746c91cc:
> 
>   Update version for v5.1.0 release (2020-08-11 17:07:03 +0100)
> 
> are available in the Git repository at:
> 
>   git@github.com:alistair23/qemu.git tags/pull-riscv-to-apply-20200812
> 
> for you to fetch changes up to 339332b8aa240e4ea3a56ec1b98cc9b2e1346834:
> 
>   hw/intc: ibex_plic: Honour source priorities (2020-08-12 12:07:58 -0700)
> 
> ----------------------------------------------------------------
> The first RISC-V PR for the 5.2 window.
> 
> This includes:
>  - NaNBox fixes
>  - Vector extension improvements
>  - a L2 cache controller
>  - PMP fixes
>  - Upgrade to OpenSBI v0.8 and the generic platform
>  - Fixes for the Ibex PLIC
> 
> ----------------------------------------------------------------
> Alistair Francis (3):
>       hw/intc: ibex_plic: Update the pending irqs
>       hw/intc: ibex_plic: Don't allow repeat interrupts on claimed lines
>       hw/intc: ibex_plic: Honour source priorities
> 
> Bin Meng (7):
>       hw/riscv: sifive_u: Add a dummy L2 cache controller device
>       configure: Create symbolic links for pc-bios/*.elf files
>       roms/opensbi: Upgrade from v0.7 to v0.8
>       roms/Makefile: Build the generic platform for RISC-V OpenSBI firmware
>       hw/riscv: Use pre-built bios image of generic platform for virt & sifive_u
>       hw/riscv: spike: Change the default bios to use generic platform image
>       gitlab-ci/opensbi: Update GitLab CI to build generic platform
> 
> Hou Weiying (1):
>       riscv: Fix bug in setting pmpcfg CSR for RISCV64
> 
> LIU Zhiwei (2):
>       target/riscv: Clean up fmv.w.x
>       target/riscv: check before allocating TCG temps
> 
> Richard Henderson (5):
>       target/riscv: Generate nanboxed results from fp helpers
>       target/riscv: Generalize gen_nanbox_fpr to gen_nanbox_s
>       target/riscv: Generate nanboxed results from trans_rvf.inc.c
>       target/riscv: Check nanboxed inputs to fp helpers
>       target/riscv: Check nanboxed inputs in trans_rvf.inc.c
> 
> Zong Li (2):
>       target/riscv: Fix the translation of physical address
>       target/riscv: Change the TLB page size depends on PMP entries.
> 
>  configure                                      |   1 +
>  Makefile                                       |   4 +-
>  include/hw/intc/ibex_plic.h                    |   1 +
>  include/hw/riscv/sifive_u.h                    |   4 +
>  target/riscv/internals.h                       |  16 ++++
>  target/riscv/pmp.h                             |   2 +
>  hw/intc/ibex_plic.c                            |  36 +++++++--
>  hw/riscv/sifive_u.c                            |  26 ++++++-
>  hw/riscv/spike.c                               |   9 ++-
>  hw/riscv/virt.c                                |   4 +-
>  target/riscv/cpu_helper.c                      |  15 +++-
>  target/riscv/fpu_helper.c                      | 102 ++++++++++++++++---------
>  target/riscv/insn_trans/trans_rvd.inc.c        |   8 +-
>  target/riscv/insn_trans/trans_rvf.inc.c        |  99 +++++++++++++++---------
>  target/riscv/pmp.c                             |  57 +++++++++++++-
>  target/riscv/translate.c                       |  29 +++++++
>  .gitlab-ci.d/opensbi.yml                       |  28 +++----
>  pc-bios/opensbi-riscv32-generic-fw_dynamic.bin | Bin 0 -> 62144 bytes
>  pc-bios/opensbi-riscv32-generic-fw_dynamic.elf | Bin 0 -> 558668 bytes
>  pc-bios/opensbi-riscv32-sifive_u-fw_jump.bin   | Bin 49520 -> 0 bytes
>  pc-bios/opensbi-riscv32-virt-fw_jump.bin       | Bin 49504 -> 0 bytes
>  pc-bios/opensbi-riscv64-generic-fw_dynamic.bin | Bin 0 -> 70792 bytes
>  pc-bios/opensbi-riscv64-generic-fw_dynamic.elf | Bin 0 -> 620424 bytes
>  pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin   | Bin 57936 -> 0 bytes
>  pc-bios/opensbi-riscv64-virt-fw_jump.bin       | Bin 57920 -> 0 bytes
>  roms/Makefile                                  |  32 +++-----
>  roms/opensbi                                   |   2 +-
>  27 files changed, 338 insertions(+), 137 deletions(-)
>  create mode 100644 pc-bios/opensbi-riscv32-generic-fw_dynamic.bin
>  create mode 100644 pc-bios/opensbi-riscv32-generic-fw_dynamic.elf
>  delete mode 100644 pc-bios/opensbi-riscv32-sifive_u-fw_jump.bin
>  delete mode 100644 pc-bios/opensbi-riscv32-virt-fw_jump.bin
>  create mode 100644 pc-bios/opensbi-riscv64-generic-fw_dynamic.bin
>  create mode 100644 pc-bios/opensbi-riscv64-generic-fw_dynamic.elf
>  delete mode 100644 pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin
>  delete mode 100644 pc-bios/opensbi-riscv64-virt-fw_jump.bin
> 

Note to Peter, there is a comment to resolve on patch #5 before
applying this.

