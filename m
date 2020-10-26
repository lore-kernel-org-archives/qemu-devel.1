Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D60BBC4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 13:24:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3863520809
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 13:24:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t0a+zFUH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3863520809
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX2U7-0002g9-CT
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 09:24:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60906)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kX2TY-0002EZ-Sr
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 09:23:52 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:42219)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kX2TW-0005te-PC
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 09:23:52 -0400
Received: by mail-ej1-x642.google.com with SMTP id h24so13464666ejg.9
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 06:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qxuWfTrjk+zii/v+oSpXfBlDA+swz1ETle75BLG3oCQ=;
 b=t0a+zFUHYlS4MiiGuYFheq+9M5lHmXQgzu5sZ8bdhEDvstKoi3T0Bgqay1aiy3ywPC
 O3r8qxmnuWamyJKqm3sN78p/PwzcxA4kwuJMEjZvSgD7XsBletZJI4TvR6yHQAGzYAgx
 diKVgmnWsFeEC2CBEEUTcPEMjZm/1YcZvzPDvrDsi+vP9bCC3jyHhEa3xuBJbDiJxK+w
 hDRY8g0XkE/XhcYKJkMDkG2kP9LeoDGC/RLyFe+ZbC2KAq3GddwOdmH9hjDHXF7oVdZz
 BXeWBHDLPGSk+2Kv9CvD9kC+gTVF3Cz2cD+74MpBEH/6VD1A+I1SWF/i/VgDAIjy0A+Q
 tj6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qxuWfTrjk+zii/v+oSpXfBlDA+swz1ETle75BLG3oCQ=;
 b=WmUFIiQDLDh9cM2BVsF9CsEJlf8G4MStEF8Y6zuyaS0SaVW7CzExqKs+KtNVXyytsM
 pRlr24AKy13th1pgzjaBwaNswlaLNh+W18qNpPKbRTwoooSXJYqhWwvL7m6VcVCL7oNP
 lXsl/EMgMTvaK290Rsw4Oan3phA4GdExFXdvAy01OakdNS64IVOTU/q9MBvANsTa+4H1
 joyFLefVxBQw0gi1xJCHJzi/rTzYncArLMR/LK+ugc3Cb5oqoUtrGs/bc1naZV57Xhwi
 aJn57L9F7CnJ3aPjAXBoAfbSb0itxVvQThjz+hVIa36tmJacv+pq43krIdM/pO7Coh+/
 sqYA==
X-Gm-Message-State: AOAM533Xu7ZifkgGBaCvCovwusiJyFjsnQHDqYm+lfWyfLainpjhx0yl
 o2xa07+GDG75pYTZr3hYIJ2NkILPU+h72NDTIwNtYw==
X-Google-Smtp-Source: ABdhPJySD1EihihboryYmNu/fjH2QQm+Z1a+HZS/FkCN5ryM5VeckzdFriCeKE/Qu/ss95L9DEL13kJR2pJyFrQ7uQg=
X-Received: by 2002:a17:906:af8d:: with SMTP id
 mj13mr15332818ejb.85.1603718629145; 
 Mon, 26 Oct 2020 06:23:49 -0700 (PDT)
MIME-Version: 1.0
References: <160343854912.8460.17915238517799132371.stgit@pasha-ThinkPad-X280>
In-Reply-To: <160343854912.8460.17915238517799132371.stgit@pasha-ThinkPad-X280>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 26 Oct 2020 13:23:38 +0000
Message-ID: <CAFEAcA9ywpOtS-wy6QXT6SKzbC1TK47F-d56e53i9Y6V9rSxcQ@mail.gmail.com>
Subject: Re: [PATCH] hw/arm: fix min_cpus for xlnx-versal-virt platform
To: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x642.google.com
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
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 23 Oct 2020 at 08:35, Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru> wrote:
>
> This patch sets min_cpus field for xlnx-versal-virt platform,
> because it always creates XLNX_VERSAL_NR_ACPUS cpus even with
> -smp 1 command line option.
>
> Signed-off-by: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
> ---
>  hw/arm/xlnx-versal-virt.c |    1 +
>  1 file changed, 1 insertion(+)
>



Applied to target-arm.next, thanks.

-- PMM

