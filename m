Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A00C47404
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 12:10:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 006FB20663
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 12:10:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GLiRQyBe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 006FB20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8Nw7-0007yb-61
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 08:10:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48824)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i8Nv2-00071i-98
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 08:09:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i8Nv1-0004Aq-Au
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 08:09:48 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:36238)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i8Nv1-00049P-66
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 08:09:47 -0400
Received: by mail-ot1-x344.google.com with SMTP id 67so25794453oto.3
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2019 05:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=BvDSlGW/ljIwdifZ8OqpxQdh3CICFSkI/PVi7XKfK1o=;
 b=GLiRQyBeV4DzzolsndUHa443wn0jwTMmgacxxetC5zRwKStPItxRx2ErLFcg43mHEU
 Qar12lD7Vpd+F0yjQQUbeLnDp43IpVyL86CHMNS5YVmWbMGlGknZff7p68fqEPsejXGb
 oc1K9Ek931XYAo+33xjHoEQHWOOsvV4ekNhkzP7x4e7I4dtBCxS0I1S1M93tYaeop+ca
 Upv5RA+y++H7wYVms/Aiu8Eer0rmxCY6IxxJiRicXgcTz9DAz8S2HGrfpKEkeReh/BDq
 UG786GbfFHuN/PZMWmGaWZ8TyOZsX7SwDY55h8EvuhFxCWBqzKrqkPsdZ5Z4SaQxlDj1
 mBAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=BvDSlGW/ljIwdifZ8OqpxQdh3CICFSkI/PVi7XKfK1o=;
 b=HlETMNYesCI2bl024Nm6SEeEtqnD2DI98biKMOUG8k6i2PPZ/kELvM0TjSOXX0FkJh
 WRR0YnPKrgCOQlmfHZXVgKL2i6zMDHpswq7cheYaJX1bNJmoX6mDJ564BEnRWeE+PUQb
 RVVyTltz+vT1V02kQEd1PMobDcDdYAtS7GVySLpNeNJNzOTaCnf04kdjDr0OO6I7X2p0
 CjMyYYlBeRGqwvLbh+YkLfYnFK1It1eOR4v9nSLACh94XwoL3ZDpQ8oDlGcPl/VyTiE1
 z6lH8PdfX+D9DJJTeqkv6havOQXdpMzXPZC2oJ0FmquRmWYKxov9M0I31BOwfKMc3QWD
 INBA==
X-Gm-Message-State: APjAAAXs2CZMSeGzWtev7tVDNogjPVNL0z+wXN+OA3zAdMJ7VlwlcLU+
 ertK+RI9sKy5CvsvrS/rjRQVCgQHjPSJFBFdyLORvg==
X-Google-Smtp-Source: APXvYqx37i6VSB2VQxGr9a67rh0O28pqtNcxrNxCqACQOjW5sW+wNKDhbLB6TrcJc8XHxwb4KEV6YGXSpBAzY2+cy9A=
X-Received: by 2002:a9d:68d6:: with SMTP id i22mr26801018oto.232.1568290186464; 
 Thu, 12 Sep 2019 05:09:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190910144428.32597-1-peter.maydell@linaro.org>
 <20190910144428.32597-13-peter.maydell@linaro.org> <87a7b9zpmr.fsf@linaro.org>
In-Reply-To: <87a7b9zpmr.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Sep 2019 13:09:35 +0100
Message-ID: <CAFEAcA_=s0Ua9S7oB-weoX1z7Vks54h5opWtuKnsNknmvaXg6g@mail.gmail.com>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 12/13] target/arm/arm-semi:
 Implement SH_EXT_STDOUT_STDERR extension
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 12 Sep 2019 at 13:05, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
>
> Peter Maydell <peter.maydell@linaro.org> writes:
> > +            /*
> > +             * We implement SH_EXT_STDOUT_STDERR, so:
> > +             *  open for read =3D=3D stdin
> > +             *  open for write =3D=3D stdout
> > +             *  open for append =3D=3D stderr
> > +             */
>
> I love the way the spec documents field2 as an ISO C fopen() mode and
> then an extension literally subverts the meaning to be something else.
> Where the designers worried about adding a SYS_OPEN_TTY function to the
> interface?

It's just extending the existing convention of "open ::tt as
read for stdin and write for stdout" a bit. IIRC some existing
implementations actually did this as a sort of undocumented
extra.

thanks
-- PMM

