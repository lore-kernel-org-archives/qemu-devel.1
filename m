Return-Path: <SRS0=VGOL=SR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E3E1C10F12
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 15:52:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA5C220880
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 15:52:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j7d1HL6r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA5C220880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52105 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hG3ty-0005P3-Ua
	for qemu-devel@archiver.kernel.org; Mon, 15 Apr 2019 11:52:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44608)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hG3or-0001pU-5t
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 11:46:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hG3oj-00011w-Uj
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 11:46:48 -0400
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231]:43547)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hG3og-0000vZ-1A
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 11:46:42 -0400
Received: by mail-oi1-x231.google.com with SMTP id t81so14178733oig.10
	for <qemu-devel@nongnu.org>; Mon, 15 Apr 2019 08:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=Pi+xtrmHJw1pTXV/MamVxODwfyo9iS/0pcegcfVA0dk=;
	b=j7d1HL6rYA2rN6rCpE9YXymZ0xdpHBf4Fa96qWqFh4ukgsVcVh56eWJ4r//7c3WmRk
	rq2WuwBV7YIMCUU+bzzeSGwQ8u6Twyrmpu0SeZ1b6SKhuusQyKDKnq3q7DFZEnOT7M+M
	xTKgJbpo5IRTGM5w8dP88E0miGfEiurgw27QENk4j3u90UZbyMj2TRVFsju6n1254KJ6
	z137M63huGaQq3yv17cT3yI6Aa1Aq82DZ49CveJlHQH/ST0dTgd6LE9ROJNF885UOoGS
	9igXaSNL8u11m3mGdd8b55YqLAohU96jigHyKyPoJ79fLDecbXXVSFe+O2Mfrft1gW94
	hLCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=Pi+xtrmHJw1pTXV/MamVxODwfyo9iS/0pcegcfVA0dk=;
	b=HjL3sdvinZQswAahOapCkKG96rQMuJEkt1TNyP7y9xAU4I8ip67BqjnpObRiqeJfRy
	tpsP7wohXoRaR54SoEj+peE4mxmUCwh9Fit7R9jYKWB/e5KwV84teAVlTKs9ISLJMXkl
	w1WU+26UjtEDa62H6caXhvdVdr/vLxTDiRzGR9RB+4m4npMhTomIzTN/OoMWdb16j4UL
	RVu6JdNbyIWT5Imx5NwlCPU+YMDh5jlqwUyUM29GN7rS59yAfEuYfCV+Wbyd38GDmZuZ
	VVFH2+pXmDnCMr07CFoPXiVRdribB1esgfDUIEhXsh3PKClQ3VFpbujchcUURjoaq1DM
	QqvQ==
X-Gm-Message-State: APjAAAU2CwglY1b1M3kN1DfrDF4c+orIYLPZnM/h0ifqSIjTvnXZR3gE
	dFHBq3cBXjKAnpLJ4JezWB1DbUFMK3A9uxZvCXYkvA==
X-Google-Smtp-Source: APXvYqzxkd53hl/S99H1XTToNr2nMiVl5CmbFISZM9K5OxlYlqARXkA01kqF9UNc7v2tHijQtMIAUvsSM14yABoafFs=
X-Received: by 2002:aca:b3c2:: with SMTP id c185mr20635136oif.98.1555343200596;
	Mon, 15 Apr 2019 08:46:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190415141547.15444-1-berrange@redhat.com>
	<CAFEAcA9353Sar3Uny0Qvx0Ex6jP-dzE2w4AjsA4O8gCEF3RdKA@mail.gmail.com>
	<0ade556d-bdf1-4440-472a-1e3e6cb7387a@redhat.com>
In-Reply-To: <0ade556d-bdf1-4440-472a-1e3e6cb7387a@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 Apr 2019 16:46:29 +0100
Message-ID:
 <CAFEAcA-ZYZ2M-nLThqc6bP2ZqeoRUEt_-7qA3m=obTyyi=7zow@mail.gmail.com>
To: Eric Blake <eblake@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::231
Subject: Re: [Qemu-devel] [PATCH v2] vl: set LC_CTYPE early in main() for
 all code
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
	Markus Armbruster <armbru@redhat.com>,
	Bandan Das <bsd@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Samuel Thibault <samuel.thibault@ens-lyon.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190415154629.y3UmbLJOpF1ciRuW392Gf7obo3kT4nSZc2eTuUEiE-g@z>

On Mon, 15 Apr 2019 at 16:25, Eric Blake <eblake@redhat.com> wrote:
> "two known problems" but...
>
> ...three bullet points.

Nobody expects the Spanish Inquisition to be code reviewed :-)

thanks
-- PMM

