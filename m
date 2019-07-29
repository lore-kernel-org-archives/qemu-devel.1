Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1393CC7618B
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 09:20:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D172C2073F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 09:20:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B5EVXEJM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D172C2073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs1pc-0002d0-3y
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 05:20:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56550)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hs1pE-0002D4-NX
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 05:20:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hs1pD-0001Ph-S9
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 05:20:12 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:45760)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hs1pD-0001N4-LR
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 05:20:11 -0400
Received: by mail-ot1-x342.google.com with SMTP id x21so23379780otq.12
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2019 02:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=SMFHbqWoJAUJvOkkcizf/Dx31wgfv4RnyxZ6fZ6kMpo=;
 b=B5EVXEJMqy1AlEXnsYp6CjebScKaUYFQaNoSDDhltLG346QpMr0nSAxevBaCGVjEgc
 njuKPWR8tK44FYkmPfHvNuPyTsfcIW2wW0fG885fNKM1vdE8WE/SUoUFRro5rrdIe1y2
 1OtYsfAsq5BRICMvMm6WE64Y5rSvvqg4FTdWrZNd6v+/xUWK6YxTXqPS1++yLrPTdE2F
 ImbEKKQDRwCfziDkTMalZrPHjLIq5ks45+5PSK9TACRp9vXXKmhvtxUuNz93aEMAxuz2
 2ZiLfE828uxVLKxlUIpQsSd2K2/26g0gt91ACAjT7/qlkaM3MfMHAaaQORlIkk9eQ8GE
 UI+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=SMFHbqWoJAUJvOkkcizf/Dx31wgfv4RnyxZ6fZ6kMpo=;
 b=AteajkDRwAmD5oLy08XwRpyx+/Xj4w3ZxwRgYSmznRsJ6TJl5ExvlELjwO2Bp9dtav
 Rq4h3dy+41NZLZRZAJiGvmi6CnzLnR1JWK0p/wQZ0pRYinsRUOB+9VhaXEBJ4yHxH08a
 N8b353qobiilnZPTZyEaLvyD9qsf8iCnw8DDj0zKFOrSf/pvmbg1295l17SFuKRDvi7o
 JP7nlXNu47bhMbuN4EHE+99A48XmSWoPSUadJVrOUHznE0O/dBv02TLI48A32A/NNfst
 os0DQ9dUcEQ2ufPhuLSa4vgjaITB8W39s9zB5E1VINPyEIURnVDHZgT380l3FumkHERg
 tgWA==
X-Gm-Message-State: APjAAAUwbkAMFmRKb6qDNsAMMsVACk6ud4XemNmXlVuY4RmPnOISD2NY
 ycFKSJ4i84o1vXQRChlAeSMR5KZ/nkCwSW55193Iww==
X-Google-Smtp-Source: APXvYqytr+E4V5YWwdXaoRvSL/ZSuE/IefhUcKsIy/LfNK6TjE47N0eZJ0cmwuBNF5R/B7Kk2NJsfgJ4ynK5R1+Q/F8=
X-Received: by 2002:a05:6830:1653:: with SMTP id
 h19mr25874204otr.232.1564392010685; 
 Mon, 29 Jul 2019 02:20:10 -0700 (PDT)
MIME-Version: 1.0
References: <1562775267-1222-1-git-send-email-pbonzini@redhat.com>
 <1562775267-1222-5-git-send-email-pbonzini@redhat.com>
 <87d0ie58cj.fsf@dusky.pond.sub.org>
 <78c3bba3-3e85-682b-b4ce-fc4809add90e@redhat.com>
 <87sgqsx7zp.fsf@dusky.pond.sub.org>
 <0b209125-4277-2836-e27b-a9c13f43f294@redhat.com>
 <CAFEAcA8J5AsEC+p3vAQ0H1emN-GS3T5GSj579tS=qC76WjkTVQ@mail.gmail.com>
 <20190729082115.GB32718@redhat.com>
In-Reply-To: <20190729082115.GB32718@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Jul 2019 10:19:59 +0100
Message-ID: <CAFEAcA_k8q5NEBG8PXw4pc_JFokNijVqR7-4QosW9TSPG=1T2w@mail.gmail.com>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
Subject: Re: [Qemu-devel] [PATCH 4/8] convert libqemuutil to meson
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 29 Jul 2019 at 09:21, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
> You can disable warnings selectively per file using a Pragma in the
> source.

In at least one of these cases (libvixl) the point of using
the per-file flags is that the source files are third
party upstream ones which we don't want to carry local
modifications to. Otherwise we'd just change the source
to suppress the warnings the way we do for other files.

thanks
-- PMM

