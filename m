Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8453CC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 13:11:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53F83206BE
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 13:11:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ag1sn6N/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53F83206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqG2Y-0007Wi-La
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 09:11:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56608)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jqG1g-0006tD-SZ
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 09:10:16 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:42017)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jqG1f-00020O-2S
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 09:10:16 -0400
Received: by mail-ot1-x342.google.com with SMTP id 76so3911888otu.9
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2020 06:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=zVq/9973tf2Z20yIs/X9QGLTnFofucsQlmr/1yZQfoA=;
 b=Ag1sn6N/nM856cEs0+WG/BjehaiT3/MGPOq9qWml4FT0+esLM89WvmzBBANswhUnE1
 rD6+cnGk+6UK2uWRS+tHLBLioNFF2gSuYweYlQh+fn4Q81cz33fGeOYWZpXyI102WX2h
 oyXb2+bQj+ObHcNWUgIb2dSlvM8X71UEedyv1G6loqzfLFUe4ecdkbnrl84v824jEUye
 olL6Pwrubp3Z1hLEMYxRwRkUNXqb8E09I0JVpO098jlKM3+Gzj1L1MvcMMyLP6sblaI+
 HU9E5Od9LA6k9yqp4My2hYio4ovtI8tEcK/riA4Ahuxv343SnXx/nofdXoA4poEMnypI
 ScVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=zVq/9973tf2Z20yIs/X9QGLTnFofucsQlmr/1yZQfoA=;
 b=F3DmvPVJz/clq73ghmjGwpIrDdYrBwX4+II/s/Zus7JuSUR86TdD96fNolh9457Ejh
 YuCDcm6fzapjyz2xTOPliFLzQtBdTMxvVaDzA7qKsbd8Qd1909bo7Vsq24f+D0A1uOgL
 OpImSbwY4ECc3qRIhz+88VvG0sAbgbeBsVyky//GbN+fQtd2Zg5xJ5xPHgucVIABUH9A
 cS/5EIJRSsVqZ8BvOLpD1ySmB/QoiAQXW7qQ3fuqyfjk3kceGJ3KdPjqNhgjP2+mliPt
 sah8EIdyYO+p9jCHgyAogep6FHQVfkLSH9b7y5/HrFuX4Ng2odj0exs8AatJ8VK2bIXk
 cY5A==
X-Gm-Message-State: AOAM531I9pXZsOLwkPK6dr4Rbka1rLal2ad85LIGsWWnPxONepsNW+34
 OaQ6exFzzhNIXzlRbmeSroGlefEetQd74xRee98isw==
X-Google-Smtp-Source: ABdhPJzraFE0SHiIUWsCeWpu6yb03jJxAAg105OxK8KLhNFzt6EYu4W1cz+/bbtv8KZNAdci3kA/hiUtPb3Loox+55k=
X-Received: by 2002:a9d:7303:: with SMTP id e3mr11721892otk.221.1593522612769; 
 Tue, 30 Jun 2020 06:10:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200630103448.22742-1-alex.bennee@linaro.org>
In-Reply-To: <20200630103448.22742-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Jun 2020 14:10:01 +0100
Message-ID: <CAFEAcA_vmcPq=LhEd2d5Kxyg-3q-VjYVa906EUempkXZ0cRXUg@mail.gmail.com>
Subject: Re: [PATCH] linux-user/elfload: use MAP_FIXED in pgb_reserved_va
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 30 Jun 2020 at 11:36, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> Given we assert the requested address matches what we asked we should
> also make that clear in the mmap flags. Otherwise we see failures in
> the GitLab environment for some currently unknown but allowable
> reason.

Adding MAP_FIXED will mean that instead of failing if there's
something else already at that address, the kernel will now
silently blow that away in favour of the new mapping. Is
that definitely what we want here ?

thanks
-- PMM

