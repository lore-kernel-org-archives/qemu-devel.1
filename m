Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A7CC433E3
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 08:52:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7450A2075E
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 08:52:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WyFVHx4X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7450A2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8gJ2-0008Ui-NG
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 04:52:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53326)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k8gIS-0007rU-ML
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 04:51:44 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529]:41296)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k8gIR-0007R1-44
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 04:51:44 -0400
Received: by mail-ed1-x529.google.com with SMTP id w17so953824edt.8
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2020 01:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ooNIC3nvLKAvUNQsUDQ4OWBPsf1vNEmKaddWXjNIcNc=;
 b=WyFVHx4Xe1BVTvjXQiPL3eVYFFelIiSVE8b9HyLtrcfJiJltNqQjrTO2yBsBq5B/ev
 SloOmSFej1xXkqjtuBgBMYMRDul7evjUOw+uGO9kIrS2BJF0IbclhxKwOaUSZ0GaoVmL
 LbT3Hwpx1sdrQX98VZ9P4aSL/bsxrCxFjq+ng3G570ekPlZlk9Jo/WkIn0Yuqpnhg9U4
 RRbY9QYJzg5reJyCUxWQx+28MiLlvCendaI+ZVmkKbKXsiaxMhTucvwjle/tJiN6zFfz
 c19AgbbXIu/L7st1QQ/f7N9EVS3x7PQzaa7ZckeunkaqOEYa1ygYUv8ViJq/IG2tfMhB
 lLYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ooNIC3nvLKAvUNQsUDQ4OWBPsf1vNEmKaddWXjNIcNc=;
 b=h4N0P6qQw8b/2hhWzuoyC6dFiNHuO6HD5i2B4EJmJ7plp+tSHh4U4z3EaVr5C1mppQ
 9SPonKk3BFm0M+8XDWODnUh+Tl/xSx2dRqSzgpO4oiWjCqSy3kPOQ2as1U/FpyIB1pMj
 fygzCeiAFWdbB+RO/R2d9IIfwljdeu/dBhN1JvAJlSBgF9w8u/hsCu1/336rtpVPQNrI
 wLW+2m6HPUun4ev1E+Ybazslz7JAxZC3aTmuuTRwXukq1tH5+07QrPpBYYMurkNyjY2r
 X9/W6hQ2SJCWUW0n2yTUi6sIWymK9XjRqJbXO81YauKNMcQqPi3wj3bWdMTWLC4TIE0l
 bT1A==
X-Gm-Message-State: AOAM532k+Z6zFi606qwm5Vwjg3EpGKFfLXws4FGFnRy/oPkZ4fHL7H1F
 5tRoeTOiqLtPxr8dbjZUjcKhAVXyNUkvxkiPGISg8w==
X-Google-Smtp-Source: ABdhPJzKiCU89tGKydt+uGc/9xOBOF8pznLsU5hd6A7CLgFcyA1HoeZdN7U1Ex0mR11LfKSdSAWsAZrfC67zXuUOBWE=
X-Received: by 2002:a05:6402:8cb:: with SMTP id
 d11mr1962766edz.100.1597913501383; 
 Thu, 20 Aug 2020 01:51:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200819143525.2175-1-pbonzini@redhat.com>
 <CAFEAcA_8VJecDyK8FR0ty=pknmo+Hc5s0OFj+-Y1Ah-OJ01FDQ@mail.gmail.com>
 <5d247082-4928-b47c-76c4-c366a9421e1a@msgid.tls.msk.ru>
 <CAFEAcA_YU8QY_VRNdXmBV=YKuBFaX=scT0Pnk1F8JBWrrbsbJA@mail.gmail.com>
 <72597e7a-6ee2-9875-536d-c5cd2d81950d@redhat.com>
 <CAFEAcA-RF4T43zeNMBb_NWaOqWOVS6H5iiRN4s4ocvnGgN65bw@mail.gmail.com>
 <627b7282-5e3f-f53c-28db-ff7afdd3bf9e@redhat.com>
In-Reply-To: <627b7282-5e3f-f53c-28db-ff7afdd3bf9e@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Aug 2020 09:51:30 +0100
Message-ID: <CAFEAcA-rWmj7SUndoFKUhC_vg4EqRbUwDGuT1ipFGFAQqbVX-Q@mail.gmail.com>
Subject: Re: [PULL v6 000/150] Meson-based build system
To: Paolo Bonzini <pbonzini@redhat.com>
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
Cc: Michael Tokarev <mjt@tls.msk.ru>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 20 Aug 2020 at 00:20, Paolo Bonzini <pbonzini@redhat.com> wrote:
> My complaint was only that, until last week nobody even tried to apply
> and make the patches, and therefore some of the input I got surprised
> me.

I think from my point of view I've been surprised because my
impression as somebody not following it closely was that the effort
apparently went very rapidly from "experimental effort" to
"this is ready to apply". Perhaps it caught others by surprise
in a similar way.

thanks
-- PMM

