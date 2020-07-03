Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 073E9C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 12:38:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C61EE20782
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 12:38:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DA9kkRqc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C61EE20782
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrKxg-0001CN-1e
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 08:38:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34636)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrKx6-0000nI-Ss
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 08:38:00 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:33475)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrKx5-0007XR-4H
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 08:38:00 -0400
Received: by mail-ot1-x342.google.com with SMTP id h13so6015099otr.0
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 05:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/7pAYmGTlUQ6hQzzBgqEzRBN8gZV4BbjUNtF3tE+zAI=;
 b=DA9kkRqc5nufL3wSjxiqsz27rgDRQHDNVahefkkiX84821IjC5dYse1Xsrs+xCgbCc
 qJ223poJe+BlQrrafqy01J3tfM8H9SwfywJpbod2W6lw2AEsPOzOFy4oeZ1iiCJWGSQ0
 Ph7DDnRnvZxAbh+Tc9wbVWPriQVzBdc1fXhWbXyRhLmcCRMCFvMHRDxY6BcQZfDTnm1y
 /61Dcv9UAjMO35EQjHY4qno725w2SsvG+eBbAiWT4NMkonCjBpvm+ARs7vBGX2hXAqsk
 0FaaepiPb35vyHlkzcnZKHBdax0OswW5HssiCNa/iRcbaCcBRAR+48JnXjmviJwuz0jE
 RzBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/7pAYmGTlUQ6hQzzBgqEzRBN8gZV4BbjUNtF3tE+zAI=;
 b=LZZdBO+awD02ZfN7Ab9EvIlicecT6sPAakBmlIDp3JJRfqiIZwgVK7/Vv69vOWqtde
 5TX3ZGgVyEtLRLXij7FhxKkd0ouMpMD2FLPXEtBv/eQtMKMIYLszDslroA1jCkw2z1YS
 frhz5+QKCxBpRMUSgrkHlqimvxXWRsAJC2c6j6Op00PSEOZqcbbV/0WHYYBw9x4ZfGzg
 dx3R0YfmuULPbZUSRkxi/CeIXupCUCqjIKqHezIa0a1KvFDb+1snpI7PSvbImiX/SkWT
 GVYMJqvTx443kzjKf4N6qwr/ABzieCBZyxKQttpXqCoQpK8wwX4pfUId3IBUAFqDL1o9
 eLEQ==
X-Gm-Message-State: AOAM530Ju/RRWRjp2OgEtu8wL9ZpQaBKuYTEKXMZzzkrIzmpirNQk12/
 zKvW01wtlELA7TcAQaPfLvSQJ/jyH901A8DIwqeNqA==
X-Google-Smtp-Source: ABdhPJwFFSkuMU8x82Xyzht0x3YlCeIFoRAAI/LRmSD/AFjEpOKEplVr5wyrvBbU9P8GPGqhKupez//NnRZF+7JAbMk=
X-Received: by 2002:a05:6830:10ce:: with SMTP id
 z14mr23007380oto.135.1593779877609; 
 Fri, 03 Jul 2020 05:37:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200702142250.21793-1-kraxel@redhat.com>
In-Reply-To: <20200702142250.21793-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Jul 2020 13:37:46 +0100
Message-ID: <CAFEAcA9bYvT_vyWQVPKhBgHRiz=Ktevv+oKdqDA-7rBRWvQeOA@mail.gmail.com>
Subject: Re: [PULL 0/3] Seabios 20200702 patches
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, 2 Jul 2020 at 15:24, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit fc1bff958998910ec8d25db86cd2f53ff125f7ab:
>
>   hw/misc/pca9552: Add missing TypeInfo::class_size field (2020-06-29 21:16:10 +0100)
>
> are available in the Git repository at:
>
>   git://git.kraxel.org/qemu tags/seabios-20200702-pull-request
>
> for you to fetch changes up to 563b9d0d8d944d358921a774f82a0e60527e7823:
>
>   seabios: update binaries (2020-07-02 16:21:10 +0200)
>
> ----------------------------------------------------------------
> seabios: update submodule to pre-1.14 master snapshot
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

