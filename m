Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7333C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 16:41:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A39C720792
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 16:41:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HB/87LgF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A39C720792
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxvKO-0004C3-VA
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 12:41:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44754)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jxvJo-0003mp-Rl
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 12:40:40 -0400
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f]:39516)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jxvJn-0000li-9w
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 12:40:40 -0400
Received: by mail-oi1-x22f.google.com with SMTP id w17so17767629oie.6
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2020 09:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=plu2HwQJQZokvM/jWpyBIwtvgf5ckfDp6FWH8McBRrE=;
 b=HB/87LgFwX0xD6e7alFpil/ZBH97KErBNI5ZOTgWJnEvZJu240Jv5V+5kJ/4Xd1DCp
 FKU6a8z40QM8yNg8Jo9UWWls2qrYsxPufaf8eLNHsFs1FYGWpoItVSmTRs8SS0/AlXOw
 eXb5ca+QZuyBOyNV7cpWfhmWTOr1uk7+vaSPHHqexEYf5qQWbEMKftQuYgfMVmesV2BS
 dsGktf+CmqJ7BMPO5gtZEJxFtNJuexRkmrEgAFmOGIls+duRQXGGR0X0RJf+oyUgoJuO
 KV//L1OzuJisMsy51ii2YQTXJwusIpqBsCtYI+S4ii8dGNW8zaLvlw7dj2n7MkJsDeAh
 aspg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=plu2HwQJQZokvM/jWpyBIwtvgf5ckfDp6FWH8McBRrE=;
 b=IoWJVR2JEYy6kP7ARI1CzAxDgEhp6ypJG7IAYG40/xV1NdCsbRpV/yHoDkBlDkQicA
 ukIJMWDr0vTlb3LL/OXaGgC1MkRkaAjT4s9DCyCDYkqksIdQ6RHS4eXCGt5a62IxO1Xv
 kRi1CGJiGTczrcc4f8zPu1+S++tSnhaxs5gh2P4mVmrpzXdkDp38cwG9oiCqFSTO6zhi
 /pTOHunKlvRTrjTYDzUjKkxurUGZX6SMOUKusypTRpWww8sV3OMxL4u1jolkYCQVSXW1
 xMlMv3TQEfeQrIQDpnhbZP8K01LP8qbthuqNG2iQPXHRkHBxa9RBiCOf5zc4vpie88dK
 YNFQ==
X-Gm-Message-State: AOAM530WGZ2sEc1H0yu8OsgoI94oPnMl45HRdyizcTahcP3L3TqX19dq
 9/wZxmgQw7NFnOCiNtwXgKrK2rnh3TMIq1i6I2Grv3xwoPY=
X-Google-Smtp-Source: ABdhPJz1LZD5rL7D2zW2rTfcCSZim5I0GyScVGAMigAEqVAfDhkWHwERbe4sLEPIAvmRo1HDScx4Bpw5srZvf08Aru4=
X-Received: by 2002:aca:54c9:: with SMTP id i192mr3775621oib.163.1595349638155; 
 Tue, 21 Jul 2020 09:40:38 -0700 (PDT)
MIME-Version: 1.0
References: <8f5a171a-59db-f5d1-477c-1ddf7af45da7@redhat.com>
In-Reply-To: <8f5a171a-59db-f5d1-477c-1ddf7af45da7@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Jul 2020 17:40:27 +0100
Message-ID: <CAFEAcA8b3N+oxAAW3JEKGTtsZezXTOFdnu9Hm1MYK=yURTfVsQ@mail.gmail.com>
Subject: Re: What is TYPE_TPM_TIS_ISA? (Not an ISA Device)
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::22f;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x22f.google.com
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
Cc: Eric Auger <eric.auger@redhat.com>, David Safford <safford@us.ibm.com>,
 qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 21 Jul 2020 at 17:07, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> Hi Stefan,
>
> I'm trying to understand what is modelling the
> TYPE_TPM_TIS_ISA device.
>
> It inherits from TYPE_ISA_DEVICE, so I expected
> to see an ISA device, but then I noticed:
>
> 1/ it doesn't use the ISA I/O space, it directly
> maps the device in the system memory at a fixed
> address that is not addressable by the ISA bus:
>
> #define TPM_TIS_ADDR_BASE           0xFED40000

Why do you think this is mapping to the system memory?
tpm_tis_isa_realizefn() does:

    memory_region_add_subregion(isa_address_space(ISA_DEVICE(dev)),
                                TPM_TIS_ADDR_BASE, &s->mmio);

which puts it into the ISA memory address space.

The weird thing about this is not which AS it's
going in but the fact that the TPM_TIS_ADDR_BASE
is way higher than an actual ISA bus can address
(so for instance it's out of range of the size of
the ISA memory window on the Jazz board).

> 2/ it is not plugged to an ISA BUS (ISABus*)

Won't it autoplug into the ISA bus if you say "-device tpm-tis",
the same as any other ISA device ?

> 3/ no machine plug it using isa_register_ioport()
>    (it is not registered to the ISA memory space)

There's no requirement for an ISA device to have IO ports...

thanks
-- PMM

