Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E6B9ECE587
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 13:48:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 182FB21906
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 13:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q4q+xsMQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 182FB21906
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFIVU-0000GP-Kw
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 09:48:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59918)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iFISg-00071A-5B
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 09:45:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iFISe-0000la-Ue
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 09:45:05 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331]:45520)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iFISe-0000ko-OI
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 09:45:04 -0400
Received: by mail-ot1-x331.google.com with SMTP id 41so11537004oti.12
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2019 06:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=5NU2OpS+ap0igpEiRbaJiJCwHkdzeRmXJ5Mm0Gw1yVQ=;
 b=Q4q+xsMQkbxvZ9B+a1fRL+J2NDHRAHxZRvm7E2apDYlGafp8UXb9m6csDXChbymjVQ
 B1kubdmCiMSMsC6a8SAz6T78pHi5nV2neBN90WOW6P7JdcC0q+xECY9GWLoL8y68ZdUu
 rsaJsz9qS1NI/JQiOOD0KPlsh4u8Ef0p3yEnEUIwyFonrggn11tvgLLjv9f0Fx1iIxzS
 +WyP0Tqo2EJyH+bhO3OJ9lZDxFW6YSHhUaqxjfO2aIYdit9+fZuVXv9QznHW8JpisRsy
 aUtz8kwTt/14nBeHAZgg7nqnb6WsyLLbYjokGLT7JHrR0+lz7ToRiXzc8VWEzLVoCxf3
 J5fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=5NU2OpS+ap0igpEiRbaJiJCwHkdzeRmXJ5Mm0Gw1yVQ=;
 b=hg0FOwEZyIhd+0H7hPvoNtfhsDB62or7n725Jvy0uA6xT1BoTZBG5RozO7C02lFqGM
 ZK0TPwFjXM6+EV20a55pr1QleRq4VoBwp2ATqK/TMkGA/CSvoxNcwWejrZni4GwkL7W7
 PO7MFG7L2QhoB7YMZCPur00uw6nn0BXmBgMoxxkXs4zyUUfNe/Lq0C0bFUb1RSxV3/yC
 59ybX3nVfmwEITZaVDM30AvxXihctADCVtFGtjDbYnC9f4gDrL6zcu2vsCOmAqBajW79
 cEE/tXuFdZr+0mvmeMRslARzUEe1S/Qek0BpIDAcm3dFbRkQoCap+bv96QLFVna57uxG
 hexA==
X-Gm-Message-State: APjAAAVyX/GIgWi2jRGly/uG5jiTCeGQoh+ndwJTLh/qJ1A4iwB23cJy
 W/Uvi/6CE0VJu+EAsdDzd5qwGf6vOPhU69GpQNvIRg==
X-Google-Smtp-Source: APXvYqziRtneQYbFm0lEeiO/m9+Y1hGJxQr5qBuiEKiVCTX/POvPCBjOTXM+tHrEBrPil0lEAR0NM6yPlcHasuj3/GM=
X-Received: by 2002:a9d:73ce:: with SMTP id m14mr13317367otk.135.1569937503802; 
 Tue, 01 Oct 2019 06:45:03 -0700 (PDT)
MIME-Version: 1.0
References: <20191001132609.23184-1-marcandre.lureau@redhat.com>
 <8bc51230-963b-e9e2-25ea-9719223c5c79@redhat.com>
In-Reply-To: <8bc51230-963b-e9e2-25ea-9719223c5c79@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 1 Oct 2019 14:44:52 +0100
Message-ID: <CAFEAcA8SZnh7iyf5ebChJ=Seu+u7thuhzmLayoYnpa69u+_K-Q@mail.gmail.com>
Subject: Re: [PATCH 0/3] Some win32 fixes
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::331
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
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Weil <sw@weilnetz.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 1 Oct 2019 at 14:43, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 01/10/19 15:26, Marc-Andr=C3=A9 Lureau wrote:
> > hmm, do we have any automated testing/CI on Windows (beside just
> > cross-compilation)?
>
> Nope. :(

I did wonder whether it would be possible to get 'make check'
passing under Wine, but never investigated...

thanks
-- PMM

