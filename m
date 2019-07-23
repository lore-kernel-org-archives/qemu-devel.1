Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C13D0C76186
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 17:28:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90ED02070B
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 17:28:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kk6Hto7M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90ED02070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpyaL-00074b-RC
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 13:28:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52064)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hpyaC-0006fg-Ii
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 13:28:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hpyaB-0001Xd-FD
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 13:28:12 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335]:38337)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hpyaB-0001Ur-7p
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 13:28:11 -0400
Received: by mail-ot1-x335.google.com with SMTP id d17so44893119oth.5
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2019 10:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=dVi6YVlWRIAW7sm4fkplK8kxgeIcoQm1niGV8H41Zn8=;
 b=kk6Hto7Mmj+1UsxxYe2DuOoprvsk1pbWHW/dp9IOfjO0mAilDOc2nUTPGL4bP+Q2D1
 ReSvukCmmN3fn+4F0ExwdW0UOiM2vtd4M5sZsKpNXi0dEz3Z4ydSRPW0pVVZDZrBGNWv
 LSN04vOqhDrBARAEey+PiYA4Nru4Rcwa8d6SuhEBrM1A/gIaqabmdTiiuu9+sUCcHCON
 BT1VSMstQ0amiRTWY7CuJkExWIQ+VYj2t92VsNqwWOFO6wywjF7mxwGmUxLWCELrIccK
 inDRD9oJcfZMuveWEb4ZvxWsOJxEoSsBn99zvISwbMutarQMO+IyqQ2uJNAFbzHaP6hl
 /tAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=dVi6YVlWRIAW7sm4fkplK8kxgeIcoQm1niGV8H41Zn8=;
 b=jtDeM36NBy//JYWGUUOJltYv/V59koSvDMAcpf+3BvUScMl0X4B3qDjqV7giWlqcHf
 RsquMHXrsg+kpKNegtRomqqcNY+pSLYC5u5Amho/6DWT7Egn4aMfLrm7J8mwGgQjQrJ/
 TyzLvXkWmZPc08hITwTZ7SPrW6NPotPm/FYm6ewfsTV42DvQqn+bc2UtcZI22k6gcqFa
 tpNjMSO4zdNryO4yNz4oydX6PntrDLjAkMkl8IbSgdcQV0vzbbd79kAi/sQ/5LAJbz1I
 qjFcjq4SYvAeMdHphFq5fjqW/PRJqrvnRNw94Jj+xj34n5Zj6vtGPV7QHRY5rJc/6Ed1
 mNFQ==
X-Gm-Message-State: APjAAAXDcPEps3uyDsP2USoqeYt6GoUZ0Z3FSqAPtkgam7Pkb8ubpmGU
 vH6frdR+6tnNgZSItGEp3XbaAcghczbzFrhGqBoThA==
X-Google-Smtp-Source: APXvYqy+AFHCP51yrWo6ZDf1H3FDge4IP74MzjoqNKVlG8+gTGLaSuxkmjrbTNaWTyZtrUA1a5IloeswL23hazxE4Ek=
X-Received: by 2002:a9d:711e:: with SMTP id n30mr53876619otj.97.1563902886401; 
 Tue, 23 Jul 2019 10:28:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190723162356.3296-1-alex.bennee@linaro.org>
In-Reply-To: <20190723162356.3296-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 23 Jul 2019 18:27:55 +0100
Message-ID: <CAFEAcA9iJmD9Ch+TwtooXw=PiKY9W9AeiK4LQZwj-8qgWmfFCw@mail.gmail.com>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::335
Subject: Re: [Qemu-devel] [PULL v4 00/23 for 4.1-rc2] testing updates
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

On Tue, 23 Jul 2019 at 17:23, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> The following changes since commit 4da6c0f9ebbdaaf4315c71ccd288d02b9087f8=
af:
>
>   Merge remote-tracking branch 'remotes/amarkovic2/tags/mips-queue-jul-23=
-2019' into staging (2019-07-23 12:49:39 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/stsquad/qemu.git tags/pull-testing-230719-4
>
> for you to fetch changes up to 98808c3d0c162aba93fe7840a34b54c4814332d4:
>
>   tests/docker: Refresh APT cache before installing new packages on Debia=
n (2019-07-23 17:19:11 +0100)
>
> ----------------------------------------------------------------
> Final testing updates:
>
>   - docker sphinx updates
>   - windows build re-enabled in CI
>   - travis_retry for make check
>   - build fixes
>   - docker cache fixes
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

