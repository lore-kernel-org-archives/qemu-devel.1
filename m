Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7524C072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 17:32:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EF3A21848
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 17:32:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VvTdzWt8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EF3A21848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57881 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUE3r-0000gB-E7
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 13:32:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53399)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hUE21-0007DD-Ni
	for qemu-devel@nongnu.org; Fri, 24 May 2019 13:31:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hUE17-0005K5-Vl
	for qemu-devel@nongnu.org; Fri, 24 May 2019 13:30:06 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:40196)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hUE17-0005Je-QY
	for qemu-devel@nongnu.org; Fri, 24 May 2019 13:30:05 -0400
Received: by mail-ot1-x344.google.com with SMTP id u11so9388289otq.7
	for <qemu-devel@nongnu.org>; Fri, 24 May 2019 10:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=Vx4tTQWgEEDhUneh+utjYv491sxLZwNCyRJRcN+3dsg=;
	b=VvTdzWt85WnsRfWdSAQykoNIASGZOc+nd8ylL/E5X6EeyC1ILTeAtUhqCha8iB6c3o
	gzd0YJnFnUmrfxbxngnvX3TDG+qjHebRvFP92VDPKku0Yu3OT/asQVIv3AGvQ76JQA4w
	gov/337bxrbfJ6RxDmonwO+mqDicy0TKI9AtHTl6eCR7KgLYLNpPjj0xqPgDXcypQl/b
	AK8D6Cq+M3fNsedjFDjLKGaakTSFdvLoTQeJjLRP2YNCpVdjGcPCSfMG6fH+7110hicP
	Zj/pcQeFe7pxTfF1mBaaTXVyt7oRQHxvjI4sAnrakimpmGqb5gfTE4+noGPH/Fz2Hn1M
	raBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=Vx4tTQWgEEDhUneh+utjYv491sxLZwNCyRJRcN+3dsg=;
	b=F7JgFe1H4kgeUv4VhZNS1AOOB70qBwG3WZTJANmZSQk3KnFB9iuoubNCnHUOVTlCHe
	QERLulLP1VlnKhNyvFdx1w87ltUZAQD3Z0c+cTcZGhqdZEN66mGzy7A5m7mdtuqU+FzY
	ZbugCRPKggXLVRUcl9NOwfpIOcnVdDsu9ETKtyl8bKGFuN4Xg83EP8rmrcJQRR1gZ2ah
	iY0+9h5J6w3+NkuZwDDjS3cihtO8jdzAt6TUCG/iqG60yH8e/UKqeqbUV6pRuXMvuEWr
	5eNc5IiYnhCvcHwBRXW3WBwAlyso+nZzHerSz6CFqdDEQbFGURuEIKf+mK9SZ83NLnoS
	x2xw==
X-Gm-Message-State: APjAAAXl97DniAW4kU1GA5vwMQTCv0IqyvfI6gFzpfyte//6N3WAcVzW
	zr4xiHyuciDLUVL9NVS6sYGekObc9kbkMaEyr8R0JQ==
X-Google-Smtp-Source: APXvYqy00vTtoLjjjPTrIyedE1QJFn6oMnbtZf8B2s989K+Yf6vK9m/WYD51jbrjftHSH2XzEvKO23qwltGUXPsqh90=
X-Received: by 2002:a9d:6b0d:: with SMTP id g13mr26214875otp.91.1558719004843; 
	Fri, 24 May 2019 10:30:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190522222224.244714-1-rkir@google.com>
	<20190523102225.GA2994@work-vm>
	<CAOGAQerwpqaP=DKxC+WVdJcGpxnAayfMrwoPP=bBJBBG5Vn87g@mail.gmail.com>
	<CAFEAcA9bKQukg7_HcGKWAFmoaX+DG0NhSctzwg7mpVJ_AOO09g@mail.gmail.com>
	<CAOGAQeqEuc9T-gDWoGPmgZgOoNLA9V_h6Rwz5+PBinZe1XwfmQ@mail.gmail.com>
In-Reply-To: <CAOGAQeqEuc9T-gDWoGPmgZgOoNLA9V_h6Rwz5+PBinZe1XwfmQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 May 2019 18:29:53 +0100
Message-ID: <CAFEAcA8HDEXBHUkOVatfHBc4+8+EK3+yVj5Eigj3p8RJqQp6Sg@mail.gmail.com>
To: Roman Kiryanov <rkir@google.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PATCH] vmstate: Add VMSTATE_OPAQUE to save/load
 complex data structures
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
	Juan Quintela <quintela@redhat.com>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>,
	Lingfeng Yang <lfy@google.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 24 May 2019 at 18:00, Roman Kiryanov <rkir@google.com> wrote:
>
> Hi Peter,
>
> > In any case, migration state on the wire needs to be
> > architecture/endianness/
>
> Could you please point how the proposed change is
> architecture/endianness/ dependent?

That's really hard to say, because this patch doesn't
come with any example of its use. So I'm basically
guessing that when you say "load/save complex data
structures" and call your macro OPAQUE that you mean
"I am going to just feed the raw in-memory representation
of this data structure into the migration stream in an
opaque way". Perhaps my assumptions here are wrong ?

> > implementation-independent,
>
> Could you please elaborate, what "implementation"
> you mean here?

I had in mind the C++ implementation of unordered_map<>.

> > so you can't just send raw complex data structures
>
> Do we need to serialize (in pre_save and then release in
> post_save) our state into a buffer and to write it as one
> piece using the existing macro? This looks ok, but how
> is this different from what we are doing?

I guess essentially what I'm asking for here is that
this patch comes as part of a series which makes
use of it. It's really hard to evaluate the design
of a utility feature without a concrete example of
how it's being used. That then makes it easier to understand
the abstract feature and also allows us to sometimes
suggest better ways to achieve the underlying aim
(and to avoid making suggestions which don't make sense!)

A corollary of this is that in general we don't like to
take patches upstream that implement facilities that don't
have a use upstream. Is there some existing vmstate
handling in upstream QEMU that we could refactor to
be more cleanly implemented using this?

thanks
-- PMM

