Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5BB3C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 09:43:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71A80206D9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 09:43:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DU2I2mT2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71A80206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVXdA-0000Kd-L1
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 05:43:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54558)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jVXcX-0007w7-GZ
 for qemu-devel@nongnu.org; Mon, 04 May 2020 05:42:41 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:34350)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jVXcW-0008LC-Nt
 for qemu-devel@nongnu.org; Mon, 04 May 2020 05:42:41 -0400
Received: by mail-oi1-x241.google.com with SMTP id x10so6128208oie.1
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 02:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=vmkFayFWx5sfKboCStc1ZdInvZHdlFJUtJcBrBPpMK8=;
 b=DU2I2mT2dNWovMsaUZ4bmQbiy5h0nTH2TAU5nxlgbfirdsDtxHYvmWX2vAY9mezK0M
 rgZR9Eoy6Hf4NVBGPV3/AZaE0mqf73Rb/BtnMRpHl5ejgrXSsGkKGKBSdqJPNV3tpXlP
 sKXDTm888DFN+FofF9KsLBnfch1E9ox8NOzYQkwDTiu9bukE78C/E6SUyKfrdAAsfE69
 UZmOvps5A5GPA9xENKVnEB+vDolHRILNYS9DFmrwZYj3zGi2g6E7F1H40r2p93gDSPiG
 TGQ4lNbjnK1+p3KvuEzhcjR/Lww+YGNTOey3FZwEoHylNg8yJK29jh809oG1fshdd/Iu
 7vzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vmkFayFWx5sfKboCStc1ZdInvZHdlFJUtJcBrBPpMK8=;
 b=YJ6lrxeZSsn6RmbytHNBmO0LHTJMD9qdYB5w7YQvSFm0i6nhzAusNysKsUe9hFXsj+
 23mhMcA2oRSiTk7mwQDSfbx5UC/wZqdgto1Q+LGZQzvtwI8RNdt8stcFRAkXSQwQgseE
 GJtWZ/b5YmQUUCowDU9g8AyWjnBWqN/XXfhy2WgKI7Xy4mhioX0re+/mniQV/jYyVSl0
 JQmFLFJjBYr6DsdhHV5ZIvnCEwKcZUJQaftJwX/NHvWVFL5OgJvQSCsEA4EJ6ttHj0t3
 WAWTbU30oLYop0WeHPEjp3vrNYowltEMDI18CIEFojDfzDMi2rgSefVB+zgJT0x/4pbQ
 8H2g==
X-Gm-Message-State: AGi0PuZcXd4fa6oF7IOAHvqtwQT6eMK7Mx+qrSoCx+MrSs6860vQjEjE
 l5RG2gaJEJqseubN3n5Ij2xDYu32akF1kECBtz+fkQ==
X-Google-Smtp-Source: APiQypIDeLgf+PEDsn2vdJ3jx+79OeBHrg+9oCI4AsSENLUSDXseqoZQE0j4j29miobSqixAdzqjUxRWnK3YAgORKyQ=
X-Received: by 2002:aca:3441:: with SMTP id b62mr7881390oia.146.1588585359466; 
 Mon, 04 May 2020 02:42:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200430162813.17671-1-richard.henderson@linaro.org>
 <20200430162813.17671-14-richard.henderson@linaro.org>
In-Reply-To: <20200430162813.17671-14-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 May 2020 10:42:28 +0100
Message-ID: <CAFEAcA-ntSS=gmuOtpDKOCzxpQ0uYVgJe2Lt8MHqGPwuOYbE9Q@mail.gmail.com>
Subject: Re: [PATCH v4 13/18] target/arm: Update contiguous first-fault and
 no-fault loads
To: Richard Henderson <richard.henderson@linaro.org>
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 30 Apr 2020 at 17:28, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> With sve_cont_ldst_pages, the differences between first-fault and no-fault
> are minimal, so unify the routines.  With cpu_probe_watchpoint, we are able
> to make progress through pages with TLB_WATCHPOINT set when the watchpoint
> does not actually fire.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

