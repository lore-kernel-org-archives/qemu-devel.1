Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D857CC433E4
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 19:55:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61986206D7
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 19:55:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gYve6vBX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61986206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0VhE-0001B0-Gu
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 15:55:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37674)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k0VV7-0005Ay-Ps
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 15:43:01 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f]:38489)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k0VV5-0006xY-4N
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 15:43:01 -0400
Received: by mail-ot1-x32f.google.com with SMTP id q9so120521oth.5
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2020 12:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=R1+mBmee8uodhwtXvu2etQOtQiChgLRNxwoqIWSN4F0=;
 b=gYve6vBXaYooixLL8fxQP07rtdkwQ7j6tN4mnuxm1yXyPvu6ePXdSfcqoor2CTkIJF
 cb4Et8r0H+Fr43aFAKLPfVyrZtR2vJ/IL8T36SU1UCCwCo0kAzteXXhuZaMewTi/QuGN
 EQGvit90V4bxUX9C9Id5vZdvK1OMfHTtg0VOuVPQv9H3VM4RuaT54nSB/Np2J6k7ucpb
 SI1+W2nDjMcg9zkUdbZVzztQV20SOkBCpUbdJyLBmk6HIW6d+nq1hr2Q2z7TBGk5V01O
 SzBZkHsJII6/CIZfXqdfmvzFW45ERHoL8R8sr6uHYtFYSb5ZUpkf54esO3My+7u365Nr
 Zp4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=R1+mBmee8uodhwtXvu2etQOtQiChgLRNxwoqIWSN4F0=;
 b=heCVaf5YE4NTomO6eTxyAT4wm0AJ247YrhVrOHBFR2Rfks3iG0Etc9ltyZGOcV/1G4
 0mQ4/AkIja1xRFJ4JSS2aPiNRH7gEVFJA7RZze+rDp6shOTcGVi28cti4KDhG4m6RQu1
 yos3axQjUvaRzMoafzQi68JiKcT2YEj6Oj9L+uGB6+HhJBYBw9o0UrjW43MGWhuAS62W
 MVZd5VxninbV8/d3+/mbxb4UNAw3vap/WTiufqk92YnjtGjhwUlLgqwaKjk4ocnlZFay
 YOBhJBVAJ4pi33nbK2YoMGxk0OrUScbn+x50zvcwAXP30iEPmeJDFDrShTf+oCyJin1K
 ST6g==
X-Gm-Message-State: AOAM533GfUS8bLlDh2F4mhmDDx0oSuEShTEuAZkioJnOfnPkFB0ObCYk
 UXlwaPuhH7VA6uFXMSCsrx/4DrgDscS1McQDG4AsSw==
X-Google-Smtp-Source: ABdhPJy7NcPck4ufjupaOWb1wHo0dOkXiWg52LI725hDIgZK8TWQj4eGGS+MYknn7UD7Oh5mfI+jtCdAQxvWf1GDJvk=
X-Received: by 2002:a9d:7303:: with SMTP id e3mr24572123otk.221.1595965377639; 
 Tue, 28 Jul 2020 12:42:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200728143108.2192896-1-marcandre.lureau@redhat.com>
In-Reply-To: <20200728143108.2192896-1-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Jul 2020 20:42:46 +0100
Message-ID: <CAFEAcA9z8_8KCNe68JVW-ibELEukrqsyTnMDAwQyD3Pv69QMjA@mail.gmail.com>
Subject: Re: [PULL 0/2] Update slirp (+ debug test-serial)
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x32f.google.com
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

On Tue, 28 Jul 2020 at 15:31, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> The following changes since commit 264991512193ee50e27d43e66f832d5041cf3b=
28:
>
>   Merge remote-tracking branch 'remotes/ericb/tags/pull-bitmaps-2020-07-2=
7' into staging (2020-07-28 14:38:17 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/elmarco/qemu.git tags/slirp-pull-request
>
> for you to fetch changes up to 9c15f57891af7c2cb3baf2d66a1b1f3f87a665ba:
>
>   slirp: update to latest stable-4.2 branch (2020-07-28 18:27:59 +0400)
>
> ----------------------------------------------------------------
> slirp: update to latest stable-4.2 branch
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

