Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE125C31E40
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 14:03:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9207F214C6
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 14:03:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b5PSxjDC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9207F214C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw5UU-0006Xt-Qw
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 10:03:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36334)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hw5Tz-00067i-T6
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 10:03:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hw5Tz-0001bf-21
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 10:03:03 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:38685)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hw5Ty-0001b5-Sy
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 10:03:03 -0400
Received: by mail-ot1-x341.google.com with SMTP id d17so133080603oth.5
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2019 07:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=t8CDQ+8NIBSx0S3Dr2Zhy7qUpMvtQoAJ1zejgEhyiSM=;
 b=b5PSxjDCpMywfg6Rs6J+UEqpBCS+HEEOx86OCEJY3rmR2wqAaEyAx5IZhXXBAmIc/k
 Bsmhr/fcVLOilV/UrKkwt75bX1Tds6p9Cf6RpabrOa+xCXKvJPlxp7QpmOgk+IKiJET3
 fKnYpEbjIUXEMJPxLibqTlztntUH82IGKdcPy1ldxepPCdkFd0EH8l6+AuEYtuNEbNcD
 6BxIJ9rHMDzygGNDuUCCoVMpDJLjLEk4VrezwLW6ElmYAPRiWaIGGzU2Vy7aa0YXI327
 FjeUqDUArm/EosfHA4TzuGE0ADrenmGBGAQvxGRYiqxxfwweloGOZq3aR+ECVGBK9WoL
 T2XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=t8CDQ+8NIBSx0S3Dr2Zhy7qUpMvtQoAJ1zejgEhyiSM=;
 b=LjBKDiHV4erfgOzwgJnYoPLOfXEtG0IkiF9EyueIZheHSnSp1YGPVdC1sVJJ4tk0rI
 a7X9/r9RNfukY2uPB2DV1LjHmTPou7RZa6QLPFwtEEYz7iqB6SXvZoZLQ4ddP1sR3qgo
 cJys/1ZNHMZUblqmpgVUnxitNCp1cnAA/EVLNuyeTCz/p/9o7IH0qJXeHYIHqVrzkGUo
 +oA+WzorequgdsfzDk+o3e24CTgDUKWoiNuT3gp8hxK2s0IrZ0YKIro/l5WgbTmjojGh
 0Leomlk0OFoebcgh2JS0aSigKfCGwPqxko7uLjzUTvdHNjKylZSPwzFxhfiCJGyLE1GS
 PTtg==
X-Gm-Message-State: APjAAAV50/6tHXz8STSfU2FKxQUMcEpF+RDoEB4feO3QewwfypcKs8ho
 yQ96jYYEHIvoxe9P3RdZjB8mtD9OKj/QdpAk4FCFZw==
X-Google-Smtp-Source: APXvYqxirUxpPgZO+TKYu78XvHyN3XGr7/YrGUMVlJaMr9z8RUpjvaveQk3P/pHpc9siWbHDZBamZQOKTz+bv9RaXu0=
X-Received: by 2002:a9d:6a0f:: with SMTP id g15mr18587277otn.135.1565359381759; 
 Fri, 09 Aug 2019 07:03:01 -0700 (PDT)
MIME-Version: 1.0
References: <87r25vd5y1.fsf@dusky.pond.sub.org>
 <CAFEAcA-3X0s-mxaD27HWQa7ysiEb6Uo-BD+Yxo0QhBV_yb9WLA@mail.gmail.com>
 <CAFEAcA-e2aW33GeuganVSnu9epuqt57rnZ_KgEHwDNqrWrTHuA@mail.gmail.com>
 <20190809133514.GF13660@redhat.com>
In-Reply-To: <20190809133514.GF13660@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 9 Aug 2019 15:02:50 +0100
Message-ID: <CAFEAcA9mpqS82PnSZ36ceR_W9mQjgFsJ4jx-3V-PUTKhUokXMg@mail.gmail.com>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] Does i386-linux-user build on an i686 host?
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
Cc: Laurent Vivier <Laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>,
 Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 9 Aug 2019 at 14:35, Daniel P. Berrang=C3=A9 <berrange@redhat.com> =
wrote:
>
> On Fri, Aug 09, 2019 at 01:49:07PM +0100, Peter Maydell wrote:
> > Easy fix: uninstall oss4-dev.
>
> Perhaps also make 'configure' exit with an error if it detects the
> broken soundcard.h ?

If you're going to patch QEMU you want this one:

> > Better fix: patch QEMU to provide its own versions of these constants
> > if the system headers don't.

which isn't really any more work.

thanks
-- PMM

