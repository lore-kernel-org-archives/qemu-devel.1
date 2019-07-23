Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21CB9C7618B
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 13:02:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF2FE21670
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 13:02:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JBbRJf7u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF2FE21670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpuQr-0000uJ-22
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 09:02:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50834)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hpuQe-0000Py-EX
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 09:02:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hpuQd-0006zc-GY
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 09:02:04 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:45151)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hpuQd-0006y9-2q
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 09:02:03 -0400
Received: by mail-ot1-x344.google.com with SMTP id x21so5462850otq.12
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2019 06:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=hHIMmXm2SuvfFImb+GQbXb2CtHrx3LFY99CRFUUEgUA=;
 b=JBbRJf7u0f3+1VA79hnNgG+KTg22Rc74SdjF0i80VYLaaOJ+cys7uF0VOXIiDdlaO0
 oeQtOvX3GdM9ZzFinhcmNvXwporGPeM4dS65ym/qFog9lzKOpX+oVY6GzI9k6s0bv/xa
 7MiW9Xchiv1A7VOuYOy0cYT7IphQ/rIqYdVCBlo0QXWcBRG/qQMivocpnZLt9ZaZeIFE
 tLbsiYj7Tdw2D1dI8rSd7dMwI9TS/p5WqogiIcCSyhk3pJ8SsRkXODbNmjLZ8WJb9e3X
 +dv6bgJ8tivqseLI/UXybmK06rDSW5CJnzmoGHHLF5N1wcEfKXv6QMN6TJNH3awzTqsq
 XfDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=hHIMmXm2SuvfFImb+GQbXb2CtHrx3LFY99CRFUUEgUA=;
 b=t9JgP96kAogSFnx/cdh6GJM0727eAJorkrvhkVZMpKgyQWVqppul5hsTLMrdpRxg4E
 UAGcReRcC9WBKY1cz2ylLDLSy3zTtakuViCU1O2W62xGROHzo9pihWstSlxovidoIz4E
 0uJTTKrhFsl4TKohlx8km9bLNad2NyL34XaJzraUFimM+OVogB4tuKVCNjnMUoluvDyu
 7xiedgwfvi/csfv98iQ0B/Wi1qcmvsMaD9PDSXTh/M9piIAmKyZPTrCmS86awhxLoKhS
 IEbB5sn+pFC42NXPU91IB6+F/8BXpREPOoU4TbVyfMo82e9xjwpuVXLH8yeM/Uh48FRK
 71KQ==
X-Gm-Message-State: APjAAAWioOQOZxlSstYfDAZyrXANQjZ75VVCZP4/sfc3wTb+iy+0k2AS
 sWcDjZWgsDLOZIL6Fi3daIJaEnBcgRQvRlCQzeuvbw==
X-Google-Smtp-Source: APXvYqzrXHmyB+MaiKuhckVt4Rr0BN03xdjrSogbW2piGb2ONbDwRsacuEeKIdkurSjL8M4nYwy70GgDenInf+ABsjo=
X-Received: by 2002:a9d:6a0f:: with SMTP id g15mr26001884otn.135.1563886921669; 
 Tue, 23 Jul 2019 06:02:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190723103612.5600-1-alex.bennee@linaro.org>
 <CAFEAcA_P_Bk0bNGCW+TwhQGCeqM-XZd3OudKZ4tu0fNThFH5ww@mail.gmail.com>
 <87imrt0y9a.fsf@linaro.org> <451b91c6-3a4d-afb4-30f1-595fcc7e5f65@redhat.com>
 <CAFEAcA_O4kegKUsSfzQhBp_AnV_uD1S=F4pm0V0nG6XQ2Dyseg@mail.gmail.com>
 <87ftmw29i2.fsf@linaro.org>
In-Reply-To: <87ftmw29i2.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 23 Jul 2019 14:01:50 +0100
Message-ID: <CAFEAcA9nmmoHD3Sa2bknbuDW+Qv-mJ8f=YDNFsuMSV0KqY3_Yg@mail.gmail.com>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PULL for 4.1-rc2 00/23] testing updates (green
 CI!)
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 23 Jul 2019 at 13:58, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > On Tue, 23 Jul 2019 at 13:16, Philippe Mathieu-Daud=C3=A9 <philmd@redha=
t.com> wrote:
> >>
> >> On 7/23/19 1:46 PM, Alex Benn=C3=A9e wrote:
> >> >> I see Thomas Huth has a patch on-list for that, but this
> >> >> didn't manifest as a problem before this pullreq.
> >> >
> >> > OK, I'll add it and rebuild the PR.
> >>
> >> But Thomas got another error later...
> >
> > If we're not sure what all the needed fixes are we
> > should probably just drop the change that starts
> > running the iotests under 'make check'. Otherwise this
> > pullreq is going to miss rc2, and it's too big to go into rc3.
>
> I'm just double checking now - it does seem OpenBSD is very slow even
> with 18 cores assigned.

We should avoid enabling "very slow" tests in make check too...

thanks
-- PMM

