Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E18C76190
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 08:08:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA4D521655
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 08:08:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KjaX2nnY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA4D521655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hmw2P-0000BL-NN
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 04:08:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33691)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hmw2F-0008Bv-NW
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 04:08:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hmw2E-0002tN-QP
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 04:08:35 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:33117)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hmw2E-0002sZ-Gp
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 04:08:34 -0400
Received: by mail-wr1-x435.google.com with SMTP id n9so16057393wru.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2019 01:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=CjGaMRx2ePGlfEGa//QQbsBOaS63FOOAHxt3w7kMx3k=;
 b=KjaX2nnYA6M/EEK86CXUa1tzYTsXzcexXgCOugLxxGbVqvQ5ufhkEpbE4WCHNGaimR
 OVmQgKmz5SmzoYs5kQvG/QWqu5NhOwPcllhFVqCFyFdF18SSymb5+4ldRECmWSE6KIO1
 5gWghRPYDF5Gycak/gcoO51ekA8YSfuq9KH/SGNv7dFNn6zMae/AcC/8Zuz38jgaviJo
 2JSwS86DsFkFpvriQU/L6/cEOZCm0+mYl4tdRuvv93DRx4VLYzuo7NdhdX/YHUfBMRwi
 t0MZvrRF7hTi0rRdnVfz7XrgoVBJqsjLq7A7b4W04isMlv/DFamYJREFfkmMrs+YXAo4
 klmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=CjGaMRx2ePGlfEGa//QQbsBOaS63FOOAHxt3w7kMx3k=;
 b=FMeC6F2oyqzJt7P/c3QxMNWRgzvnwLoIlyWD5Mlib+wPSx1ixZDYY5SM0MGBI+7M4O
 +oEjubLlTp+TZdIgDFnnwYEE42GulZWUxZoFTz71rChZa36LUDbUZV3bpPrQ3Pe14z5c
 CEvd4Gtr6xaCRHdIqEFcseK+JjBF40DPGVRoZp3A/gHpcu7GUQyybtWHVou7myKjVcjG
 z6otYaPdvAETJEY1AeE22tQrYmIn21lOWykydH690GpBw1SybgMfetFUEcIItdxXDNXy
 07LP6ahxVm+6K6EHOz76ov3nOuIx+uP6PrSpQvVcWLfs1mD5UXkz/t9lTylYGYS5eyzs
 E3yg==
X-Gm-Message-State: APjAAAW5khvpZHbEA27HvexamGjFyLmiJD7dpbRO7TKXykVu/rYJn3uq
 CLAgelxVInSGa9zG4zLfeF+pFA==
X-Google-Smtp-Source: APXvYqxyUWFJTA06XUgdsh43py/hCgd6LKJNfeEla/X51QwgkD4Rt/Od6PUNTMHScA8xiv22bpmWbw==
X-Received: by 2002:adf:e4c3:: with SMTP id v3mr27016799wrm.107.1563178113007; 
 Mon, 15 Jul 2019 01:08:33 -0700 (PDT)
Received: from [10.0.7.42] ([194.144.248.241])
 by smtp.gmail.com with ESMTPSA id p7sm832860wrs.6.2019.07.15.01.08.31
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 15 Jul 2019 01:08:32 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, Stefan Weil <sw@weilnetz.de>
References: <030a439f-bb17-8232-bd1c-3585905e8feb@weilnetz.de>
 <CAFEAcA-ZEsX2nf7OmLmBE+v3VLHYQo60m8Vay28o7VNVgcn_ig@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <442551a1-bb10-3fb1-efa4-3f8df184ac03@linaro.org>
Date: Mon, 15 Jul 2019 08:08:29 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-ZEsX2nf7OmLmBE+v3VLHYQo60m8Vay28o7VNVgcn_ig@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::435
Subject: Re: [Qemu-devel] [BUG] 216 Alerts reported by LGTM for QEMU (some
 might be release critical)
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
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/14/19 5:30 PM, Peter Maydell wrote:
> I had a look at some of these before, but mostly I came
> to the conclusion that it wasn't worth trying to put the
> effort into keeping up with the site because they didn't
> seem to provide any useful way to mark things as false
> positives. Coverity has its flaws but at least you can do
> that kind of thing in its UI (it runs at about a 33% fp
> rate, I think.)

Yes, LGTM wants you to modify the source code with

  /* lgtm [cpp/some-warning-code] */

and on the same line as the reported problem.  Which is mildly annoying in that
you're definitely committing to LGTM in the long term.  Also for any
non-trivial bit of code, it will almost certainly run over 80 columns.


r~

