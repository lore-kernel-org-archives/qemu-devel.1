Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84383C04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 15:28:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F5AC2173C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 15:28:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dHNfwhNq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F5AC2173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55568 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT6gZ-00076d-LH
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 11:28:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hT6fm-0006lF-O7
	for qemu-devel@nongnu.org; Tue, 21 May 2019 11:27:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hT6fl-0000mu-T0
	for qemu-devel@nongnu.org; Tue, 21 May 2019 11:27:26 -0400
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c]:33415)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hT6fl-0000mP-Lc
	for qemu-devel@nongnu.org; Tue, 21 May 2019 11:27:25 -0400
Received: by mail-oi1-x22c.google.com with SMTP id q186so6422826oia.0
	for <qemu-devel@nongnu.org>; Tue, 21 May 2019 08:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=eIeFJRPiV3mX1LTw1NJ+v8QJgu+uaynSvxBaGOIJCgw=;
	b=dHNfwhNqNU8rxB2Ll7J0LxUsErYIPYH7+KET2G2BLvmpn1jGfUtECD0lY1BNU7cosV
	+EfJmGQem3QBnlgtsbZ6pbG+rWRvTduNwCvxnYdZ+k7nAkhlKysfEAQNo9PAFeXgBV92
	38xZVueDRXxTv6N4jvuijeW6mOdtKdYmZk461e/bwmbSt0j1FQ+CYUFkG4ZaFSxZRjji
	mhUwLCZQf8+hq6ne2TQgYV2Dh4fC1u2etu01ljPw0lhM5PpZAuAmUak4aor0Q0xa47jF
	wrINE6589eSAUENtVRsSkUGkZ/r9n5pJIBP/CYEhHldLxPn00fgAedop9Xj4+IVmAkhZ
	D7jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=eIeFJRPiV3mX1LTw1NJ+v8QJgu+uaynSvxBaGOIJCgw=;
	b=LovGPZSw4BtsYfWlvpGqqORzYtjyIrE6Lwthx+qOEtWPcbzQracS/w7+CtQYPRvAnC
	uM0lPvBckzjGxpj4tj+ujuTWYqcblDEo2gjV7SPf+8XlTzX4v/6y9LYqI8zwOsMreTAY
	Kjz3A0JdV1i1i/FRwz5V04TTODDuvy84RUz61jHwEfj6G+kyTFJ0LAjtIPVTK526jny1
	G72lqeiTbPtW8oKiuRqiculxfagBz5fbLzKpDwCV3uX2QdO2ioN/mWUrpumWJxQdxz/u
	fViXL79iANfN0Zl72h0mW3XAdoDpPBAEGeSFEN2buMB5230OYyCmKO56FQ5JxRgYzMVt
	uQZA==
X-Gm-Message-State: APjAAAXWchXWtdt2H01snMoiD/yPioGwGO6IcXloJExx/tX5Jk3pnl0u
	83mdd39oefAZv9VVuYsmirEFJSYmI/yG6uwezD+D/A==
X-Google-Smtp-Source: APXvYqz6bJtStwUFydFAKZnC/vVM7owiB8uL1o0YOz1E0oj9UAZy1HJCn0nLpPqY5/I7U0bFhFgKo1mraAJJF7ygLHA=
X-Received: by 2002:aca:5785:: with SMTP id l127mr3575754oib.48.1558452444499; 
	Tue, 21 May 2019 08:27:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190520184108.GA10764@habkost.net>
	<20190521085350.GF25835@redhat.com>
	<e2395213-efaf-6d6c-6cfd-d949d071b4f6@redhat.com>
	<87pnobrg37.fsf@dusky.pond.sub.org>
In-Reply-To: <87pnobrg37.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 May 2019 16:27:13 +0100
Message-ID: <CAFEAcA8db=UsyU_kRBoatFT2ULQBqL318xRhg+CV4D_7hV76Og@mail.gmail.com>
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::22c
Subject: Re: [Qemu-devel] Introducing GSoC project: API Documentation
 Generation
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
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
	Eduardo Habkost <ehabkost@redhat.com>,
	Gabriel Barreto <sbarreto.gabriel@gmail.com>,
	QEMU Developers <qemu-devel@nongnu.org>, "Emilio G. Cota" <cota@braap.org>,
	Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 21 May 2019 at 16:18, Markus Armbruster <armbru@redhat.com> wrote:
> Anyway.  What's so special about QEMU that justifies coming up with our
> own doc syntax?  Other than "we made a hash of it, and cleaning it up
> would be work".

The major problem as far as kernel-doc is concerned is that
it somewhat bakes in the kernel's style choice that the
'struct' keyword is not hidden behind typedefs, and so it
gets a bit confused by QEMU's "use typedefs for struct types"
style. The rest, as you say, is just a matter of fixing up
our syntax errors.

thanks
-- PMM

