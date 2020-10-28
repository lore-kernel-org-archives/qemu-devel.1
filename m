Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C1EC388F7
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 16:26:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7BAA247E7
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 16:26:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xz+2Az0Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7BAA247E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXoH4-0007ZN-Aa
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 12:26:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33518)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXoGS-00074E-Hw
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 12:25:32 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531]:41643)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXoGQ-000765-Ln
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 12:25:32 -0400
Received: by mail-ed1-x531.google.com with SMTP id l24so26355edj.8
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2020 09:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=IO0m4MFjawOmyny8FMRrRgHyEgrTqbbdAcC0TJHdsao=;
 b=xz+2Az0Z1j2qUUMTpKIhynL793rSO4HE0YdVU5I/dEkZ7cWYg0PT1Wt4Wv9OukRNSC
 EMmUJDTJ65Bo3x+RBCHStQ4lHStkWqn8O9c75dLZVVPU2Gt/F4MGRTCDEVlmvk2Nf+r0
 //oInKIb+6uYEKZjls/Ggr27sSnY5+bpXkIalMvjgj+kwbzOYWo/FQJ6VeDxzhtl799j
 yliPuOfy3uIiorieYluvs9KvBLFOgfA9DyiEwdOxhl9pyVYpxULVc97eKJnD6NXkusRr
 yj90/uYy6ZGm++PQiw/hfvz3oUolNOjy8353hHC69YyytxmIP+DWnVe4+TF1xzI6Eb5S
 qBAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=IO0m4MFjawOmyny8FMRrRgHyEgrTqbbdAcC0TJHdsao=;
 b=g1iv0mlD33RRx2zcmOqPVugJiudvLCDFnl+tF2Mx+s0WDqgL+n9Ux3UFRwRm4RA0jD
 vaeOOC4eAPwH3bBb6iCm1iO3YCh0oIbrYzhqPOLqvFmtqbeOZAfKXi/PyfkHLdMILezq
 JMBHrBbA2uxBZoiM6a6SCSVzlmRAHXOFfeC9LuYqcsjJQhIt8+Rc+U0ktNzE585z2X44
 /VsqiDOLkWiqUjTgUIkXN1KJR524YlaZzCcffiqN8YaKxYdc5i2hZ4cVwj5HNsI0qOqm
 ZcKPcesFct1f0evcdDmBx7BjZXWFdaPolsuFxe4ttDIBNzRCIM3UdEO4ZAJdidfDXnUS
 l9pA==
X-Gm-Message-State: AOAM533ULKnGSAR1jS8n24rHO73et/7jxkQhIkrZJxKrZvbgibtJhc7A
 8Kci3+qz+YhtDZvxD8ZrnTqfLyZNLBiBCu/acZ/dPw==
X-Google-Smtp-Source: ABdhPJyHSI25HNsaPRDr9qncZjo4u+Z0lKDaOK2DXAafKZVYq4pPxw2yB9R6nIPSdIvknR0W2BI9tM8c0wJNm+meWrc=
X-Received: by 2002:aa7:c683:: with SMTP id n3mr8412420edq.146.1603902328839; 
 Wed, 28 Oct 2020 09:25:28 -0700 (PDT)
MIME-Version: 1.0
References: <20201026220339.195790-1-laurent@vivier.eu>
In-Reply-To: <20201026220339.195790-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 28 Oct 2020 16:25:17 +0000
Message-ID: <CAFEAcA8_yGmAQgdy9VoLmStKUDrmsxb6aVOYJ-HvttXN4171-g@mail.gmail.com>
Subject: Re: [PULL 0/8] Linux user for 5.2 patches
To: Laurent Vivier <laurent@vivier.eu>
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 26 Oct 2020 at 22:12, Laurent Vivier <laurent@vivier.eu> wrote:
>
> The following changes since commit 4c5b97bfd0dd54dc27717ae8d1cd10e14eef1430:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/modules-20201022-pull-req=
> uest' into staging (2020-10-22 12:33:21 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/vivier/qemu.git tags/linux-user-for-5.2-pull-request
>
> for you to fetch changes up to ab97f0505bec6280c5455009b7678daf5c9278bc:
>
>   target/xtensa: enable all coprocessors for linux-user (2020-10-26 12:07:19 =
> +0100)
>
> ----------------------------------------------------------------
> Update syscall numbers to 5.9-rc7
> Fixes for prctl(), accept4() and xtensa
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

