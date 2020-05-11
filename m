Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D1DC47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 14:04:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8315E206D3
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 14:04:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jSrfgOoj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8315E206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY92X-0007Nx-K4
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 10:04:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54274)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jY91d-0006KQ-0Y
 for qemu-devel@nongnu.org; Mon, 11 May 2020 10:03:21 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335]:40776)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jY91Z-0001Mb-AM
 for qemu-devel@nongnu.org; Mon, 11 May 2020 10:03:20 -0400
Received: by mail-ot1-x335.google.com with SMTP id i27so7574886ota.7
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 07:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=RTM6+Yn+NO9lpfXcimSXrrW639DahkEUidnJnfBxThE=;
 b=jSrfgOojEkE8atIA1RP40mdma+rqa98JWnHbRQGAIAEOgUxjXQJvzYMaCiqpP0f4za
 cEC/CxFIcuNEfaObBc27Mdkezx77/4PKv+t5Y4WlG9qe0iBWDGGdSQM+Ue3Pxoo5tpBo
 RvneQynh4mv0w6f8rMuJSmmgNUQjAr0rKiAj+yFxp4Z60QABZJDo5OdZvpGvNp9xp35u
 EJvJNiIIo4VR+Eu7UmrdUQr07BuY+FYWDDultbgfARXaJ3huc1OdmyKNTAPmtM79G2PZ
 rh0IVLi2BYbnP2fOixOl0wb/Ns1HR2HPLYlkjoYNXL0n61kSAFqtY7EwmW6pXeR7hEnZ
 Sm1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=RTM6+Yn+NO9lpfXcimSXrrW639DahkEUidnJnfBxThE=;
 b=FCXvo2qCL+NZDH0ycJwcpHK4HLV3DAoLlsij/z1v9YH0z+IC7NVcBT7UjJCONZl6BM
 FYwFoXfT31n/uKFX3m+GFSdTCou3EG2cWrRHYfj7iHYVkEAJFK9r+BRd2AHZ1vEBYswt
 VH/bjMomUCgRhi2P0dqLY21ZYwiX7mGZT1G5PbmUR6ITzo6E1jKuWwHX+3ShmUjoeboa
 kppxuzBKw5NrF657eMQxBApaHCbRL/lioF/Tfwbr+4AHULLo1ZFtGeSeOZxsewbrF7/K
 +Ypw+3/wTMrmaimnQKvea+CmLhR6P4urkS+QdNA+QW2qnjtSWie1YoxnbVc1ar0D2x5Z
 Izew==
X-Gm-Message-State: AGi0PuZJFQMob+SsMotAQYeUp6MttyjrEZuEX4/3YBE3p9SESWm3l2lc
 eLXg+2BRIHjXv1zCL2Ns1NE7WOaG2fx9eCFGRMoLE3N5DQc=
X-Google-Smtp-Source: APiQypJ/WhMHXFJaOzCky9tNkq+E0AK4uslWRJ7BrUCtYfEZOH/e6OQYd1XB+juukLCNZ4/ZRUaHpctUZS0XdzGK+98=
X-Received: by 2002:a05:6830:1e4e:: with SMTP id
 e14mr12571229otj.91.1589205795513; 
 Mon, 11 May 2020 07:03:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200511133405.5275-1-peter.maydell@linaro.org>
In-Reply-To: <20200511133405.5275-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 May 2020 15:03:04 +0100
Message-ID: <CAFEAcA9PZ2S1uiC7dOorOW19m7hkH7b0JmYiO4ay8QSrTvp3kQ@mail.gmail.com>
Subject: Re: [PULL 00/34] target-arm queue
To: QEMU Developers <qemu-devel@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x335.google.com
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

On Mon, 11 May 2020 at 14:34, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> The following changes since commit c88f1ffc19e38008a1c33ae039482a860aa7418c:
>
>   Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into staging (2020-05-08 14:29:18 +0100)
>
> are available in the Git repository at:
>
>   https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20200511
>
> for you to fetch changes up to 7e17d50ebd359ee5fa3d65d7fdc0fe0336d60694:
>
>   target/arm: Fix tcg_gen_gvec_dup_imm vs DUP (indexed) (2020-05-11 14:22:54 +0100)
>
> ----------------------------------------------------------------
> target-arm queue:
>  aspeed: Add boot stub for smp booting
>  target/arm: Drop access_el3_aa32ns_aa64any()
>  aspeed: Support AST2600A1 silicon revision
>  aspeed: sdmc: Implement AST2600 locking behaviour
>  nrf51: Tracing cleanups
>  target/arm: Improve handling of SVE loads and stores
>  target/arm: Don't show TCG-only CPUs in KVM-only QEMU builds
>  hw/arm/musicpal: Map the UART devices unconditionally
>  target/arm: Fix tcg_gen_gvec_dup_imm vs DUP (indexed)
>  target/arm: Use tcg_gen_gvec_5_ptr for sve FMLA/FCMLA

Hmm. I get this link failure, but only on non-x86 hosts
(aarch64, ppc, s390 [aarch32 ran into a temporary connectivity
problem and didn't run]):

linux-user/vm86.o: In function `do_int':
/home/pm/qemu/linux-user/vm86.c:224: undefined reference to `cpu_ldl_data'
linux-user/vm86.o: In function `vm_putw':
/home/pm/qemu/linux-user/vm86.c:46: undefined reference to `cpu_stw_data'
/home/pm/qemu/linux-user/vm86.c:46: undefined reference to `cpu_stw_data'
/home/pm/qemu/linux-user/vm86.c:46: undefined reference to `cpu_stw_data'
linux-user/vm86.o: In function `vm_getl':
/home/pm/qemu/linux-user/vm86.c:70: undefined reference to `cpu_ldl_data'
/home/pm/qemu/linux-user/vm86.c:70: undefined reference to `cpu_ldl_data'
/home/pm/qemu/linux-user/vm86.c:70: undefined reference to `cpu_ldl_data'
/home/pm/qemu/linux-user/vm86.c:70: undefined reference to `cpu_ldl_data'
linux-user/vm86.o: In function `vm_putl':
/home/pm/qemu/linux-user/vm86.c:52: undefined reference to `cpu_stl_data'
linux-user/vm86.o: In function `vm_putw':
/home/pm/qemu/linux-user/vm86.c:46: undefined reference to `cpu_stw_data'
linux-user/vm86.o: In function `vm_getw':
/home/pm/qemu/linux-user/vm86.c:64: undefined reference to `cpu_lduw_data'
/home/pm/qemu/linux-user/vm86.c:64: undefined reference to `cpu_lduw_data'
/home/pm/qemu/linux-user/vm86.c:64: undefined reference to `cpu_lduw_data'
/home/pm/qemu/linux-user/vm86.c:64: undefined reference to `cpu_lduw_data'
collect2: error: ld returned 1 exit status
Makefile:208: recipe for target 'qemu-i386' failed

Any idea what's going on here, Richard? Presumably it's fallout
from some change in the sve-loads-and-stores patchset...

thanks
-- PMM

