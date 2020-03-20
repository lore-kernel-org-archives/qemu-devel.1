Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92329C4332E
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 16:05:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C5BE20739
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 16:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TJg3jdrO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C5BE20739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFK9H-0000DK-Gp
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 12:05:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37399)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jFK4F-0003Ma-SK
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 12:00:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jFK4A-0005E4-UA
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 12:00:15 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332]:38290)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jFK4A-0005D0-OQ
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 12:00:10 -0400
Received: by mail-ot1-x332.google.com with SMTP id t28so6448973ott.5
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2020 09:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2gtrUypW/po+py9ZQStQYZk8bi7M9dsSt8me7y/uEnE=;
 b=TJg3jdrOaEonS5N71Op2qiIcCXA5DAsl2zvD7qD1NvMJPqq37kt9ymIKLFqnIDFCdW
 KVpNAojeHXt7cWLBBJbjJbQkzMhwsH8xfWQBhJIQsDmXAJb3C7NGo3Y/kngQkVse/7yU
 5j5C+xH2MBLl8SfiINujf6DVTvcFRJ0HH4ls4BRg2+Q615qSGruB2Q31sjanMilpVJQt
 sTRvgZOuqbwUuEuimixN573bZCGV7B5E8SfaPF57Y+H2elgG1yKU4t7/BN2URJWHdx+J
 5O776U76YbmHxkkNB2vXD8kHfx1YpLBrev7lLF017hQ+bFOHMhk82aiW893TURsfRqXq
 Thnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2gtrUypW/po+py9ZQStQYZk8bi7M9dsSt8me7y/uEnE=;
 b=syvcbfwMvD4VMpYaaFz0xOYPEluwdVne63dPHPVHhKIyJwFze48phhh9k2o3RU8DW/
 KGBk+zUO+Rt1QXTsKArWGGIyH+bplJixesKvvhL/R0S5EuKQXY082ce7jaKSysS8JZHR
 MWhisty0pGKvCj03wUZW5eEAgb4iDQkOgaIQT10oaKM2eGvoox97cIugtVx2UZq+f+Mp
 36nJCbdrnh7+O6dm53vMU9DNSVbVWxWs0Ueo2H5OTvKHL1EKafN6pH8TnOUmr6P9N9LC
 WOHjHub9BIibFanqWpsGUwUbv1lkfQ0MmgRvN8ezFbIzP1VocJ20Y1qlyXOmQ2DFlnza
 l9nQ==
X-Gm-Message-State: ANhLgQ1guVjfSpRN7kBAY4rqgBWsX7ff1aL0ry9yaIgd4Ppj13mkx+9f
 NLohCiQwndhPKlXFJ4J+KnPfA7F4GpYIre1+lboQsg==
X-Google-Smtp-Source: ADFU+vvOl/UxG/QlTv/jMkgVoUWg0wyR+YurzVv045stpG/0Hw9DhWcgRMbVR1v3jx69X0PaPG7kTeXnjFJ2IOsVOwY=
X-Received: by 2002:a9d:1d43:: with SMTP id m61mr7394668otm.91.1584720009824; 
 Fri, 20 Mar 2020 09:00:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200318011217.2102748-1-ehabkost@redhat.com>
In-Reply-To: <20200318011217.2102748-1-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Mar 2020 15:59:58 +0000
Message-ID: <CAFEAcA_6i1ponfRK6vUA_KCz_F=2c886CPQNKE8Kn4SifaRRxw@mail.gmail.com>
Subject: Re: [PULL 0/4] Python queue for 5.0 soft freeze
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::332
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 18 Mar 2020 at 01:12, Eduardo Habkost <ehabkost@redhat.com> wrote:
>
> The following changes since commit d649689a8ecb2e276cc20d3af6d416e3c299cb17:
>
>   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2020-03-17 18:33:05 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/ehabkost/qemu.git tags/python-next-pull-request
>
> for you to fetch changes up to f4abfc6cb037da951e7977a67171f361fc6d21d7:
>
>   MAINTAINERS: add simplebench (2020-03-17 21:09:26 -0400)
>
> ----------------------------------------------------------------
> Python queue for 5.0 soft freeze
>
> * Add scripts/simplebench (Vladimir Sementsov-Ogievskiy)
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

