Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B75AC0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 12:14:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2786120B7C
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 12:14:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UgZW08Yz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2786120B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhvCf-0000P8-EL
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 08:14:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53742)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hhvB2-0007pI-LB
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 08:12:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hhvB0-000182-6e
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 08:12:55 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:46134)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hhvB0-00015a-1u
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 08:12:54 -0400
Received: by mail-oi1-x242.google.com with SMTP id 65so9721883oid.13
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 05:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ojpK5Vnj35c3sG9gS1mYZguUk7VTk5K4mIty05dreN0=;
 b=UgZW08YzIXK3CMkGPV5Og1YG/luvYh9bvQ+TZz5PAuyodIZKnbvevblySyY6XSCrJK
 3zlp8gtEtv1AaY3T5fLjSuprzl5MUl1tbAjIXRIMKVOjvWWL/Fuey3iZpuMoUvzfx0nM
 QIM+41MLDbxGKAYJYvXhdL1hEYMyDImEWQnT7IuZOTs96gQ5n8B+iTrUCOR1n+864h6w
 aRLQt3loF+unEpQAJOdeB8Wc708OFBH9+N7N4hSCn0jOGaVBsse8YGWtHQ825Tkbot4h
 Y9Iv1RyzFiyIb9W9TlIXnmxKLOqujcnHgOSfzq5BODsgkq/yohgbC+yM4SW/zy1WbyaJ
 lfPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ojpK5Vnj35c3sG9gS1mYZguUk7VTk5K4mIty05dreN0=;
 b=Dn05xM/VPzyhRIO9wsL//qWj2J/0TOa0CgVmRSeQhYIwvMPBUQHQSvYexPc7vmwB9l
 sJpiBc2CPy0vOyqx0alOK2Yf2Ds8LHnrpJ5XZTPjsqXoouVn9qO2optLkJgfXhQ2KPHP
 Nu4w0z2vPoJVf0cOJ0fZP6SksVZUJD6vMM3BuMnUp9NgUuQFaN6NV2/dSi5DnpBSfy0z
 SE1lyjVzrnejpkWAROsKsfsAUkwZnswKNCmEn7AsfYsvNNdkzJ7SIA6xdNEsip63schY
 LSw0hBYGF1pzwIzB3Hq4OuhiUeNI6RRVSsw38K0bSuNcd8H/GPU19ZunKQtxAgcmAPTj
 gNuA==
X-Gm-Message-State: APjAAAWSV3UI4FcPr+lIn96W5VQVy13dHQY3WNUjXoQNpvw9266aIIEn
 aHnFsyFV4ImrB4uls+HxzTUEWT4yQePWD5IEvSTLaQ==
X-Google-Smtp-Source: APXvYqxNI498GBOTRNMyGAngva6yCd66rX8QrLhYEqtvpuZjWVmVfjA0lR25dFLYErkij3GfhYLF6oTYLUYdZ1Id/eE=
X-Received: by 2002:a05:6808:d4:: with SMTP id
 t20mr6713435oic.170.1561983172849; 
 Mon, 01 Jul 2019 05:12:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190416013902.4941-1-andrew.smirnov@gmail.com>
 <CAHQ1cqE5RZVYB1N2+CxGKNDb5NrtBOiQANhruZ6_6EbOThNwiw@mail.gmail.com>
In-Reply-To: <CAHQ1cqE5RZVYB1N2+CxGKNDb5NrtBOiQANhruZ6_6EbOThNwiw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 1 Jul 2019 13:12:42 +0100
Message-ID: <CAFEAcA9_UV+7p3HSEz8AZ84f7VEC8CTez2D7GSGWxcAbyXZ1=A@mail.gmail.com>
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
Subject: Re: [Qemu-devel] [PATCH 0/5] Various i.MX7 fixes
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
Cc: "open list:ARM" <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 18 Jun 2019 at 01:27, Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
>
> On Mon, Apr 15, 2019 at 6:39 PM Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
> >
> > Everyone:
> >
> > I recently revisited my i.MX7 work and this series contains all of the
> > fixes I had to make to get it to work with latest (5.1-rc1) Linux
> > kernel again as well as fixes for genuine bugs that I somehow missed
> > during original submission ("pci: designware" patches). Hopefully each
> > patch is self-explanatory.
> >
> > Feedback is welcome!
> >
>
> Is there any changes necessary for this to go in?

Oops, sorry we missed this (for future patches you can feel free
to ping them after a couple of weeks of no response).

If you could reply to Philippe's query on patch 1 about the
correct value for FSL_IMX7_DMA_APBH_SIZE that would be great,
but since that's a very minor issue and we have softfreeze
for the next release tomorrow, I'm going to take these patches
into target-arm.next as they stand. We can fix the size value
with a followup patch if necessary.

thanks
-- PMM

