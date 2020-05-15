Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA18BC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 15:48:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C06A20758
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 15:48:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BU8uDqXs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C06A20758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZcZB-0004U1-Rz
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 11:48:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56508)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZcYI-0003QT-Ms
 for qemu-devel@nongnu.org; Fri, 15 May 2020 11:47:10 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335]:36444)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZcYH-0003Nq-Nr
 for qemu-devel@nongnu.org; Fri, 15 May 2020 11:47:10 -0400
Received: by mail-ot1-x335.google.com with SMTP id t3so2254606otp.3
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 08:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=TomqSaO4R3RlIEYlDyeec4GZQXW8w29VzvCFlvqGplY=;
 b=BU8uDqXsMH+2kJQP+f1NRCjfbEQib2/C09yH2bjW1MF2k41w++pmQNDZ/lT+fFi3L4
 6HE/4CpArPEwSMzJqoFkJ1dSdnNCBvSNPoJfiovAFfGeEmM96EhH78dUiV3eXE1mEQUa
 jtRsrO3Nuuj7/gd8q9bARTSK5/14wq43cNKdu/tj3kFXWpY3RbrwiC4jCoEplzhZvkia
 AXewXATHbls08suxTRlFMmAT6e8wmHrZwzezJcXYyJa8/Erq8T6OZkrypeFEH3LPxif5
 jwolYffqIWyeST5H7UeqNADdR1ZeBFx0i1PEx7lVAHAsjaxNMAuQO/w5ytx3PNTe21Zi
 Xrlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=TomqSaO4R3RlIEYlDyeec4GZQXW8w29VzvCFlvqGplY=;
 b=hcP1OhLbHIdMNAPHPisTMIQzV/tm8jnJ2yJKMv4uOQ+675tBwEfAk77EizUyMGrecM
 OCR0Fjal6YZi5iPSXvpFQGdx4Jp9dq4+yHx5OJYwoGPAVvy8A4PwtzHlQha2bD+AtORF
 qzhVHXlqHeWkjjSxOnUitA3ayz8Z1vu5YIC0aSyteuZu5eEOtO8h4W+6H04kgalwMGcC
 sJ3Ndy7TtaBxK/kmj+EGlS6XtXWqTpvAKLRIya6BC7w4ZYX0fdjSl+vmBgKjx5VXRk6W
 CSWZpxYCip0rpuEICsgABYTDW3R5SAqlRlijaVvmshBfJIwkgIma6veu5VQ86KgGCBAr
 vymg==
X-Gm-Message-State: AOAM531YH43S2k3L1mjRXRLHBx0HDoJMl7AykVGoD/fI2Md7SRnyq4Zn
 LlTLHeML6zlo1+vXCR7pDPS7x2B1Ym3p9lx0AA14Ew==
X-Google-Smtp-Source: ABdhPJwMWqCpF4czKe+cpvyUa0+c96H7Pzfw/y0u1sZDY/0NM9geUjsDJXESdDRhG++LhpUT9EvUXGiAK8I558QFuTs=
X-Received: by 2002:a9d:b82:: with SMTP id 2mr2588422oth.221.1589557628391;
 Fri, 15 May 2020 08:47:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200515144405.20580-1-alex.bennee@linaro.org>
In-Reply-To: <20200515144405.20580-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 May 2020 16:46:57 +0100
Message-ID: <CAFEAcA-6wLVYio90-OqZ-0kBsstGRebMk1wt=zq2xnx5_Po1Yw@mail.gmail.com>
Subject: Re: [PULL v2 00/13] testing, tcg and plugin updates
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 15 May 2020 at 15:44, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> The following changes since commit 2478b8ecd45f81a21b9aa319ce7147a790a214=
4f:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/ui-20200515-pull-requ=
est' into staging (2020-05-15 11:18:13 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/stsquad/qemu.git tags/pull-testing-tcg-plugins-15052=
0-2
>
> for you to fetch changes up to adf1cfbdc29e6e3342ca07701be4d2cbfd7d3907:
>
>   MAINTAINERS: update the orphaned cpus-common.c file (2020-05-15 15:25:1=
6 +0100)
>
> ----------------------------------------------------------------
> Various testing, tcg and plugin updates
>
>   - fix bug in gdbstub tests that leave hanging QEMUs
>   - tweak s390x travis test
>   - re-factor guest_base handling
>   - support "notes" in disassembler output
>   - include guest address notes in out_asm
>   - cleanup plugin headers and and constify hwaddr
>   - updates MAINTAINERS for cpu-common.c


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

