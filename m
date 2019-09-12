Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F63FC5ACAE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 10:21:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39EAE208C2
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 10:21:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VUmjhdlh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39EAE208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8MDm-0006jt-4j
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 06:21:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53624)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i8MC0-00058s-R6
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 06:19:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i8MBz-0007Lc-JR
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 06:19:12 -0400
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234]:41885)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i8MBz-0007LP-E4
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 06:19:11 -0400
Received: by mail-oi1-x234.google.com with SMTP id w17so3443771oiw.8
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2019 03:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=lUN+R38jmZUAOenscLTAvjujHSpq0M6PH78aF1obd8Y=;
 b=VUmjhdlhl0eN6g2pCZ/E8GiltEQUakYwYu9zcAb5j2MzmBH8Ytr90WPhkZCAbuWkvx
 NpeQeTnhRRmuGYkypuNHwmbicfe/npSIzgzTl8lahgArnzekyKFQps7L7uPHfO8qg6uS
 Ey83+ukS4IGvhLXaUDvIcGYjzPXamrAfYzWr7CkFI/PqUd87Kg/DWCcF+2R038Pjy1c9
 lgApYMTkBUSshUS0B/YLKJWTY0hu2If88DtrYOsd7A/B/jCdSAYlRU4IuL2YwSao0Dmj
 W4eVHCe0ktWTmocv/YMPadDxwNg8UB4V9DK4sfBI6GHIr0O9Hr/HwPA66y+QRpK3Yugg
 aY/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=lUN+R38jmZUAOenscLTAvjujHSpq0M6PH78aF1obd8Y=;
 b=oNOu6EtJRXKj6fPB6qJuam3mH5eGrQF6p1rmPIhH/wodpCUXfWdjY9YnCqyvj7hNPu
 vqr3Hx7SPDsT96fcASZ55UW8Mr55gF2+RTW7kWZ8m/Ih+ZczttSrU3tx55G4CqP770+Y
 S+Ms0776vXircDC27T++lxeSPcovi8OI6pXroZCJDoN12QTZxoe9TUGxORjTprocItUg
 XUSEniSjzNxQpI1LGW3+mHtVGY9iS12+PDLYb1n2uh2ilSZ5z8NOhZpDaQ52kNZS+cCJ
 7hbI8Q1gC5iJToZKt+/kdGm6N8R5BTDy9Ata67k8T6eDrdReW6EzGC21Ltp04QD2OD/0
 /9fQ==
X-Gm-Message-State: APjAAAXn0eBYdSuSjlWxInfwzqOmv7c6GdeOWL7J0wb8y8NcnYkeAidJ
 NlYF8pm1ffVS09Wcq49mfOnoo54ZLIBMQnpx+RUGkw==
X-Google-Smtp-Source: APXvYqzXAvUefxSLcjLNpa4EuuHNzs6hPeqmNl44VB2Niywxyg/0IpHpkHnMh8BBSX58KokFOwY/2UHvg14wqFbPCQ0=
X-Received: by 2002:aca:b48a:: with SMTP id d132mr7984015oif.98.1568283550122; 
 Thu, 12 Sep 2019 03:19:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190731160719.11396-1-alex.bennee@linaro.org>
 <87a7cty0tv.fsf@dusky.pond.sub.org> <875zm5yzgq.fsf@linaro.org>
 <87d0g6dnbc.fsf_-_@dusky.pond.sub.org> <87y2ytzy17.fsf@linaro.org>
 <CAFEAcA9Db2ENw7e_1-XOTbHeV=sp_zFxqoq4se+63OK+mQaeew@mail.gmail.com>
 <87v9txzv3o.fsf@linaro.org>
In-Reply-To: <87v9txzv3o.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Sep 2019 11:18:59 +0100
Message-ID: <CAFEAcA_dQ4txzn7HzBO8PMwh2K2WpJ+_8LOEMtXxqg5Hmwfzdg@mail.gmail.com>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::234
Subject: Re: [Qemu-devel] TCG plugins and the GPL (was: [PATCH v4 00/54]
 plugins for TCG)
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
Cc: Markus Armbruster <armbru@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aaron Lindsay <aaron@os.amperecomputing.com>,
 "Emilio G. Cota" <cota@braap.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Pranith Kumar <bobby.prani@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 12 Sep 2019 at 11:07, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
> Peter Maydell <peter.maydell@linaro.org> writes:
> > Wait, what? From my perspective the whole point of the plugin
> > interface is that it should be stable, in that at least there's
> > a good chance that a plugin you built will work against multiple
> > versions of QEMU, and if it doesn't then it should fail with
> > a reasonable error message telling you to update. I'm not
> > sure we should be landing the plugins infrastructure if we
> > don't have that much stability.
>
> There is a big fat blurry line between "set in stone" and "not requiring
> you to re-engineer the plugin every QEMU release". I'm saying we should
> reserve the right to extend and change the plugin API as required but
> the expectation would be the plugins will continue to work the same way
> but maybe with tweaks to the API hooks to support additional features.
>
> It's also a pretty young interface so I would expect some evolution once
> it is released into the field.

Sure. But I think we should document that we at least intend to
have some approximation to a compatability/deprecation policy
here, and some mechanisms for versioning so you get a helpful
error rather than weird misbehaviour if your plugin is too old.

> One problem with the anti-license circumvention measures being suggested
> is it will mean having to recompile plugins for any given release.

Why should we do this? I think this is making life hard for our
users for no good reason. We *do* have this check for modules,
because a module is just a random .so that can do anything in
QEMU. I thought we had the TCG-plugin interface much more locked
down than that?

thanks
-- PMM

