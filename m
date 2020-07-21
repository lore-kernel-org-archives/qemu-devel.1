Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E20C433E5
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 12:44:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78D83206E3
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 12:44:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AbY1KE5p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78D83206E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxrdi-0006eB-Ly
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 08:44:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35022)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jxrac-0002sP-6c
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 08:41:46 -0400
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233]:35966)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jxraa-000541-F6
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 08:41:45 -0400
Received: by mail-oi1-x233.google.com with SMTP id h17so17076979oie.3
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2020 05:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=lYLSXL4nPfA41p6Rc9qYA+MGSDuAwV+OcL/Q5VR+lYs=;
 b=AbY1KE5pTbpdVWAmI1K7yz2Z8MgRD5qFZHatSUCyp5zVHB9jm+wEnppK13RcyB4tP9
 aGwIbIye0pVJdmxyBHkfdrq0MGNW/Cv0O0K37NUse+/55QXScAx/y0Slr2bSl1UWeJH9
 CcD+t5lPGX401X+oBBA6k2yUFGavgrwOSyyjqoooAcYYNnFzGxyLfYkjqKjcj8Gj+cat
 KSQx7Ng/+Rhc8ZVFa9wegWLtD98lsQg8+XleRkzSDV1AznErGmIjnnCdDMtaWdU64RsH
 MRrIOS+Dgea11eigo4EvF/u0IbOpSpmazT1WDv7FPVwHztwuvUZ2qZKThXPKftNYYNKs
 wQ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=lYLSXL4nPfA41p6Rc9qYA+MGSDuAwV+OcL/Q5VR+lYs=;
 b=iBbBfa18yU7PnKmTEzx0b3B7jxEwV1D3Jj2tllX69QMzHygcjMle6FsuDO8iDLXSxL
 BZ6tyeo68ArsKkZQZbmhLRiL0V3pq8208U0TAO/HmkB7hLaHB3j/MiejCaC8NuOWJM/P
 lR4yk1poowzigg6sTTI6c5Ewh43a+8bv3ZGERr0XfGm4WBEvQ50FAkblXkB1kCqOmY0/
 Kb5K6qNClyw8cd/qHSoT8eN41ThwtbFy/iLLrtZF82yc9NqjBJ0ypzLsubB3o1Scbpx5
 OMaFpU8b5qB2dNOhafSvC1IYObmoLX/m6tBacmwSqs4FuuppUUunjc5TfbULBO5I0hZp
 rNHA==
X-Gm-Message-State: AOAM533M9SOYgObOo92LpOJrkYBPhOm1VTfAa45ZBFyfequzL8WTCL2i
 Puoi4symVRj24M8zrdrmpEVjt3kyuGa9IOaOFX77xw==
X-Google-Smtp-Source: ABdhPJx0NjePBqwM2/v4NA9CrO8vfydRl2j8I/Y5O8CjfBepAWo35r0LffYCWgF40n5834Er8/nM9FoB6T6sBjRY+w8=
X-Received: by 2002:aca:2819:: with SMTP id 25mr2633776oix.48.1595335303205;
 Tue, 21 Jul 2020 05:41:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200721123154.5302-1-f4bug@amsat.org>
 <20200721123154.5302-3-f4bug@amsat.org>
In-Reply-To: <20200721123154.5302-3-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Jul 2020 13:41:31 +0100
Message-ID: <CAFEAcA_Xz4OPGEx5T5aoWaW9-G92ioS-jLt1B_vFYFS+s_RkYA@mail.gmail.com>
Subject: Re: [RFC PATCH-for-5.1? v3 2/2] hw/isa/isa-bus: Ensure ISA I/O
 regions are 8/16/32-bit accessible
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::233;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x233.google.com
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
Cc: "Daniel P . Berrange" <berrange@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 21 Jul 2020 at 13:31, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> Since commit 5d971f9e67 we don't accept mismatching sizes
> in memory_region_access_valid(). This gives troubles when
> a device is on an ISA bus, because the CPU is free to use
> 8/16-bit accesses on the bus (or up to 32-bit on EISA bus),
> regardless what range is valid for the device.
>
> Monkey-patch the ISA device MemoryRegionOps to force it
> to accepts 8/16/32-bit accesses. This should be reverted
> after the release and fixed in a more elegant manner.

Do we need something similar for isa_register_portio_list(),
or is that function OK ?

Do we have a view on what the 'more elegant manner' would look like?

thanks
-- PMM

