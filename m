Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF36C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 14:02:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCE892087D
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 14:02:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ETb3V1F3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCE892087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jda9w-0000c9-Vf
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 10:02:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36578)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jda9F-00005s-KJ
 for qemu-devel@nongnu.org; Tue, 26 May 2020 10:01:41 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:46968)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jda9D-0004N5-Tn
 for qemu-devel@nongnu.org; Tue, 26 May 2020 10:01:41 -0400
Received: by mail-lj1-x244.google.com with SMTP id z6so24584659ljm.13
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 07:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yR1yHjNMfbImg68WVZg7zsro/I48kFz2BdVm4lU/wOo=;
 b=ETb3V1F3yq4QP5sDyb9OvOVC9lNKLodOrjsD1TfjceXL4bFrpWG7IciEMRuoXcHmn3
 UryvzVIoWEPcpNZvinsOwdopjUKmp9UOv0uJcJiNN4WkCpuGOGfrqxH77YSNMC+8G7RN
 fhOtm+WcLxCva1mT17OLcZjDDAY1Ethk36/yDKItorqAT32nL8wbJjstjvkCLsrWi4O8
 QcPYrjcw0UifgEFXgQfego7/ZAiZqmbTKflgtEOP92qYH3LRyKShTcsUVya86SbI37Hu
 F3/qOkhkNdwwf5k8fC+FyOWtZPHAY3csjKGFS+AObo6aTaWk+FSJCveqBp2qfHRbnyfz
 nKew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yR1yHjNMfbImg68WVZg7zsro/I48kFz2BdVm4lU/wOo=;
 b=W52wJw2Qr9yYHBDyCn+LWMX8PtPQA32ONVd7frKEnA1SimNQohxNEhQZWq7MHSTbTU
 LFNwgej5lJdxp1bVAuheLJcO6EmLFGe2BekBpP5bOxa+W8INvdoMOetkuuEs6dPaA5Ft
 9xvN6kuGZgzbQCiwQNflFHB410NUAMn5q49B6N0/yhc56kIP6+BOrQc/OX5gbMnFxrVt
 lttdNM8YBLLdErbfQU2CaIsCvO53DRmBCCBPf7MDQcqouC7ebacAN6vM3yqNuzDW6VCt
 e5nSB5nEWa+c53/cueCEkGugIgI2qpRc5Fhpu/XDHGzirZp5zU0eolTfS2u51crhyuwL
 kXTw==
X-Gm-Message-State: AOAM532qt4YFnyj/k+r1GhxyVvAFyjAVlZcY78B3n0YLWzR5I5/qs80/
 wtTcfYRFrC9vmZ+akid7yHRWpz/ThLAM0DkJYotWOw==
X-Google-Smtp-Source: ABdhPJw78gqHl21sN3gKQLVghI7Op/h+RN+3O12zsXCGke2u2cIzWJ6Mjss4S8NKfw0QskEXRJw4tLwNufHTcAC+0J8=
X-Received: by 2002:a05:651c:1104:: with SMTP id
 d4mr666617ljo.193.1590501698063; 
 Tue, 26 May 2020 07:01:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200522160755.886-1-robert.foley@linaro.org>
 <20200522160755.886-19-robert.foley@linaro.org>
 <CAFEAcA8gqM1vn4eV5XK-2qOQ47ugO9OsFWA_+MgRpO4Vb5JFOQ@mail.gmail.com>
 <CAEyhzFsS3g-OQ0JzcDVfaaKAt9632XmKfzC0tfy0VmF_RRB2Og@mail.gmail.com>
 <CAFEAcA-u_vAGtn7htspqkN56Xhb-WH_x8dF7GYs46zWaBLMEvA@mail.gmail.com>
 <20200523171814.GA382220@sff>
In-Reply-To: <20200523171814.GA382220@sff>
From: Robert Foley <robert.foley@linaro.org>
Date: Tue, 26 May 2020 10:01:33 -0400
Message-ID: <CAEyhzFunwxFpEveiLvsNfcUSkCyqtCDDOfF9Lf1cB3+i7k39-Q@mail.gmail.com>
Subject: Re: [PATCH 18/19] target/arm: Fix tsan warning in cpu.c
To: "Emilio G. Cota" <cota@braap.org>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Peter Puhov <peter.puhov@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 23 May 2020 at 13:18, Emilio G. Cota <cota@braap.org> wrote:
>
> On Fri, May 22, 2020 at 23:36:18 +0100, Peter Maydell wrote:
> > So is this:
> >  (a) a TSan false positive, because we've analysed the use
> >      of this struct field and know it's not a race because
> >      [details], but which we're choosing to silence in this way
> >  (b) an actual race for which the correct fix is to make the
> >      accesses atomic because [details]
> >
> > ?
>
> It is (b), as shown in the per-cpu lock series. In particular,
> see these two patches:
> - [PATCH v9 33/74] cpu: define cpu_interrupt_request helpers
> https://lists.nongnu.org/archive/html/qemu-devel/2020-05/msg06322.html
> - [PATCH v9 39/74] arm: convert to cpu_interrupt_request
> https://lists.nongnu.org/archive/html/qemu-devel/2020-05/msg06328.html
>
> Since a more thorough fix is included in that other series, I think this
> patch should be dropped from this series -- I'll post a reply to patch
> 00/19 with more details.

I agree, we will re-focus the patch series a bit and drop this patch
from the series.

Thanks & Regards,
-Rob
> Thanks,
>
>                 Emilio

