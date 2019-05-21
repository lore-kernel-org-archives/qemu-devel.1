Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58559C04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 12:49:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13191217D7
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 12:49:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uhFk7e3+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13191217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53045 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT4Cr-0005K0-W4
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 08:49:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hT4Bu-000516-GU
	for qemu-devel@nongnu.org; Tue, 21 May 2019 08:48:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hT4Bt-000866-NW
	for qemu-devel@nongnu.org; Tue, 21 May 2019 08:48:26 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:45500)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hT4Bq-000813-1t
	for qemu-devel@nongnu.org; Tue, 21 May 2019 08:48:23 -0400
Received: by mail-oi1-x244.google.com with SMTP id w144so12626039oie.12
	for <qemu-devel@nongnu.org>; Tue, 21 May 2019 05:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=8yEHaNg2UNaklGEubbtypf0kpgUD/Vb1S3yungnkSPI=;
	b=uhFk7e3+uOQ9n+dvo9/5/665cLG54rONmnoCRxcS6OgY4KYpjFrbyf1+trSfev9bXt
	07tpzv3o6Vxt4b1lbtqoou+TsdINlIzlunaI6bExPhVHRwUw8AjZUF8z7NijvHBN+y9F
	yPdvbWZmQHpsZfRIeyYYiik3xSKWg+l+NwTZc8IQ+BSCXnGYRRDS84nnpkeER+tqw+3m
	dSiM0+iXSfTTa9yXLpFyT2tMYPs6oSI3uvR/kROY9w4NWhO9UPd5VJRQIRYETnHYRSl1
	T2lN6wtbGloLGMUo3BYpv0tElvNxnZfZQkhWrNYQLUPny1NgPumBtb5+i2iRmLqEfsyx
	5Sgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=8yEHaNg2UNaklGEubbtypf0kpgUD/Vb1S3yungnkSPI=;
	b=gCNTPJh+7cfblTkRBBaO12RpoTF1t5K5DsowC55H7MP++T+85ukySYc87fHxO3kZZZ
	PSQR0fwhag1zoBy1zFLFWlKvnAmbY4w5CzL/ty7CxrQ2t8GJ50NTs7vt4XdJI6vDjihu
	f7RF5NeuCU0eJDxPbx2Dud3fwlJmdC7Moz4sK4qSc+SPlC1RQzkVwbwE6/duatJcRwY3
	k+K3Z+bVTj+MBhLH8wkZzkhH0EIA9XcgpWpkSc8UAgMidc4Mr6MGd3lLoyx4Ss7NIgwo
	8t54E7cF6nmyqPA3DGiio4i4I25x089q8lN5W3kTkLOTUoODWzaQZVOYLHw7hdcHS9o7
	NvyQ==
X-Gm-Message-State: APjAAAWkivBxfBc3S497iWE5i0niteGed3W0NyppoksGRYAgJo8e3Veb
	fCUQAMNAQVJv3Njm0/Rq9CUEvMaXEeOJw9ASghk2oSkNDmg=
X-Google-Smtp-Source: APXvYqx9yiWWmMrGX9ZrKYN/5aTou9ljQAkVeQ34N0akSsXy5ELEwMBKtHX6nLJ1G9u4yMGUb1hPJPb7MeiJ2CFp32g=
X-Received: by 2002:aca:4e42:: with SMTP id c63mr3312649oib.170.1558442900340; 
	Tue, 21 May 2019 05:48:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190521122519.12573-1-peter.maydell@linaro.org>
In-Reply-To: <20190521122519.12573-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 May 2019 13:48:09 +0100
Message-ID: <CAFEAcA_EE3knqwYQ9Bk+ZJT5z4Ko_RTiO=LnfCOCMSZr7vngOg@mail.gmail.com>
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::244
Subject: Re: [Qemu-devel] [RFC 00/10] Add kernel-doc support to our Sphinx
 setup
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
	Eduardo Habkost <ehabkost@redhat.com>,
	Gabriel Barreto <sbarreto.gabriel@gmail.com>,
	"Emilio G. Cota" <cota@braap.org>, Stefan Hajnoczi <stefanha@redhat.com>,
	Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 21 May 2019 at 13:25, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> Hi; this is an RFC patchset which I'm sending out mostly to provide a
> work-in-progress snapshot

...patchew tells me it was sufficiently work-in-progress
that I forgot some signed-off-by lines, so for the
avoidance of doubt, all patches in this series can
have my
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

