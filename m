Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA20EC432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 14:32:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 814D620733
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 14:32:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oOUeJhFW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 814D620733
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVce7-0006OX-FK
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 09:32:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60346)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iVcW2-0005lB-GB
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 09:24:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iVcW1-0006jJ-D7
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 09:24:02 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:36459)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iVcW0-0006ih-T2
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 09:24:01 -0500
Received: by mail-oi1-x243.google.com with SMTP id j7so8749579oib.3
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2019 06:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=v2GL+vEceX7QnJdKkRZm0hTIut65lKcbIclQGi2TMYQ=;
 b=oOUeJhFWTuixgiaHr5LuAPJKXhpTTqkrHWIbe3bW326PrttPYdIXRMXZa/8uquIx/C
 9OdG7OrdoVsBnIECiUW8kNBZgriEQRTeJCng2ya5jU44wVb1rmJ9oXr/8i9DoIYyc3PH
 GuyQLJNAGazvZqoZ4uNGw3cO0sSiq5TwsOt8hd60jcfaJX2zvBIW8Ms7XwNzLl8ya/eP
 C2xE5n1OnYr7Z/tRn0RgBizb4hTlXjQr5W2LC0cKQ61OXKQdtQDFVjCFx0AwWWpvbVlk
 nbTVuZZtXqnLvAKI9GGNvpj6b2XgEPv3ULbmhwY2oTWtjkuesQ9m9fm0n/wanLHe3ZOk
 hU0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=v2GL+vEceX7QnJdKkRZm0hTIut65lKcbIclQGi2TMYQ=;
 b=FD5k6nvN9Sx9C39ze9OjQYXm8a+xmZkUsRcp9vkQS9H72thmiMfooDDOeoECiYd1YL
 l0q3s2VjbJ/HbNEwZoFLhQaRYWr/L9a5FbG+FL2tiDE2ovNXBkkyCeo7+19VYwhpRY1e
 7DFwNmF2ciKPLwHbDw+ls1ymkWxIUEqBXtuzWnJx/Tci6vwuVKlin4JvHclzbbuMGjhf
 ksl2DMy2AGYvQjTkyusHqnqP69BvFYEdO978k+bc7OxMpXN0wqw9Vr8eRGlJiRYXk0cT
 SIOxNuTcu+3kh9CM4x9efBNb27xhekd37MMWn+Ro3VFOuuQVmMRGdPtiJJpEtTjjM/PM
 AHEw==
X-Gm-Message-State: APjAAAWpq2kLa8ICh5amoEonWDNykrTMxr+Q0FpZjMMjvcbVnPjC3M56
 yz+XUB9Mphw1GMSt/xw17OCkbCXdTcPkKVJSkVtmTw==
X-Google-Smtp-Source: APXvYqyqzGzCg5nW/oyn+K8wSpYpgR6Ivpbph0vN16Ki4+z+Dhc1sFh2I5AwkGUmyFE3YPCkNYlqlXtN/ttS2J0tWZ8=
X-Received: by 2002:a05:6808:b04:: with SMTP id
 s4mr8182301oij.163.1573827839885; 
 Fri, 15 Nov 2019 06:23:59 -0800 (PST)
MIME-Version: 1.0
References: <20191108095942.401225-1-stefanha@redhat.com>
 <20191108095942.401225-3-stefanha@redhat.com>
 <CAFEAcA8b_POWyCWERMaT2mKZxrYA+RDoaLCHtO=pS28f-SCZ3w@mail.gmail.com>
 <CAJSP0QWoSNk7NmC+AjgWQenyKLw6H5wqHay8C-1evQ8QTrSJ6Q@mail.gmail.com>
In-Reply-To: <CAJSP0QWoSNk7NmC+AjgWQenyKLw6H5wqHay8C-1evQ8QTrSJ6Q@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Nov 2019 14:23:48 +0000
Message-ID: <CAFEAcA9w7NRXSRV=RO95vPE0KmRg_ju5ozMe83XDL5wAgV-4Og@mail.gmail.com>
Subject: Re: [PATCH 2/3] docs: build a global index page
To: Stefan Hajnoczi <stefanha@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: Daniel Berrange <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 8 Nov 2019 at 11:39, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> You are right:
>  * The hidden documents are included in the navigation bar (different
> from the table of contents).
>  * The search index (which install-doc omits!) includes content from
> the hidden documents.

What is install-doc failing to install? I just did a test
'make install' into a tempdir, and the search seems to work
in that set of installed docs.

thanks
-- PMM

