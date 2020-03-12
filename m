Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F1CC10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 13:42:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89F4420650
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 13:42:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cCgHebz0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89F4420650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCO6J-0003JA-PJ
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 09:42:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55772)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jCO5d-0002dc-CT
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 09:41:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jCO5c-0002Cs-9Y
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 09:41:33 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:35674)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jCO5c-0002Bv-4t
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 09:41:32 -0400
Received: by mail-oi1-x244.google.com with SMTP id k8so4042909oik.2
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 06:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=a32ZZEX/gCmST/AYs/6Rmu6wb4d+7oXusEcXRkcl8sE=;
 b=cCgHebz0/J7fQat7z1XmtWnPzPhHdwtheCnBsVxlbmxq/qi4zZm27pzjbYuC20tvFf
 iTyeCX9BqFzFNzP/z1ot2CtNS2na9gQt4SIteN9w7otMa50KN0th6l0ABGlGoU3MoNuG
 GhTWEUWKKHRc0SLc8y0u2o/U09PmOVyW/5frgicjjZGy3lnYiSKtIBj8wR0BtwVFfDVc
 9XpXMMXEXa7ppctOI9UwKvs2IKdHz+C1QfnwDRQZJ3onJY2MVCv7hiGkt09LqAz2zAHf
 2zyVRgIw5AytQqDLbZSWnrTuT8noLD7dxPQS8K5bg5lUaj/l1SqUJ/VLqSb3E6+op8A6
 Ud/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=a32ZZEX/gCmST/AYs/6Rmu6wb4d+7oXusEcXRkcl8sE=;
 b=KEC9SO0K628AhwQBSw0cO7Djm6YpyirXch4XNVa0Ae1QNrvHSqK3Y9wFQYECzvW5AJ
 urgiTjWtOucL0JxMcAp6ufWA5HTPcDECTDuyL72dd5xyRcHK/2U/FulRe9FQKHTWZbsh
 cquBCbfst9pl8Ub8OnRBwyJdERXHHGxqoNSlwhxz1k3Fc5Qh5swUfP4WMFRSsmURRG7h
 ri3cAZBMKn/LSkH5c2mSOP5JXrwUex5pp6lixAWlVwXIVqMX9nf5X/kNQImg65WcUJ3I
 0QmZfdLQzwp2wK8ydzQRSazF5v5bnQ3d7tETZtpY9OY1IeG8wSVbOfiNfIfqeea/hedI
 fy4w==
X-Gm-Message-State: ANhLgQ3CR+UcjHvekGVJR/d7cMIoRRUN4C8ObPV46h4JzNN6d9y39b1c
 CpbVq1YVsv3e86b4OlPpL9SG5g/ytC+rfJiRD9425Q==
X-Google-Smtp-Source: ADFU+vs9gBlVZFpcZnmS3uHkTEC/E1y1CjfkyW2UHDhEmlSfMEVfcgJ2YgPvPl6fgwO752JSLDrSDxdjBJzIoqPksAY=
X-Received: by 2002:aca:c608:: with SMTP id w8mr2720087oif.163.1584020491007; 
 Thu, 12 Mar 2020 06:41:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200310215146.19688-1-linux@roeck-us.net>
In-Reply-To: <20200310215146.19688-1-linux@roeck-us.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Mar 2020 13:41:19 +0000
Message-ID: <CAFEAcA8LM1bVGMMSAzNXGOmckah71MHQkUFyrhFbAMNqqeSCgA@mail.gmail.com>
Subject: Re: [PATCH 0/2] hw/arm: fsl-imx25: Connect eSDHC and USB controllers
To: Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 10 Mar 2020 at 21:51, Guenter Roeck <linux@roeck-us.net> wrote:
>
> The following two patches wire up eSDHC and USB controllers for fsl-imx25.
> With these patches in place, the imx25-pdk emulation can boot from SD cards
> and from USB.
>
> ----------------------------------------------------------------
> Guenter Roeck (2):
>       hw/arm: fsl-imx25: Wire up eSDHC controllers
>       hw/arm/fsl-imx25: Wire up USB controllers



Applied to target-arm.next, thanks.

-- PMM

