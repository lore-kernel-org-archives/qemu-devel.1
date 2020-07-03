Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5CEBC433E1
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 13:03:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3FE0206B7
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 13:03:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RyQw7N4V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3FE0206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrLM0-0005DW-Uz
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 09:03:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40424)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrLLI-0004Zc-He
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 09:03:00 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:42841)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrLLG-0004k4-Te
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 09:03:00 -0400
Received: by mail-oi1-x243.google.com with SMTP id t4so8615871oij.9
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 06:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=rBgxuHCHS3fxFE2hat1Uonsm9BPtmcuF+c+sPALMllA=;
 b=RyQw7N4VBpCwlzM+lf5RRrWmIrNQRDdCs2QMXh8d/dGePq4NtK3pB8hHFvbEnqS/6T
 wCbcPIyZQy0PG66XLsZjEVY4bMX/qg/hsVotnXH6Nz0+mRS2rZmmPAPY6CIMgx0wY/2j
 8BHmQ56/uJRm3MvLJ+5waBqXPmrzf6ehHZIwpyS+5/6wI8ABJgbPRaSpNQrSofWsucvZ
 ROT82T0UKIpdd6cXcQ88NiJ5ZsTmlutIjt+W0BESN4yiE+uqhuW5Amr5tn7m2KihitEn
 d9+y+Ga09KAZ8ubQmP/BQNGADergUPsA3kxso9/4m+4GdoWcKq1tzKRqvBCUv478WL/G
 2+cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rBgxuHCHS3fxFE2hat1Uonsm9BPtmcuF+c+sPALMllA=;
 b=q8BoiQlUpFdwtQH8+VSM1MC1Rs3derzDtYLM0vpLVGJMSML+zzi4yWctsHnM5sdRD3
 RSBP3qyvWAJD2h2GMp2FFNUZ3UmxhHUyU8XdUfMdDHzXa6B+wpKv+fWx4UHXebSWbx9s
 09yUIRA310IEVXJXIrdKVuuuD4w0lztXd99e2X/qwmE+ycuZDzY4sEjYCxQwxJycbsg7
 IxrW1hH1yMBxFyAn6+jUt+PE0ENSrkxSjNw295uQGaImoPu9bdEyO09Yf+93JApbsIB9
 2J/S8vIXI6c6u0NT9D4g4xhe3MT+nKX/QWTNCl+0lFjLwH361dLOySaKwjsy+0DmmMpu
 w9bw==
X-Gm-Message-State: AOAM5315QUlh3LTRnMuRCB3LKGmQK5VS4umZ7Q6DVNGJFVPAnMbV7fkK
 FSlayaSg4UGUnBGL/SGT/1DGxw/rV0SKtBTz9ePT8A==
X-Google-Smtp-Source: ABdhPJwrMuCc1BRGHuE1p6gdQwT3JsTXJGoxkw6kzH+9Qepfs2xjL1P/Hsyn4o7gOv4ehblYbI6WwQSyrsZLgYiYP84=
X-Received: by 2002:aca:2819:: with SMTP id 25mr21027392oix.48.1593781377711; 
 Fri, 03 Jul 2020 06:02:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200629140938.17566-1-drjones@redhat.com>
In-Reply-To: <20200629140938.17566-1-drjones@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Jul 2020 14:02:46 +0100
Message-ID: <CAFEAcA_zb6DxEV6voPVSPy0ZrtSF6Wr=atkH_r-GuHa-fF2CGg@mail.gmail.com>
Subject: Re: [PATCH 0/4] hw/arm/virt-acpi-build: Only expose flash on older
 machine types
To: Andrew Jones <drjones@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::243;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 ard.biesheuvel@arm.com, Igor Mammedov <imammedo@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>, Eric Auger <eric.auger@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 29 Jun 2020 at 15:09, Andrew Jones <drjones@redhat.com> wrote:
>
> The flash device is exclusively for the host-controlled firmware, so
> we should not expose it to the OS. Exposing it risks the OS messing
> with it, which could break firmware runtime services and surprise the
> OS when all its changes disappear after reboot.
>
> This change was suggested by Ard and Laszlo.



Applied to target-arm.next, thanks.

-- PMM

