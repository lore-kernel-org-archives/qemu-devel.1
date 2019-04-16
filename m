Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E417CC10F13
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 10:31:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABC0A20693
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 10:31:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L0FuBf5/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABC0A20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34479 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGLN0-0001RO-Vo
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 06:31:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hGLMD-00019U-UU
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 06:30:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hGLMD-0006lF-45
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 06:30:29 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:43707)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hGLMC-0006ku-SA
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 06:30:29 -0400
Received: by mail-ot1-x341.google.com with SMTP id u15so17122616otq.10
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 03:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=NLBFo7BD6wX8nYsaAoFBIIdYHciufGtKDam4ZuR8zDA=;
	b=L0FuBf5/qilVVgbf4MaRL2RN+pK7bVilcfoukA1Zn84HDezulUJ6oyrplP3RadK3l8
	NiTtKUOzk+l0N1Ot1+3GTIFNSqilAWBDmpzBTJCOlATaOxUHshpZlTfJuGpe7bCVxp5o
	peuCC+zVQBsttVf0HE0P5+8SbKZRPVB2NbbaSju8ycN5K2kqW+5ZDEqIEIj2tZdspmO9
	3b5UsPr6HlfD+GArrz4OP2qj8R4/jdwlze59OizMnQjdozL2iqnn8UdU+POuXR0qRdca
	3QeLtMP+5hRCw47uy+TvOzhGIi2PsaKMhVEEs0HSp5YdrnQhSaJa6woNvlDv0L+9OakK
	lE9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=NLBFo7BD6wX8nYsaAoFBIIdYHciufGtKDam4ZuR8zDA=;
	b=TNkMnIfLqQb94KUQuP6RI/3eSOV+NV1Of+Sb19s/iW7hpZ7qAhNpv6pOSY2g0mKFWH
	WPsargjghRa5vuV6dMmFeXKvKWFBD29hkEy4HXnBrMsuh2R1d6vo2oeaEc+as9twKHvb
	VCqbga94TufvOobZ87gl/E9x/Ko4RcgfnIpHx6/oFej1G+cBuYgJohQvfEMX7XC9/DAp
	lXk23pF4voO9JYMhE8vlgzNPiRJxSexj7IoaPObn0TizAr4K+R7XObFeZPl+8ahJtvLN
	N6uORkABFaTz8wBUlRoeiaX3aLce8PwKUBLozBrLzAvq3FxFT5fsTA9Vhyj37ev0r33C
	QfUw==
X-Gm-Message-State: APjAAAWZThhUagIx7jsihw82E5itCTJd1qaSacs0ZDBnmlsOPJTJzMFn
	BySAXqofRKtLnPYqhq+1pwIZ+OY4IruLWtx1qbQ5wQ==
X-Google-Smtp-Source: APXvYqwJloIifP1jiHlFxnUNgDV6dvLZO0KdUof/ZQfortOdJoVSr5kEqvd1escs3sFW5SQ4FY0uaI/vSQou0SNhgYo=
X-Received: by 2002:a05:6830:1497:: with SMTP id
	s23mr47671682otq.236.1555410627700; 
	Tue, 16 Apr 2019 03:30:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190415163337.2795-1-marcandre.lureau@redhat.com>
In-Reply-To: <20190415163337.2795-1-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Apr 2019 11:30:15 +0100
Message-ID:
 <CAFEAcA-v+RJ7gYyJWTcZ5SBQO1MRPdfNq6jM9yXmg8Q_ig_J0A@mail.gmail.com>
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] [PATCH v4] socket: allow wait=false for client
 socket
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
Cc: "reviewer:Incompatible changes" <libvir-list@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190416103015.z5vsNB3gYnERL4cT1tkZoZGwsvm0AkFkTYPpSxnZTig@z>

On Mon, 15 Apr 2019 at 17:34, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> Commit 767abe7 ("chardev: forbid 'wait' option with client sockets")
> is a bit too strict. Current libvirt always set wait=3Dfalse, and will
> thus fail to add client chardev.
>
> Make the code more permissive, allowing wait=3Dfalse with client socket
> chardevs. Deprecate usage of 'wait' with client sockets.
>
> Fixes: 767abe7f49e8be14d29da5db3527817b5d696a52
> Cc: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---

Applied to master for rc4, thanks.

-- PMM

