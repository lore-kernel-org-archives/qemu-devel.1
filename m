Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0553FC31E44
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 08:56:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAAF420866
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 08:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nMBiQoSH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAAF420866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49400 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbi0Y-0000Ng-26
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 04:56:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59999)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hbhyK-0007cO-Db
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 04:54:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hbhyG-0000d5-MS
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 04:54:08 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:42170)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hbhyE-0000bn-ST
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 04:54:04 -0400
Received: by mail-ot1-x342.google.com with SMTP id l15so1915255otn.9
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 01:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=bNhOqaZ4SZIbr8woomDHTdN5eZdOvsu8fEjb/bIHhj4=;
 b=nMBiQoSHtFvY1Fk+3q2O25q4O5UqDOJRvasMwi9B8b6mDw8i/wuECyAbv/sXODtMbQ
 oIMA/SEhBvIzMUbQLi9cgCpPj5080bM9MeyU/pMEJ2Oz2sf9ylanMvOEUDE2vQI/P2Gp
 zptf7iMaiRTxUql9oqvd1HsiMpsV3IX9izK0Z9TbTbJ6drjrcVm4HfM7jNvFHg8H6ziu
 q5RcU81C0QJZ/BL1xf3+AzBOI7+0RtmbnWXNTct1dSRwglV3mV90IRBMFxytFYAE0WiE
 RljSH4qZ3XQOfpemDFCV/zoKQoWXh3gLecjdOAy1hW4Md4erl2lD/JbhG+fhLT84VEAY
 /czw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=bNhOqaZ4SZIbr8woomDHTdN5eZdOvsu8fEjb/bIHhj4=;
 b=PrUNPgeegH6ItmBAVFMOxg6GU6LsAyfxffTwpLPpNH3DnqDy5y9WQ5eUR5DkUzvuPm
 Ms7MHxgd3Yu7LDFmJ+OPRi74gKO0SIK0rkNJLPadajqp4vt53j0LT+xpylv1yxzZJpoC
 I5ONRWLX6K1V5fv6pMnG5nJWGjRYz3r/9BMg47ovf/7OZRDYg8yo+qmrNvLBZwSXjkJA
 QXiz0tFJTrvgxXqSv3azEhiBaqlufZnryazszuH63RGjm74ZeivsqM1n18rIx6wY9bsB
 3GZdxX1NvRHeEgwJjNAENN5hdXD+khedFqU+yGsY5XjFrVtlyP8Z6M+Db9ykcuTAKJMG
 JIcQ==
X-Gm-Message-State: APjAAAVRYeN1tzv5SP9N9FV0PvON7Yvvuz41BcF3yjOEob7/dYD2aOfU
 sh9ZzpH7dYm3Sg8HZn0vLQb2lEcAXlRRb2E2ws5atA==
X-Google-Smtp-Source: APXvYqyMC5M12b7p/p5uVAKz5m7a2UaDOH9wnCz2CUBnK425lHdmcmnt+YQbxVe5BPXZFtMF1iw66/2g0O+MKaKt5UE=
X-Received: by 2002:a9d:711e:: with SMTP id n30mr11923509otj.97.1560502441775; 
 Fri, 14 Jun 2019 01:54:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190614072432.820-1-philmd@redhat.com>
In-Reply-To: <20190614072432.820-1-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Jun 2019 09:53:50 +0100
Message-ID: <CAFEAcA9zEKePcOHK6WMqAitf282EWh5LUYRqZ3oAJ_W1wPsohw@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
Subject: Re: [Qemu-devel] [PATCH 0/6] configure: Try to fix --static linking
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 integration@gluster.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Qemu-block <qemu-block@nongnu.org>,
 =?UTF-8?B?TG/Dr2MgTWluaWVy?= <loic.minier@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, QEMU Developers <qemu-devel@nongnu.org>,
 Bharata B Rao <bharata@linux.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Niels de Vos <ndevos@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 14 Jun 2019 at 08:27, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
> Apparently QEMU static linking is slowly bitroting. Obviously it
> depends the libraries an user has installed, anyway it seems there
> are not much testing done.

The main reason for supporting static linking is so we can build
the user-mode emulators. Almost always the problems with
static linking the softmmu binaries and the tools are
issues with the distro's packaging of the static libraries
(pkg-config files which specify things that don't work for
static is a common one).

So we could put in a lot of checking of "is what pkg-config
tells us broken". Or we could just say "we don't support static
linking for anything except the usermode binaries". We
should probably phase in deprecation of that because it's
possible somebody's using it seriously, but it seems like
a fairly weird thing to do to me.

thanks
-- PMM

