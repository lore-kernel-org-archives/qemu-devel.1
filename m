Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34696C2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 13:41:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8319020735
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 13:41:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="daUn94oy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8319020735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kb1zH-0006C8-Jc
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 08:41:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42292)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kb1yG-0005WQ-CZ
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 08:40:04 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529]:45341)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kb1yC-0004Kd-V6
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 08:40:03 -0500
Received: by mail-ed1-x529.google.com with SMTP id q3so1272675edr.12
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2020 05:40:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=AKnReEf/p/xSBuslk1N1S2RpHTmhnhh7XzQnHsR2Bmg=;
 b=daUn94oyFO4dqdSyWVN0KxTXWNHyPguuirT0xAGFfr8hdcolJNAl6JRJEjTfCwlyYA
 F3/j0ZABOUrwDzw9UjIPJC/3RKoOCEXgEX2XYvIt5djrw3JdT6h3S/YA4IemHiQjqTTC
 XVtYvBrl5yE7riAvYYbplZo13KJzTqUJeryW3mdV62J/iprOFZQpSL+9G6GIqnBTUp+k
 5tKivf6kspHbqu2R3Kqhhg6BOkbzqVfU9KBA9ov7vKmO5FdXfmBm+2cw3n0k1jFE5W1u
 7Fz+hf9Ps6WTsDia3G+auSYSNJ5dGcHh2tGR+LnAfEd3MeDtdgfAz6kc9wWOAECzo1kC
 xesw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=AKnReEf/p/xSBuslk1N1S2RpHTmhnhh7XzQnHsR2Bmg=;
 b=X0wmJQDpEN2b/XUPRUJZVk75GTau5kpVjF+Ggvlr+6hznXU21W2Lx59QnDvesKOVm7
 4uO2suvmQVZxpgju85Hclk3jUGAuR026EYSKo9x0aQp07JgNU0aVb90nt6Ccu0bMkMFO
 N6kX9pSSgniHszUb0g5PGNJBd6Wg18pkbx7vahinIrLfwSxu9WMGA4r3qWtxqvlehYAt
 NmpHFU5W/Molw1fSx8D7wlYSa93Kw/UQ0M74cWo5dasiJYnnsBObd3VPOnPf4DaiU0qw
 F6Zr2p+V5mISdM3aeZ2+87UBU3cfi7wfiMR+WCsAz51RWCMR5wny0NhLD7Xxz4vXU0/W
 5OMw==
X-Gm-Message-State: AOAM532htGZK6Bwb8ZHv8kzJsL8A4aWQZIDcDCdJbwU86YL4bUuuDk0r
 7sRtw9t31q1Xx4gzVop28x3MbSYt3kDHJzWGDbUA7g==
X-Google-Smtp-Source: ABdhPJwRtfrfzOma3hWqvGkBY3KGtVOhqP+LLmw+So5ynmjLjPEQwQxSFJTBorzAjEl9c55x2EMRSRz9rBZ026fhCIY=
X-Received: by 2002:a05:6402:30b5:: with SMTP id
 df21mr2009335edb.146.1604669998555; 
 Fri, 06 Nov 2020 05:39:58 -0800 (PST)
MIME-Version: 1.0
References: <20201105154208.12442-1-ganqixin@huawei.com>
 <CAFEAcA9QMBqF0Bm44q4m1d=QaPVBJodH9rwuYhGx5H6zy6ULcg@mail.gmail.com>
 <87d00qk51l.fsf@dusky.pond.sub.org>
In-Reply-To: <87d00qk51l.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Nov 2020 13:39:45 +0000
Message-ID: <CAFEAcA-_5vRbsi5fFpyLV2OyDX5TVrpAx7_Z43wqvb1zhQO_8w@mail.gmail.com>
Subject: Re: [PATCH] scripts/checkpatch.pl: Modify the line length limit of
 the code
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 zhanghailiang <zhang.zhanghailiang@huawei.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Gan Qixin <ganqixin@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Chenqun \(kuhn\)" <kuhn.chenqun@huawei.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 6 Nov 2020 at 13:07, Markus Armbruster <armbru@redhat.com> wrote:
> The current "warn at 80, error at 90" is a compromise.  It's the result
> of a lengthy argument.  Why reopen it?

There was some previous discussion under this thread:
https://lists.gnu.org/archive/html/qemu-devel/2020-10/msg05653.html

which I think is what prompted this patch.

thanks
-- PMM

