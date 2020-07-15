Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 033C5C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 12:05:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEDE220658
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 12:05:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w1Uyvrdw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEDE220658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvg9m-0002XV-Sw
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 08:05:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55892)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jvg9B-00026M-Ql
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 08:04:25 -0400
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d]:45354)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jvg99-0006YX-Oz
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 08:04:25 -0400
Received: by mail-oi1-x22d.google.com with SMTP id j11so1973212oiw.12
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2020 05:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=rhlYuhgLQAtbnAd7zk9h7e2GS5shqg+8SZTy7WM7nKc=;
 b=w1UyvrdwiGlYPpe0DgxhuadF3ih/Vhe9SxAeBGL1XyM4kFBtDE85BKkt7K+sO7Ni4M
 LC1im0CjJ2j2Q208FxKxZ2yCIy89dKHIMTUPc7JhoizS73gt57ekHXtyIXx4dGJvHmIT
 Bc4TzCRWB/WrC1YG7eg8oU6+TVOTxjqScza+mLGNBgZTcq28F/L6YrRE++aceWjfwi2M
 r6L4ajvTk4BmebZhp369XA+RWYHpSP45gYBAFxByv69ecrdIFbJb2a0PQmguFE1F97eE
 /YFxpZ7OpQO05QjMFsjaK1U5URKLSlQOZcR3cpfIeffy8GGmMGCJs3mpTO30eMOb9S7M
 M2Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=rhlYuhgLQAtbnAd7zk9h7e2GS5shqg+8SZTy7WM7nKc=;
 b=SOXvJC0l6Kr16kTKOy5FwMNRVze5g8Dx9f2r9JKBmQxBE+ggHwpxiT+Y6qiON+bNL2
 NVuvPzJIhvcomL0r0k6Sl4Z8CYkTe65aaKlFuz58Mlfj2Wq/d4Z8lOKTcHsxhGZBdQcE
 XuBUqYfo7OkrvN1JWoNC+4asl5NUvO1b121oHfV3/TnrhJQkTc443lkWuta9IjU6kd9M
 Wmie48dlRQ5DTDjas9xEjoNe5DU0RNAaMvyKs1uhtIq18WMMzZ36HhhgHH4tTHZu6Ihz
 XPfhsVBUOslLuqi6+WFfeIECZeNbsI4Wj3QOk1jc5DpouMLolcGOtNlkQ9+8yMFqy+rg
 3ktw==
X-Gm-Message-State: AOAM531yfLGkk6In40BmQ/kLJQ4M/Z9zsaJ3A2cyoiB2MItEuxaSmdx8
 k5vHRarO/mxiVZsIqT03ewu9Q3JtxUF4QrPQi6K8QcIB
X-Google-Smtp-Source: ABdhPJxAfujMTTovS8SeoYZR6xsmV3ziJcSF7z5tYf/9OhvaInS82qEMAhFzjWMP+5sHDYt3LgGnMqKHvI6youTvC/k=
X-Received: by 2002:aca:2819:: with SMTP id 25mr6956325oix.48.1594814661961;
 Wed, 15 Jul 2020 05:04:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200715105542.14428-1-alex.bennee@linaro.org>
 <87imepxc4r.fsf@linaro.org>
In-Reply-To: <87imepxc4r.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 15 Jul 2020 13:04:10 +0100
Message-ID: <CAFEAcA80_zYJWHAGRuH3zvM8zTXwwsnbchnLjOz_O9fiCc3N3A@mail.gmail.com>
Subject: Re: [PULL v2 0/8] final misc fixes for 5.1-rc0
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::22d;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x22d.google.com
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

On Wed, 15 Jul 2020 at 12:15, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
>
> Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:
>
> > Dropped configure patch
> >
> > ---
> > The following changes since commit c920fdba39480989cb5f1af3cc63acccef02=
1b54:
> >
> >   Merge remote-tracking branch 'remotes/mdroth/tags/qga-pull-2020-07-13=
-tag' into staging (2020-07-14 21:21:58 +0100)
> >
> > are available in the Git repository at:
> >
> >   https://github.com/stsquad/qemu.git tags/pull-misc-for-rc0-150720-2
>
> Just sent v3 to add the Travis patch we tested yesterday. Sorry for the n=
oise.

Still segfaults on arm hosts. (Others seem fine.)

-- PMM

