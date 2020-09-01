Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15FF2C433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 12:55:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF3F8206CD
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 12:55:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yh2gQUbN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF3F8206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD5pI-00077m-M5
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 08:55:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34790)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kD5jg-0005Df-OM
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 08:50:04 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:35312)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kD5jf-0001p5-3y
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 08:50:04 -0400
Received: by mail-ed1-x542.google.com with SMTP id ba12so1316348edb.2
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 05:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=peHf4GtgUeg0RgYEQ72lb96CS7Od5ddK7dRVhswRxn4=;
 b=Yh2gQUbN5X/J7lPXJKGpdOkTrDFLez2UMio8RBaJJbIV9qPc0eqDUOzoTPhmm++jhI
 360z0aHmiW6mGxWoBvCIJkFm0t3kx2/aNmdh/arhjwHpTXL0pTeyhyEpSi1dBCjM1tAf
 7QqLnPPWIHB9OU8IoH6bmen+8/HbxKAfbRwAPDcFMuVKgXxSTq4ifxak77Egk8xARz0l
 Bzqmej17JlGZ06dRi4+2mT4DDfd3C6AG2efj5ly4EMPLx0R4djeYkiw4PQANWrprj7eo
 /gXh60HMfqrIasYcoJwvOSSz/1852sAYD0iEkZbfU27Bdkw9UGIduYFbEc7YytEFbd35
 /Aeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=peHf4GtgUeg0RgYEQ72lb96CS7Od5ddK7dRVhswRxn4=;
 b=By0UTTSZ1eVcYlxXzgcLgk4Bq1Wu6dro+5FN1amo0FNcbqBLok70+1brljbNnBytXA
 bGT0AafpnYA3Zyw84/dX9VyL1KUPGc73Vp3kvXmcISuylMOQPrxDfMQfNQI1zrSTjlwj
 sjE+PSgkfwJu9sTGX7anuUrOmS5HZjA/iEe2GY4UnQcXq0AClg3ePR2Eu7rOXtq8XavF
 FCwUyG+iyWEwJn51kKKFLLX4bPOdX1eHaYdHhULkKP5p3znmjFzMGUk7xlDTcvEn6rUu
 qwQbpxoo1BM+KKY9QFw+QDLwmn6MNnLb6Xo2HE8dIJ56hO0OXW0gdKf6uy4Q680E4KiK
 vWAA==
X-Gm-Message-State: AOAM530MjErpXsC8WD4gsD7SCsqu5DCXllPATb75cg3sqKb/dxGG4huN
 gJrHVxDy65iE0Wjd3SB5hVNzlfIUxIHKLQdOfD/TVQ==
X-Google-Smtp-Source: ABdhPJwOFVBFS9Nit2xTq0hTbEOwa/C5VC00FhQnt1LK7zddYifZqDzMhBeLMr2wABCCqyqY7Mp3VdEUw54Nala5tDM=
X-Received: by 2002:aa7:d596:: with SMTP id r22mr1628331edq.204.1598964601252; 
 Tue, 01 Sep 2020 05:50:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200827142915.108730-1-stefanha@redhat.com>
 <20200827142915.108730-3-stefanha@redhat.com>
In-Reply-To: <20200827142915.108730-3-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 1 Sep 2020 13:49:48 +0100
Message-ID: <CAFEAcA9rSvcK8GoBtg_LHroOgcns4TvRk3r1MfSgfPwWEosYsw@mail.gmail.com>
Subject: Re: [PATCH 2/4] tracetool: add out_lineno and out_next_lineno to out()
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::542;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x542.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 27 Aug 2020 at 15:29, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> Make the output file line number and next line number available to
> out().
>
> A later patch will use this to improve error messages.
>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

