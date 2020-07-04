Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDF03C433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 21:59:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B320208E4
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 21:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UHAesMIq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B320208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrqCG-0001wo-N4
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 17:59:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45752)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrqBd-0001Sw-Ug
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 17:59:05 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:41282)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrqBc-0000p6-2u
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 17:59:05 -0400
Received: by mail-ot1-x344.google.com with SMTP id a21so5725506otq.8
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2020 14:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=XU39nVodtDWLGxnUJuqcg43GRQsoav9qp5zl1pL69jw=;
 b=UHAesMIq/BajU4XJefk1o4Du+ttP54d0ifHBE7YUQc/HrdJILSWooQpe4MZxg+tov+
 G6gzr/oYFTSUM43P9YsJsEFWE5Yxdvaod0wMW7uY6vEzK7+pw1YpAxcfxYRZnv1rWclQ
 8KvXx43Qs4vLa4ulNU93XA56co0jbpu67NRTQ6HCdb/3enaGDVHH8tCer72+p+vJpV90
 WRm6NnAlSpF8SppO5g55epmAdL8s3vWAWsWImcLtLcSl6ajBVwRyQp+SeDjIMuWS95Q1
 wO2XJbFTyF50Xgh4eZI6ho13EHI8f1pC3F8fxBPdmOPQ0ECgVSfxaZSqseXU9z6Z/5Cu
 OYWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=XU39nVodtDWLGxnUJuqcg43GRQsoav9qp5zl1pL69jw=;
 b=YmvmGJOPQUpp04OjUkCZe9Ze/61x3/WmTLB8bV3o7kSgNu99WP0It77+s6PK5aBcy0
 9bnJpjtS2mPNcpY6UiezbuGhDXoX+0sVbSSZD5ELgcUq9DaPAjcG8bWf/Tzad1kZ+oAS
 BvWErON7jY3M/ks6ArlrWpouWNY+Pw4H7HtDXN1/MohuCS/GYGsY6lrcKcMTKUi0h4yZ
 Kz/TOwFYpbpx+4ozjodd9BOqOsRwnXezw1fqsC0zbsj38QW2EoENyfwXiA/AXv0trwDT
 geDsQliFXnmQNM1Hx7ZcxnVcktKw06nOAsKchh+1t4eJ6TGvDqFpo4ukbqb5EnbqIKlf
 nzWA==
X-Gm-Message-State: AOAM530RiCwj1I3NFw0pAY6d438TqVmtCkb08Cz51mvCwrppAhYPl5cW
 WsFjm72KSkgYaO4JYV4yYAP8yuUx3+qcpX/KUFqntA==
X-Google-Smtp-Source: ABdhPJzGHiGhjbejK7FrdEE7aNte5SA+0xBet4lQPIxKpsl4+3PU451raPlkAXMriWPRKln3IZdfRT5NztMpnH7Wg24=
X-Received: by 2002:a9d:7303:: with SMTP id e3mr29217042otk.221.1593899942532; 
 Sat, 04 Jul 2020 14:59:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200702143955.678-1-thuth@redhat.com>
 <5EFE07BC.6040407@mindspring.com>
 <1e699fdc-639e-ef8a-313f-7e665cad868c@redhat.com>
 <5EFE5291.6030300@mindspring.com>
 <975b5072-43de-da16-bf62-fc7e5a7a87f5@redhat.com>
 <5EFF5DFC.2060006@mindspring.com>
 <CAFEAcA81y59yaOCW=QONy9EKv6Fdkkwb=XGJ786-N5du2+P9NQ@mail.gmail.com>
 <5EFF7DD7.1000605@mindspring.com> <5EFFA499.7050008@mindspring.com>
 <3474053c-12d7-cf4a-5470-62845c166127@redhat.com>
 <5F00A1ED.6040909@mindspring.com>
 <69adae2a-8c3c-ec17-08f4-c2109b1d0993@amsat.org>
 <5F00D548.5050305@mindspring.com>
In-Reply-To: <5F00D548.5050305@mindspring.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 4 Jul 2020 22:58:51 +0100
Message-ID: <CAFEAcA-QXBw_5xcPZAWS7cX7BHohiyMMbB3_RaKC8cEchj8EwQ@mail.gmail.com>
Subject: Re: gmake in Solaris 11.4: TFR missing
To: Michele Denber <denber@mindspring.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Tribble <peter.tribble@gmail.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 4 Jul 2020 at 20:15, Michele Denber <denber@mindspring.com> wrote:
>
> On 07/04/20 11:57, Philippe Mathieu-Daud=C3=A9 wrote:
>
> Odd...
>
> Assuming you are using gcc, have you tried 'configure --host-cc=3Dgcc'?
>
> OK, so I changed it from
>
> # /opt/csw/bin/bash ./configure --cc=3Dgcc  --extra-cflags=3D"-m32"
>
> to
>
> # /opt/csw/bin/bash ./configure --cc=3Dgcc  --extra-cflags=3D"-m32" --hos=
t-cc=3Dgcc

It would theoretically be possible to make configure
a bit smarter about --host-cc. It defaults to "cc" even
if you passed a --cc option, which is probably necessary
for cross-compile setups, but we could make the default
look in more places. We also ideally ought to check that
whatever it is actually exists and builds host binaries,
rather than just passing it through to make and letting
the build process fail later.

thanks
-- PMM

