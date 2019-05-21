Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B48D0C04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 09:43:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FA6821479
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 09:43:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G/CJe8uU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FA6821479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50222 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT1Ij-0007mp-Qg
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 05:43:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hT1Hy-0007F1-Te
	for qemu-devel@nongnu.org; Tue, 21 May 2019 05:42:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hT1Hx-0008CH-Rr
	for qemu-devel@nongnu.org; Tue, 21 May 2019 05:42:30 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232]:35729)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hT1Hx-0008BM-K6
	for qemu-devel@nongnu.org; Tue, 21 May 2019 05:42:29 -0400
Received: by mail-oi1-x232.google.com with SMTP id a132so12315757oib.2
	for <qemu-devel@nongnu.org>; Tue, 21 May 2019 02:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=YGPhBrMbFHeaOXlSYWGQD39Pk3ODT4SKRb0H4QrfiRw=;
	b=G/CJe8uUjr2oVDSlU+0fkgSBTfRPjTXpaCHhKVgX/AcrkugeLaNNsKd3Qku6MsxXZM
	/S4G5FinxDEUGZuKRxQ78brpJjKSjrk3ryUuv9n+aD6soSxYNTRMbzRxuigcR2Lsdkhv
	BhZmp6zasL7HyOYNqUePQngZ/viHZ+2+ZRiry5KAr5KS240FDcd+uskjsbI+HD3OIvCy
	f4wuqu/TjfJmWCOitZh9yWgDnlopg5LmYtYf0MlKx+KlNNdofkZAPFxE9BFNtJVZHeXl
	G90HI50iGl4IJIZLPNR84ZyjBaPVExe6RbiP5sOIgtbSiXVxB0iZPzNy4vlrxfinjbYz
	nSDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=YGPhBrMbFHeaOXlSYWGQD39Pk3ODT4SKRb0H4QrfiRw=;
	b=q1akSx6IFCeDvzx/kQzq/AP3kZJ69Rqdxh0H0TB3f4IKk6hh1vc0Rey8wBrWJuN+Mj
	ythw28R1zE8E0aCR8hsG9DF8BV9XVPulcxJWmO98NZWKasXU43iiTaYKa8j/6u0k4Azr
	ODWePa7vmUteS4lSN5fbEVXahqkPr/NpyE5yFrMTBTkf9wg4Y/XxiqOUdIrw9sxR5qlM
	arFMoc1oP4wpx25OFrPmHlZAONMBjTQiVKtEEWhUJFsXhy0beTSctv2rTA3YWaXG6yry
	mv3S6CXrUyf2dhxAx7s+ii4sAyLO7mUPO0wpmGnPBvb2k54JMlgB9IhvcNG6EgQh/zXE
	9FTw==
X-Gm-Message-State: APjAAAWO011qcL9uJsuHw+f5rrdDpBG/n6+lzx/6k2MGzI5FgfYO5cOk
	1lIBomQupUJdZ/4O1unZNzQgZa8wajsWl5DQf6GYbg==
X-Google-Smtp-Source: APXvYqw7Jp7m9v6JAqyWR29apgaa7lFxRtL5MzJqMP7GPELiZCHd+DqZKJknyZvzkfMBj0YXtG/3R9EID1cQFiciiGo=
X-Received: by 2002:aca:b1c1:: with SMTP id a184mr2785638oif.98.1558431747442; 
	Tue, 21 May 2019 02:42:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190520184108.GA10764@habkost.net>
In-Reply-To: <20190520184108.GA10764@habkost.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 May 2019 10:42:16 +0100
Message-ID: <CAFEAcA_jn6VBHMoKoGRojGTEQXOyzLtPG-rCE+uAt3BDBxYOBw@mail.gmail.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::232
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
	Gabriel Barreto <sbarreto.gabriel@gmail.com>,
	QEMU Developers <qemu-devel@nongnu.org>, "Emilio G. Cota" <cota@braap.org>,
	Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 20 May 2019 at 19:41, Eduardo Habkost <ehabkost@redhat.com> wrote:
>
> Please welcome GSoC student Gabriel Barreto.  Gabriel is going to
> work on QEMU API Documentation Generation[1].
>
> Gabriel's first task is to evaluate our options for extract doc
> comments from C source code and integrate them into Sphinx
> documentation.  I saw that Peter has experimented with kernel-doc
> in the past[2][3].  Has anybody evaluated other alternatives?
> (e.g. Hawkmoth[4])
>
> [1] https://wiki.qemu.org/Google_Summer_of_Code_2019#API_documentation_generation
> [2] https://www.mail-archive.com/qemu-devel@nongnu.org/msg411643.html
> [3] https://www.mail-archive.com/qemu-devel@nongnu.org/msg411841.html
> [4] https://readthedocs.org/projects/hawkmoth/

I think that kernel-doc is broadly where we'd decided we were
going with this. I have some in-progress patches that do
some integration of it: mostly just rebasing of the patches
in the git branch mentioned in your link [3] to be on top of
the sphinx support we now have in master. I'll just give
them a quick dusting off and push them out as an RFC, to
avoid duplication of work.

(The other interesting thing I'd wondered about with generation
of docs from code comments is whether we would get better
(ie more accurate, regularly updated) documentation of our
supported machine models if we generated those parts of the
docs from comments. But that's definitely much harder than just
getting API documentation, because it involves trying to
integrate them into a 'user documentation' manual which we
have not yet converted from texinfo.)

thanks
-- PMM

