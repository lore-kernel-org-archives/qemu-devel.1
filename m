Return-Path: <SRS0=qR42=YW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C17F3CA9EAE
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 16:29:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8ED1D20874
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 16:29:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ef23H96k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ED1D20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPUNY-0002XW-Ny
	for qemu-devel@archiver.kernel.org; Tue, 29 Oct 2019 12:29:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51433)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iPUKZ-0007xl-96
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 12:26:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iPUKX-0006aG-Mm
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 12:26:50 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:41681)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iPUKX-0006Zn-HM
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 12:26:49 -0400
Received: by mail-oi1-x243.google.com with SMTP id g81so9431447oib.8
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2019 09:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=GA4O6mku9T8YYWTTmh8mmMH0HGPjtOl/lJtI6YEIv8c=;
 b=Ef23H96kMobFs+zRxpK2UC8qjrMvkqiE2k6Lt6jduoDCxgOMxyIP+f6fy2KqcLoUib
 WjUOTJvw5u/azGftKkGKsEWTnwrGNaGOzyq1mCw5KK21544bYnPwJMFioy6nQ1wv5cCv
 hNWuOwTm/FobsDZf9F3SnaBM5rP89LTEw0TQ38eMq8PlBj/2ph9GrxHiqrGsuuGPW+TF
 GErZnpA5ZKDFvNLcMQnTHKfVAM8+1lgqGz4cXtznKSo+bTocDX/8T3hk5V2boY4bYoVB
 CzUBkgBvkYyT2cys6s4d/ld02UMnl3dM4LagQKVezvTU5DVLY2o54D3/nvaFyD5vRv0R
 ADWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=GA4O6mku9T8YYWTTmh8mmMH0HGPjtOl/lJtI6YEIv8c=;
 b=TJGbxIG+jv94Tb5doadVrrJqaPRelOgZBHhvGnY69PJ4hSsPGu3r0DgmE35q8yhNec
 vgXMbupLUmIAT2I13I0t/Ztc/OqjKOZ6vzQolGwwr0e1LICX8Npu1gXkWilOxKR77RO7
 QJXIGhi6Lgtm9ElrTVRiYbIq9FP4uNOqDCR5nG/x+z7/LM1eIaJrV+DTglMIUPN2NPHD
 Luyn25FMGxqQ7kZn+1QTJXvvzf3XtZGFCkhlZrwqNy7xdtXbYOeBlwo1Yl/k58NzTnqh
 SANMyYoSz8LCxFGeTaE6tPHWhLlvGiFk+lQMjMc10i6XsU8Soowe8IIyNomRIJFgIilK
 M7Ug==
X-Gm-Message-State: APjAAAV6LgZ4zvgWikWMPANVA6ASBKYSLrFYp4PiKg8ajgFlDQjp1nQc
 xa/tKFiFxPrmjPxVfZ+MZ3NPca7jxwKDjglkc56Mdw==
X-Google-Smtp-Source: APXvYqyN9tlZKzBXmDhm0G0WpbEYgqOZevjmdgCpaYtxHXg4J4m99v5Kbn8e1qkF3iaObG8GisFFlCrA5RF2h5ZBkqs=
X-Received: by 2002:a05:6808:b18:: with SMTP id
 s24mr2437035oij.48.1572366408514; 
 Tue, 29 Oct 2019 09:26:48 -0700 (PDT)
MIME-Version: 1.0
References: <20191028154914.84821-1-berrange@redhat.com>
In-Reply-To: <20191028154914.84821-1-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 29 Oct 2019 16:26:50 +0000
Message-ID: <CAFEAcA_qsRbuwF3J0B0=fZkwKLT=NMg9hZP9UUM_g5V0X9xYEw@mail.gmail.com>
Subject: Re: [PULL 0/4] Crypto luks patches
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 28 Oct 2019 at 15:58, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> The following changes since commit 187f35512106501fe9a11057f4d8705431e002=
6d:
>
>   Merge remote-tracking branch 'remotes/stsquad/tags/pull-testing-next-25=
1019-3' into staging (2019-10-26 10:13:48 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/berrange/qemu tags/crypto-luks-pull-request
>
> for you to fetch changes up to dc2207af2de162005f7e9e534850d07232290cee:
>
>   crypto: add support for nettle's native XTS impl (2019-10-28 16:45:07 +=
0100)
>
> ----------------------------------------------------------------
> crypto: improve performance of ciphers in XTS mode
>
> Currently QEMU uses its own XTS cipher mode, however, this has
> relatively poor performance.
>
> Gcrypt now includes its own XTS cipher which is at least x2 faster than
> what we get with QEMU's on Fedora/RHEL hosts. With gcrypt git master, a
> further x5-6 speed up is seen.
>
> This is essential for QEMU's LUKS performance to be viable.
>
> ----------------------------------------------------------------

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

