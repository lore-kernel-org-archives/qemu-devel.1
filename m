Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1352CC2BA83
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 18:22:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3C622168B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 18:22:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EAOKLrky"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3C622168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2fbp-00012x-2U
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 13:22:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33603)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1j2fZ5-00036K-G5
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 13:19:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1j2fZ4-0003q4-GK
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 13:19:47 -0500
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:44970)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1j2fZ4-0003p0-3n
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 13:19:46 -0500
Received: by mail-lj1-x242.google.com with SMTP id q8so11698292ljj.11
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 10:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=trV9K24HPaEBBj7x8CovdrLRj/RVEB+f4WI5zhXBTPI=;
 b=EAOKLrkyxroVVXAWuPvOn7RiBXN2kieUdCvZMk65MS7yBgy7QaYNRl+weDeWfEOfRO
 xgaGY8fL4kT3R/1zHvaDnqAw4Cmzcg/bTK9hdFOI9NQTtV/ctm3L4pHWRSe558BSrpM3
 60idmiAAnjoLSuDXaKLbT4oV1OfPx+m5DhQDgniKOSXTmvNOF31ev+JFPSLLjKZL1elU
 BpwOOl9cw1Ph/frtru4h0fHZJTZkPlRon6aS8HZxQEikx5diKJRq3MkIh5gwZI5sgqF/
 NEocTq53xUUzxuBijufF2E+QK6UeQVr7eiC1Cl5EfixL4Ngv1nL7WeXqc6Nwu6ndRM0P
 myUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=trV9K24HPaEBBj7x8CovdrLRj/RVEB+f4WI5zhXBTPI=;
 b=eLlPetCr4oWCPIYgYDq4QjS7e8w16VshAp6fv0MCEZ+h10KD2z0r8X6hkbdDwxGgcT
 hYl4ycZpkhQ2XjZhxNT1mW4LBrpC1l8VjZ6uGzwYddMEWCFrayheMhzUF4m2yLKxxcfL
 qIL1vq9GuXAr0VZDrnYbwwjuXeoI+2YsSJgas18FeLxOF0UqqbMP/W+88VBJ5S2x7/JL
 fv9Dckp7gkbVszcOlwRekrD3KPzDbTEkaTEY7aQAwW6EIXB28qxXZdS9pkNFR6s8tf2l
 UPqY4vjhH/KH3ycdqu6e6ajLAkNebypQZpRAw3cNFQuVTAxXlf9XFbAqlnkEklzaoeWy
 zFTg==
X-Gm-Message-State: APjAAAW4dbOJuh4k6C+TjVSfDEAng1BOIqKmHdXYUCm1/yi2saqBalJP
 T9nUlDUG+8D3qXdfFDO6Jx2l1UUQMSqJobijb+fr8A==
X-Google-Smtp-Source: APXvYqzME+e6zfNNc8PTHt3GLAoWtMIYBf5H10klPhHavMtgwqlJUYsm2pOenRuknxqNj0iB1dh4qCBzjfKlop+B+fU=
X-Received: by 2002:a2e:90c6:: with SMTP id o6mr2850406ljg.129.1581704384748; 
 Fri, 14 Feb 2020 10:19:44 -0800 (PST)
MIME-Version: 1.0
References: <20200213225109.13120-1-alex.bennee@linaro.org>
 <20200213225109.13120-10-alex.bennee@linaro.org>
In-Reply-To: <20200213225109.13120-10-alex.bennee@linaro.org>
From: Robert Foley <robert.foley@linaro.org>
Date: Fri, 14 Feb 2020 13:19:09 -0500
Message-ID: <CAEyhzFvTpv65qkRtkmysZc5+LD2nrsvfug54Vd_fxTKaBEZoUA@mail.gmail.com>
Subject: Re: [PATCH v2 09/19] tracing: only allow -trace to override -D if set
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::242
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
Cc: fam@euphon.net, berrange@redhat.com, pbonzini@redhat.com,
 stefanb@linux.vnet.ibm.com, Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org, robhenry@microsoft.com, f4bug@amsat.org,
 marcandre.lureau@redhat.com, aaron@os.amperecomputing.com, cota@braap.org,
 stefanha@redhat.com, kuhn.chenqun@huawei.com,
 Peter Puhov <peter.puhov@linaro.org>, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 13 Feb 2020 at 17:51, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> Otherwise any -D settings the user may have made get ignored.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Reviewed-by: Robert Foley <robert.foley@linaro.org>

