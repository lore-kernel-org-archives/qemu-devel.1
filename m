Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B989EC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 16:04:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8148720782
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 16:04:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LiL/qtjU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8148720782
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAbR2-0007Sd-Ow
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 12:04:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44422)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kAbQT-00071n-4R
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 12:03:57 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:45519)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kAbQQ-0004Wz-H3
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 12:03:56 -0400
Received: by mail-ej1-x643.google.com with SMTP id si26so17276247ejb.12
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 09:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=4mGTsHkEpArISEARXexHwI3OhEY/w3zlfztzHLEUQcM=;
 b=LiL/qtjUGYz+8Cy7ZqbV63VCPNeVv/FTFt/nkFuVR8+y93Rg1+cg2l/TMIdBKy4vtr
 IiZp4dreAPlFb/PTtRlyMkY00KqFQ8HBi8WKUFHShPvcRFIN8eJV9mbskCgx38aluDaz
 ym2y2Xaz35DZ+JN4zpb+Ao9vsctc7CdqbtvaFtTPLs23p1iE5YAXROeh8bO/WAclKt86
 J8XO2/UrkOIjCkI9+1+m0UZbOF7alwuUqegq3SGz/UKDxjtVmRFeIyqTRzo6skxjIxvu
 hc88w61UxqrAnOzwXeBEuEOblN/EsNg6X+TB2WYJUfbJI0wEpvBBmCjne42+CK44AGmc
 fEVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=4mGTsHkEpArISEARXexHwI3OhEY/w3zlfztzHLEUQcM=;
 b=B6dVxemcAFkGTzJs8wRAvCbXkKKQRVWLbaxHgKIh1haRUlM4ueCSIYnDOvMBGxL4iv
 SxznhK7/nbYh2bQUxyM9s6PeDME0Mbh73Y8x9U/is3l+q8oewDXRWIfhq51lYJzX+XAj
 6Dta5UvOqHBt9yawzIGJUNlwmbdcSxwPw6LSfYuWqUHFTDNvLoaYcZgWCXUunjG3dyEX
 UtrC3ofqPRf29pH/kgkcAfXW8YHY/Bt5efzCeg9IJboXOQA1u4VZIvOdjq7c/5RL7jlx
 YX4y0eAgGIACzwdcW35CyZQy+j7+tq6jEvsqvFos1tLEOsuLn3wjE8zfSPGw0tK+YYuE
 yU6g==
X-Gm-Message-State: AOAM532E+Z6GS4/XYDj+cN6dJeyEppUu/Z9TdPiwBhvVVo5E/LYUGCM+
 YszTJlpotjz/Z0V2fbxSAm57EZa4z4/3GNr0RXOnAQ==
X-Google-Smtp-Source: ABdhPJyyS6VBUm30EAdl28sMK1C9PIeqqUq4zF0uTQ4IYCAyswk336agCuTEplkmp1fR5XXD32EOb5rku9Vk1y5WK9I=
X-Received: by 2002:a17:906:d8ca:: with SMTP id
 re10mr10853587ejb.382.1598371432741; 
 Tue, 25 Aug 2020 09:03:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200825150409.346957-1-marcandre.lureau@redhat.com>
 <20200825150409.346957-6-marcandre.lureau@redhat.com>
 <20200825151156.GW107278@redhat.com>
In-Reply-To: <20200825151156.GW107278@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Aug 2020 17:03:41 +0100
Message-ID: <CAFEAcA_b3aGS8TFB3V6mNwxi7xG6MGNwqtnt9=XpEve+OHQQEw@mail.gmail.com>
Subject: Re: [PATCH 5/5] meson: add NSIS building
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x643.google.com
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
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, QEMU Developers <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 25 Aug 2020 at 16:14, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
> This is a verbose way of saying I think you should create a
> nsis.py, not nsis.sh, to avoid the inherant portability problems of
> shell that hit us over and over and over again.

Does it have to be a separate script, or can we just write inline
Python in the meson file? The main reason the current code is
written in shell is because that's what you need to write it in
so you can write it inline in a Makefile, and because half of
it is "invoke this other command ($(SIGNCODE), makensis, etc)",
which is what build systems are good at.

thanks
-- PMM

