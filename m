Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F23C43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 09:42:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06F61206BF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 09:42:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yzg/vQuO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06F61206BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54880 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hL2oH-0008C5-5n
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 05:42:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL2mu-0007RT-QX
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 05:41:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL2mu-0005J3-04
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 05:41:28 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334]:43256)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL2mt-0005Hs-PN
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 05:41:27 -0400
Received: by mail-ot1-x334.google.com with SMTP id u15so8002702otq.10
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 02:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=ijk1o2ge62wcY3D/7EY25+VIN8rwk4d/VXp1pxEpnWc=;
	b=Yzg/vQuO0WMtn/lzNjp3YlXiEwcSDjZ8TjziJeusooelssFUJYfBwmRSik++wrK97f
	24whv1kDLxz5N5h4uH3/7oduz+VYMuuCGAHS92cW6C1W3+mnehVgfprw1d4KBnFQ0YxQ
	Z0wMCQOODWIOfJGtV/0mo/KNNhv6cfrp21Fy4Eo+1+FRm6iPtMb6DeCJEkPc11Um65EV
	qvyYp3tlHZGQwmAA5lLqvF/ePJ7eR8Zhon6ZEz0XvjBOX3fwCzsw4r9UvkoZE4Gfc0Kz
	eyl9UYtZouJ7T3KDy04ZwJXDVecy14MvfI5p/g/N3hUkt2uVbOdN3/fNfZg3r4nULi1v
	kOUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=ijk1o2ge62wcY3D/7EY25+VIN8rwk4d/VXp1pxEpnWc=;
	b=hYvW33TJYlY+rrbMgOA1cRn14QgAVyveLYEa0wrWr5PdLlk+t9QaZ4E+jKrHmWXFJu
	9BKvQ9aPpx5b/W3zKe1OvtIBM82rxZAc0nMVc0y/PIbthaTzEG71RIHe5qZ7x6XBEflW
	26POce3urYznb9oFQXcxAWlpv98j+o10zuY1YpEa+fK8ycEpyBpg1Ot9c4Z6Nb7RSTSR
	r06V2p7znnWG7ADEoMqOKJkJVansDGa0d8+YXpZJpR4fDQXgMMEgDJu4og84m2wwBcp8
	N1xDZUkFTLt2bvZvvtDlK5Ad4zu7DoWWwH0rab/3uvFpGtfRbqp6Hmaw93JnmJvGKhmB
	mORQ==
X-Gm-Message-State: APjAAAVW3I7eTLEVaBYM6MXl1mSLLfUE7p6xrIvoVsd+4gZHoOrHVHFm
	Ez2LeaC6KmFGgYlQLcrxmak8/DxmmVM9StabLSL+gw==
X-Google-Smtp-Source: APXvYqwPvzfJ5UFc79nwxBR7g5z2lEWIaYpfILtnWZmz5tGtOdTPPqi0oXSppVS0jhjK6Evw1dnaxy7HJMCSQMe2IfU=
X-Received: by 2002:a9d:61c6:: with SMTP id h6mr559982otk.316.1556530886197;
	Mon, 29 Apr 2019 02:41:26 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1553510737.git.damien.hedde@greensocs.com>
	<bf7dcbc7-5dc6-6269-87e9-44f027946cd9@greensocs.com>
In-Reply-To: <bf7dcbc7-5dc6-6269-87e9-44f027946cd9@greensocs.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Apr 2019 10:41:15 +0100
Message-ID:
 <CAFEAcA8e9Ua8p4LQ=VFkZE69_vr+-EW-bjKX9W-LmgZmvho7Sw@mail.gmail.com>
To: Damien Hedde <damien.hedde@greensocs.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::334
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
Message-ID: <20190429094115.KxvxAd7sPaQnUxuIxyVPeA2LMQESxMrQJqhV4pxfMRo@z>

On Mon, 29 Apr 2019 at 10:36, Damien Hedde <damien.hedde@greensocs.com> wrote:
>
> Hi All,
>
> Any comment about this ?

Sorry we haven't got to this yet. This is on my to-review list,
but so are 23 other series, and I've been on holiday for the
past week or so. I will try to get to it this week.

thanks
-- PMM

