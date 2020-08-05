Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8106C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 15:21:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9534522BED
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 15:21:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NMDOHAR5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9534522BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3LEr-0006SD-Q0
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 11:21:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33442)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k3LED-0005eW-Bm
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 11:21:17 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:37463)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k3LEB-0000qj-Ac
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 11:21:17 -0400
Received: by mail-ot1-x343.google.com with SMTP id e11so9417135otk.4
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2020 08:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nQKTQ2ldAmHgZgOMUMVEFx96SpQ5qa7tphPMc7pv7zU=;
 b=NMDOHAR5bLxiwla3TjfnBmCVMnymEvRReycPKgHrhwTijpgKfsR+77RsmPfdS6XNfs
 jvX3aPYWGyjAHRhzJTxohnTZXzI7Lrd6Q2qMcSXREzF1A6rly3Ld5prD13cXykzHJvJX
 e9KzW7Rf0VZZRWCGDB7p+UyjMGOa33MwcJq5X82sKlA34sMU45WUsvrzDWQBOkBSwxM6
 cPO/lw3J5bIQ6upkksiZCaMklvvgML7fIR/ms22jbm4wQj1F5Cc2XjTH8Vqaz0cf2YaJ
 QOeJi5vmskwtIq6FGVMn+/GnB5VLeMTDqtNE9wYgfCsaRPFG0EOHIIbMmr0t1LkviO1Y
 zSwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nQKTQ2ldAmHgZgOMUMVEFx96SpQ5qa7tphPMc7pv7zU=;
 b=bNE4YBUjrwv23RlExMn4yYNqEfko1k4EUjGePgfkFaMipcmR6CKoN0P8Xt+KnVAP49
 BQqJqTbntASeOB2gUJkA1kOArXCOMIZHu8YmQbZjwxdLA1CtX8FoWOA5BmTEn60hzGeJ
 yHdmGmVPLZ2U2CetvTYq9dA5M9u9QajZRTn8Ld3me+jTd7J2rvBxEm1mOmkXws2IlbkA
 9XyECtMQgaNc8QejPcwZOaNN3JesYjlNDxgbyW42+AJ9Sbo2lxmUu+XEF0+8KQZ/Fa1W
 1eP+G+P+dRGqCYZc4GPfNGyKOpoD+MwxET7SxVyE5y7/LAyn0+Hlo7nN9CkV0HaAm59A
 rtDw==
X-Gm-Message-State: AOAM531YrSJJkwCKAKTQONgvzsziVcc4zGZFCD0auu+8gwHwJgI13dwd
 rTqY5MvLYlGckVIgEGvwUcS+LiklhzO+PcrAcnfqmw==
X-Google-Smtp-Source: ABdhPJyJq53MsdWIrlA8SSxqdejIr72Q1x8edMxb+S2dnhx9qzP6f9BdAnS+SYoxsDBqk8MqGP8d2w7LmvatDHsgPto=
X-Received: by 2002:a9d:39c2:: with SMTP id y60mr3099162otb.91.1596640874106; 
 Wed, 05 Aug 2020 08:21:14 -0700 (PDT)
MIME-Version: 1.0
References: <81ba90fe0c014f269621c283269b42ad@h3c.com>
In-Reply-To: <81ba90fe0c014f269621c283269b42ad@h3c.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 5 Aug 2020 16:21:02 +0100
Message-ID: <CAFEAcA_kTE3eS6wR+ccywTVajSTkgTksZ=YtbNK0znq5btwOHg@mail.gmail.com>
Subject: Re: [PATCH] qcow2-cluster: Fix integer left shift error in
 qcow2_alloc_cluster_link_l2()
To: Tuguoyi <tu.guoyi@h3c.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, Chengchiwen <chengchiwen@h3c.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>, Gaoliang <liang_gao@h3c.com>,
 Wangyong <wang.yongD@h3c.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 5 Aug 2020 at 10:24, Tuguoyi <tu.guoyi@h3c.com> wrote:
>
> When calculating the offset, the result of left shift operation will be promoted
> to type int64 automatically because the left operand of + operator is uint64_t.
> but the result after integer promotion may be produce an error value for us and
> trigger the following asserting error.
>
> For example, consider i=0x2000, cluster_bits=18, the result of left shift
> operation will be 0x80000000. Cause argument i is of signed integer type,
> the result is automatically promoted to 0xffffffff80000000 which is not
> we expected
>
> The way to trigger the assertion error:
>   qemu-img create -f qcow2 -o preallocation=full,cluster_size=256k tmpdisk 10G
>
> This patch fix it by casting @i to uint64_t before doing left shift operation
>
> Signed-off-by: Guoyi Tu <tu.guoyi@h3c.com>
> ---

Applied to master, thanks.

-- PMM

