Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E941C2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 18:33:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 842ED20774
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 18:33:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oIwYDW+V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 842ED20774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMxxM-00082g-Ep
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 14:33:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40450)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kMxwH-0007aE-Ad
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 14:31:53 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433]:43788)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kMxwF-00018F-ET
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 14:31:52 -0400
Received: by mail-pf1-x433.google.com with SMTP id f18so1817696pfa.10
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2020 11:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6A0n3vd2JhZ97SNSS2i4YVfy1p4vWjc6rEe7kV8A1rc=;
 b=oIwYDW+VNAQcLSG9I0V8+f3kzIXUJplq5c88WicHWZ0GoVssArn8c5LGMF1SEX4eRj
 d525bO/zCaxCpRMFdI1z4MYXBSquRw6yVYEmFldM0EWHaclwxoA76TGVjcKQDVgqSy1v
 QYfGdl+GfCTEtaEHoH3gw1YVbjfxGm8gX7O2oyupx+cdKeKJIC9ClvFtjW+xf4/GgQ/t
 QTg0q817qPcEEY/5HUGpAtsrwy4VG0fN1dehmtpEVketrV5qXO+81mvU1EYQHsePfZ7/
 btSkJ0WR3Z6IbYddZnf0/hQknPJgIE/ojlXrq+a03Xvd/nbXk/w9sBiihcBUaWpa/ndI
 ufWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6A0n3vd2JhZ97SNSS2i4YVfy1p4vWjc6rEe7kV8A1rc=;
 b=ovo4L0aSVE/0coJ7Mo/wLaL5x0qxiV94CdZVD8ty+iDBaNdAdGFE/1akKXAglymDEb
 n5/kVYM/ob6tYp+21QqhD312n56I+bYBOcWLK4FXXLKB1QjLWoyY2mN8VupE6n6pTYYe
 MXKTCHbLHZexnJXGhlNKtES89GOY7VNgAr6LF1x95P3FKD6y5tYhSbmp8xlWZDd29DVF
 57lA6z10SgMMbhxuvDR7Y9qYQ6hpDsBy5q/GtpFVNCvMTGVU5gjy5CSWB7Z9PmoOlC6f
 SKjiA7MLgFqTr4J7EDIx4OKmoCoH9AGEC+dAFG9R5F2EWA+ZhVAP0z3OIGUbbhnhlHvc
 OkYQ==
X-Gm-Message-State: AOAM531ho94G0NAjxt/d39IFNuXfrA4q7W7/02E2w0jvYiZhvLr/Igti
 n8c8p8NU3iu3yFxNw205ZhNhlDWi/wiVlXc2h4aicg==
X-Google-Smtp-Source: ABdhPJxtShR0eRcFgZc0zW59AA6w3ooGAyMpiRzRCT4kr/7RpArPadfxNWcuiXUjeipVjQnB9SftH7ghdH67oujXT/8=
X-Received: by 2002:a62:520e:0:b029:142:2501:3979 with SMTP id
 g14-20020a62520e0000b029014225013979mr734889pfb.62.1601317909818; Mon, 28 Sep
 2020 11:31:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200927134609.2358960-1-alistair.francis@wdc.com>
In-Reply-To: <20200927134609.2358960-1-alistair.francis@wdc.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 28 Sep 2020 19:31:38 +0100
Message-ID: <CAFEAcA-3X62vaL0UB20m8QtE5Uyy5T1sHRNMPxyw0dDj119gQg@mail.gmail.com>
Subject: Re: [PULL 0/2] register queue
To: Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-pf1-x433.google.com
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
Cc: Alistair Francis <alistair23@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 27 Sep 2020 at 14:58, Alistair Francis <alistair.francis@wdc.com> wrote:
>
> The following changes since commit 8d16e72f2d4df2c9e631393adf1669a1da7efe8a:
>
>   Merge remote-tracking branch 'remotes/dgilbert/tags/pull-migration-20200925a' into staging (2020-09-25 14:46:18 +0100)
>
> are available in the Git repository at:
>
>   git@github.com:alistair23/qemu.git tags/pull-register-20200927
>
> for you to fetch changes up to e8a612b7e3cdbdface1e34a27300ca2f8521dee0:
>
>   core/register: Specify instance_size in the TypeInfo (2020-09-25 16:52:24 -0700)
>
> ----------------------------------------------------------------
> Two small patches. One with a fix for the register API instance_size
> and one for removing unused address variables from load_elf.
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

