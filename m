Return-Path: <SRS0=M8gQ=CP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4931C43461
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2020 13:08:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DD7920DD4
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2020 13:08:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dyQGkiIC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DD7920DD4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEuPD-0001oN-VW
	for qemu-devel@archiver.kernel.org; Sun, 06 Sep 2020 09:08:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60238)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kEuOO-0001G1-2l
 for qemu-devel@nongnu.org; Sun, 06 Sep 2020 09:07:36 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531]:35740)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kEuOM-0001A3-6z
 for qemu-devel@nongnu.org; Sun, 06 Sep 2020 09:07:35 -0400
Received: by mail-ed1-x531.google.com with SMTP id i1so9955684edv.2
 for <qemu-devel@nongnu.org>; Sun, 06 Sep 2020 06:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=i1xRcLva2a2endHyEkdlCHOBEVHUJGkWMSXBaQ1mxl8=;
 b=dyQGkiICS6CZAySeCWUrcLHWzkkt9uoRpBt4VZ7nuqeCpOm06Dvd3seggcyz1bWpqH
 iaA1CYvRCwjXVFWqkkSZozb3GAr3/fX0my+yCM32jYZ8cOOfv5Ryi1zaCqklWFAOvG52
 h7lQ3L7WjerzlBSNVGkehBxILxsRDOt67lDiZmOa/4AYn9mdBKgb+RbyHfErM1ywoHyZ
 mK4nH5VgJoUUWr74+JGoKonN3w+LWV9fIOHUhE037VlJkz6WEb+n2nd5+QwxgydkKz60
 h4Lq0Kc2FiIrEajeW3nX5BXZLSBLuFErgHML9PXFGzaJg17MwloKWo6S5cyrWNKPe9Ku
 Do3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=i1xRcLva2a2endHyEkdlCHOBEVHUJGkWMSXBaQ1mxl8=;
 b=hpagif9VIAPG9gnKQzp4SSPRn6ShmQALMY8ygOaQU7NagK1zI+mDEpfhJxtv0Gx2Nu
 GeaAnBofUL+pFimmJ/wDjNAM8Y8z1DX8JE7vG9dP01PEshdXxsvkUuxx8Kwi2mM9EgCQ
 w1BI5G5MAubjs60hyiMap78JZcNDfZlPkeASYIXI1Glj7u60DgVTOMWSxbzYg8NpuZSf
 0jODH9IZtBVYmatJbeyKzBhXOh5Z5wtyrVx/NGQrZy/KHohp7rvGOIKSavfnfmjXR7Mr
 eJCTjFjFaeGSPMct50YWY8I+MdqLAWZ8HkwLrIhcO8La32UjKpfgIhEzSWkJDkIHBFaM
 tHAw==
X-Gm-Message-State: AOAM5338FRIQsmD3jSjwdEJEEXqrwic2bhFBO80NrNCiBqwNbFEegAVD
 zuLxFkzvV/+9ueDxNHjbWvQcxXe5NkT/jgIf5n4u0Q==
X-Google-Smtp-Source: ABdhPJyYHDr+LJmBZRdt4zPMCcomgu1r+GUuhJJ2h5G0ratvl/sTBZikHZ8vRNTPGVyBXwQ847/HNH0uV+xxv8s2GcA=
X-Received: by 2002:a50:8f45:: with SMTP id 63mr17838988edy.52.1599397652286; 
 Sun, 06 Sep 2020 06:07:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200903214101.1746878-1-richard.henderson@linaro.org>
In-Reply-To: <20200903214101.1746878-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 6 Sep 2020 14:07:21 +0100
Message-ID: <CAFEAcA-ue1joQDRq5FhdirfsMzFCEtFe+O9ezUBkS6rJ+Om5Lg@mail.gmail.com>
Subject: Re: [PULL 0/5] tcg patch queue
To: Richard Henderson <richard.henderson@linaro.org>
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

On Thu, 3 Sep 2020 at 22:41, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The following changes since commit 3dd23a4fb8fd72d2220a90a809f213999ffe7f3a:
>
>   Merge remote-tracking branch 'remotes/legoater/tags/pull-aspeed-20200901' into staging (2020-09-03 14:12:48 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/rth7680/qemu.git tags/pull-tcg-20200903
>
> for you to fetch changes up to fe4b0b5bfa96c38ad1cad0689a86cca9f307e353:
>
>   tcg: Implement 256-bit dup for tcg_gen_gvec_dup_mem (2020-09-03 13:13:58 -0700)
>
> ----------------------------------------------------------------
> Improve inlining in cputlb.c.
> Fix vector abs fallback.
> Only set parallel_cpus for SMP.
> Add vector dupm for 256-bit elements.
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

