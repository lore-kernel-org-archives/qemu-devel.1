Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A0CC43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 13:25:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24FE1206A5
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 13:25:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="atQ/Ghuy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24FE1206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG06g-0005lQ-20
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 09:25:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60998)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kG04g-0002Hu-5M
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 09:23:46 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:46471)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kG04c-0004Xb-H0
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 09:23:45 -0400
Received: by mail-ed1-x544.google.com with SMTP id a12so2586991eds.13
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2020 06:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=WZ34cWNxEE29ZHGeDca0Y5fIi3J8/dynHLnNo8kKlfY=;
 b=atQ/GhuyMtltCF4TDWd51HwygjimAA+n6tlAw0K8ssc+8giV6gTYBJR+LfSeTIYI4L
 8K8yWQ1CHMkOfemuFc2VzuCFpEQGN9DdVj2K17ubUaGC3burYAMqRj3bj0TI24RYJFfn
 JNbFOFncgA9CKMIDCgmZha5ufAxSjZiLZ6iLm3vZfhCJ4aDArBUwT0RQ/U7Y/X8mR9wy
 ibCHHv6UBlLyOxDhXn1piJQJmF789Kgdug6Z9Sp8GUWRElhFISvu1lmTzUFyC/K6C188
 k36F2fVLk0TNg7ebUUCA31ZarFkt3tqyPtPx5SFrNL5kN2bfHRPXGPbnfu+S4urJpYJN
 WvSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=WZ34cWNxEE29ZHGeDca0Y5fIi3J8/dynHLnNo8kKlfY=;
 b=mvnCe0Vwj/A/ANwttjWiTOA5/2QDuz5JLYARDk1qqM4m+DLoriEpMI+8BAMPg3mLSW
 kkY8rk4iCvrXmIopGa9n/3O/O3T7CnWlRcH6Zy44c3o6+8MAX0s/421wg/wVPWSHCXE3
 C40XgmVsqN9JPzt+E5LLruR6wx+vjRBrLZ6Q0it7PibuO4dJBDvm1c2tDNi51j0MyW+m
 LASyYIuEN4OXOQwsb09o4DNexjrwG3jhzyLbbBR0Lvkm0u56W/18ZesC6PH7B5vJyJVG
 6TULz3r2u2CUb6QlhFmtRVHcgQhPdXa+tawqebYrpGhaJm6fOuoe8ZYJbK5bAm0iumBv
 rRUQ==
X-Gm-Message-State: AOAM533wEDgwjqvCTtrRcu/aIX60Pk2V/rleieLzpRvNdW/U8OVNQc+v
 j0kvzSFhzYKMUYrxCVAPMjFNpJ49tgWYDYh22nPdGA==
X-Google-Smtp-Source: ABdhPJygNJbATGXF+zO6AkNkPSnZHbsE1M0uY881G0C8iFlDyftZFe8ljiDDMU75WZC+xxSP0vDXgEV8diId4Bg+KKU=
X-Received: by 2002:aa7:dd4b:: with SMTP id o11mr3944277edw.251.1599657820411; 
 Wed, 09 Sep 2020 06:23:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200903110831.353476-1-philmd@redhat.com>
 <20200908143725.GD7154@stefanha-x1.localdomain>
In-Reply-To: <20200908143725.GD7154@stefanha-x1.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 9 Sep 2020 14:23:29 +0100
Message-ID: <CAFEAcA-Ptc6_jQCna8+BMM1DOY-A+-b4toJiAm8z-9nzwJiDcg@mail.gmail.com>
Subject: Re: [RFC PATCH 00/12] hw: Forbid DMA write accesses to MMIO regions
To: Stefan Hajnoczi <stefanha@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::544;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x544.google.com
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>,
 Qemu-block <qemu-block@nongnu.org>, Li Qiang <liq3ea@163.com>,
 "Emilio G . Cota" <cota@braap.org>, Joel Stanley <joel@jms.id.au>,
 David Gibson <david@gibson.dropbear.id.au>, Laszlo Ersek <lersek@redhat.com>,
 Robert Foley <robert.foley@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 Beniamino Galvani <b.galvani@gmail.com>, Eric Auger <eric.auger@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, Peter Chubb <peter.chubb@nicta.com.au>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Tony Nguyen <tony.nguyen@bt.com>,
 Prasad J Pandit <pjp@fedoraproject.org>, Alexander Bulekov <alxndr@bu.edu>,
 Andrew Jeffery <andrew@aj.id.au>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-ppc <qemu-ppc@nongnu.org>,
 Klaus Jensen <k.jensen@samsung.com>, Jan Kiszka <jan.kiszka@web.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 9 Sep 2020 at 10:12, Stefan Hajnoczi <stefanha@gmail.com> wrote:
>
> On Thu, Sep 03, 2020 at 01:08:19PM +0200, Philippe Mathieu-Daud=C3=A9 wro=
te:
> > The main patch is:
> > "exec/memattrs: Introduce MemTxAttrs::direct_access field".
> > This way we can restrict accesses to ROM/RAM by setting the
> > 'direct_access' field. Illegal accesses return MEMTX_BUS_ERROR.
>
> QEMU needs to simulate the behavior of real hardware. What is the
> behavior of real hardware?

It varies, depending on the hardware. The most common thing
is probably "happens to work by luck", which is OK for hardware
but doesn't help us much since our software implementation is
naturally more serialized than hardware is and since we don't
want to allow guests to make QEMU crash or misbehave.

thanks
-- PMM

