Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D033C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 10:06:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C68D20709
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 10:06:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ByNIU5Gf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C68D20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuvrc-00068U-B0
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 05:06:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38894)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iuvq6-0003O8-19
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 05:05:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iuvq4-00016r-Oz
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 05:05:21 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:45285)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iuvq4-00015R-Iu
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 05:05:20 -0500
Received: by mail-ot1-x344.google.com with SMTP id 59so1076620otp.12
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2020 02:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5nTWtV7lYukw91KpsAmGaCUsmanaGccNVUAvd8pQvGs=;
 b=ByNIU5GfDgKvdSQXlPtHFOhUl7EAEdZcioOWGYMfCFRMh1c07xVxzSWCZLsaVrh4Us
 99whgTD6GRR6bQz5nOdLY2gK86DCW9LVDEAnlb7x/DQsKMNxcNSoGMldtaaeupqSuYr3
 fG/xQBNvLGsXIG6Ph3E0+DOU9E6Od2eqAipCAcv2cdwgl3vEQQGlRVJmOyg5iv4iGZZZ
 AClhQ4cyIuIBQEICzIyHr5I8S6jzaOaXF1rtdsdj7RjddLftRNMJqzAkfBe8SLJR0V1Y
 qgCivGXmU4FOG+KGmAhxL0QzMFsQan+AjQYFdSFHMbKp/s30UwGp/9Q8LISsmNrMEmel
 ev1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5nTWtV7lYukw91KpsAmGaCUsmanaGccNVUAvd8pQvGs=;
 b=GlabRniXH/tgH6ELXwtI3+UZYntzNC55mQuc2D55FehKzWGyoiZ6nsQD7lDzHpHENa
 Q7+QkxX9cJPSt1Y69Dlxxog8SrHKGpw/rsbevCUEk5NEW9aYf4I5l46vEQ1am9I1MYZe
 m/YTfhR4B7k6omNPm/XkjcpG+Xxo7AVGXjBFIKTNm2L+Xjpljz/783uIbkQOCd5l8cp/
 zmR2G8oumqB0Cz+XgDeysmDne90cK/TlDqlWB1PRr3kwlc+UmqEqHvYHoc+wADl5R4s1
 FCJ/Obf9g8YiMffX/0boLI7U4/yTB69Wg4dptCKHvYZPKmcq6pBaHSB8/cARyH1Gn6di
 y/3Q==
X-Gm-Message-State: APjAAAV6PpbqtBKyYehHF98Gy+38S+03JcgviNnDIzpVwbAxm+cHFP84
 9t/n+hRaoNQY/cdAx2xArDhWFy55bIjEsOthaIUBgQ==
X-Google-Smtp-Source: APXvYqwBxzvQwY0N9sFHUW9ZPPq2vVPgAj/+kV4Mu7iKr64k490XWmtACz+lYB6u5HrDU6vRCc22Xepz53DwiVe6RB8=
X-Received: by 2002:a05:6830:13d3:: with SMTP id
 e19mr2115886otq.135.1579860319633; 
 Fri, 24 Jan 2020 02:05:19 -0800 (PST)
MIME-Version: 1.0
References: <20200123132823.1117486-1-damien.hedde@greensocs.com>
In-Reply-To: <20200123132823.1117486-1-damien.hedde@greensocs.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Jan 2020 10:05:07 +0000
Message-ID: <CAFEAcA8G7zGwRkbGRjyK4P7KZ9V+cboBHwnTH=jJs4NWu7rMMA@mail.gmail.com>
Subject: Re: [PATCH v8 00/11] Multi-phase reset mechanism
To: Damien Hedde <damien.hedde@greensocs.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-s390x <qemu-s390x@nongnu.org>,
 Cornelia Huck <cohuck@redhat.com>, Mark Burton <mark.burton@greensocs.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Edgar Iglesias <edgari@xilinx.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 23 Jan 2020 at 13:28, Damien Hedde <damien.hedde@greensocs.com> wrote:
> v8:
>   + patch 3&5: ResettableState::count type from uint32_t to unsigned
>     (Philippe)

We'll have to change that back if we ever want to migrate
the count (migration insists on fixed-sized types), but
I guess we can do that when we get to it...

-- PMM

