Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7029C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 17:57:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3BFA206E3
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 17:57:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b+Oi+QzQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3BFA206E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyfTV-00083Y-04
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 13:57:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45728)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jyfSb-00078u-J3
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 13:56:49 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:37785)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jyfSV-0005RL-8S
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 13:56:49 -0400
Received: by mail-ot1-x341.google.com with SMTP id w17so5024023otl.4
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2020 10:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=QzOQA4F3NZ+mW/tpH+3PMMYoIK656Ju45Uur3q7DbhE=;
 b=b+Oi+QzQdOUoC60bEFAP0zW/af9ztRpgXLIxzeRIgvXVRbX430FjxrX944R98uCC+R
 NDaRSpscdF4OlYkANDABNmGv9zBAJmPWs9mrox27ex0fxkU21spF2ldjR8fGJIv+TViF
 ihceWzEeeHuBooGE/y98V1xBlIQibfC+M2oEUefgOJHu3k01snvJFNlzufthAoWmn2nj
 O447qhrQAjfmKUgpLcNEoPgCUJuVUzWwMuCKew+yhzVw8Dq+sdW109NO1wVtWlfLwhkg
 5SuYSLpiJa7wg2WiAUtZOOaS1FhIovxmuTFhysf+IEJNRnLX+pZPcvtGXLanRtDY/1Yy
 XO6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=QzOQA4F3NZ+mW/tpH+3PMMYoIK656Ju45Uur3q7DbhE=;
 b=bsq2BRUuAALYw4hE2I15bkhPqkzlfUutIAbUqJQfNCazkMkmqOoET2/NIDPzng+xG0
 YJU5G7Ma3yexv5Kyl6TxYgc2N8L2vtCfuIrwgHDxXcI6OCVdNZiEscuIkGmYk+r8dqLm
 1wuaOabHCcu/HXytLdnij19srDJPqzIBMYuGbdhACyX7lFHjaBVPb5oUeuEBhOH5cvpG
 iJ7km+OaqS61bmOdZQ4oI+l7gNAm4HuqkZw+8F35WyRa2fz1QsQptQAnuEgujChUC7fG
 Sw2tk22oH3PtJLn5jm4Ykyz8eQz4M1209wZO/7nuRQUXNWsEK8Q0XgeG0tR38HZSFk2R
 j+5w==
X-Gm-Message-State: AOAM530T+Bs813na/0E4vnuwX5XgVv3CUKleyDzeBvdyonSw/achZjaB
 tvtqd0eIasWxuf6miUGiUmM0gjD0FF38/63ob0K44g==
X-Google-Smtp-Source: ABdhPJwhYIBghpT7qvuuyfndg5M2xFAO0B5nra08LJooCV9nhliW5SH4FutOD7RXB8m+87esghctj6JZoZD2xracY1E=
X-Received: by 2002:a9d:7303:: with SMTP id e3mr5004582otk.221.1595527001719; 
 Thu, 23 Jul 2020 10:56:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200710095037.10885-1-mreitz@redhat.com>
In-Reply-To: <20200710095037.10885-1-mreitz@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Jul 2020 18:56:31 +0100
Message-ID: <CAFEAcA_FmCSz=PnRm+CvZeZrdyM9spOZ6WwhcqFiS0Jak1+cXw@mail.gmail.com>
Subject: Re: [PATCH] block/amend: Check whether the node exists
To: Max Reitz <mreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x341.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>, Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 10 Jul 2020 at 10:51, Max Reitz <mreitz@redhat.com> wrote:
>
> We should check whether the user-specified node-name actually refers to
> a node.  The simplest way to do that is to use bdrv_lookup_bs() instead
> of bdrv_find_node() (the former wraps the latter, and produces an error
> message if necessary).
>
> Reported-by: Coverity (CID 1430268)
> Fixes: ced914d0ab9fb2c900f873f6349a0b8eecd1fdbe
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Hi; has this patch got lost? (I'm just running through the Coverity
issues marked as fix-submitted to check the patches made it into
master, and it looks like this one hasn't yet.)

thanks
-- PMM

