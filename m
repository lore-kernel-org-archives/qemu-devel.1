Return-Path: <SRS0=FShu=BK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BEF0C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 19:14:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA73921744
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 19:14:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rwEIRYEy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA73921744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1aU9-0002ve-9m
	for qemu-devel@archiver.kernel.org; Fri, 31 Jul 2020 15:14:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39408)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1k1aTU-0002UI-59
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 15:13:48 -0400
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:44987)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1k1aTS-0003DE-Ao
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 15:13:47 -0400
Received: by mail-lf1-x142.google.com with SMTP id x24so88805lfe.11
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2020 12:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0ydHrJEHzsquQQVL3qgS+K3UiwZ0ldt1AK/7W+Im8zc=;
 b=rwEIRYEyM24pvLMzV6f418bh7hQ6+Y/6dNmn0hlrL/AI5CtHu2BBUPAFCpPsxiGuSW
 gwT/6pyU4AtgOClw/doIgRKzWAb/uUBN2MCWZJ1ztjfFeu4y4boRpnIX1uqFfjGlax+X
 vG72IZa3m585txrKf89Vt9PQPFsYvjvFoN6J5NEH4GJ6e0CumcxOivxkneYe7vf4bRDb
 7Sp1ens+423ww+LS8xG7aWXtva1JuGmEmIeHbjeScnAiBUX4LBflgMjkn1UFWy1MHPod
 REdYmepNZvOrhkLSsNBiu3k4EUBB6vGO9s3dkELJt4RAN7f8xpDseqWMWqhJzC8GJG8s
 /nUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0ydHrJEHzsquQQVL3qgS+K3UiwZ0ldt1AK/7W+Im8zc=;
 b=SZeTftzmp9WaaEUh0j1fzdD7VcCJSRN6DiqAObT5kbsC3UzptEWi0/glSSILlQv4ez
 6l+ikTcY3bgY6Iz4T6NH4d2gHpY5tGrapmv1/0mnu/GkCwLYJYFEQEgeS0nPJp9oOC5n
 XtuF/lU6vBWsXQ/AespZSSKvXQis2pwE2tMTRJ7bW7MhFa5d/PWdgSmWp9zhCkXuQT0w
 v78QbzUPJkjUuQ5hwyrQVnV0kxzAh3PFjiHRDdTnI2sxdCk18W+blBhHHKdkM+qlUrS2
 p1ondKyMWlfwPy9QOC5B+K1wrliydILi0mu5lpiMFdSuS3yHKBC+3aHz52ioCoHkGZBd
 dFaQ==
X-Gm-Message-State: AOAM533tzpA+1W2Lm/WGVD5bvh5NAdmxx9XQ3Gv1NEZthZYAst4bGNkH
 5xgNke3LMcvfGiA7ak7Xsd7MM3grfj8MU66HlMzQRQ==
X-Google-Smtp-Source: ABdhPJzmJNDU5Nf+gzBm/UBW/PU2S3aEBYKkUcsUr148hFBn2RjYuSr2PI2ekjPxgMnnFdEAWIYYW0+EO62YA4hTSnI=
X-Received: by 2002:a19:8607:: with SMTP id i7mr2721607lfd.208.1596222824017; 
 Fri, 31 Jul 2020 12:13:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200731125127.30866-1-robert.foley@linaro.org>
 <20200731125127.30866-2-robert.foley@linaro.org>
 <20200731174353.GF225270@habkost.net>
In-Reply-To: <20200731174353.GF225270@habkost.net>
From: Robert Foley <robert.foley@linaro.org>
Date: Fri, 31 Jul 2020 15:14:02 -0400
Message-ID: <CAEyhzFuBiqpAijLMw-SZmiDyGQnc2c6yk6g+E0HN9eSYRVaWMA@mail.gmail.com>
Subject: Re: [PATCH 1/2] hw/core: Add bql_interrupt flag to CPUClass
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::142;
 envelope-from=robert.foley@linaro.org; helo=mail-lf1-x142.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Emilio G. Cota" <cota@braap.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Puhov <peter.puhov@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 31 Jul 2020 at 13:44, Eduardo Habkost <ehabkost@redhat.com> wrote:
> >
> > +static inline void cpu_class_disable_bql_interrupt(CPUClass *cc)
> > +{
> > +    cc->bql_interrupt = false;
> > +}
>
> Class data is not supposed to change outside class_init.  Why do
> you need this function?  I don't see it being used anywhere in
> this series.

This function was to be called from changes in a later patch series
that depend on these changes.  BTW,  I added a correction above,
it should be disable, not enable.  The idea is that it is initialized to true,
but then the per arch changes would use this call at init time to set
it to false
as needed.

We can remove this function from this series and add it in later when
it gets used,
it might make things more clear.

Thanks,
-Rob

> --
> Eduardo
>

