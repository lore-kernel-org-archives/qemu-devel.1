Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D526C43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 16:05:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED2A92087F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 16:05:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QQzpLuqo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED2A92087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42980 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMah2-0004nl-36
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 12:05:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hMac4-0000Rn-Us
	for qemu-devel@nongnu.org; Fri, 03 May 2019 12:00:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hMac2-0003Ad-Tz
	for qemu-devel@nongnu.org; Fri, 03 May 2019 12:00:40 -0400
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e]:41637)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hMac1-00038c-8D
	for qemu-devel@nongnu.org; Fri, 03 May 2019 12:00:38 -0400
Received: by mail-oi1-x22e.google.com with SMTP id v23so4795655oif.8
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 09:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=UryPuS+KNZtgHQBCrWBR74q8kdkTnuRZE+e5Ns822Pg=;
	b=QQzpLuqo2xP+Gk/ZNBmJ5URCiJPPjjnPJ+Q5zziIhJPbC5JcHaSeA3ta87udIG1xZW
	3X8KkkkmdSc8iAMkx4dJoSjzyd9N3B8gU8tJIzFbnfKxdMlcOyzDjtPrQL/kKQbb6eTv
	MkGZBVxumkmRno/bdQndGesV/QKHz4zSiAK1fW6utkAaUqTdDjwTvIDjxePoS3ICMAb4
	gxQxVRMWlYQaHrt5f+XsGzDN/irPmvQMocG5bo9lsC4/ua8wE9R05gyqspn+Sd6mxEmZ
	OWqWqdp/WR1wHtNoi8r6cx8Rb/8D3aT7Y63wOODS6vkrsUn1FscWlGr6004XSUECkmvc
	OWMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=UryPuS+KNZtgHQBCrWBR74q8kdkTnuRZE+e5Ns822Pg=;
	b=AaEQEBhW0ir/siYSG13wvjh7mW5dGxZeccnN4kwjqK/LAiqbh6wmqzIWR+PTHo+KY7
	m7+gqAOzM/7Jd3rkS6NaAhMej2zMv3V4PsZG0jFBY+JsIZ0un8LrSYba7u/r1NyfpSsx
	KDSkbCa62pHR08mxLoT7i6TkXiBvmO6kdSDnwxZyXe9m9LVk9mtTS3IH8GfTXpi8JkOU
	8KMZ+k+Xta6TEYDm5b4mT/I+V8OIMgSibO7sKTwrkFqD3uMEbAng146l8xV+6F8jRAYL
	A575elIaYhBYUwAD82wWHfabWmP//GeH/2sXAMq/5fC9scq12rG4iJ05PfoAwbgTcwBd
	fc5w==
X-Gm-Message-State: APjAAAVBH3n3xHKjTCQt2oAx8eaZZK3ChiLzvvRkVYkv4Gs0Cpqa+8Yp
	mWvxm96Xg5WxSSAa80FWC+I6/SdAB1CipF98qeQRKQ==
X-Google-Smtp-Source: APXvYqzpDhA1bWyTuaiq+2EvkEPZoKL93YJ446+61eGUH5vaCellCtfWvKXHaHFrx9z8OOIUx8asSldr2ZdbmVf+PwU=
X-Received: by 2002:aca:ab12:: with SMTP id u18mr5951214oie.48.1556899235809; 
	Fri, 03 May 2019 09:00:35 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1553510737.git.damien.hedde@greensocs.com>
	<bf7dcbc7-5dc6-6269-87e9-44f027946cd9@greensocs.com>
	<CAFEAcA8e9Ua8p4LQ=VFkZE69_vr+-EW-bjKX9W-LmgZmvho7Sw@mail.gmail.com>
In-Reply-To: <CAFEAcA8e9Ua8p4LQ=VFkZE69_vr+-EW-bjKX9W-LmgZmvho7Sw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 May 2019 17:00:24 +0100
Message-ID:
 <CAFEAcA-TrYPeESbxOjpd49F+iZHWSrwwpRwai21_jhmZJ0Xonw@mail.gmail.com>
To: Damien Hedde <damien.hedde@greensocs.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::22e
Subject: Re: [Qemu-devel] [RFC 00/17] multi-phase reset mechanism
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Edgar Iglesias <edgar.iglesias@xilinx.com>,
	Mark Burton <mark.burton@greensocs.com>,
	QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
	Alistair Francis <alistair.francis@wdc.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
	Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190503160024.QvURv5o80y9EbyRdV-4EnWGipdog4_x9mNBMKcUejCY@z>

On Mon, 29 Apr 2019 at 10:41, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Mon, 29 Apr 2019 at 10:36, Damien Hedde <damien.hedde@greensocs.com> wrote:
> >
> > Hi All,
> >
> > Any comment about this ?
>
> Sorry we haven't got to this yet. This is on my to-review list,
> but so are 23 other series, and I've been on holiday for the
> past week or so. I will try to get to it this week.

I made a start on this, but it's going to take me some time
to wrap my head around the design and the issues you raise
in the cover letter. Given the bank holiday on Monday and
some other commitments I have on Tuesday I think it's going
to be the second half of next week at best before I can
do a proper response.

In general I like the code (though as you say we may not
have got the interface quite right -- I had not appreciated
some of the nested-reset cases when I proposed it I think).

I think we could use a document (which would eventually live
in docs/devel) that describes the reset system and provides some
how-to style documentation for
 * what you need to do if you're writing a device
 * what you need to do if you are an external user of
   a device model and you want to reset it
plus some notes on whatever we still have left over as
remnants of the old reset scheme and any intended transitions
to try to remove those remnants. I'll have a go at writing
something because I think that will help me personally in
trying to understand the problem domain and what the new
design is doing.

thanks
-- PMM

