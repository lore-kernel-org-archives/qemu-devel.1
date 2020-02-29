Return-Path: <SRS0=0Zkw=4R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE4F7C3F2CD
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Feb 2020 20:07:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 861D024688
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Feb 2020 20:07:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="klxmiVYJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 861D024688
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j88Ov-000381-La
	for qemu-devel@archiver.kernel.org; Sat, 29 Feb 2020 15:07:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47128)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j88O7-0002RX-M0
 for qemu-devel@nongnu.org; Sat, 29 Feb 2020 15:07:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j88O6-0005Lo-MZ
 for qemu-devel@nongnu.org; Sat, 29 Feb 2020 15:07:03 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529]:47100)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j88O6-0005Jp-5n
 for qemu-devel@nongnu.org; Sat, 29 Feb 2020 15:07:02 -0500
Received: by mail-ed1-x529.google.com with SMTP id y3so1324782edj.13
 for <qemu-devel@nongnu.org>; Sat, 29 Feb 2020 12:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=SoOfSQSJDR8dzp5cdCwa65yHauHzBT4X8KXID6OZpdU=;
 b=klxmiVYJz9IXlb6XGyQYKW4tSVh9fCY5TeKP11qpl4UzyhfZAPo/QoEVJlLJ0fXCY8
 7X07Ec0SCt7yh4yKUAfzoydMi71N+uR6M5pesjReQBUYE4t14Kbescr8z+HdGFbBfaoj
 FPKXwKW6w77OcGK4ZxYSMkZHhSLjvSzclQk338q2Ndas+h38TA6YlRVWobvltrdd7Nlk
 Qmwbbv7cW4X5vLT3KsmjVj/Yj/eYejjnvYKsukyysRCE+Rq5cZ7qaCrdxWfhFRc07f/B
 a7sSFZ3EJmlRlCsPKl/9nuaPbsTaOfZeKCSsUXVqd4feX2fpq/eTqnGYSm7UV8uD71T5
 EN2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SoOfSQSJDR8dzp5cdCwa65yHauHzBT4X8KXID6OZpdU=;
 b=s1Rg5uCdQZAnL4iugp7/SBVi4nSwb8j0yR2Ee4OzAIS8bnuyutHzlOtwJYXmCakqBK
 JowpQ0o4dRrHppeODuQvPKz0Mn5nrCTnZjIUWX6PQGqEaAXOEY/oYkyMFHbWkVoCgZiZ
 goEses3aTNbsYGPaCV/Y8Yr/e/ulpOyfQDn8sJlAE4ticq1AqTIa2I4gkvVtZY2VyUjQ
 RsFDH6RVTUfdpTLMV7LHLVpfa1veIr5T+fSyxnyzlYpNqoF+qP+Yi3jhgkkInHf29Dul
 UPg/71/zCMwElPMiygN/aRXmK5d9LIokJIfwLmAAHWbNhNmeMdXDugiIQwXkX7VT/Ii8
 6Z3w==
X-Gm-Message-State: ANhLgQ2zWHk4Bb5OuAJXzpu7jEsO6Mo+CtzpAAAD2p/7EdXzck6LBVSa
 1pLgm4lJksXpK+6HscjIbLTc+tD/vo0l7ll8WaehIg==
X-Google-Smtp-Source: ADFU+vv6VAXumPMu1OMUZizzD9VrT2YPW37RrxCmVGzwrhbLUcDS9B1fwaowcrDVC/lMgUwKhMQ4r4bAH9xL11Qxerw=
X-Received: by 2002:aa7:c2cb:: with SMTP id m11mr1947868edp.116.1583006819897; 
 Sat, 29 Feb 2020 12:06:59 -0800 (PST)
MIME-Version: 1.0
References: <20200228092420.103757-1-quintela@redhat.com>
 <20200228092420.103757-7-quintela@redhat.com>
In-Reply-To: <20200228092420.103757-7-quintela@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 29 Feb 2020 12:06:48 -0800
Message-ID: <CAFXwXr=9R9FZ5wD5Lk=cbP=Qt93KOokrcOjxj_JKevmso9qdgg@mail.gmail.com>
Subject: Re: [PULL 06/15] configure: Enable test and libs for zstd
To: Juan Quintela <quintela@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::529
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
Cc: Laurent Vivier <lvivier@redhat.com>, Fam Zheng <fam@euphon.net>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Hailiang Zhang <zhang.zhanghailiang@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> +##########################################
> +# zstd check
> +
> +if test "$zstd" != "no" ; then
> +    if $pkg_config --exist libzstd ; then

The option is spelled --exists.  This is generating an error during configure.

r~

