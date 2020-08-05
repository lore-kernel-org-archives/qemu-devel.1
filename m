Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEEBAC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 19:05:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA36A22CA1
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 19:05:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xrLUkmyM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA36A22CA1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3Oio-00015q-22
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 15:05:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60078)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k3OiA-0000WU-8t
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 15:04:26 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:46742)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k3Oi8-0003bR-29
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 15:04:25 -0400
Received: by mail-oi1-x242.google.com with SMTP id v13so23934659oiv.13
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2020 12:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=HVkA4GtPY9nHRy8TNBrSpNj+Za8pZISkS+dRzZ7Myaw=;
 b=xrLUkmyMWFPWqqosnYzwto6K+QgsyClnxO+MRq8teV8/8VoeKvG0hx//BTbNT4xRJ1
 vJOVU1a3HCDTDTX+dHzonFZHVGPIobvCAn5+IKkpujGy0AW0NE2j6+NCj0SnyOy+sXk1
 IGTKrN0KYi4I0eF8DPgoY7arZYpak3NZmmAqv/D3Gz/VoPB7yGuCRSrR2xZynvNEwLJH
 7kQjODJxbNZ5kjPOhJ/iwFER53JtIyf9+tn5b7f/qM5z7m/qBG4EobaRJygvDFaouIdS
 ADDqqB0R4NBzz7FypgfNUDER7w2+k1IkXcjnBI6Jkw4spIDeDYYXSxCj7JvMjzDnVXxe
 rGTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HVkA4GtPY9nHRy8TNBrSpNj+Za8pZISkS+dRzZ7Myaw=;
 b=sDJJTvhRYLFFoVXZRq8rt/gZrtw41NKaNLAHXMvLauvIE94OK9QkWCtetbj0WfDnV4
 u4sEhe1WkgQdgcJucM+U/i1MiF/h26xeiY4w33EH3VNNO0v3t3JFfVwr0hTVrT7sze7W
 wAEjw/p545kCIhoGywGKC6Jf4MWn/JhfJcDg5DRRw3usJO6bRTZdji4/k6oVQE7ts2aY
 oT/4YMvN+3D2D6DQwcxAVYkzAlStxEHlzZwoXpIVmhWDaZjrVMfYBkIOXxR2IfxIiuHb
 U944FxORD8bt5koGnvVpY1BRtRypKNipZsa0j0YU5rcFP8DzeoBv/30NfaIPKUaCkFe+
 TrIg==
X-Gm-Message-State: AOAM532/tuStApE3Rnj6LMdVk8+EwzE2+iNfJTEOdCXRZxhZcW0E65e0
 HLm3EGY+3QTRtMbv3TRenv2DdCZ8Z/dF15D/UTszMw==
X-Google-Smtp-Source: ABdhPJwvSu65hCJszv0lzZUyX4PIVE65nQeHFQJCqDY8hKlv8rau1wJHcSnhWIxGV3tTBllnbZtfE5oSoUQnqOEkkYQ=
X-Received: by 2002:aca:4a96:: with SMTP id x144mr3975116oia.163.1596654262673; 
 Wed, 05 Aug 2020 12:04:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200723025657.644724-1-bauerman@linux.ibm.com>
 <878sf3uojf.fsf@morokweng.localdomain>
 <20200730005947.GO84173@umbus.fritz.box>
 <CAAdtpL5Mtaf7Xwu74U33eGTCAiFZNNXeCST8COwQeW8S9j8ZVQ@mail.gmail.com>
 <87a6zh3uyv.fsf@morokweng.localdomain> <874kph58o5.fsf@morokweng.localdomain>
In-Reply-To: <874kph58o5.fsf@morokweng.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 5 Aug 2020 20:04:11 +0100
Message-ID: <CAFEAcA-Yi754zyxHd+bggjny5vXw=rrs5fm6SZCcxwVUeoTtOg@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] Generalize start-powered-off property from ARM
To: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::242;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x242.google.com
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
Cc: Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 qemu-s390x <qemu-s390x@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 qemu-ppc <qemu-ppc@nongnu.org>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Greg Kurz <groug@kaod.org>,
 Richard Henderson <rth@twiddle.net>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 5 Aug 2020 at 18:01, Thiago Jung Bauermann
<bauerman@linux.ibm.com> wrote:
> Any news on this? Is there something I should be doing? I saw -rc3 today
> but not these patches.

Sorry, you've missed the bus for 5.1 at this point. I'd assumed
that the relevant bits of the patchset would go into a PPC pullreq
if it was important for 5.1.

As I understand it, this isn't a regression from 5.0, right?

thanks
-- PMM

