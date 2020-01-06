Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81B28C33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 19:14:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F26F2072E
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 19:14:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bdDbUZZs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F26F2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioXpX-0001Ru-GX
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 14:14:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55002)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ioXXu-0000HT-1A
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:56:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ioXXs-0002p8-Qc
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:56:09 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:44342
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ioXXs-0002ok-Nb
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:56:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578336968;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hIp7ZgtBYeXJsyf4hkZCTUh5a1NowQo7bvQavIpEFQI=;
 b=bdDbUZZssM1ONZrwoij4Mtcq0vAp+PXBUU2mdcV1dDcayQ7wrUqwgbDYa50z03Mj/iV8WR
 V8rKohIfJfuvSaDR82j2Ci7ivIp9VLriYnXs2lmmq3k4AEmiuFC+Op/7ya+Ldm+yARAwA6
 /dtr6KEcUYoVP4oks1Tw7yKI17YJgl4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-55-xr1TD4bDM_Cp7B0YhuBCuw-1; Mon, 06 Jan 2020 13:56:07 -0500
Received: by mail-wr1-f71.google.com with SMTP id z14so27688194wrs.4
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2020 10:56:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=f52nck1WgVsD0vNwhu4z7UU2av926Cm0pV8zGMRcySY=;
 b=JZrABOF3QhizTwnh7XIyC5m69tj1n+PZLqcZXCOzu5USPGMud2JppHsyMURkeRWpmU
 hMJbhJ7l8RPxHyUIsJBxTooCS/QCxOwjN2y6BWufu+GwlwlKOy9OWyu6Jre176DAaDgP
 L6AFnRkVfSkm2Qij5PBZ7sE9YQhlYzkVFIJj5mlyuAXyaUd4sGKFWaHZqFliEQMQEoRP
 CoPI+SCEDth7hEIzp+UgHYvAxPqVfiQd2tfRMkKT3YfhjKXWYzEpAS/tW0cBx10X7b8m
 Ptb9abD446BtmiOZYJyRK+91Tci7ZT23o6qxK8W8ELCIGC6rUjsvNfStkwlDo1up2+wl
 sFcw==
X-Gm-Message-State: APjAAAWBuP6CpHTTdTzZyrhn+PyNtN/V6oBy7+JnZnQrYPbXD9OX90cn
 Z3I5pJTcmBCnMGcY3l/ER5PU60ufBUko7rF2lG0dyfyfJgQ9G5nhabLKh1+X4W2fJKfYmQivBrK
 hoM4W5hbYr9XFEI0=
X-Received: by 2002:a5d:540f:: with SMTP id g15mr100923391wrv.86.1578336965850; 
 Mon, 06 Jan 2020 10:56:05 -0800 (PST)
X-Google-Smtp-Source: APXvYqwuFXh+0WvXkdx1l2fRevVEuEYiwYRoQxZqZK+4WnP+OCWaVuZgqef83GUj+oDT/dKUVhTtMw==
X-Received: by 2002:a5d:540f:: with SMTP id g15mr100923364wrv.86.1578336965574; 
 Mon, 06 Jan 2020 10:56:05 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id g199sm24473198wmg.12.2020.01.06.10.56.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jan 2020 10:56:05 -0800 (PST)
Subject: Re: [PATCH qemu v2] spapr: Kill SLOF
To: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?C=c3=a9dric_Le_Goate?=
 =?UTF-8?Q?r?= <clg@kaod.org>, Alexey Kardashevskiy <aik@ozlabs.ru>
References: <20200105234242.78897-1-aik@ozlabs.ru>
 <20200106041940.GV2098@umbus>
 <80157816-7859-3450-6a2c-ab151be5ee94@ozlabs.ru>
 <20200106085042.GW2098@umbus>
 <741e9b5e-6a7d-66a4-451d-e37c30697b2b@ozlabs.ru>
 <b0587d24-c7f6-ff1f-9527-ee389bd25b1f@kaod.org>
 <CAFEAcA9ZrTgPBxBq1rBo0u4z2SB=YHpWx_WUuycXK6pahARuXg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <b67cd7f5-b8ca-631a-f349-234789b9df12@redhat.com>
Date: Mon, 6 Jan 2020 19:56:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9ZrTgPBxBq1rBo0u4z2SB=YHpWx_WUuycXK6pahARuXg@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: xr1TD4bDM_Cp7B0YhuBCuw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-ppc <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/6/20 6:25 PM, Peter Maydell wrote:
> On Mon, 6 Jan 2020 at 17:09, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>> ARM bootloaders are also embedded in QEMU's code. See hw/arm/boot.c.
>> You could improve a bit the definition though.
>=20
> Given an opportunity to restart from scratch I don't know
> that I'd do things the way hw/arm/boot.c does. The initial
> idea was really simple and straightforward: 3 or 4 insns
> which just set some registers and jumped to the kernel.
> Fast-forward a decade or two, and the complexity has
> significantly increased as we added extra tweaks to deal
> with SMP systems, the GIC interrupt controller, boards
> which need to do some extra odd stuff, CPUs which start
> in Secure state, 64-bit CPUs, mangling the DTB, booting
> multiple flavours of image file format, implementing
> various 'firmware' functionality and APIs, and so on and on.

:S

> Insisting from the start that QEMU emulates what bare metal
> hardware does, and doesn't get into the business of faking
> up the behaviour of firmware would have been a neater
> separation of concerns in the long run.
>=20
> To the narrower concern, yeah, on the arm side we
> just embed hand-assembled hex values in the C file;
> this is mostly to avoid needing a cross-compiler setup at
> QEMU build time, but it also lets us hand-patch the
> binary blob at runtime to fill in addresses and so on.

This was also before we provide a handy docker image with cross compiler=20
for about all architectures supported.

Maybe the cross-build-guest-tests target from tests/tcg/Makefile.qemu=20
can be reused to build spapr-rtas.S?


