Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F957C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 08:08:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AE33206F4
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 08:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IwbT+GU1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AE33206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRst0-0007QH-Iy
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 04:08:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46548)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maxim.uvarov@linaro.org>)
 id 1kRssE-0006qr-V5
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 04:08:02 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:41576)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <maxim.uvarov@linaro.org>)
 id 1kRssC-0004pO-Vp
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 04:08:02 -0400
Received: by mail-pl1-x642.google.com with SMTP id w11so420695pll.8
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 01:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=BWDQO5aPrAfLfnQelq3/3NNlBK1si0DmmIdvr2r8kNg=;
 b=IwbT+GU1M44w/A02IZ6ldAQqSgsFDaNcgaQY5Er+GH0cfF8buW3/uVhsgiozAXh1PO
 FBW3arADSVJguipvFIYs/c+sl2A7/zw8x0IKG/S79AY005INvpAw7vii+rFIXnBUfTvh
 CDJgqFdOcMtBY7LldLEsptDn97K2ScIgoUtz/MzaKqW0nJFRpGxZOUv0aPNe9y5oGQ28
 ZP/3kqiCqMtwSmuCUcOECcOlQy1UX5+8QHxCx7LP68lWC9PQrvEgvoGC4XuaV6ZRRdLG
 VXL+HzmaiQalU5Jh0SHEg/OLMcPybRUYpYFmV6sYGkw/xQ6zwyPczKQ/KesEAoQQn10q
 y5dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BWDQO5aPrAfLfnQelq3/3NNlBK1si0DmmIdvr2r8kNg=;
 b=I7Wqc4070s8KRtEqlBQlW0iML8o+H5lAPy1sTOLE+ts3tZKNnKAVz9YAtLCGfi12CQ
 tGIDGU5+K8g7rCpwWvtrkz56iERFU0IcM8jJRweNsAvoIZep824i8znbLsg1r/kdag1w
 FxBns2gvWe2XW8jblRMF5jVc+tV76yx7yritvo+2aKRb54ZUimgVBKz23GMUt/v3wPOG
 SdDMD8YFaIA1kBpnVfaUjdmu1hVS1GrbpQ1XmrWrYwq2NVH1SS41+tU6Pj7nL8rKZsij
 iV8xgZJNzcAOdqROdjG9UbfOa/7s5L8zxntOIV2kksGwBSRy4CN+aphjNy0d8sd9m7o5
 dz3w==
X-Gm-Message-State: AOAM531Of/49Mumt7YDiQdC3lZfrNImFarve+bcdSjN5Q3cQP8uc67r+
 2j1mBgxglOdwsHGVEEwpPCSSQq+aYCzEMvmSgNvZjQ==
X-Google-Smtp-Source: ABdhPJyUACD1vHMjM3m/Lg7DVTi3LJRhJU1utEcgNtAa+eLsbDe94MtBXaVCCdr883IjG7pdLs3AGbobtsHflV3Sk+E=
X-Received: by 2002:a17:902:b595:b029:d4:db82:4403 with SMTP id
 a21-20020a170902b595b02900d4db824403mr4334605pls.49.1602490078807; Mon, 12
 Oct 2020 01:07:58 -0700 (PDT)
MIME-Version: 1.0
References: <74151CBD-4750-4E68-9127-21076C019036@getmailspring.com>
 <CAFEAcA9cZPgaHGuCs0J20YJ48V2eXHFFRsb9a56xFULjtFtn3g@mail.gmail.com>
In-Reply-To: <CAFEAcA9cZPgaHGuCs0J20YJ48V2eXHFFRsb9a56xFULjtFtn3g@mail.gmail.com>
From: Maxim Uvarov <maxim.uvarov@linaro.org>
Date: Mon, 12 Oct 2020 11:07:48 +0300
Message-ID: <CAD8XO3bE3PTrZjxHVWE3_7Dif_WXySSnQTU=kf_yekFrgf4J3g@mail.gmail.com>
Subject: Re: Re%3A [PATCH v4 1%2F2] hw%2Fwatchdog%3A Implement SBSA watchdog
 device&In-Reply-To=<CAD8XO3YmTC7fzxttg%3DQLMpJbg7uLogatxN7q7vf-iGZjyQLjjQ%40mail.gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=maxim.uvarov@linaro.org; helo=mail-pl1-x642.google.com
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
Cc: Shashi Mallela <shashi.mallela@linaro.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> +static uint64_t sbsa_gwdt_rread(void *opaque, hwaddr addr, unsigned int size)
> +{
> +    uint32_t ret;
> +
> +    if (addr == SBSA_GWDT_WRR) {
> +        /* watch refresh read has no effect and returns 0 */
> +        ret = 0;
> +    } else {
> +        qemu_log_mask(LOG_GUEST_ERROR, "bad address in refresh frame read :"
> +

Then it has to be  uint32_t ret = 0;

On Fri, 9 Oct 2020 at 20:51, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Fri, 9 Oct 2020 at 18:30, Shashi Mallela <shashi.mallela@linaro.org> wrote:
> >
> > The value being returned here is 0 (initialized to 0 at the beginning of read function).
> > I have seen similar practices being followed in other qemu implementations like for example bcm2835_dma_read() in qemu/hw/dma/bcm2835_dma.c,a9_scu_read() in qemu/hw/misc/a9scu.c.
> >
> > Please confirm if you would still like to add specific value like 0xdeadbeef for bad read offset.
>
> Judging by the subject line you've mangled the headers on this
> email so I'm not sure exactly what this was a reply to,
> but in general QEMU doesn't do that kind of "return
> specific marker values for bad register offsets". We
> typically log it with a qemu_log_mask(LOG_GUEST_ERROR) and
> return 0 (unless the h/w does something else).
>
> thanks
> -- PMM

