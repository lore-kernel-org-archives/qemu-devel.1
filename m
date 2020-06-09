Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC85C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 01:44:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21B9020774
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 01:44:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="S6kBn+QO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21B9020774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiTJk-0000lE-PY
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 21:44:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40210)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1jiTEx-0005yb-O0; Mon, 08 Jun 2020 21:39:47 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:37643)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1jiTEx-0000Vn-2J; Mon, 08 Jun 2020 21:39:47 -0400
Received: by mail-ed1-x541.google.com with SMTP id k8so15002342edq.4;
 Mon, 08 Jun 2020 18:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nR8duXu/7i/owTQ/5PmEvOI0K8pxjyS17auW0MJccq8=;
 b=S6kBn+QOr3q38jWbuT9kbZVIAnqpYgcZNu3yYeCim6bpSZhC7WuWxqGUzbDMsNBq/e
 TSNtSLWWkKr5ZjB+MsPsgzP1Ls9HLHr/Xy5HCDAIjZJcOb9aMK8WoBQ9ZTp5Xnt/rIVe
 MY5e+pzjvKvKCBNSbH4ET6Xh7BldjLWgsoqGw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nR8duXu/7i/owTQ/5PmEvOI0K8pxjyS17auW0MJccq8=;
 b=swQSiAeA3k7Q+YumbDRYCMPQ2yH/9+4QT8h1/qyOilJsSlyrxSScmpGYmo056UUUTI
 PMqG1XPym7ro/B77aKy1vBgXcEG3AaBtQs0TNF74kTgsOWvccrG8TZjOMiPljrpSUM9z
 obj0ciHkTmFZ4CUbnbJNQkWVgGUJ+JYWoNn0puQ4jOztLFkXlqkp+Rc49n3V0ClR8SWB
 qqNgUd78OqjZnJwGUFPflEciLEIpci3rLTNzmci/AFyh9+Zxe/1bBnO20mSA+wBJ2OC4
 WkB4uvt3OpyZk3CS4EJFAiv70KWx+mlvQsKvPXSVixdrFW9Z5xxi4+FcM2nMSco7Gb6T
 DdDw==
X-Gm-Message-State: AOAM532ARnBoKMg5eEpldOIaO8yEMxd/Zqqz7a2ic5U1C1bMmV6rUDBb
 kG6K6spiKN23dZQd+dpLxaO6Y+dYHjn9hw1LbCp/HuaS
X-Google-Smtp-Source: ABdhPJz2Ssmc1DgPOeJ20fagPYih3ljE0WhS/aV6l9plwevqV0fs1WxemrsfBHrmWA5n7a9oZoCRHRog+rqKTj7ckUs=
X-Received: by 2002:a50:f094:: with SMTP id v20mr24308785edl.77.1591666785312; 
 Mon, 08 Jun 2020 18:39:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200521192133.127559-1-hskinnemoen@google.com>
 <CAFQmdRYYhoWu7q350n0vNOE+pesp-UG975v1f1Yjwf9Ao0mjcg@mail.gmail.com>
In-Reply-To: <CAFQmdRYYhoWu7q350n0vNOE+pesp-UG975v1f1Yjwf9Ao0mjcg@mail.gmail.com>
From: Joel Stanley <joel@jms.id.au>
Date: Tue, 9 Jun 2020 01:39:33 +0000
Message-ID: <CACPK8XfOtLSVR2u12qEYxB=ggKLD-NeK8BYMW3_uRo8ExnM6Ww@mail.gmail.com>
Subject: Re: [PATCH 0/6] Add Nuvoton NPCM730/NPCM750 SoCs and two BMC machines
To: Havard Skinnemoen <hskinnemoen@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::541;
 envelope-from=joel.stan@gmail.com; helo=mail-ed1-x541.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, CS20 KFTing <kfting@nuvoton.com>,
 qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 IS20 Avi Fishman <Avi.Fishman@nuvoton.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 8 Jun 2020 at 22:15, Havard Skinnemoen <hskinnemoen@google.com> wrote:
>
> On Thu, May 21, 2020 at 12:21 PM Havard Skinnemoen <hskinnemoen@google.com> wrote:
>>
>> This patch series models enough of the Nuvoton NPCM730 and NPCM750 SoCs to boot
>> a minimal Linux kernel. This includes device models for:
>
>
> Does anyone have comments on this series? I'm currently finishing up a second patch series that adds flash support and a few other things so qemu can boot a full OpenBMC flash image built for npcm7xx.

I had a look and they appear good to me. Note that I'm less in to the
gory details of Qemu than some of our other reviewers, so you should
seek  a more detailed review from someone else.

I look forward further support so I can test the OpenBMC kernel
against Nuvoton boards in the same way as the Aspeed ones.

Cheers,

Joel

>
> If you prefer, I can combine them both into one series and send it to the list.
>
> This series can be found here: https://patchwork.kernel.org/project/qemu-devel/list/?series=291809
>
> Thanks,
>
> Havard

