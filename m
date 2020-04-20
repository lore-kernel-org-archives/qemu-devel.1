Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83954C3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 09:04:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EC19206B8
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 09:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k69KqVa2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EC19206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQSM2-0001AD-Ek
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 05:04:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33772 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jQSKf-0008W9-4g
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 05:03:14 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jQSKe-000720-B1
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 05:03:12 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:34601)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jQSKd-000710-N3
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 05:03:12 -0400
Received: by mail-oi1-x243.google.com with SMTP id x10so8159083oie.1
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2020 02:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=pmDtXQVBA/J/84N0HPePEXf/5fmclCdstH2yA26a3ag=;
 b=k69KqVa2Qt2GbpDUHyDTA+ycMWvzQLdwbKzm9ReZk6VzS1tXfH9QKP0AYFRk3WibzH
 dnU8Yjcssy+fGqRXnWomvKLjn/o3jEd35GAwEOE8vL4qV6gX9Gdqu9paK9oVA0phHIKx
 JcXLkHKdXFZsES6QrYkvJRuS3Y5dvG7izCWBSsLpU4SAzm/LCRHOVf+S1wOLTKRihFNF
 D5+5UUbkHpifwddtan+3XAdR6pCptlGp8w1yYv8FRUlWbyZXFRwfJ8h5kj/tzmDsQq4y
 OTZ9HveMy2bIjYqWxDEoDzBY/RxMsIxguHSdxvW0iBPuRvxl9PIOdWS0cSncrV9Vd4R7
 w1Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pmDtXQVBA/J/84N0HPePEXf/5fmclCdstH2yA26a3ag=;
 b=VBjDTcJhZvqP6L2ds+5krkTZaLmmT7aT6TEaYfeoVqI/qjCr2dxg1ze72yNZ71Q/rC
 Pnd4v5Vr/YNdeWum3MOuyKu+gLjL4540Lwu7o+zD+g3lR5jcwKxGaGjPPeh+pABwrHCv
 trBM/9qwfYDhsoDkndPV9WZ89uhj1+0p8Tu6CECEAiLrF7EHXkfJnP2qDdbvqa5AQhIQ
 qy0uHSwlIjAX7hFHpe/3CvNACOqn84CWL1SRnkAJYbm7VCcf3fbw0MvMRpYaa27vC85I
 Peyn+0BHfQxNxpiVtpUQow/sq9uSAPXxvr8Uby6fdWk+zKvy8DZHrLnIn6pq9FrA9B6c
 r1jA==
X-Gm-Message-State: AGi0Pub2Pi6+euevUd6pe+De8fDoVz3tzfao/TDcmbeX3YQhNFYt7dWZ
 9+Ubt0b3uKu51Juhcs22tObLeNPCh+0JT8ZlMJlLvQ==
X-Google-Smtp-Source: APiQypJwvR5Ey8fvZKIQ8AuUpQWIcbzon9d0D0GvwLsfs7kR4oYlZSWXhUVIUld8O0cDHlNtTsJA4GW97c1QEGpTG84=
X-Received: by 2002:aca:dc56:: with SMTP id t83mr9321432oig.48.1587373389863; 
 Mon, 20 Apr 2020 02:03:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200417153800.27399-1-edgar.iglesias@gmail.com>
In-Reply-To: <20200417153800.27399-1-edgar.iglesias@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Apr 2020 10:02:58 +0100
Message-ID: <CAFEAcA-F0Y+_XWCgBhaHxk2V_MwiSRSp1oTX+KeaJYnP+A0A0w@mail.gmail.com>
Subject: Re: [PATCH v1 0/1] hw/arm: versal: Setup the ADMA with 128bit
 bus-width
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::243;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x243.google.com
X-detected-operating-system: by eggs1p.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: figlesia@xilinx.com, Edgar Iglesias <edgar.iglesias@xilinx.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>,
 Francisco Iglesias <frasse.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 KONRAD Frederic <frederic.konrad@adacore.com>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 17 Apr 2020 at 16:38, Edgar E. Iglesias
<edgar.iglesias@gmail.com> wrote:
>
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
>
> Running more testcases on the upstream models I noticed that the
> ADMA was not setup for 128bit bus-width causing some tests to
> fail. This fixes that.
>
> Cheers,
> Edgar
>
> Edgar E. Iglesias (1):
>   hw/arm: versal: Setup the ADMA with 128bit bus-width



Applied to target-arm.next for 5.1, thanks.

-- PMM

