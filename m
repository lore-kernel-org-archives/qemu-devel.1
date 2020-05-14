Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88098C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 09:59:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BD3C206B6
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 09:59:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CeYnTi1Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BD3C206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZAdt-0008KR-FL
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 05:59:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33764)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZAdJ-0007vB-Vh
 for qemu-devel@nongnu.org; Thu, 14 May 2020 05:58:29 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b]:36946)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZAdJ-0003W7-1n
 for qemu-devel@nongnu.org; Thu, 14 May 2020 05:58:29 -0400
Received: by mail-ot1-x32b.google.com with SMTP id z17so1881952oto.4
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 02:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6tD1xP5dW6LCr6Bd1uUPS3KXyi0U3o2XPPJxZ5GUEz8=;
 b=CeYnTi1Y96WxgTEeqLgaLr4VK+gbWolv5RHsazOHKa0gAVLJMYsALMCJrrQ/goCrB9
 U6YILXilwA9ofUO0SCr4dVqSyLf2l7UOnnjdhBFStubGvWgFRwzcaZt9DMXx22pmH8a8
 T+/g3CX7gVzHrcINjCvbad3vllJT5gBty9KSiFGJTU8aCGiQD7vbFhT7n5YklDq9c+dC
 vmbfP1HBJNwnW1xzgHOD6NXjNryUST05dozEYYkt/YI6xRcFfNCQuCxLaeTE8miBhZXM
 TCtEFQoRoSB9suVG+B2VjOSRz7rLrOzYwJ9bzt5rY/YqZks80Q6EkEtreqRgcrkINkOR
 hfXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6tD1xP5dW6LCr6Bd1uUPS3KXyi0U3o2XPPJxZ5GUEz8=;
 b=OZLDdVuDVPyq0jWIZN/R+yoI6I6zNFgE3gEC8LrXDuuA+OvhLIwp8dsu5dB4MrdW7c
 h3pvTY7Tn97lZMC9y54J9UAqAjM0fg9lW4enLo6U2ZfR3WZGlCY9RokY53pPSk2oKLnk
 19+D/TUFmmULS5fG46CIlazo/pwyvUTDKP+ZojCnFfWElGo3kzvRvhv579Yv46z+pOIh
 mR05p3dyWXe6vLnZjr96wBGXl5gpWLAoImussIpa8KFyWGWIj7oyaWc3XKjV0cS+cFLi
 wxmjD3Q6S/K/F/JC4xFsco4/qOp4IuH4ppAr8HVw0+dH6enlQtw0jqy15x17L52xgdgA
 Uvyw==
X-Gm-Message-State: AOAM530chn/jl0+E9swB8zSxaU9VoaVGtEzLQ5oqj8nCMTNRClkaCJUg
 lYt7T0F/2ZOmH3bKjOc96lZl/cHpR+/FhP4DNUix5g==
X-Google-Smtp-Source: ABdhPJwieY0TOj3FtV8nEmEHt81//q4kDvHQPzQSM5XAhJLHb/dJeTT1dRc1erHwKRHR2XBiVn86Zn+7RombY5FsWHQ=
X-Received: by 2002:a9d:398b:: with SMTP id y11mr2904319otb.135.1589450307611; 
 Thu, 14 May 2020 02:58:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200513140057.576234-1-ehabkost@redhat.com>
 <20200513142255.GA577771@habkost.net>
In-Reply-To: <20200513142255.GA577771@habkost.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 May 2020 10:58:16 +0100
Message-ID: <CAFEAcA-6SO-OFKnYqJ+mq_OT=W-k1CPe1cigzY7mbkqJAtLgTA@mail.gmail.com>
Subject: Re: [PULL 0/1] machine queue, 2020-05-13
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x32b.google.com
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
Cc: Igor Mammedov <imammedo@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 13 May 2020 at 15:23, Eduardo Habkost <ehabkost@redhat.com> wrote:
>
> Peter, note that my PGP key had expired 2 weeks ago, so you'll
> probably see a few signature check warnings.

I couldn't find your updated key on the keyservers -- which
server did you upload it to?

thanks
-- PMM

