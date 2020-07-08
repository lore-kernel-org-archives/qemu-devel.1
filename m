Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D9CC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 15:34:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE6E9206DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 15:34:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zWKvCk3i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE6E9206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtC5A-0006cG-4V
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 11:34:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59722)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtC4I-000618-8Y
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 11:33:06 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:45074)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtC4G-0005EE-LL
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 11:33:05 -0400
Received: by mail-ot1-x344.google.com with SMTP id h1so15062882otq.12
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2020 08:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=870pmzz8gUZHxEnI+h8NiFZ/xO3dyNXWEewqo7sSIzw=;
 b=zWKvCk3ipkZkiSgvt0HIQz0svylMuqeJkHPyrhsZI0xIxxdliIqDO7MNPLnOVpR/1H
 vp3zaRFQX5Ii7Z2AD7W1tuIR4mYNKgYtJ4jMruKdWwEdUiCxODyytZz5kCEjUQvaa0Cp
 G9YOpw/p9QUoUKXbsLaN/yHie4T2BW1K5RnFsd9vteohwB2+cy37fgNccS25wnyZ0F4T
 fs2BQYYZiXR65ewnl99CIa06t8Lty0jcDri8i7llrqJsCSKlpg6bNp+bTNqf7JBAPHqP
 YfSPkOtI6XfrEAFUWQ9B2TonXyhWl6Riuim63/nLyI0RSXvoo9ii076QiqbcaKJTEe9r
 tZsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=870pmzz8gUZHxEnI+h8NiFZ/xO3dyNXWEewqo7sSIzw=;
 b=P3tOLFNMAciVOrfx2F6QsLKlG07ylUa5TRhNe8N9OJVZIgXjnRxuMy0+6u2Y5NDxjy
 6ZJrnu/3lPs707JZ2OTat4ShfCTLRi4jBYrHDTAep1+bn4ZfVBJYVgmx8xmI5gSOrtGT
 FlnS5CsguHIQlCWxpsT19i/jku5hrNq/11Kft+Dty1yYMdnMnQljuRAOJuWig6wWP3L0
 hrdLiezOBnIoLq9M7ZU7nFCA9LtSP04UslNzmTBWVRotXIIPXQ7cLFezgTT31Cdp91zF
 RC6/zxlZ/bFz3lz3UydA61I9OM52WsnAnNdVDQNuADGeIQraNl1HtP6QxlZmVsNggDxA
 Apgw==
X-Gm-Message-State: AOAM533z5JPTrf6U/1A7ca8SKw9oH+gmtTc2mxIW2J0+8P7OXWcnTm/H
 33PlSK7tgFioJFP1HdKQzAJt6E8FOmsyIa5IY9u/Tg==
X-Google-Smtp-Source: ABdhPJwpb/yZbcLe+tHeKQh3YnltraMeNVc3K6zAjVIw100yWLCLwqPi4vil7N1HvCHgBsDWDcDK10KNyFjJImfoPVU=
X-Received: by 2002:a05:6830:1bd3:: with SMTP id
 v19mr47668148ota.91.1594222383271; 
 Wed, 08 Jul 2020 08:33:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200707204333.261506-1-bauerman@linux.ibm.com>
 <20200707214917.GX7276@habkost.net> <87y2nu3nxq.fsf@morokweng.localdomain>
 <c53b36b7-ee7b-bb66-8220-cce788fd631d@redhat.com>
 <20200708100038.GG18595@umbus.fritz.box>
 <CAFEAcA9V7Uha9-rz+JY-5HkazCWuTk1vkLnw1m9Lw-bXXKbkvw@mail.gmail.com>
 <20200708152540.GZ7276@habkost.net>
In-Reply-To: <20200708152540.GZ7276@habkost.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 8 Jul 2020 16:32:51 +0100
Message-ID: <CAFEAcA8mFM-O=mgCQHNz4TNB5N3Trid2o95s0Nx7JVp_q_dSrw@mail.gmail.com>
Subject: Re: [PATCH] cpu: Add starts_halted() method
To: Eduardo Habkost <ehabkost@redhat.com>
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-ppc <qemu-ppc@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Thiago Jung Bauermann <bauerman@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 8 Jul 2020 at 16:25, Eduardo Habkost <ehabkost@redhat.com> wrote:
> On Wed, Jul 08, 2020 at 02:14:03PM +0100, Peter Maydell wrote:
> > The original bug as described in the commit message sounds
> > to me like something we should look to fix in the implementation
> > of async_run_on_cpu() -- it shouldn't cause a CPU that's halfway
> > through reset to do a KVM_RUN or otherwise run guest code,
> > whether that CPU is going to start powered-up or powered-down.
>
> What "halfway through reset" means, exactly?  Isn't halted==1
> enough to indicate the CPU is in that state?

I mean "while we're in the middle of the CPU method that's
called by cpu_reset()". "halted==1" says "the CPU is halted";
that's not the same thing. KVM_RUN happening
as a side effect in the middle of that code is a bug
whether the CPU happens to be intended to be put into the
halted state or not. If the CPU is intended to be created
not-halted then KVM_RUN can happen after cpu reset
completes, but not before.

thanks
-- PMM

