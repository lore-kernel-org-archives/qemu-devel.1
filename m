Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A43D2C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 17:48:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FB9E206CB
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 17:48:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PicZPOVC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FB9E206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiMOW-0003Vd-JR
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 12:48:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60792)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iiMNm-0002bO-6I
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 12:48:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iiMNk-0002vh-TT
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 12:48:09 -0500
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331]:44101)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iiMNk-0002tH-M2
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 12:48:08 -0500
Received: by mail-ot1-x331.google.com with SMTP id h9so10168886otj.11
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 09:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Jih2xcyOYpweuWWY7i7vPYQUHBi2e8hvIJvl7Wid188=;
 b=PicZPOVCVC0Bc5AMp92oiUZbrzHOM9Lgt6f1KpPeeeur6R5FTuM3qDTUsqrzKWjvp7
 xN5mJOBie5GF50p36m34DXR+7cV8uha0MY8pJ6xPEw8JiYUPwlrYM4BDSsvOnE+az9pA
 ImmABO+fRbkgBW/LGKse002XuiNXvhuhEzED9F3EUX8DEDjc3v95cwXfJ3nrA+YGqN5s
 6wFHzmGVHKqYiK5TNRBlh3/UUVrOJ0SR3m7SBQiiHZepqedmksM5ud5xkwCxGQRvXf3C
 3Esa/jzs+qNdJCupLhaZF+ogv4/F9DJSjk4pN2WmDMgNFdggdyWjYz7Z9cCAugz3Ar/z
 v42A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Jih2xcyOYpweuWWY7i7vPYQUHBi2e8hvIJvl7Wid188=;
 b=kE2mWIhtBgWKpgEE/LpWIj/kdnJgd9y0hUMpf6WlIxpLijdHXZkEaN+xOdexX9uDwI
 qHm7PCUOi0w1F86rrGLzRA/VaUWSYktAucZIQtzPhQ1GZaXEh5vhEgnUS8sikTIpceMH
 W+iIvvNl+8hN8+DSUXRxxx0GbWRW0YOL9szsG8Qeufd34De8iXyvx28v3uUArqaFG6EG
 aFX2Czuvr/MpxmRajDgw0mS3CDteJJN/7ItTrYAaFxljX8E6VZbuECoWkDe00qt9516V
 riqQIUiN58LEZFHtpJ/qVmiyaIDj2+GloLH2Okt23Iyd5CaSr2Jrl9p3JXcsEOJGPW93
 8Gyw==
X-Gm-Message-State: APjAAAVJtDohD1GOa084CVS7lBwSKfXdxcZoDorqXF4mxe/WpFXfJs7E
 DQz7rBvGcjAAP67gJtzEVzJqHXRhJn92MCIw8QAJMg==
X-Google-Smtp-Source: APXvYqxpJvDGbYzqK66mmUfFZ+W4NkI4GYPQRpt9x0sOPequ01M7mKnCsQ7c9+4/Q0SBiPOm17ul32qvw1l+wRGIfmM=
X-Received: by 2002:a9d:3f21:: with SMTP id m30mr2392620otc.232.1576864087377; 
 Fri, 20 Dec 2019 09:48:07 -0800 (PST)
MIME-Version: 1.0
References: <20191219110112.8343-1-cohuck@redhat.com>
In-Reply-To: <20191219110112.8343-1-cohuck@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Dec 2019 17:47:56 +0000
Message-ID: <CAFEAcA8YTvKtUNtmMyPzux9k4C_eACQgdcHjk0+erQUARWrogA@mail.gmail.com>
Subject: Re: [PULL 0/6] more s390x patches
To: Cornelia Huck <cohuck@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::331
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
Cc: qemu-s390x <qemu-s390x@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 19 Dec 2019 at 11:01, Cornelia Huck <cohuck@redhat.com> wrote:
>
> The following changes since commit aceeaa69d28e6f08a24395d0aa6915b687d0a681:
>
>   Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-2019-12-17' into staging (2019-12-17 15:55:20 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/cohuck/qemu tags/s390x-20191219
>
> for you to fetch changes up to 104130cb7c106378dab944397c6a455c4a6d552f:
>
>   s390x: Properly fetch and test the short psw on diag308 subc 0/1 (2019-12-18 15:54:24 +0100)
>
> ----------------------------------------------------------------
> More s390x patches:
> - tcg: implement LOAD/STORE TO REAL ADDRESS inline
> - fixes in tests, the bios, and diag308 handling
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

