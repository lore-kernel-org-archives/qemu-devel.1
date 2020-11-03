Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 313D9C388F2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 11:38:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F849206B5
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 11:38:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J5gmYd2F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F849206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZudW-0004GR-CX
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 06:38:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38702)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZucP-0003MD-Tl
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 06:36:53 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531]:35085)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZucN-0001iy-9J
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 06:36:53 -0500
Received: by mail-ed1-x531.google.com with SMTP id ay21so4528280edb.2
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 03:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=Tt7eOeKm4HkGz1Jm/YCy3l176pQhvcvxZOWZwSyW1XA=;
 b=J5gmYd2FOftIxj7xkRGLJ8Tk+hA0Ppy+nm2fg+lyqaORycaiVrwHYveNgDOW7BqQbt
 SQBuXwW447viQlBzlZjGV4vAx7I+4c4QPgl3yXAW5dkM35OVcQmqYNZVK/D512Cin1Wj
 mMu5JdVVO4T9xoI9/ddlaDp/KhHeVdH4bwjU7Hzaw1F+NEPitBNd68lY8NguPUcoAV56
 94fiRa4Yv15pFKuBC8SJGh1yzosDNkdfDdhrDvFp+8PL9IwRYmkj7AGNETUxs0fjNJS5
 RBwD1GEbYWenZ096auk4mHp3GUhoArHej+uIxjhmbZ4d8zgqtEBRlmOX8+gaO+Dl/4XI
 0N1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=Tt7eOeKm4HkGz1Jm/YCy3l176pQhvcvxZOWZwSyW1XA=;
 b=TlzFNKRJlxA1uM8PhW4F9xNRVAQC+nOC60QFkxyrTRYyXJItAoqSLB44lzxJk3bqth
 FEkpSuNVEsq9tfGMaHKLFPRFzon3simK89ai04b5wprZ2gfwM49QdyH3PbzM7aAm4S5F
 ezwVcjNFJlb+JnCP1hebjz9WSEDmjFWX3hX+tG5SzTxe+cMNV1rrXX4fx2dNHS5hKZx4
 OviXTq/T9ZjljWuMADnx6VI3rfHsNwDOsztcpFZv7jMO271bGBNal9EjqcwUG1vHFJMb
 10NpLeK9x0vNuHuHf4zE6MyzLLo1+cGOsfudS4cLpe7le1Yx+Msy36XsdO2ql8WT9DQ0
 0DlA==
X-Gm-Message-State: AOAM532dTq29SocSDTe64Jr3YRZspnR2z76rh5ySHB2z0G85OZg9W7pH
 whHaqY7XSw+IBb+GLRg8iOo4Md7Ov8KiUuJ8s+ew2+e+S5Q=
X-Google-Smtp-Source: ABdhPJwgpZCTuAjhrDSdgvxeW9JhiTvJ/2TJjN3CAdK0JFsr5+NDyF1bhkmwdwRWrtMBLXi2xbAAjdwJAKNdfDMu3Yk=
X-Received: by 2002:aa7:c683:: with SMTP id n3mr20770998edq.146.1604403408234; 
 Tue, 03 Nov 2020 03:36:48 -0800 (PST)
MIME-Version: 1.0
References: <20201102171005.30690-1-peter.maydell@linaro.org>
In-Reply-To: <20201102171005.30690-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Nov 2020 11:36:36 +0000
Message-ID: <CAFEAcA8PeOXmQoEyCVqNSYPZ9OsPp3z7y+UFXake_wCXCU4XAw@mail.gmail.com>
Subject: Re: [PULL 00/26] target-arm queue
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2 Nov 2020 at 17:10, Peter Maydell <peter.maydell@linaro.org> wrote:
>
>
> Small pile of bug fixes for rc1. I've included my patches to get
> our docs building with Sphinx 3, just for convenience...
>
> -- PMM
>
> The following changes since commit b149dea55cce97cb226683d06af61984a1c11e96:
>
>   Merge remote-tracking branch 'remotes/cschoenebeck/tags/pull-9p-20201102' into staging (2020-11-02 10:57:48 +0000)
>
> are available in the Git repository at:
>
>   https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20201102
>
> for you to fetch changes up to ffb4fbf90a2f63c9cb33e4bb9f854c79bf04ca4a:
>
>   tests/qtest/npcm7xx_rng-test: Disable randomness tests (2020-11-02 16:52:18 +0000)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * target/arm: Fix Neon emulation bugs on big-endian hosts
>  * target/arm: fix handling of HCR.FB
>  * target/arm: fix LORID_EL1 access check
>  * disas/capstone: Fix monitor disassembly of >32 bytes
>  * hw/arm/smmuv3: Fix potential integer overflow (CID 1432363)
>  * hw/arm/boot: fix SVE for EL3 direct kernel boot
>  * hw/display/omap_lcdc: Fix potential NULL pointer dereference
>  * hw/display/exynos4210_fimd: Fix potential NULL pointer dereference
>  * target/arm: Get correct MMU index for other-security-state
>  * configure: Test that gio libs from pkg-config work
>  * hw/intc/arm_gicv3_cpuif: Make GIC maintenance interrupts work
>  * docs: Fix building with Sphinx 3
>  * tests/qtest/npcm7xx_rng-test: Disable randomness tests


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

