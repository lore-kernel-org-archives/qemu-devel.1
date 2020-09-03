Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F6EC433E9
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 10:54:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61343206A5
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 10:54:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PR9t1nxg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61343206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDmsV-0000s0-Hu
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 06:54:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58486)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kDmru-00007Z-5K
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 06:53:26 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:34293)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kDmrs-0003vB-Ec
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 06:53:25 -0400
Received: by mail-ej1-x642.google.com with SMTP id gr14so2084333ejb.1
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 03:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=w5u2m4EY9YQbq3NbFun/1FKiDPl3zzjNRmb9apmKtAA=;
 b=PR9t1nxgXFnK+ou5tH7nZH0zwcoOhXgMM7puuAMc0c9pZw4LggFEw28J2VpWAZ9rQV
 fG9l3WTD/IDxz1lc1dk0cPSgmGTQgwmhIVco6GoQLXtyEDYS+zQtkMpVtAOzkAGKeuy8
 69dElHS0CskiVBqr7pVhpxkvSRBHCOAYjg4eXEbOzGfcQx9YMzqIP5XhucAPw/Ri8u9B
 YgJyFbcwAnh+PaEzHDWeoaMOjEhNrTXt3TETKflrUQ2vzHFbpEb4CddIxwPtveZJWCsc
 9iNjg14Fz3QnkWOYxEgwgRMzI+cUyh0/pPUTLfl5NRYha0HxYH6j0WnAOpWieGQ8JgFi
 A6/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=w5u2m4EY9YQbq3NbFun/1FKiDPl3zzjNRmb9apmKtAA=;
 b=s0JAqNHjWprXb6jsw18wUtilfRaOXQW7osQtf7T3U+GrbIXxS69D7OGkCVGAqbSyDg
 pPFH+8h4Ztcp95ISuTZyNfTF1WRHUGGzPY4iYKQXkeGiZ6ziDHgYn06+hPEPxeP+jMBY
 ow75NVmmqUeHmJWk9f2ObcAR/AeUJLRY1kZctjaf2p3wdXHVcofMVp2mDuV3IcI1Qkf0
 SeI7QrqZNzbzPFW3LdsAhKjw1g/ehlFx5E4FVUZSYY+3w21I6JtXbAOnINo9hFldGrfg
 vvXhBCP4AVkGdrVSGoOE0rlv/TZl23M35m1dXpioU8HSxrKVmlHLiQShNVBp5ugo6CE4
 wT8Q==
X-Gm-Message-State: AOAM530tCJLns/LU8yrPkmjW8cm5G7dekGGbQW6jGDFp6OcQ5Ch/C4ub
 heOzqVlYMNSo5JpwT1uh+VqdYsPtE8z5fOD4wf6JGw==
X-Google-Smtp-Source: ABdhPJxzRZzZx9swoNuRFJC91wxqjkKavFToVaKq3SBRQxnR3p+W7rilP28QUbgSGrGiXn2UbpMjulwPhL3ikNr9Pm8=
X-Received: by 2002:a17:906:2cc2:: with SMTP id
 r2mr1451111ejr.482.1599130403032; 
 Thu, 03 Sep 2020 03:53:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200902162206.101872-1-liq3ea@163.com>
 <b840aab8-542d-af43-43e5-0a07f442b5d5@redhat.com>
In-Reply-To: <b840aab8-542d-af43-43e5-0a07f442b5d5@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Sep 2020 11:53:12 +0100
Message-ID: <CAFEAcA9mvMaR5MJJ74Vv63TG6frWnMeSZA19Zxv8TUceudPUTQ@mail.gmail.com>
Subject: Re: [RFC 0/3] try to solve the DMA to MMIO issue
To: Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x642.google.com
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
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Li Qiang <liq3ea@gmail.com>,
 Li Qiang <liq3ea@163.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Alexander Bulekov <alxndr@bu.edu>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 3 Sep 2020 at 04:55, Jason Wang <jasowang@redhat.com> wrote:
> I think we still need to seek a way to address this issue completely.
>
> How about adding a flag in MemoryRegionOps and detect the reentrancy
> through that flag?

This won't catch everything. Consider this situation:
  Device A makes DMA access to device B
  Device B's write-handling causes it to raise an
   outbound qemu_irq signal
  The qemu_irq signal is connected to device A
  Now we have reentered into device A's code

That is to say, the problem is general to "device A does
something that affects device B" links of all kinds, which
can form loops. Self-DMA is just an easy way to find one
category of these with the fuzzer.

thanks
-- PMM

