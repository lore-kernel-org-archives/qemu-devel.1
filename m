Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 349DFC31E40
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 17:39:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF0792082E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 17:39:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fvKqdGvm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF0792082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48606 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haOGg-0002X3-VO
	for qemu-devel@archiver.kernel.org; Mon, 10 Jun 2019 13:39:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57317)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1haOFP-000244-S2
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 13:38:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1haOFO-0000K9-Pk
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 13:38:19 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f]:38421)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1haOFO-0000Hl-K6
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 13:38:18 -0400
Received: by mail-ot1-x32f.google.com with SMTP id d17so9108682oth.5
 for <qemu-devel@nongnu.org>; Mon, 10 Jun 2019 10:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=/m1tlCfW0oLJeUKahc4RitnMKgo8T10ODFg3BRHMkWc=;
 b=fvKqdGvmDyuILYrdt4lOzixOOu/mMf5gTqGxrTwv7P09Q051zXvZVqRmXJH0zl63a1
 6GZ7vhty+uX0SPUfM2qOM9mQuuee89kE3BP/LcaVBw2/j+VxupVlMX/P7q32SIveLQid
 e6Ch+7ZUcVyKGAg2PVpXtmhYUIogu20jq+mVc+fy8TvntzYugYQnAwlhB9LXsyS9Cn5g
 ON3ml7d9xvUpKezyQs2ZOU8n3DbG8WBhn9L+SqwrSFXqazrHvSOv+6+hLN1AMqxCjXSh
 8zvEFe9hJWotOuo7WJ/mba6fPZT9fd1XAioUwKLqcsk3YtACKDO3Mwt8JzNtdSDCz3ay
 vq2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=/m1tlCfW0oLJeUKahc4RitnMKgo8T10ODFg3BRHMkWc=;
 b=ugMsK34z9sHyTdBEmO4ONoHcrLEkCfoGhK1mG2pUXO+6AkzBYes1lj6jItzR8nEK5i
 oODZnI2h4xqtZDekx2bZ/HGmUOrWvBHXvW9+TYMvYhy0tr1d4HYr42/OimoEYbyZTTSv
 P5AEXI82XI5xbIeNqdgfF2xmqQCnkeG+UpMbh6KDtHzJbR0lCtUZ0seWl9CS5R8HK30x
 jyOJO0Nx1OEsQIkRGk7gucjTHStJnRr5jrq4DP94G80RQ9+C0W4UO2MHb/HqEpfLQ0wp
 NDv2o8p52wW71eefczwXabUaKA8orE5N7hy6d5+AW4Wf8thKu8pXei1uhHZOVxCWpkWV
 EMnA==
X-Gm-Message-State: APjAAAWinev7KNIptNTBVwl6i1E3TR1rVuYIBb8vEPME/4Tizl8mXQzh
 lFReGDRy1uasSve9w8srsZEhTu/+6MzSJSdfQPvUZw==
X-Google-Smtp-Source: APXvYqwDarnAH9d2DVsQ8YJ1CcEspbVJHhH+Z353uVDd4Ixl7BKjm9BRWd1TB8+Nky86GJzC4yyNsp8Smwbmw6iyWMI=
X-Received: by 2002:a9d:711e:: with SMTP id n30mr12626864otj.97.1560188296656; 
 Mon, 10 Jun 2019 10:38:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190607211544.7964-1-ehabkost@redhat.com>
 <CAFEAcA-wCqppsi+gcrTqGjR3bSDOHs5btKKE8oHYxbAUDtu7Fw@mail.gmail.com>
 <20190610131105.GJ22416@habkost.net>
 <CAFEAcA_fBBN_854PznqJUniks0uemEite8Hxcw6cwTbUSr+aVg@mail.gmail.com>
 <20190610171213.GK7809@redhat.com>
 <CAFEAcA8L7dFfwi84_wLwEV1xYyyAbf31WxiqCf_z_m8p0SAhhg@mail.gmail.com>
 <20190610173000.GL7809@redhat.com>
In-Reply-To: <20190610173000.GL7809@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Jun 2019 18:38:05 +0100
Message-ID: <CAFEAcA-L_OfUyP9NMOZbpaKst+3Q2PBCc8=+3ErMRVLNaTASfg@mail.gmail.com>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32f
Subject: Re: [Qemu-devel] [PULL 0/8] Python queue, 2019-06-07
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
 Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 10 Jun 2019 at 18:30, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
> Do you have access to any machine in the compile farm or is access
> granted on a per-machine basis ?   If i'm reading this page right:
>
>   https://cfarm.tetaneutral.net/machines/list/
>
> there is now one aarch64 machine (gcc117) that is running
> Debian 9 / Stretch and another (gcc118) with OpenSUSE Leap 15.
> In terms of OS version at least, either of those could be viable
> for QEMU, if it is possible for you to access them.

They're all available, but those machines have less RAM and
fewer CPUs; I think the A1100 is also not as powerful as the X-Gene.
I'm pretty sure Linaro has access to something better than that,
but it will take me a bit to find out and set up to use it.
(I do actually have a Mustang board myself but it's running
the aarch32 builds and I'd prefer not to make it also do the
aarch64 builds at the same time.)

thanks
-- PMM

