Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D71FC433E2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 18:42:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8852206B7
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 18:42:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GghXn3Ib"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8852206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEFQC-0004ir-Rc
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 13:22:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49108)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kEFP5-0002ur-9w
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 13:21:35 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:37372)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kEFP3-0004q9-Ib
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 13:21:34 -0400
Received: by mail-ej1-x641.google.com with SMTP id nw23so9636362ejb.4
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2020 10:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=2oKg/ZiGY7j5xb0rpCpgtuLnfrfU527rasMOF9KTyeI=;
 b=GghXn3Ibadx0omzzzXtQ9FO/PqUemhbHJpj8PeQiiwdN4z9YF2KqSa/3uyXlAQ2Kb/
 +pSA2d+8GVby+JCmoBy8VTpXV2+jPyLZEAWJ8XptebXXJIADK88vz6k3zkyvSMGCLMI7
 aWZvFavOxYGgw6ZggSqafLdzCxwmbwkEfZkQLJazvxUsMcoJHYGbIE4hT4hVyf55fvuL
 xSH0bNq5Cke0VDGzy0Oi6NcM/mM3nEaJIvPWk1zg4ThdLpfvP9b7jbzjOKp/1+W5jGBz
 xkW5lCQimVpM6zkyS7Nx4PrDgTKRow+WsDatPv53BTau+5pg8s7KBCbDyG40ihkGLKgy
 fudw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=2oKg/ZiGY7j5xb0rpCpgtuLnfrfU527rasMOF9KTyeI=;
 b=Yw8FUMRdldvQRb2KmXdKQyGJEreUJ89P89e467N2bQmNrvTIKEIVSRGZ4M2j72mvFf
 KVmKTjdXjUUvwItZgiXifqy16MNPZmOwr/XGgHwsBB7dVviSaujIvyBxGkG8iEMRv0Cu
 KX7FmetPepuVyRBJ3vxcLLyTbWyLOa4cAn2gYqFPrkI5+Wsq93xHGUYhEOt0iV0bVQhV
 Z33HVr8t4z+lTEoqqmnubLrz+hteSmysMIwzjrUPZmYOrfBx9gDLPuwZtSavm3fj5eE/
 MhYr9KP/CsczuKWLcGLsk9gRoaK+9A196Z8mhBPWb0zsbAqui19vxrAbbds7UOGhQy9y
 Z61Q==
X-Gm-Message-State: AOAM530NkgeeqO4UigvQBPb5TY7SnKW2As4OLi0Px43vjTR5wNnxTWM5
 fMhP7B8/38vHRRR78oYBSAYAAXDz4rV3+F5d7VPDOQ==
X-Google-Smtp-Source: ABdhPJyQ4/L9WLhaC2GVni/dsWXHO4NQBkGk8tZ2E1kpYcE/FQoIRLksmDVfIggX/whLJPJpPfToMOjniYHFgttUE84=
X-Received: by 2002:a17:907:20d9:: with SMTP id
 qq25mr4434207ejb.382.1599240091538; 
 Fri, 04 Sep 2020 10:21:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200904165140.10962-1-alex.bennee@linaro.org>
In-Reply-To: <20200904165140.10962-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Sep 2020 18:21:20 +0100
Message-ID: <CAFEAcA9+hoPrkDNg21b03CT=YmTXuOLwKrornYn6J12bZ=B+OQ@mail.gmail.com>
Subject: Re: [RFC PATCH] docs/system/deprecated: mark ppc64abi32-linux-user
 for deprecation
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: "reviewer:Incompatible changes" <libvir-list@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 4 Sep 2020 at 17:52, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> It's buggy and we are not sure anyone uses it.

> +``ppc64abi32`` CPUs (since 5.2.0)
> +'''''''''''''''''''''''''''''''''
> +
> +The ``ppc64abi32`` architecture has a number of issues which regularly
> +trip up our CI testing and is suspected to be quite broken.
> +Furthermore the maintainers are unsure what the correct behaviour
> +should be and strongly suspect no one actually uses it.

IRC discussion suggests we do know what the correct behaviour
is -- it should be "what the compat32 interface of a 64-bit
PPC kernel gives you", it's just that the code doesn't do that
(and never has?). It's like the mipsn32, mipsn32el, sparc32plus
ABIs which we also implement (hopefully correctly...)

But "this has always been broken and nobody complained" is
a good reason to deprecate anyway.

thanks
-- PMM

