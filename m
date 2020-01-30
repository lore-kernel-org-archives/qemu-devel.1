Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF73C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 13:42:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 488662083E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 13:42:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="joTB+Zoo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 488662083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixA5b-0007As-Fo
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 08:42:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49070)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ixA4D-0005yC-2P
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 08:41:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ixA4B-0003XC-KK
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 08:41:08 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:38680)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ixA4B-0003Vq-Dl
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 08:41:07 -0500
Received: by mail-oi1-x242.google.com with SMTP id l9so3505567oii.5
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 05:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=ut6Se2R8QN544z+VLTdjev2SS9Vm3bNo+oL5Ci2TgM8=;
 b=joTB+ZooBZUxaooP5gpi1099q/YM2UxHrRs+5C2MPudTBxP37fBW2fpJNIaQF2dDNB
 qW+6DgK2+LrfrCh91+qz2SluoryYniBWWr9H7VMfTwkjU5ihRifAR8PV0hcd/d/w9doH
 4ab03DSZ1MiI++2Tvzd1M6M/pumW3j2kOuLX/I/5yzsQLsqCVB+NqrSmaliIL1evJzdi
 tz2rZAVgUvR1nQ4FoSPqtXIyh/X7Pjh1KcfBnFNetpkQ2DiZG/h84h77hTR+hqKmEuN8
 WbYCZ0MSO7UABpFgTUUgqep6p9t4gCS/Wpj51YyXOjCaR9FGNP/tZ1QEE77RAfwiVkIv
 UfbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ut6Se2R8QN544z+VLTdjev2SS9Vm3bNo+oL5Ci2TgM8=;
 b=j+FyRN3iIg/EqNFMVL3YE1tcXCo7ZsLDSSyk7yKo6cwozdnv04sY8F8k7OWvM9lamz
 p5hzF01xJ9buF1T69Ywlckz35al6MhBqxnIK/Up1YI2ohdVeFLe/CnQRG8UxTWMs7CcA
 dPSAHEAXo0pQ8Vjm5ozC9m5rDIDW+Sit9av/6ukPdgE2Iu/BgHVhUNm8tbxm1gS0SB3A
 8kChhT60TijPZGVx5DdAo1/9LM6MHRzyGl569NHhPdhZzoX+xw6j8kmgaX8W5RKXg17h
 pG3YfGeNXAt2/Jl7rbaHOtpHBbvfSULzHOlp3RCIUEHVD0XDi+Lh83p3wDAdTvBe4Oml
 JCTw==
X-Gm-Message-State: APjAAAXZHgd27ybXWFuLHUOV58mKhJFlg4rnrWfuBxq7iBqR4DGEA3SN
 TAVBP1GjXm99R0pd4dQkC+9+dXBhNdpvrqhDhmEBkA==
X-Google-Smtp-Source: APXvYqyeG1OopE0kX9A3xHPadBw6m0Q+i5VckRza7aCBskGN2+9UkvBT9Tl+aUgj9ZbMbHO9eddZhE36BBnWUOoCbXQ=
X-Received: by 2002:aca:b2c5:: with SMTP id b188mr2874648oif.163.1580391666479; 
 Thu, 30 Jan 2020 05:41:06 -0800 (PST)
MIME-Version: 1.0
References: <20200114103433.30534-1-clg@kaod.org>
In-Reply-To: <20200114103433.30534-1-clg@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 Jan 2020 13:40:55 +0000
Message-ID: <CAFEAcA_M=xmh7CNT0RjQoORTBcF3LKt7o__J4HCOAC_KG4t6nQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] aspeed: extensions and fixes
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Joel Stanley <joel@jms.id.au>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 14 Jan 2020 at 10:34, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> Hi,
>
> Here is a short series adding :
>
>  - a new eMMC controller model for the AST2600 SoC (Andrew)
>  - accessors to control the led state of the pca9552 device (Joel)
>  - a 'execute-in-place' property to boot directly from CE0



Applied to target-arm.next, thanks (I fixed up patch 1 to
use device_class_set_props()).

-- PMM

