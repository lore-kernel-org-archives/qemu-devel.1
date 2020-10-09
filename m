Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A969C43457
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 18:52:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 804A620732
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 18:52:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iJm5p7iC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 804A620732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQxVA-0004ZO-8x
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 14:52:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38936)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kQxTH-0003QW-Fi
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 14:50:28 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d]:33460)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kQxTF-0005jW-PA
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 14:50:27 -0400
Received: by mail-ed1-x52d.google.com with SMTP id g4so10459502edk.0
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2020 11:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=cssYHpgs5MXJhrhvMFjN8sollDNnwikZosQd8jydzHE=;
 b=iJm5p7iCduqGXvDr3OHt4dcKx1hzNBYaHw3rXUrh7vlJd3JXFn9cQEipFve+WExY8b
 +8GdHV7qY/q94mPnaoqRfiiJHev2paIRCufXsiWwJx4hAMAd7atQg41m6g8ICeU3zGrF
 C1q3c47xNDlFxxjB38N1XlSYXRserUmO57ADAXOBrt9aQYungl+huCSwubt+9LxTqFD3
 PlfvcHiLIkNb6sdGBd72trRdn+ysxdZLFsdGxkWpwstsnyKD3IqRwGveThJ/3ooAGIrA
 M1+UKfgRBSqv4HIhBQ98VZqES0mjrVp1dtKsDaXica7npWpljLStuQnESzFPKMs9Akhy
 IbVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cssYHpgs5MXJhrhvMFjN8sollDNnwikZosQd8jydzHE=;
 b=joWHWFEGXsQxbP7r3/Wm4uvA4J/LTK3aE9gd80Eyr78Nq2Gleq0Hk1NEdIW2zUbY/s
 vTqEomfF9F7HqUxR2rP/ezXuvzWUHoW5dMMchbBpbb+hkU8VQPt0D8XpNfTJDzqw3MhE
 d4Qc9gAS3gcyjz9eTpadUv/CAc9Egzcv1eQmUw1BWZF9SUvwdjjalZSDK9s156uDx+yh
 uIvsSG40pK+2AucAVtkkDINyMllZ38plU4cpZhisKFeYj2FCIN2xpEWHJutIlb+ys0df
 g5gpGow2LtSsZaiBfdb7CKq6UpU/wEkIZ55UCoRb4GBKFUTVU4SZgPhQzPXwO20VVvyZ
 F7ZQ==
X-Gm-Message-State: AOAM530iPjZ0j3ac2I3n3zy16rC1uz9sdpsi/QdpmT6Pr6zRVL1AhxSw
 Jcz5tHsQhoDg4Z098GD2vhTz3bLxA0XjB33Q5yTUtg==
X-Google-Smtp-Source: ABdhPJz1eH96MYfBlawnx5TnIYn7jJ3FZTBRNzi4IoFtc0JHAVdvBRRC3/6mmWyfYsSPznhHYBowPYnj46pOcMbJTjo=
X-Received: by 2002:aa7:c302:: with SMTP id l2mr649138edq.204.1602269424018;
 Fri, 09 Oct 2020 11:50:24 -0700 (PDT)
MIME-Version: 1.0
References: <20201009135429.1122744-1-eblake@redhat.com>
In-Reply-To: <20201009135429.1122744-1-eblake@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 9 Oct 2020 19:50:12 +0100
Message-ID: <CAFEAcA90sfus8hv8Ft79YzA+MuVPwr8t0iPTEWuaDmv+EVxaoQ@mail.gmail.com>
Subject: Re: [PULL v2 0/8] NBD patches through 2020-10-08
To: Eric Blake <eblake@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
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

On Fri, 9 Oct 2020 at 14:57, Eric Blake <eblake@redhat.com> wrote:
>
> The following changes since commit 497d415d76b9f59fcae27f22df1ca2c3fa4df64e:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20201008-1' into staging (2020-10-08 21:41:20 +0100)
>
> are available in the Git repository at:
>
>   https://repo.or.cz/qemu/ericb.git tags/pull-nbd-2020-10-08-v2
>
> for you to fetch changes up to 351a587410eff515ee28da619867030217b62457:
>
>   nbd: Simplify meta-context parsing (2020-10-09 08:34:15 -0500)
>
> v2: fix BSD compilation error

Compile failure on Windows:
../../qemu-nbd.c:157:5: error: "CONFIG_POSIX" is not defined [-Werror=undef]
 #if CONFIG_POSIX
     ^

thanks
-- PMM

