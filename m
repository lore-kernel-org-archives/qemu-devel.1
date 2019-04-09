Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 743FAC10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 17:27:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DB8C2084F
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 17:27:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GJ5TkS0Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DB8C2084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46840 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDuWT-0000Ef-BS
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 13:27:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hDuVi-0008L1-Gs
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 13:26:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hDuVh-0003JW-H8
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 13:26:14 -0400
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236]:45672)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hDuVf-0003DJ-H5
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 13:26:11 -0400
Received: by mail-oi1-x236.google.com with SMTP id y84so14216645oia.12
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 10:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=CvxdmJmmoFdSNlwy9UIPSzdfeAHwJB9F/qzVAhX601I=;
	b=GJ5TkS0ZFFIdxghP9UigF3k5+afGUQ7i7nArj4boKBeLuiIrgSn0Q7mh/aJ60UAyea
	qJNtQvIbcd89N39psBmW7eIWWQDy4QT7MYHWZNB5VMbWx9VXIDH3KiL/0zpSwsWUY9+y
	xX8+zcWRrhuKv/MEaKmoZIx9Xf03IabqpJeLZaeJaxOhtxttgPgR5uyWz2YIDaNCJbMs
	aBPwTpsiEoBRaAhYIodWAYtIwZlleTPOgVcB+tZc25telwX9ZgoGPTvHsU1tSN8pt45s
	wDas0nrmfOKPC5r9p2BjsPKF9vCKmfrm7hWnfjjTyjdHM88z0KsL+bJ13mD32Ym+XRI4
	4BvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=CvxdmJmmoFdSNlwy9UIPSzdfeAHwJB9F/qzVAhX601I=;
	b=hl+bV09pSaffR1p3Ld81N6L2ryLAmPBLgzR5V/nSberbwlBnfeDUBRJLvN9ytKg0Nv
	YPooJf7wqT4Ouy4K8zqgv5+nfRQA4S2yk5aaYFJuiQD+sDdpdszPpXp82DMFVMNf5Qc3
	q/LKxkd1Ft5TLrDJlt0N5bjTMwF1A01HkhGk39ApefgDj6uSfZoFE9NRbal5DpX/x8YG
	2DMPI114XjYhNG6NMuvcI1RYFeTPI/XcBLNdnFbfuVqnAKtm6jJiTSg/SLaCrMHNV94K
	f1XCP7qiLczfFWu3v+cGvwrBDZuB1ctS4KpgHyJmu1brpm2RzcVhxYZ8Ns36OMxPw/AG
	TDiQ==
X-Gm-Message-State: APjAAAW+LAj1APrElzbOHs8AbhE9vy9nc15gY2EsQD852ZKsB0pOEWko
	CvnCq7xlM0QkxmCeytga9GRHjGu3+V7xf9RBJmRUKw==
X-Google-Smtp-Source: APXvYqyupT09REifOsFLNTciguHQZmsMzNafChLRAOGHg9FBnkuAS9AJBMMyRDyKA+oUdNDvuFFKV4ccOqAxfHnX5yw=
X-Received: by 2002:aca:b3c2:: with SMTP id c185mr21314389oif.98.1554830759793;
	Tue, 09 Apr 2019 10:25:59 -0700 (PDT)
MIME-Version: 1.0
References: <1554827719-10184-1-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1554827719-10184-1-git-send-email-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Apr 2019 18:25:48 +0100
Message-ID:
 <CAFEAcA8fs_H-gwk251mCq1V2tOBF=Mr96e4FY0aePyCre-D9NA@mail.gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::236
Subject: Re: [Qemu-devel] [PULL v3 0/5] Misc patches for QEMU 5.0-rc3
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190409172548.ys6KFb1DZq9niVSl-DvzGzpJ1OMefJ2cL31VwdY9SYM@z>

On Tue, 9 Apr 2019 at 17:36, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit 248987f92cfda8305d6d44ced23e173e62a8bc0e:
>
>   Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-4.0-pull-request' into staging (2019-04-09 10:02:30 +0100)
>
> are available in the git repository at:
>
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 3e20c81ed87cb15cd04f929b075e244e0758641a:
>
>   tests: Make check-block a phony target (2019-04-09 18:34:21 +0200)
>
> ----------------------------------------------------------------
> * fixes for Alpine and SuSE
> * fix crash when hot-plugging nvdimm on older machine types
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM

