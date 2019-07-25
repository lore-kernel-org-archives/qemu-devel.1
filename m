Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F4FC76194
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 16:43:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D78542238C
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 16:43:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DCDOwvyX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D78542238C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqgpi-0002Z3-3p
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 12:43:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55458)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hqgpY-0002AU-M8
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 12:43:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hqgpX-0005JH-EO
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 12:43:00 -0400
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234]:34885)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hqgpW-0005Et-GS
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 12:42:59 -0400
Received: by mail-oi1-x234.google.com with SMTP id a127so38106734oii.2
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 09:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5lQZfwP1L1z/F4lPA6XdBMpCtWZejBWC7FW920mXWAQ=;
 b=DCDOwvyXAuSmwYgn5CUYkVSgEY1U8e8jifiXe8H9dhtfHSc3Ft9qSXVfhUWPNZlssi
 5zReVBRI/SF4cdk0wfXhbr1Tnx3lVanHqRLZQbNampbd3HDpHiF1rj1MQK/wlDGHmipx
 KRWOYFIWK63gLeqdR3qTWgSGPmErjQWB9M30foyplQQk+gQOH1rwshC3Cc9H1yVEuhNv
 /fRrwJxWW7zzWco/GNHiYNxEOltVLE7hsFT2ORuY4CrUVok9ZGz6OETkXceECu8f2vsL
 5EUzjaBOzsnbbjKDVwEpyl31bWd82KDVGd3HnXec2qy28yTtTXr/6VMbcGyY4f+XNW7F
 BB9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5lQZfwP1L1z/F4lPA6XdBMpCtWZejBWC7FW920mXWAQ=;
 b=K0WmMmHl45pH/tcLLThyFX2HB+m5a3oyYXif3r3pVYq1wpMeYZkqmKot74+YkpEVQz
 LsFuBa6BRgxGArg08Gsjc7JDbsPvzz7ZDRrH9FWwkM+xy/QjyOs9LGsegtSvdS6tIUmY
 od9sfkTPUWwsKFdXlmggPTwH2nd1Ndr+jRISm6obdNdButtrSMv3jXqy/E06Kg1bLE31
 xiKjL3z3hlK3rMp3g2GohG3NWcuIeF8wzqIvcWvA0gLG5f1lT/CEf07XoTpTAxucS83/
 cCF/jeLk5tZ6omdVQ7HOqAJ13mWZDNIRyf48h/BhILUdBWbpdM9TAudYCma3RaGkyIS4
 FnFw==
X-Gm-Message-State: APjAAAWIaws22yh7uXuFX2jCwQ2Uld4EPdmufKnBdwhdmC6ZLTnFaNZ7
 K97s1pfXuo4PpcVdtHBwG5pKmvSoWpe6x2flLiW2iQ==
X-Google-Smtp-Source: APXvYqzengipRmml4uk1bs37WHRPOEVqlxrDdf0iQStb7JDBZ9OwO9OuWMM/Ot3xPS1bknPleArMg1MHUQq4i7jjlEo=
X-Received: by 2002:aca:ac48:: with SMTP id v69mr42624700oie.48.1564072972170; 
 Thu, 25 Jul 2019 09:42:52 -0700 (PDT)
MIME-Version: 1.0
References: <976a4589-f836-0f31-b682-f384e22149e9@redhat.com>
 <CAFEAcA8eCsgAeX1--jZubKJ+v1U_ioa2q_Ec7UAQiRU6bKTpLA@mail.gmail.com>
 <676de2d8-b7bd-1f16-8270-8bc5f7de8254@redhat.com>
In-Reply-To: <676de2d8-b7bd-1f16-8270-8bc5f7de8254@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jul 2019 17:42:41 +0100
Message-ID: <CAFEAcA8s=YbvO7Qw4twt5NemH4vVbZX8_mi5LveTYgYYQY5YNA@mail.gmail.com>
To: John Snow <jsnow@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::234
Subject: Re: [Qemu-devel] Sphinx and docs/index.rst: dead code?
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
Cc: qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 25 Jul 2019 at 17:34, John Snow <jsnow@redhat.com> wrote:
> Yup; I think a single point of entry would be nice -- I think we need to
> start hosting our sphinx documentation because it's confusing that we
> have both the traditional manual (hosted by Stefan Weil) and this newer
> one that isn't available anywhere.
>
> The interop manual in particular is crucial to get hosted.

Yes, this would be a good thing.

> We could perhaps formalize this as follows:
>
> - index.rst, which is an "absolutely everything included" single point
> of entry manual for developers and contributors,
>
> - user.rst, which could be a single point of entry for end users, to be
> bundled in distro packaging.

This means you'll end up building 90% of our documentation twice,
which is something I was trying to avoid with the current setup.

It occurs to me that we don't necessarily need the 'top level'
page to be generated by Sphinx -- we could just ship an index.html
which has helpful links to the individual manuals.

(https://wiki.qemu.org/Features/Documentation is the current
plan and lists the various manuals we'll end up with. 'user'
in that plan means the documentation for the user-mode emulation.)

thanks
-- PMM

