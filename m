Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE4DC47254
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 09:49:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A1B5206A4
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 09:49:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lW7ps8Rd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A1B5206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVuD8-0003ZJ-Cb
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 05:49:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52280)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jVuCS-0002jB-JA
 for qemu-devel@nongnu.org; Tue, 05 May 2020 05:49:16 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:42979)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jVuCR-0003Dm-FQ
 for qemu-devel@nongnu.org; Tue, 05 May 2020 05:49:16 -0400
Received: by mail-ot1-x344.google.com with SMTP id m18so1105479otq.9
 for <qemu-devel@nongnu.org>; Tue, 05 May 2020 02:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=TAas8SXFXBR2hC3fv1RTopcHr9E/jIQ4oU05mf8HEF0=;
 b=lW7ps8RdV4eL/PgHPVLiYWxZ+soN28odC0X6M2rG9x4cyVE/g+YnJS7t3kcJcuZq+F
 WXJVCMeNDRhygnT2th7wkc/o6b1pXQ4UJrR1/xtR93AaUPZzsL1oemp9IhZU84FEwWd8
 e3/4C/1jccRzIzTevOqBe5Ot0I5jIJtJj3eQYVLiFw5lzOOzuhcDm+qgSKGEuSs+nYuG
 AmiLREL0VTrQD1MJwgVj/+SegksU2yFgiWc3pJCl236w/WVYCAWKwfCcSXVlh5E3VKHY
 Arnw8QNZqA1JQNBzhmLszYwrA1vuaDebrZ/Mf6tJBRllauVfGV8EYAfO8xsPiYLtYKlZ
 Mbcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TAas8SXFXBR2hC3fv1RTopcHr9E/jIQ4oU05mf8HEF0=;
 b=YHWVoCKrQxBjsOdmOg7KMeAQkkFS6GK2yLcrSBpwTUmMLrFWV7k6Ix3N7AAiHvYWqL
 CyvVKHv0ZQiZRX2O96zppJD50Pckn3IXEcAmgIUmnDUKVkzcyVhXxlAcVvnRc+qTs3ex
 +m33rplUKAeuBKxPE9dvB3zXYO2pN25vv6nc/Bv7pawXZHrb0Ob7Pt3E8XoIPBhvOU2z
 FhsjGPi2mJL8qnXICGfX3/AUONnv2dEhXlliWeEVq8/+UytlYQIflayEJJW5evRJwjV4
 2AsRP6AaDyX3aRBXaUNNBAijan24hgm9THY6c0Cc9M6JtunMAskWRX65nMkMT567puTy
 rAng==
X-Gm-Message-State: AGi0PuZqJB0WDap8M/z+7Yb3kRnLbmsyXRZzABOsfSRYYtNgytM8lB+I
 xDc3sIxo2hu3ff/s52qFUGrhqDxS6/R2VGDJBfY9Qw==
X-Google-Smtp-Source: APiQypI308GBtLL1/5zxOqsITcPZNf1WgdHJ7aU40XfH1lQ+YkXEWpM5gh6oQ5kd9fDsOaHxX7TL+4UrRAA59uQt1z0=
X-Received: by 2002:a9d:2c08:: with SMTP id f8mr1527787otb.135.1588672154302; 
 Tue, 05 May 2020 02:49:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200430162813.17671-1-richard.henderson@linaro.org>
 <CAFEAcA8m33s7e2T0GrZJxb4EyczcEmtW6-tRPoUsiVLO9g8dVw@mail.gmail.com>
 <20e6093b-edcb-c0e4-f4d5-b6ff4d51783c@linaro.org>
In-Reply-To: <20e6093b-edcb-c0e4-f4d5-b6ff4d51783c@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 May 2020 10:49:03 +0100
Message-ID: <CAFEAcA-uupuSni8yqs6evWbjZDZyToit6Hhn8nQ=oSWjRuJjgQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/18] target/arm: sve load/store improvements
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x344.google.com
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 4 May 2020 at 17:03, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 5/4/20 2:43 AM, Peter Maydell wrote:
> > I've reviewed patch 13, but I still don't understand why you've
> > made the size-related changes in patch 4, so I've continued
> > our conversation in the thread on the v3 version of that patch.
>
> I've changed that here in v4.  Please have another look at this one.

The page_check_range() call still seems to be passing a fixed
size of '1' ?

thanks
-- PMM

