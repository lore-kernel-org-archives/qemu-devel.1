Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 311EDC4363D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 14:39:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 709A321534
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 14:39:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L3oxAj+E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 709A321534
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUsnl-0004gk-Df
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 10:39:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45730)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUslu-0002ZQ-PQ
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 10:37:54 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:34035)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUsls-0001Za-Mt
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 10:37:54 -0400
Received: by mail-ej1-x644.google.com with SMTP id u8so3106531ejg.1
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 07:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=rVdG0MJfAs7wfweXoT0WQepqFxnXW/2FHREXTvqsWzI=;
 b=L3oxAj+EUElbAHBkQFpyOniYqdaTq2oflSHbu7jpBp0Ksj/PFJoISS6pce7b9TvRnq
 rTW9ZFEHxvh21UGnHAydz8YL1QODpCh5X53VS3nkwUg174r5kNrAsey0SCgIdFCk+RDd
 KhOqBgD+0qOzcc7LQ4/C84K4bT4gTBYPKcnur+3noAl/YdPVRZ0IYys6+G9egllK77Ti
 eALNDSmKJur2u4dKi9p+HXFDVHti6Bw3Rz0rFCx51CoN87yMFPlYWrva7g4PCmtN3Sn2
 kck5DaDoHXAZVWSVUyUDYh+7QcTOqJC+invk1CbCyoa7ijKPckDZD11Q0DvEBjc3fIZG
 XsKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=rVdG0MJfAs7wfweXoT0WQepqFxnXW/2FHREXTvqsWzI=;
 b=dla23IcGnsOdsTxauTS5kb8EoMTS4qUeJWw0FvRlCfCYVVEnSPw1aAakd2HY7AiZmu
 cs/0MmK2XDOZ0DQCbfVdCtoGh2i55Qb3wtMKEKQuU7HepV0cnJojNy6Wu62HSItIz1cU
 v/ytqFCA8FCmEJ8gX6KC9Yq5G4QMozVa5j100ZqJb+hJO8HG8gCn32Tv8VxbxB2D++w8
 B6HYq4el56ls69Ci0kom8PJMjmf0t8iBlpZXNmouR0ha3og+L/kz6HMNGPBvFQ8OAFd8
 5crA/8jlEhtwyZXi1bStm17OTLAn8sjM2wuZfz2dchrykAW8VSKXp4o5pj8U2VNZ5sHC
 /5Kw==
X-Gm-Message-State: AOAM531vLDZzA64C2hnrQpzNx2rSYcgzpyoOKGR/Ya4BM4DhwMEJgJXU
 4X64wSAmmT8dTWvABpMmrhK3HYxb50a3u2ByHRa/BA==
X-Google-Smtp-Source: ABdhPJymkkKtaOfX/Mk0JnPPU47MmraoE2muSJFpKvQ/Nxm/U/8PM7+GtNpHs6qJjVbnRHX5t7n07IkZdEabq+oy3Ds=
X-Received: by 2002:a17:906:3a97:: with SMTP id
 y23mr3486508ejd.250.1603204671317; 
 Tue, 20 Oct 2020 07:37:51 -0700 (PDT)
MIME-Version: 1.0
References: <20201019095148.1602119-1-f4bug@amsat.org>
In-Reply-To: <20201019095148.1602119-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Oct 2020 15:37:39 +0100
Message-ID: <CAFEAcA-1+kjy-bw4QUpeUumnC1+cOcwqCdSYsmv8ubQvOwAz1g@mail.gmail.com>
Subject: Re: [PATCH] hw/arm/nseries: Fix loading kernel image on n8x0 machines
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x644.google.com
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
Cc: Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Andrew Jones <drjones@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>, Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 19 Oct 2020 at 10:51, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> Commit 7998beb9c2e removed the ram_size initialization in the
> arm_boot_info structure, however it is used by arm_load_kernel().
>
> Initialize the field to fix:
>
>   $ qemu-system-arm -M n800 -append 'console=3DttyS1' \
>     -kernel meego-arm-n8x0-1.0.80.20100712.1431-vmlinuz-2.6.35~rc4-129.1-=
n8x0
>   qemu-system-arm: kernel 'meego-arm-n8x0-1.0.80.20100712.1431-vmlinuz-2.=
6.35~rc4-129.1-n8x0' is too large to fit in RAM (kernel size 1964608, RAM s=
ize 0)
>
> Noticed while running the test introduced in commit 050a82f0c5b
> ("tests/acceptance: Add a test for the N800 and N810 arm machines").
>
> Fixes: 7998beb9c2e ("arm/nseries: use memdev for RAM")
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>



Applied to target-arm.next, thanks.

-- PMM

