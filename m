Return-Path: <SRS0=McoT=XE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA06C4740A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 16:23:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3987F2086D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 16:23:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YVDc8/Xe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3987F2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7MSK-0007c4-CT
	for qemu-devel@archiver.kernel.org; Mon, 09 Sep 2019 12:23:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36139)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i7MPp-0004yg-Un
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 12:21:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i7MPo-0000D2-LE
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 12:21:21 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:40044)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i7MPo-0000CO-Cr
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 12:21:20 -0400
Received: by mail-ot1-x343.google.com with SMTP id y39so13032774ota.7
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2019 09:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0Zl/imYp4A/O7V7qy5sc3ume1dIGNpI6UR3LP9ZcsMg=;
 b=YVDc8/XervuZEn7Ol1FOdLZADdebELyu2feMd3iSxzrbOt9jfB9HtzAVDjAMZDwrA6
 yMD8oKdT5QCdxYZNsfGbkqDfrEe0SCv9hm2OqR3zyVv7gxMo8iNgZWlWbq/I1KBcy4EU
 rPtolP9gc4e3SYRPZfVhTZB0IgbT7e+2ND8Z1WCE7xDp/Zv6sz+cNbmiFjg9GHngOJN+
 T0zpZwwHBTNHTTbnBCiW45UUXO0GWAYG/xLpdm2xsvWo9ZXUabL/EyvLCHagLrcBKpq6
 HGICOiE2EGGeVULhj9eumQbZ5kXT/7xU/SrmDmUy8LDUbkxDlgJxbLa/TyQaYe5GHF+j
 r1Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0Zl/imYp4A/O7V7qy5sc3ume1dIGNpI6UR3LP9ZcsMg=;
 b=ZOtH3xkilne57ib3sf6nkIa5Xa6kTrvRurwsZ+9RXYkz0pB4fEDdzsIcdN2+M7TBNx
 mluQ1u21Y9CPOucOXSxAF+JR9aTjH4UX4o8TvsYYmSKnJ1b+dux8CICMM1T8yUnCgPNJ
 o3t6DkmgCF3eeBpgmlcspPtxrzSRtm/OQGMh0Phu3+zRVRezorM8sUBbPn52iW0F1c3y
 CpVbfFQcs3uSIZh9vIhmwEX5MIuC7kGn/cdYRoJ9sW7TMdZ9vNnMp+JsVWxBeJLHs58u
 3FA34ncp+AuNRl55rh+YqoqsGfqggsnRlxSZVEBCnut5JH8uvxx1jh2ACQKHEnVHnuRa
 LNtw==
X-Gm-Message-State: APjAAAVuQsp44u/GzG9WcNZJDDiXUabvuA2XUW/0H7Uokv7qx/E7NVIW
 r3TzTai2C6PgMGpf3qj9DYMxyQNmQ2X1YEYlDu2FUg==
X-Google-Smtp-Source: APXvYqwtToKdiTVQ4dDlpF99sA8CQDTt1SQP4/neSk08hVQAjDa39KDhjNw/AcgEkysMSHRqdqwulPU+3WeGZ+7KydE=
X-Received: by 2002:a9d:5e11:: with SMTP id d17mr20786343oti.135.1568046079344; 
 Mon, 09 Sep 2019 09:21:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190909155813.27760-1-laurent@vivier.eu>
 <20190909155813.27760-9-laurent@vivier.eu>
 <CAFEAcA9NiHrGekrEte7__aGKSz-JBObdbWdMxmxduYozngDUNQ@mail.gmail.com>
 <20190909161804.GE2726@work-vm>
In-Reply-To: <20190909161804.GE2726@work-vm>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Sep 2019 17:21:08 +0100
Message-ID: <CAFEAcA-=dEKhaG4Zow_TjX6=yTh5zWO51HMSaddpUf=2Zzn46g@mail.gmail.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PATCH v9 8/9] hw/m68k: add a dummy SWIM floppy
 controller
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Qemu-block <qemu-block@nongnu.org>, Thomas Huth <huth@tuxfamily.org>,
 Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>, QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 9 Sep 2019 at 17:18, Dr. David Alan Gilbert <dgilbert@redhat.com> wrote:
>
> * Peter Maydell (peter.maydell@linaro.org) wrote:
> > Missing reset and VMState for migration. These should be
> > baseline requirements for adding new device models to the
> > tree, because in an ideal world every device would support
> > both -- we should be gradually fixing the existing devices
> > which are missing these, and not letting new devices in,
> > so the situation gets gradually better, not worse.
>
> I'm happy to see things marked unmigratable instead for obscure
> devices; I don't see the need to worry about migration for stuff
> that's not going to be migrated.

VM snapshot save/restore is a useful debug tool. But yes,
"mark as nonmigratable explicitly" is OK too -- at least
that way if the user tries it they get a clear error message,
and we can later on look through to find what devices
are missing the capability. (Personally I find it's just
as easy to just implement the vmstate struct, though.)

thanks
-- PMM

