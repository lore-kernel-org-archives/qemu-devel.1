Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6571DC04AAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 13:27:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 312D820815
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 13:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f4gYc2n5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 312D820815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57495 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRGPm-0003ye-Ck
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 09:27:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hRGOy-0003dE-AP
	for qemu-devel@nongnu.org; Thu, 16 May 2019 09:26:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hRGOv-0003Ck-82
	for qemu-devel@nongnu.org; Thu, 16 May 2019 09:26:28 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:42666)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hRGOt-00036A-Sl
	for qemu-devel@nongnu.org; Thu, 16 May 2019 09:26:25 -0400
Received: by mail-ot1-x344.google.com with SMTP id f23so3376086otl.9
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 06:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=RWE8Wqxnoy7yDykNG8cAxiV/6xlT61vLoCQAVcZbz5s=;
	b=f4gYc2n5y6dZW6Pp4BsVE7U4uMtsbqRk6uAiV8MJmkFnhnQSgroi/kq8ZGGfqXge/H
	9fFkYAzXMjIJpmMg2Nw65A8H6kALrfxas00uRLFLF5ucHhI1DRHhVD1+VlaWJPNrlTEv
	/ewlLgFUGAQGY65dTYhEAn9+gV0ss3Mf8apSo1tg9AVetOswOdp4Xui8f5zVIJqpjKjD
	7RTUDKUwbwbrP8K8pQluWjnd5d2Bs1IcPMJAw3cvHq92webO7+KMD1ToXGYJScKzXn6J
	hy4/00B1pcsosHtAQF3m+H3bZB5macFowbOh0PeylTdznG6+wILdb4C29wqgOcKSHUuX
	5Ojg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=RWE8Wqxnoy7yDykNG8cAxiV/6xlT61vLoCQAVcZbz5s=;
	b=mLTptSjS4+HBkzIMu2XUaUVrduY3pIqAOkUC8MkpMBTd7qs4ty7nkDBuozPiO3aU2g
	PygXZIl2RXUggjvtegRBgjsWiyQ2lr4C4koG6wO6H+fWT4EK5lIzONnD3uVuZllDsB3L
	0cVwgPjyYCr5MHsVT+kUX4OyokZ43wGdbgLVe8lvkzNqboR7NG75BzeRyNEsA2pNRlxK
	VLpLYUpGQ3hhtf3gVelWD4pGU4rs8kvz305lyMa0swadtShuyMrERJMIca3UJYbrXxmf
	Gjp/cFfALUZk0QO09W730oDwsOsgaxeTc6DTPFFaAj8ylwaH+fvuwSkd5Riy6uwciGfN
	t9dQ==
X-Gm-Message-State: APjAAAWKj+FlDfStJtZm5A8NDDvXVuWONEKDLuLhFcxcCnVLm4sUJ7bM
	KT3dHxoLR7Y81zJzID0Z9mwsnGsz5vDXmm9hgXrs4g==
X-Google-Smtp-Source: APXvYqy80ztwi7dFSNISqRVHLQ2649oz9PoWvu7FDvidmH+r5ZUJgOiQ4bbd9d8d6uPzC/jP/kAE8PpOTVJ1I+/jJ9g=
X-Received: by 2002:a9d:3f61:: with SMTP id m88mr3212675otc.147.1558013181543; 
	Thu, 16 May 2019 06:26:21 -0700 (PDT)
MIME-Version: 1.0
References: <20181210165636.28366-1-peter.maydell@linaro.org>
	<98f62d5c-0c2a-9651-0dd6-961a243c4519@vivier.eu>
In-Reply-To: <98f62d5c-0c2a-9651-0dd6-961a243c4519@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 May 2019 14:26:10 +0100
Message-ID: <CAFEAcA_AqVBcjSsJkkruO-rGnvJSiOq9w2RW7VXVCXJu5kXW=A@mail.gmail.com>
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [RFC 0/3] target/m68k: convert to
 transaction_failed hook
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	QEMU Developers <qemu-devel@nongnu.org>,
	"patches@linaro.org" <patches@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 3 May 2019 at 18:12, Laurent Vivier <laurent@vivier.eu> wrote:
>
> On 10/12/2018 17:56, Peter Maydell wrote:
> > This patchset converts the m68k target from the deprecated
> > unassigned_access hook to the new transaction_failed hook.
> > It's RFC for a couple of reasons:
> >   * it's untested, since I don't have an m68k test image
> >   * the second patch just makes "bus error while trying to
> >     read page tables" be treated as a page fault, when it
> >     should probably cause a fault reporting it as a bus error
> >     of some kind
> >   * I don't understand why the old unassigned_access hook
> >     set the ATC bit in the MMU SSW, since the docs I have say
> >     this should be set if the fault happened during a table
> >     search, but cleared if it's just an ordinary bus-errored
> >     data or insn access. Probably this is a pre-existing bug?
>
> I think you're right. It must be cleared on bus error.

Thanks for the review of this patchset. Is there anything
you want me to do for a v2, or is it ready to be applied ?

-- PMM

