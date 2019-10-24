Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D8A0CA9EBC
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 10:10:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37A6420663
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 10:10:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SGZ8T9FY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37A6420663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNa4V-0000HD-0C
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 06:10:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48620)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iNZeG-00008B-75
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:43:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iNZeE-00013H-4B
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:43:15 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333]:45937)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iNZeD-00012g-Uv
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:43:14 -0400
Received: by mail-ot1-x333.google.com with SMTP id 41so20067370oti.12
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 02:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Ea2Jf9KTwh+L8dqE+o0O9TNFmfM1rEEboDdekqR/yfk=;
 b=SGZ8T9FYNH1ThC5jm6smk2MvHfvPyYMv9MYdZKt2y8uN5Z9b6iRjQ6Mf+1eu5UNxVA
 hSklSPRAJxWpmMtAjEcVbJI52exZMJFcIB8fW1tqWhtcAtZpMqtX+nTvCQ5SkJiCbS4M
 9EkzFD6OAP/UfvfB0OGTkZYHkGX4BiOaUt8rGLJoFp4H3Mdj4bljY9KA2xEr+q3TYV60
 HfFi0VPIZcLmFGPZGpb7xERxYlTgN4YNtQakNfNn3uYKGS3TQLppiADLCWE8CZAeCSRB
 jvB42lsJ5EdZ8iQ1AdKnRnGNUvXSzxHqnI9YeEBQdHa5wUBxTa4MQMEjGDyvVHkWwtgD
 Bp4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Ea2Jf9KTwh+L8dqE+o0O9TNFmfM1rEEboDdekqR/yfk=;
 b=Ldry5WOjXbjK/PBlHfNF5kDGfwgW2tEklrjg1OLi/TcLYzG6zhHg2L/o4JukvCVXCd
 nKl5XSbU+HJ2YYsqT7pJpQqTkmMoht3bolnoPKUTDTdmc0j3irlzpzYTwIFwQ8XvwHsv
 uj95LadHWG5QxQum0pQYcqNW8Z7+aAy5FfF8zZd3cMyu7hT7ahXYtY2uZr+Uk0Z2fe2S
 6Bq0OmFPk+TwRGwaXAMsEt2HnUwbbdrWkG1/U/OJ08gzVLJgiq0Gxmo+B1sJHf9g24Wu
 I6mHSoPW9iNXcF7m/QlI3SDpDMTEHFjX9Cx0qFcJQ/rbDAAVuNEYBc325yde2PAySEJR
 vkDw==
X-Gm-Message-State: APjAAAUVphot9t0NYI/vrePFAvnwRsrww1KgEQOmlZQCaOOhsc4hpiKy
 Xv7VvpED9yL+N+GmGgcrcvoLx2woiwzthW/vTiFY0Q==
X-Google-Smtp-Source: APXvYqyIs3f2tj+fYzlihYpjzFQ+oas9S6dLwOU/3CuwrA7ddWGbD4CV6kfKKt/8cMJ1zQhpR77MZSdBGfgliH96RsA=
X-Received: by 2002:a05:6830:ca:: with SMTP id
 x10mr10398475oto.221.1571910191595; 
 Thu, 24 Oct 2019 02:43:11 -0700 (PDT)
MIME-Version: 1.0
References: <20191023230110.7170-1-jcmvbkbc@gmail.com>
In-Reply-To: <20191023230110.7170-1-jcmvbkbc@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 24 Oct 2019 10:43:00 +0100
Message-ID: <CAFEAcA-5DZ0CRD9-SU=4JWnVXDRH_dC=F8zu9N7kEJOAd1BSMA@mail.gmail.com>
Subject: Re: [PULL 0/2] target/xtensa queue
To: Max Filippov <jcmvbkbc@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::333
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

On Thu, 24 Oct 2019 at 00:01, Max Filippov <jcmvbkbc@gmail.com> wrote:
>
> Hi Peter,
>
> please pull the following two target/xtensa patches for v4.2.
>
> The following changes since commit a30cb4b1f22c58aa3b933ee9e1d7611399b57b5b:
>
>   Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-4.2-pull-request' into staging (2019-09-12 16:17:26 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/OSLL/qemu-xtensa.git tags/20191023-xtensa
>
> for you to fetch changes up to d9e8553bc8821d72cb72ca95f76b2d8ff6eb628a:
>
>   hw/xtensa: add virt machine (2019-10-18 20:38:10 -0700)
>
> ----------------------------------------------------------------
> target/xtensa improvements for v4.2:
>
> - regenerate and reimport test_mmuhifi_c3 core;
> - add virt machine.
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

