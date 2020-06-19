Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A096C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 19:11:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 473FE206B7
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 19:11:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NYR9sONw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 473FE206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmMQL-00085N-I5
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 15:11:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60420)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jmMPV-00076u-FV
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 15:10:45 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230]:39760)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jmMPU-0000G9-0n
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 15:10:45 -0400
Received: by mail-oi1-x230.google.com with SMTP id d67so9367737oig.6
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2020 12:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=e1OcSWdHgEFlDU61HFAX9JKOODbejRaZjg+VNAIkFZU=;
 b=NYR9sONw2ToAQeJcgTlqYNZwR/+U41VjAAlm0bNXqoRhfP7TYqvNMv2LPXcfA00VkZ
 wYp4lYPbzT/30ljvalOJsgcY3Qw7JLtZBL7/dKxZUUw09DV8GR0HfaRArQWRsyDp/P1+
 VSbYPEknG4RDZ/8y7R+GdoXGRxTg6NLHknTBXjy/mknp4S0Ca+YZrQGzZ7ce4MmPYKlf
 pf0dEZdUpqAgxssQk3aXl1u4WupLqvM0fFvleCA4rlYQT9wLUqPeRrg3d3JONHgddQIm
 B2Kc8xF3kbgCDzg9Um6cBimGC+Sd7BVCyKMV6dAXKma85TR0Dhuj3XkhW/WZXiQNYbyM
 7p/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=e1OcSWdHgEFlDU61HFAX9JKOODbejRaZjg+VNAIkFZU=;
 b=o2hxX75OzAktsYSWzozuS3yvEtFtBF6xJsOVHUD2ypINE1A4YYRtYcD4+UF4dLebJM
 n+//BEZn8Lpl8mw3ROzcE0y8RnCltx4PUkkhKhtDFPgkiEbSvNtrOprjnjMJHdjT/70x
 JKLqFnSfVWu8JfnXBysgo4ymBQu00G5Ep9IxoUxwO+nW/MmxQt23lTZS7X1CutIom7xc
 Y/GN2RmWYC0aY8P8g23IxDvpeO3CpvaZQK9K+g83/QaNxPvXnJExp3QY1vXUnnIwjyf8
 lIakPRJR2P8P6pb+Z32OPZhti5/wF8zNowntGEunGasHG9UwlgS6pvj2tQuFNQByp2DD
 CpEg==
X-Gm-Message-State: AOAM5337W7AVF7rgESzxi41UMcI3gArsaWti8HYVAUWnEr+Ko2jR5mwm
 ayoT25BLEY1iltWFmnNdiwghwW+r7dMQutU3aB51Qg==
X-Google-Smtp-Source: ABdhPJxewMbANpY0pktdvGWMj94KI2JbvFXMpl9TrcSAJz0Y1V4ebZk4sxbxqjUwj/xeqgUdm500d2ZjwPZ+6AIxOyo=
X-Received: by 2002:aca:1a07:: with SMTP id a7mr4193319oia.163.1592593842984; 
 Fri, 19 Jun 2020 12:10:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAM2a4uyW33vsUTNMPpKN=S-obPWf+EZwS3TiznJgq4Av7R-3tg@mail.gmail.com>
 <CAFEAcA8LULxscffJvbDOTNyeSpZ0vkJoxgMWN1e5VDQ-ym6uYw@mail.gmail.com>
 <CAM2a4uy_TSumwp_LEUtewKyVPiiEVsxO9xd+-d+YkxPO1Exptw@mail.gmail.com>
In-Reply-To: <CAM2a4uy_TSumwp_LEUtewKyVPiiEVsxO9xd+-d+YkxPO1Exptw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Jun 2020 20:10:32 +0100
Message-ID: <CAFEAcA9YxpKVFZ9JZtArr4HE2ePTN0tS91cbDaApwND2PaEZqg@mail.gmail.com>
Subject: Re: Usage of pci bus
To: Gautam Bhat <mindentropy@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x230.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 19 Jun 2020 at 19:26, Gautam Bhat <mindentropy@gmail.com> wrote:
> Basically I want to model ARM structure as below:
>
> ARM Core <-- APB---> I2C Controller <------> I2C device.
>
> Is the APB emulated?

We don't model "you have memory mapped registers" type buses
at a level of detail where APB vs AHB vs whatever matters:
they're all just sysbus from QEMU's point of view.

-- PMM

