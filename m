Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E28CC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 10:12:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1622207D3
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 10:12:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uN3jSS0I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1622207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbiBE-0001kB-2p
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 06:12:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34072)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jbiAT-0000Eh-Kl
 for qemu-devel@nongnu.org; Thu, 21 May 2020 06:11:13 -0400
Received: from mail-oo1-xc44.google.com ([2607:f8b0:4864:20::c44]:35910)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jbiAS-0000E0-HD
 for qemu-devel@nongnu.org; Thu, 21 May 2020 06:11:13 -0400
Received: by mail-oo1-xc44.google.com with SMTP id z6so1340947ooz.3
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 03:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=pw2spoNl9hq2cynOq7AsA2bEwjM65Mh8ubI6Jh+9VLc=;
 b=uN3jSS0IeCYxo59x3867j+0fMtDOxx/xFd+sxX1D+cjbfHXyjmzMdMw2teOAwZdYqa
 LlfRCc8C/jNq4/jAf/lOpEMe3smysFypiUdxlqjxRA2HAaTEzAk3VHCQZ6Vx8u/TrPBb
 pT3jxdqer7kGQLugdptpR2U/ZgvaVL5M8Hht2v2iA2LThOibIx5+c5HvDbQj0tT1tAcb
 rsTnPVA1IR8H/ECExfv0mOHOZHt5aCQVVTIo38dbdpBK/9WAXVU3as0BUB/xj7dUrKPn
 A+R4O+DRadxDj9PzCn7Mfg5dzncwLqNXT1hilSWMI1y6O7/hEuXpz+fevX1sTcDY70vz
 AVZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pw2spoNl9hq2cynOq7AsA2bEwjM65Mh8ubI6Jh+9VLc=;
 b=RwGLEVKYJMCjsPX1gad1wVhe7tJFhgAv0J2cAiJfuC+CMDA3ApLng5zquI7Def0SMB
 peTAqZbc6I4MBHgUIKqOGeE28pQBLoyb85tnN5Rd7lYePVuVLfSJcXNjhgkRTO2KcKqL
 n8W0PoplGHmPpcu+Eod7qfgCLmw/UMnfFDt6FbDQ4fS2/wkfm3eSm3TTMhCZ7xg7UOtG
 3U89TOsvN9sEGzje87/ZZ/K8WRyL/VWjMBqO892DysgZzesQPKiWot40MKNKyurlYMPC
 dCSmRfB8boCL9SO2zu5BZ71Mva2cAr07pIllVik32CC5ldJ+qKs1kitePOelv3tBTA8T
 +1Ow==
X-Gm-Message-State: AOAM532jHpYlrzNkigPujSaFFDFesXq1XH/IvoYuVbYfTpMgyuMA1SQP
 kozs9INPgmbvX7PIo3S5YwfjiYX++UzIdBrOEeoYFg==
X-Google-Smtp-Source: ABdhPJwCxJ6Iv/lH6iTN8nEXIbXqUhQGZH2eCPbREAO4MI4OnyYVC7ewwPgaq6hZOI9PuWo6+z/b4OaV/iZnHk+UXqM=
X-Received: by 2002:a05:6820:5b:: with SMTP id
 v27mr4541688oob.85.1590055865872; 
 Thu, 21 May 2020 03:11:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200519164957.26920-1-richard.henderson@linaro.org>
In-Reply-To: <20200519164957.26920-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 May 2020 11:10:54 +0100
Message-ID: <CAFEAcA_jOS6dSxbF2UaKpmzNd5EC1dbA6i8YBN9r1LDxF=bwWw@mail.gmail.com>
Subject: Re: [PULL 00/10] softfloat misc cleanups
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c44;
 envelope-from=peter.maydell@linaro.org; helo=mail-oo1-xc44.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 19 May 2020 at 17:49, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The following changes since commit f2465433b43fb87766d79f42191607dac4aed5b4:
>
>   Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2020-05-19 13:42:58 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/rth7680/qemu.git tags/pull-fpu-20200519
>
> for you to fetch changes up to 150c7a91ce7862bcaf7422f6038dcf0ba4a7eee3:
>
>   softfloat: Return bool from all classification predicates (2020-05-19 08:43:05 -0700)
>
> ----------------------------------------------------------------
> Misc cleanups
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

