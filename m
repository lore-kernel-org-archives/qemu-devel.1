Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A46FCC282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 13:46:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D7F420881
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 13:46:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gk5/42pf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D7F420881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36665 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTo31-0003d6-MA
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 09:46:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hTnjq-0005DE-1S
	for qemu-devel@nongnu.org; Thu, 23 May 2019 09:26:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hTnjo-0007HX-RW
	for qemu-devel@nongnu.org; Thu, 23 May 2019 09:26:30 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:38926)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hTnjo-0007HB-Nn
	for qemu-devel@nongnu.org; Thu, 23 May 2019 09:26:28 -0400
Received: by mail-ot1-x341.google.com with SMTP id r7so5387626otn.6
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 06:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=+msFrWg8pYsDoiAgT2Yt57n7J0ivFIp9RtalhZcUqvg=;
	b=gk5/42pfe86K3GfnuSzlz2G5xyoGz0yDqNZouWBhUCsusL75HTvdQY5ZEt8J7ETarC
	aq8AQ6qqIQP4dFmj5caRJeGsJawPiQIpKBG7R6MSlDPedz6VMguLluRBUabKkTEZkfsm
	0U+t0fzIBGK5VshpbV3vkpZdqt4gIds3D8MGKp8EsOdAvs/AeHlIR8WgiNbJh56Q5uwh
	QjUV88T9YM4eQl4FDLZ8IzItETeFVUkkXJ3un1XaxKQ5/v3RhPdKt9rDbOhfG2Y3R7hM
	9dihCbisrmzWrkiuzQzz8RbBog8rb04mZ/ZVI8F3SG69kR4Gczg0Tq/Sbdh92hGsDVGE
	WAQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=+msFrWg8pYsDoiAgT2Yt57n7J0ivFIp9RtalhZcUqvg=;
	b=IY+bezfIF4j2bZ1zP5Iu8HTTC65/jtcAjz7YWuSTQtB3KvEheo4yhiJGFf7QTmiAFP
	rz43sH6mI/dbF28sxZa0YD6/PMN2JgqliSj8ThZLUlpr4BgGtiGv/eEO1KlNFp9eq31v
	fvgHGPIAFtG7+bcWGXRIdNH9HrbTgIe0GVy0UerBjpSzcItbB6o3whUIB2ILzw6Um8hV
	bq1hicYiKfsiuMu9k6NPMIU4ePdeYn6Nj3egpyfnfzz8Z7fKSLFIn+WGJ8glVHrXmyPf
	rP5T8Q/cEupxh3QnOQFxwSu2Aa32xorgnPg0EVhqo9Fj6Uldmk59w4ampxM/YOv2ur1u
	Hwnw==
X-Gm-Message-State: APjAAAXjkt65YnafWNHDyfmBfO4RtT9HDOrJTGveug+vpTNbXe5gCoHb
	/bfUwZzvcw28i+ziTpDXAaUMmOkbWU8keLL4bkv3Ws6qcN0=
X-Google-Smtp-Source: APXvYqx6l7gLCrhREjRNayyV9qwIWKpfAjUAQjjkOsWIAq6wrErlIWBydFL0RqcpGTZMZwBlJ1DnRvhdA39Nql44sbw=
X-Received: by 2002:a9d:5608:: with SMTP id e8mr204221oti.135.1558617987191;
	Thu, 23 May 2019 06:26:27 -0700 (PDT)
MIME-Version: 1.0
References: <1558550785-20098-1-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1558550785-20098-1-git-send-email-aleksandar.markovic@rt-rk.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 May 2019 14:26:16 +0100
Message-ID: <CAFEAcA_gW9PZFTB42LRXCPcD+aiWBdH3TQX7nHad_5=ioRm-ug@mail.gmail.com>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] [PATCH 0/5] linux-user: Support signal passing for
 targets having more signals than host
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
Cc: Laurent Vivier <lvivier@redhat.com>,
	=?UTF-8?B?TWlsb8WhIFN0b2phbm92acSH?= <milos.stojanovic@rt-rk.com>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 22 May 2019 at 19:57, Aleksandar Markovic
<aleksandar.markovic@rt-rk.com> wrote:
>
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>
> Most of the targets (including Intel) define 64 signals. This
> creates difficulties for targets that define, for example, 128
> signals. This series adds support for signal passing even if
> the host defines less signals than the target.

Could you elaborate a bit on how much functionality
is provided for signal numbers which the target has
but the host does not? For instance, it seems likely
that attempts by the guest to kill(other_pid, sig) will
fail if sig is not in the supported-by-the-target range.
But is it possible for the guest process to deliver
one of these signals to itself ?

This patchset is interesting because in fact pretty much
every target supports more signals than our host code
can provide, because the host libc steals several
signals for its own purposes and QEMU can't use them.
Being able to multiplex several guest signals onto
one host signal might let us run some guest binaries
we currently can't handle correctly.

thanks
-- PMM

