Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CCD6C2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 16:38:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4ACF924650
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 16:38:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L3nnJqLq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ACF924650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2HVw-0003h4-9j
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 11:38:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54894)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j2HUx-0002tt-6T
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 11:37:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j2HUw-0005uO-2M
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 11:37:54 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:47038)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j2HUv-0005sf-TI
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 11:37:54 -0500
Received: by mail-ot1-x342.google.com with SMTP id g64so6139001otb.13
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 08:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=hVljpjxOKu8zZchbn5tT/3JBUBI5cy6tSobo0vQSXeM=;
 b=L3nnJqLqpu/qUQXyOCwWVszb4apJqEwuxW1+LjlG16MJld+HWnSjWN+fkf7KgIA0Cy
 hZq7aSDa/wFDmy0Um+tfJgFlDcm+jxTcMacn/Y7w6asUKLdlIsSB23nKqj7FwtGP68sg
 YDTL0EKHyhQtpGCmnT8LO6FhGx7n6JRs75/eg3gO8qip0y3x2LaEEk1i1Gkpgt5Ni91e
 DDoetm5dir9gTenqORPf9pyBVWY1xF1iJtUEisaxvMdX5TGGldpC7oD/guuSXVBRfoVn
 0rt++FkyHAYAp7NYrlUJH6EghMaKOupXD/d9PtF0EXDgEIdzQqTI/2FqKKt0cTJ1IxyV
 C1Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=hVljpjxOKu8zZchbn5tT/3JBUBI5cy6tSobo0vQSXeM=;
 b=F3QdnThbm+RwDxPhieC3gYfjnla+OON5xmI7cRX73sS7Tt+9nSfXbN5U+7s0SeB4IK
 3IpMaxx5mhF0XL9h/6YXZn0vNg4ALfu8CtBKcaDWxmX5uufBFnJdfmqAtHLSkHBWdIaY
 VeK5wseB0RcA42o3U+BPoy//ZTGp8hHYS6iqdXTLpD2AezJzOddzxXvM+bD2gNQmlEYI
 miks/GYOT2lCUCExn0u8hhxwQUQqzv4rueyHpIdrj0ZIkOjALb0wyTOflGRSHLD065Cu
 QDh28LVCstyEqmVHnZK5/5TS6dmiwHf1EyYUGMFDyDC1S1E12orglOhXiNdt+7GRIQny
 VIVw==
X-Gm-Message-State: APjAAAW2r3ANzxNQR/TkQMX05OHHGqVB69FlXuERzbpHT5/dewKPLTKU
 WTZQzznvLnvFJoLFAWsseTcfia8vjYFDg23zOHAC5Q==
X-Google-Smtp-Source: APXvYqxG8OEormYOnBSOmeNiShQntR8YpqzS98pZae0JTWsIm1iNp9e2Fq+fZeWfx2ZcrKWazSYIq2gJ6LqyJBRYtlA=
X-Received: by 2002:a05:6830:13d3:: with SMTP id
 e19mr14074260otq.135.1581611872788; 
 Thu, 13 Feb 2020 08:37:52 -0800 (PST)
MIME-Version: 1.0
References: <20200212033641.249560-1-kuhn.chenqun@huawei.com>
 <ce5d39c0-d532-4b54-a39c-01c9c97cbb59@redhat.com>
 <7412CDE03601674DA8197E2EBD8937E83B1163F4@dggemm531-mbx.china.huawei.com>
 <99531e05-f8fc-ef0a-ca62-6d477c899e78@redhat.com>
 <20200212161957.GA5028@habkost.net>
 <87r1yy4l4g.fsf@dusky.pond.sub.org>
 <24243b1d-f3a1-1778-8b50-4d4776393cdf@redhat.com>
In-Reply-To: <24243b1d-f3a1-1778-8b50-4d4776393cdf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Feb 2020 16:37:41 +0000
Message-ID: <CAFEAcA8n1pFFTw7EhV5b8UE+XGWgVsxma++SHuh=ns7VeCPNjA@mail.gmail.com>
Subject: Re: [PATCH] hw/char/exynos4210_uart: Fix memleaks in
 exynos4210_uart_init
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
Cc: Zhanghailiang <zhang.zhanghailiang@huawei.com>,
 "i.mitsyanko@gmail.com" <i.mitsyanko@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>,
 "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 "Chenqun \(kuhn\)" <kuhn.chenqun@huawei.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 13 Feb 2020 at 16:33, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
> > * unrealize() must clean up everything realize() creates.
>
> Hmm I guess remember someone once said "only for hot-pluggable objects,
> else don't bother". But then we make a non-hot-pluggable object as
> hot-pluggable and have to fix leaks. Or we start a new hot-pluggable
> device based on some code without unrealize()...

Yeah. Almost all our devices are not hot-pluggable and don't
have unrealize code. Better to just have them stay that way,
or to add untested unreachable code in an unrealize method? Dunno.

thanks
-- PMM

