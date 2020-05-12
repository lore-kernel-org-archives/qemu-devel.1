Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7046CA90AF
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 19:26:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DFD8206A5
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 19:26:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YLqUqCNP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DFD8206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYaYM-0004VJ-K3
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 15:26:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46550)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jYaXc-0003vy-Ox
 for qemu-devel@nongnu.org; Tue, 12 May 2020 15:26:12 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:34693)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jYaXb-0007TT-44
 for qemu-devel@nongnu.org; Tue, 12 May 2020 15:26:12 -0400
Received: by mail-lj1-x244.google.com with SMTP id u20so4726331ljo.1
 for <qemu-devel@nongnu.org>; Tue, 12 May 2020 12:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=eLAY8VWzmemJkzXJYANm0A+npwdLDYO45od9Ru/9D1Y=;
 b=YLqUqCNPxvECvYXkIXojxGnEuahKKZC5TCIaAH0HjIJQE7o+VAovGSzYhKj1GlYK6S
 OM4EytuOXhC/BermiU8Kzu05bRbH5u6s+KbZ6tCq6Dtu66elemqB0tY/S5OGIhjnk2W+
 KGaDtmiXwVg8pdehgrTk6aqFU+fzW60cqGhtOpf07nQva2FU4fsfOKS8soGZSDTJbG7d
 m0rcYHJcXhe1w0ZIEr5gwzYi4y9SfECHQGMUKrV8Xtsksmxlti3vp3NznmtGJn6/i8+I
 3Doo3kNeyhnqfUF6CJoMpzKWPBe1i7ao9mZkNPeUg2X7K+5cYoovyeUdBJnm33YNeNd0
 48vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=eLAY8VWzmemJkzXJYANm0A+npwdLDYO45od9Ru/9D1Y=;
 b=Q9v/C1TvcZGOWW20QluqsvyFUI3x7rXBCtgQbWXZtmjfxnsKtVxlVCChAhiMsVd0dN
 5pxekrvx2/AnsnP5x4LKFoC0MS/IftggOf+VHOSaDofnlKSzRWGd01Q/AEpxComWEtyI
 czVZmddudfUI7LGcBFQpAXZZFLDVG17rPb2Gw7agnGFjuNSN+n/txSeH09qgNEz4lj09
 eE5pFaAoAX6sIKjDdoef9sbc2lk1RrqxP6Lj5gL2OVYKCMi2Yn+sLjb9XV/2NMrRmn7l
 ZVkSJehrZmBu4n8YtqR32o2Y3fLfSpiFjbRTUbmQ+VqkZDgGNr036+OdENwX82YN6M59
 +Lbw==
X-Gm-Message-State: AOAM533M1V+WmSwsN9do+85wYhDlsKTWpHPwmZ1mCCb4DZHvCphnRwCH
 atFTfc/VIbFJbgHNOhQs64X9+eOoaqoLSEQ20jqu4g==
X-Google-Smtp-Source: ABdhPJxaBhlSpkgoXxRKKxHCeSGGGH9z6CCN/+gD466MEJgNvTkWJi6deYNkXEu1tmUBovekvcvrPbe0Wj4EQq+A6Ok=
X-Received: by 2002:a05:651c:291:: with SMTP id
 b17mr15219374ljo.166.1589311568129; 
 Tue, 12 May 2020 12:26:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200326193156.4322-1-robert.foley@linaro.org>
 <20200326193156.4322-75-robert.foley@linaro.org> <87imh1f79b.fsf@linaro.org>
In-Reply-To: <87imh1f79b.fsf@linaro.org>
From: Robert Foley <robert.foley@linaro.org>
Date: Tue, 12 May 2020 15:26:02 -0400
Message-ID: <CAEyhzFt1=xDMN5KdQvVx8QyS5n35THa2vY9D3rV8S9emyTYpSw@mail.gmail.com>
Subject: Re: [PATCH v8 74/74] cputlb: queue async flush jobs without the BQL
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::244;
 envelope-from=robert.foley@linaro.org; helo=mail-lj1-x244.google.com
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
Cc: Peter Puhov <peter.puhov@linaro.org>, "Emilio G. Cota" <cota@braap.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 12 May 2020 at 12:27, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
> Robert Foley <robert.foley@linaro.org> writes:
>
> > From: "Emilio G. Cota" <cota@braap.org>
> >
> > This yields sizable scalability improvements, as the below results show=
.
> >
> > Host: Two Intel E5-2683 v3 14-core CPUs at 2.00 GHz (Haswell)
> >
> > Workload: Ubuntu 18.04 ppc64 compiling the linux kernel with
> > "make -j N", where N is the number of cores in the guest.
> >
> >                       Speedup vs a single thread (higher is better):
snip
> >   png: https://imgur.com/zZRvS7q
>
> Can we re-run these numbers on the re-based series?

Sure, we will re-run the numbers.

Regards,
-Rob

