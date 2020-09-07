Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F36C43461
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 15:51:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CAB6206B8
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 15:51:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BYiAdJq3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CAB6206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFJQI-0002SZ-O5
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 11:51:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36906)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kFJPe-0001ft-Nj
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 11:50:34 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c]:42219)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kFJPc-00022A-Ov
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 11:50:34 -0400
Received: by mail-ej1-x62c.google.com with SMTP id q13so18740011ejo.9
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2020 08:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2CRkDsiwrgb8dakzeAClzEgKOhf1s6rImdFElG41Ja0=;
 b=BYiAdJq3lLQlmIWjJI4aulIgh5Q/MehPeg64Mx8axlTDfhFIOT2l1/nSOf3l8WkcWd
 6muukfm1cusihRspBZisJCoBg+fr33jbFfrTzJkC9UOfL/kgavgakoIp/TrIFUdVeC/P
 4pDPKtLxV9NpbZ/L/nUAozDJ13/+ktu84SGyg8/PPJ9BeoU2/F2CaAdDTPZYndOoYx0F
 k9hi+3o6ZuPmgLzQJ7SMyxCMy/JKj1eWZIpYZSHCplTLXKd5Excb8stlwRUD/6dQ8gQ0
 k9qPZicLUcs4lTmAQJFFlubmK+44+Hfn7Wyy26f7op8aXTUWD8AvGabM9HF1PF8dQFTV
 jKGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2CRkDsiwrgb8dakzeAClzEgKOhf1s6rImdFElG41Ja0=;
 b=gwTtUj77p312QaNZmB4TEix7sObRxlhQCfWpjZz1yTW09EkNgCDhASIEmJxoeL0lI7
 NhIvw3IqZaP/wNlRcTna/SEg65k//qSgiezt8BMG+f+Xy06e8z33j37Wviz1H2O04MxX
 sQhSOXJfd74vdJQkNBd37+39pSF4UfH270duMzA//OQiBDbiPY1rlwNTuIxVSIGDZ5Mi
 kb9Ovg9wXMiXBoSI1IRZQlpy+yTrVhbr0ufb6ije7BwumGw0MQBmDYGHQyx1GRqSIb+C
 DcjSTwr43CXTxUSLo/EZhaLU90Zj9EfNxHgxktDfng2gQh1I0J7u9Zz+HotMY0NdtmQS
 U0cg==
X-Gm-Message-State: AOAM533loI+35WJTavH2crIk4LcvbAD53EOfVK+EmFM9pxH7LZ2AvkHN
 l/Bhv07Zfn3Mp3AkvEmkeTPslraVBuewARfqoe3+3w==
X-Google-Smtp-Source: ABdhPJwv6MqvfPGG/tgN6iyjQ9D8SEljGypGtsqileajpmkTyIswZf6vXS5PNjW6hVQ5gpvfPOWFe+/u9c2/nOStvhI=
X-Received: by 2002:a17:906:4a53:: with SMTP id
 a19mr4072664ejv.56.1599493830961; 
 Mon, 07 Sep 2020 08:50:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200907091748.376101-1-laurent@vivier.eu>
In-Reply-To: <20200907091748.376101-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 7 Sep 2020 16:50:20 +0100
Message-ID: <CAFEAcA8G+3K3crRxozmNqDN8ekQEK5e4ymOsaGyhNQbfnCrKbQ@mail.gmail.com>
Subject: Re: [PULL 0/5] Linux user for 5.2 patches
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62c.google.com
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

On Mon, 7 Sep 2020 at 10:19, Laurent Vivier <laurent@vivier.eu> wrote:
>
> The following changes since commit 8ca019b9c9ff916414371dd13d265bbab308b14a:
>
>   Merge remote-tracking branch 'remotes/armbru/tags/pull-qapi-2020-09-03' int=
> o staging (2020-09-04 23:24:03 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/vivier/qemu.git tags/linux-user-for-5.2-pull-request
>
> for you to fetch changes up to 5d5d17522f59696d18fdbc51984c7b4ebf191f7c:
>
>   linux-user: Protect btrfs ioctl target definitions (2020-09-06 12:29:19 +02=
> 00)
>
> ----------------------------------------------------------------
> Add ppoll_time64() and pselect6_time64()
> Some fixes for for elfload, fcntl, termbits and btrfs
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

