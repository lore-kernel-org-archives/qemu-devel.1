Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77843C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 11:11:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 308AB206B6
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 11:11:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sBO8WBXW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 308AB206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jc5Zt-00047i-Bx
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 07:11:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33122)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jc5ZM-0003eH-2r
 for qemu-devel@nongnu.org; Fri, 22 May 2020 07:10:28 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:38314)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jc5ZK-0004zQ-RW
 for qemu-devel@nongnu.org; Fri, 22 May 2020 07:10:27 -0400
Received: by mail-oi1-x241.google.com with SMTP id j145so8984589oib.5
 for <qemu-devel@nongnu.org>; Fri, 22 May 2020 04:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=rHqtP0Ji4NB3PjK2V4IgU2ZwWtaFmaOz/eDquVl2x4U=;
 b=sBO8WBXW/64JgdEsqygq6TjWLZb/lfh+0RYreHay9y71mZ1NOvx3xk/IEHl8hcINYw
 kItV2NSMggCvxsnESEhaDwFjg5gRrZpjXXBxaCCe3yVw/n+JVmer2RBf6BntOfcEbAp8
 0qyO+w6UofMP4MmA5PlfENAbn9qDPpNGCy9y95tS8yXrgcOoX+4zGnRE+yT6TzbKtGlU
 G0AhJ9untFNcKUQ2YO6J5xr4b/VGrwul8O+Lx7LgCmZ1RJjWqZqFegtENL0tAxx8sCqp
 kWTEQBep9fscxx7X/vFPgEnr6Qp8p9hdOy8VdfKK76xnI13X1jO+AjSCkTeDWIKJkAOE
 RU/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=rHqtP0Ji4NB3PjK2V4IgU2ZwWtaFmaOz/eDquVl2x4U=;
 b=bxahg+7mdmAJ7yD/bQ2Bki3zphszJLEZ/SxjM8z8ySCkaP0RGmR8wIseWG2L/J7nWg
 UOQsDdhl4ZK/TmfUSZBtWnF1feVv7ZBX5Y2h6q88TUM8wpdMiv7TRLK6B/bvkE1+xuE6
 1wqvXxZDWQn/m6BoQ/cI17mhZGCK2ToM6K1tv1yEMEuEPwGZq9IXRG43t1wrfvHV2hJS
 Z49wSs9sOFHZmbgbTrDKAbKcsuq9LSv3S7yAEpbsgoThI8LDRNYRCsbtw7zJNvFJeBbj
 mPPYG1nzjDi6kIgvAMHRAZh8cMj2bkDQgttAIel1c9qFi51BbxpLAvabM7l6lO+USE58
 zzCA==
X-Gm-Message-State: AOAM532KlkgVKmbdyrYbRlwJ1ottaVI2t4p96u5FY3YkFxSjc/fi5p3P
 jMf+vFAeX0vh/Y0IaIVEXHd8ctA4X4GSODo38MIN4fpA
X-Google-Smtp-Source: ABdhPJz1vOEWpmfPOgjg9yHJ9uRKufRxAdyO6aYCgQOJp/M1LUj0Q3yTtdDlHKSFi5a5NmCN2UDm++VMbX23A14o04g=
X-Received: by 2002:aca:ed16:: with SMTP id l22mr2088742oih.146.1590145824906; 
 Fri, 22 May 2020 04:10:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200521210635.17088-1-peter.maydell@linaro.org>
In-Reply-To: <20200521210635.17088-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 May 2020 12:10:13 +0100
Message-ID: <CAFEAcA_bQfDAeBMK2fdYF4JS2Zebpm-eM2H1T-354mcC9X=07w@mail.gmail.com>
Subject: Re: [PULL v2 00/29] target-arm queue
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::241;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x241.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 21 May 2020 at 22:06, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> v2: added Property array terminator (which caused crashes on
> various non-x86 host architectures).
>
> The following changes since commit ae3aa5da96f4ccf0c2a28851449d92db9fcfad71:
>
>   Merge remote-tracking branch 'remotes/berrange/tags/socket-next-pull-request' into staging (2020-05-21 16:47:28 +0100)
>
> are available in the Git repository at:
>
>   https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20200521-1
>
> for you to fetch changes up to fafe7229272f39500c14845bc7ea60a8504a5a20:
>
>   linux-user/arm/signal.c: Drop TARGET_CONFIG_CPU_32 (2020-05-21 22:05:27 +0100)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * tests/acceptance: Add a test for the canon-a1100 machine
>  * docs/system: Document some of the Arm development boards
>  * linux-user: make BKPT insn cause SIGTRAP, not be a syscall
>  * target/arm: Remove unused GEN_NEON_INTEGER_OP macro
>  * fsl-imx25, fsl-imx31, fsl-imx6, fsl-imx6ul, fsl-imx7: implement watchdog
>  * hw/arm: Use qemu_log_mask() instead of hw_error() in various places
>  * ARM: PL061: Introduce N_GPIOS
>  * target/arm: Improve clear_vec_high() usage
>  * target/arm: Allow user-mode code to write CPSR.E via MSR
>  * linux-user/arm: Reset CPSR_E when entering a signal handler
>  * linux-user/arm/signal.c: Drop TARGET_CONFIG_CPU_32


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

