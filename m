Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A1EDC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 17:09:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 101EE20706
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 17:09:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SGuI/aBQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 101EE20706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joVMy-0004d1-C6
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 13:09:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40376)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joVMF-00041g-Hk
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 13:08:15 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:44436)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joVMD-0002yx-DJ
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 13:08:15 -0400
Received: by mail-ot1-x344.google.com with SMTP id 5so3945603oty.11
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 10:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dCwmRyVnG6xrIjiESn7a0o4CEYbggaskdFoErN4t87g=;
 b=SGuI/aBQCJSO0CtzizLWFyrzx5oKVF6ITZbx50Ek+nFeiBGQP63Rk+IdbBFeYaSIOF
 saYioGYOgZnZdNsaUBpI6FRpEEEpmzNCZCHJEzo/nOVdfgzFoRPvZ0zN/huWk9xAgnw5
 difZt0UmiS3nnUOcFcS8Kv4WWKJh5sAyOYOrY4+vjctkpyB0bj5J6I+HAcXsQ81JZ3vw
 R8SJpxws3JHF5V1xe/XbPKH8v01QHGjWTXw5WZ0ic0JbJ8Vy0SKjWt80OYFUI6rjqsub
 YfEU+6dM88YcWXtSP9qV0JCPG0dpYJL22WDj7ReAVYl1En+S5cdkpeYFiHxMQNyGwWfr
 0qtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dCwmRyVnG6xrIjiESn7a0o4CEYbggaskdFoErN4t87g=;
 b=Q6r1hvqGwHdBDcmIbNiEQoNIsAUK520mreehuczyKOgRJfsNpR8+jZTLXHQnaBhv/N
 7/U7S3BSsDtiU21pcjFubdt/eMAleBVEW2CZvIpzbxy0lIRRbgKXmSDqCerUenTe2g4a
 wuoTuqd3Y0YkJvInSFx/j3Sjl7+zKYz74uwZ84eDouT9g0frJsmZu7gRSLOX6LGjdH5U
 jmVUE10xSWQ1UE6cbfH2g5jvZmC9FHSb6jM+IUNjrnW5nbaZxnmiblMMpadIAL/rTzdN
 JfykpNk2Sfo5ncQgbP7AZyt4YuQXDqB2kPJrv9sCYxQIkrkisnPcMj4mEYSJnq3V9fcB
 WOUg==
X-Gm-Message-State: AOAM531qOxah2elh+hYP5Zge4qK5DKP02XjJ8SYaND3qBiQCvuFqEXAd
 olzxIu+Boi0Dcv7nPcPyh/LTVqpMYXgcnEaI/MX/fA==
X-Google-Smtp-Source: ABdhPJxqQGSpQwQTwKLtSdo9dkZSpz6tQTwL5MOTs+sZgxmKBOJeM5wVcWfpKUjMKjHPRza+p3/zsn+YSETX/8GMmAg=
X-Received: by 2002:a05:6830:8d:: with SMTP id
 a13mr27561805oto.91.1593104892098; 
 Thu, 25 Jun 2020 10:08:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200623193658.623279-1-richard.henderson@linaro.org>
 <20200623193658.623279-39-richard.henderson@linaro.org>
 <CAFEAcA8xy_Q-6zXexBEHLR=WSYTXVvttL9V4HqiMPmtRm__TEw@mail.gmail.com>
 <9e80eb42-655f-9ffa-264a-f72627efdf42@linaro.org>
In-Reply-To: <9e80eb42-655f-9ffa-264a-f72627efdf42@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jun 2020 18:07:59 +0100
Message-ID: <CAFEAcA_bpthPdThRwVaWRyOWkLqbF_cja8w-bga8RHBDHO=r9Q@mail.gmail.com>
Subject: Re: [PATCH v8 38/45] target/arm: Complete TBI clearing for user-only
 for SVE
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: David Spickett <david.spickett@linaro.org>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Stephen Long <steplong@quicinc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 25 Jun 2020 at 17:54, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 6/25/20 5:52 AM, Peter Maydell wrote:
> > On Tue, 23 Jun 2020 at 20:37, Richard Henderson
> > <richard.henderson@linaro.org> wrote:
> >>
> >> There are a number of paths by which the TBI is still intact
> >> for user-only in the SVE helpers.
> >>
> >> Because we currently always set TBI for user-only, we do not
> >> need to pass down the actual TBI setting from above, and we
> >> can remove the top byte in the inner-most primitives, so that
> >> none are forgotten.  Moreover, this keeps the "dirty" pointer
> >> around at the higher levels, where we need it for any MTE checking.
> >>
> >> Since the normal case, especially for user-only, goes through
> >> RAM, this clearing merely adds two insns per page lookup, which
> >> will be completely in the noise.
> >
> > Can we have an assert() somewhere suitable that TBI is set?
> > That way if we ever do have an SVE-capable linux-user which
> > doesn't set TBI for some reason we'll get a useful reminder
> > that we need to fix something.
>
> At what level would you like such an assert?

I don't particularly care, as long as we get notified if our
assumption that TBI is always set gets broken (ie we change
that bit of CPU reset code for some reason).

thanks
-- PMM

