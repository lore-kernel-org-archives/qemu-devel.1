Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E3EC2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 12:00:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FC38222C2
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 12:00:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VDF0hbxB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FC38222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2DAI-0001MX-Hk
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 07:00:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36177)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j2D93-0007u1-Ti
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 06:59:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j2D92-0001Rm-Ub
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 06:59:01 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:42350)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j2D92-0001R2-PY
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 06:59:00 -0500
Received: by mail-ot1-x343.google.com with SMTP id 66so5272126otd.9
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 03:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=ZIUotafDXfUwGtFzakVHbdga+VmjUYxpyzlK5Dq85yg=;
 b=VDF0hbxB4RMyEIGjJArqQqwBtT9cHo8aVz2lSZ8RWEDDN73O7/0665HmZ527ojn/uk
 s6vy8op9zOmSRmIlTxgN/rvQ9qJwGa5uPL5b34ZMAcI35NHL9MsHAWk78PgNRpJpTmTv
 aHl4IVY19lQCd4KojU+kwbkUzcwFkp6bhjd3ig4OCUCuE+y1GR/0agrBJl0DBwsiuqho
 tiKSc75W2i19pNqXcm5ovMhjKtTBjU7EsAZ0E2VnGhnaUQ2f5EAHXhlnbiDXVMiM4TPd
 DTR7cwN3Rp6vvb0vIfYnwlo+A/OoNIV5OhIuNz18/257irA8cxLQLC0im8lSo/MzN76g
 aVKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ZIUotafDXfUwGtFzakVHbdga+VmjUYxpyzlK5Dq85yg=;
 b=r/Z3+fcTJB+z3CXJ/eiLBcdFL2EH8M21JErifhMx2smqGDS1uCx0eyb20bRucLO3IE
 E60zt2B999ZZOKD/2C3aO2K7OU72u9jgecRP5MjoOSv/kyDLAGOhZZgp0U5vtCJyimGA
 Sr5Qhlwp8EHEUaZGoLU7M+aNyzctIC26G/lKiyqkyu4ipDGkNCnYBZpZi3VlQO7Rchka
 tVCe9IQGsQxM+kmsipt4ZRkczXUEgUR/4CGjDatMYtsF+6T2CaSzhVoSmF5F9ZKs3I1x
 jmeh39IfzrN2hI1jdwYo+EUhYSdk/unpyKYxiTmo61gveO4jWHtVQs4PZkF1+cUGQruy
 S0mA==
X-Gm-Message-State: APjAAAV+FXfj6w6Zng5qigkiAH/ST0fkz+W7c8mYvQsMOUUA5ql+rtE2
 2X5KOixhuoC27f7fbfAOKxx/bJ7Vy8C2K31BGLRFs67b
X-Google-Smtp-Source: APXvYqwYncbzcOmNcqq9+LW/Bz8KLbv3BbhWGrLBJcESKHs4FcMPC3m/hKkTXYc/fW/Ox8v8mBhr9FFA306KMAMXx2U=
X-Received: by 2002:a05:6830:13d3:: with SMTP id
 e19mr13093232otq.135.1581595140039; 
 Thu, 13 Feb 2020 03:59:00 -0800 (PST)
MIME-Version: 1.0
References: <20200207174548.9087-1-linux@roeck-us.net>
In-Reply-To: <20200207174548.9087-1-linux@roeck-us.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Feb 2020 11:58:49 +0000
Message-ID: <CAFEAcA8ig1CYb1ioszchv8wmNnbxJDUhxMrK3_ATqprNrauWxg@mail.gmail.com>
Subject: Re: [PATCH v2] hw/arm: ast2600: Wire up EHCI controllers
To: Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: Andrew Jeffery <andrew@aj.id.au>, QEMU Developers <qemu-devel@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 7 Feb 2020 at 17:45, Guenter Roeck <linux@roeck-us.net> wrote:
>
> Initialize EHCI controllers on AST2600 using the existing
> TYPE_PLATFORM_EHCI. After this change, booting ast2600-evb
> into Linux successfully instantiates a USB interface after
> the necessary changes are made to its devicetree files.
>
> ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
> ehci-platform: EHCI generic platform driver
> ehci-platform 1e6a3000.usb: EHCI Host Controller
> ehci-platform 1e6a3000.usb: new USB bus registered, assigned bus number 1
> ehci-platform 1e6a3000.usb: irq 25, io mem 0x1e6a3000
> ehci-platform 1e6a3000.usb: USB 2.0 started, EHCI 1.00
> usb usb1: Manufacturer: Linux 5.5.0-09825-ga0802f2d0ef5-dirty ehci_hcd
> usb 1-1: new high-speed USB device number 2 using ehci-platform
>
> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>



Applied to target-arm.next, thanks.

-- PMM

