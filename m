Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74EC3C10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 20:29:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BA7320830
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 20:29:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="scUFAwUe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BA7320830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48737 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDxNG-0007iG-E9
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 16:29:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hDxMV-0007OC-Ft
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 16:28:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hDxMU-0003lq-Dz
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 16:28:55 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:33858)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hDxMU-0003lZ-3H
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 16:28:54 -0400
Received: by mail-ot1-x342.google.com with SMTP id k21so16881568otf.1
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 13:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=48gI2KKprouZYZOrB2Hir7zqm1g3ZdqiPs7fQB2qwGU=;
	b=scUFAwUetaWNeb8N1dcZbyD+IPde6Uq/d2WdT4M9XOIbswDrnFhVom99t1hXeAkw9Q
	rjn5R1bJhenTLBxdNdGFYzGSmHzA5ri0n1Kxcp5MzsCxTia5UUxiJe6za/ZhJeKovJYC
	Kasnam7JM0nyYIf5/MlFV5hYxKlBcH/tdK6sm2IXdl2yEAnTvhMRiz31m0ACWtDGk5B9
	OGg7sMwggmQnHS9zxwVqOfBJFD/O7BUIeXdHRwL9ICbXObmOAtiFOZZmAgGEBuCLMQQY
	b7FGiHfMlkxr/2F3WQi6oZE2zSQsXE8agop4kCkJXlDy/Qz8VL5yiGoDzmfZtX27cQ5Z
	He2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=48gI2KKprouZYZOrB2Hir7zqm1g3ZdqiPs7fQB2qwGU=;
	b=nKtdFp6Tpw5SF4UbOa18dO5/TrdaHA/qGjwZ1FOW3/9pOacr0k/9QKak0S0qQ31/bw
	DQ01Xd3ER5mWAN/9C7/wCdd/dAHgfX82Q3NNyb94dlVMLd7c2ROZayCWNC9zJPseYhmz
	ki2j/CkvPNL9A3Lg5/WTH14bf2kAJaHUrExhqE6zwx9ZXX4FI2Jk36MC5gbtu+HFM4KI
	P47w1N7ocGde05qWTsJwPb0uFQW2zOgAVS4ob0oExz0HKRcMIjQ2M9TNeo0IZc4h5TUN
	2XjOY/aTjgB/iKC+oFwoxo3LThRzaNZ2UvdkQ5zQdyXveTUQMFxQlCSfMAS7Zv1A29JK
	qjXA==
X-Gm-Message-State: APjAAAURehB1GNkluLUODKQcUiyzQLoAC0eaQSSxwMs1E5asx81RfHq0
	+br7vWkMQQF0nIgu+nZqxZ1Umn9rEAPsuwcprfUKJg==
X-Google-Smtp-Source: APXvYqyu0wdOHAs1a9DHL9Th2d3GZG9TRhHEwZ9bJIUtrGtOPlDiBuhS0K1PN+thLE29+R2f9+0Rc7kn5+rfLUc5ci4=
X-Received: by 2002:a05:6830:1cb:: with SMTP id
	r11mr20667770ota.302.1554841732864; 
	Tue, 09 Apr 2019 13:28:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190409174018.25798-1-armbru@redhat.com>
	<CAFEAcA8xg7wc+fX9Rn_F+L2jS0OzEwRcfjt==R5-YR6iphV=NA@mail.gmail.com>
	<CAKmqyKNAT6a+a6MyhSh7RErUOyCPnEv-RKM4S-j12GS9dUMTYw@mail.gmail.com>
In-Reply-To: <CAKmqyKNAT6a+a6MyhSh7RErUOyCPnEv-RKM4S-j12GS9dUMTYw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Apr 2019 21:28:41 +0100
Message-ID:
 <CAFEAcA9S0H=tX4wZOxwbar-UpxH3D+JUc0_6VRStz_doRKmB+g@mail.gmail.com>
To: Alistair Francis <alistair23@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::342
Subject: Re: [Qemu-devel] [PATCH for-4.0-maybe] device_tree: Fix integer
 overflowing in load_device_tree()
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
Cc: Prasad J Pandit <pjp@fedoraproject.org>, Sergio Lopez <slp@redhat.com>,
	Markus Armbruster <armbru@redhat.com>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Alistair Francis <alistair.francis@wdc.com>,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190409202841.xhMdNnkvhX5qJ8_4A5YG2KB_7Jr6k3H4OKAVnOPDWPQ@z>

On Tue, 9 Apr 2019 at 21:15, Alistair Francis <alistair23@gmail.com> wrote:
>
> On Tue, Apr 9, 2019 at 1:08 PM Peter Maydell <peter.maydell@linaro.org> wrote:
> >
> > On Wed, 10 Apr 2019 at 00:40, Markus Armbruster <armbru@redhat.com> wrote:
> > >
> > > If the value of get_image_size() exceeds INT_MAX / 2 - 10000, the
> > > computation of @dt_size overflows to a negative number, which then
> > > gets converted to a very large size_t for g_malloc0() and
> > > load_image_size().  In the (fortunately improbable) case g_malloc0()
> > > succeeds and load_image_size() survives, we'd assign the negative
> > > number to *sizep.  What that would do to the callers I can't say, but
> > > it's unlikely to be good.
> > >
> > > Fix by rejecting images whose size would overflow.
> > >
> > > Signed-off-by: Markus Armbruster <armbru@redhat.com>
> >
> > I think this patch is missing some attributions for the
> > security researchers who found the issue initially.
> > PJP's patch for this from a couple of weeks back has a
> > reported-by credit:
> > https://patchew.org/QEMU/20190322073555.20889-1-ppandit@redhat.com/
>
> It seems like from that discussion that this patch is the correct approach.
>
> I can add the attributions and send a PR for 4.0. I'll send it by EOD
> unless anyone has any objections.

Thanks. I think given it's 21:30 here I'm going to postpone
tagging rc3 til tomorrow (mid-afternoon UK time). I'm still
hoping we can avoid an rc4...

thanks
-- PMM

