Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDFE5C3A5A3
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 09:43:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9BD922CE3
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 09:43:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ANTJlRtU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9BD922CE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i166S-0008Lt-T7
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 05:43:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54315)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i164t-0006Yp-6z
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 05:41:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i164r-0001wN-T8
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 05:41:50 -0400
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234]:42221)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i164r-0001vv-Mz
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 05:41:49 -0400
Received: by mail-oi1-x234.google.com with SMTP id o6so6541721oic.9
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2019 02:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=s1agVp3eY3nKuqhYZDdzxtbXTIkvqWbl8gGe67Wootw=;
 b=ANTJlRtUBroeHrXLIKihutSNrlXmhjxBV/UneoOzAfJxNv22jZ/TFvCaTkr+gd6OVD
 yMBWVqXqgD7GahST2IOQJ/x+cjrgOH2sdpg7JhnWHJJrRvRg4BVZojPLtw4SWbjjO1B8
 s2y/JCZztZlkzMgxDNS6umR2KHdjpqZSpvTp/S4OfA521XtW30krjHpF9PNoXX9yjf6J
 3F5DE6RAmiSdsNjTihW2EPehBtG1VCY5kELBQN8/dVq8aPoGNSq7s5hUm5iTeOVKDENd
 IqaeVDlxGaNmAQTvJAP/KZC1cr624pyW1B6Hldbz90v7h/Au8W86uDwpaJ5Rg94LT9EE
 Tgbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=s1agVp3eY3nKuqhYZDdzxtbXTIkvqWbl8gGe67Wootw=;
 b=k7iUjr2WxXuS3YNqUYu6io/XcFxqTBLOZ4mIvfT+sRLNN3kPZNC+D1jenbuVyRUnky
 QJEDVhDrlObY7HaiXVpYYETc4zqnybiT8OFM8xCef8d1ve0Qvh45tiW2rAnfyAhKE6BS
 qUkHicf5/pb5PK9pWwo+nxy5JAf2ZVINhFb8LO/E+1nMOXTiFEhF4cyP+4vyo8Rc0FEP
 vAN1RciMNIsYDNegX32WY999ezj2VH+iXlKAu1SlauCxcr4ciLUKl5nb3s/q+VzBey6t
 BO385114CyzzR2bzRfOoGN8Ii5p0bDYzalSH+K+zI79hh4C7ReixM+5cIluhlQcuJcBU
 Mgfg==
X-Gm-Message-State: APjAAAVKG61sunh3ZuRLY9aF0G2IUsLBsR72Zp9IFgSUnArN0BZ3Idhq
 5pt6NF8PdTM7qZtXJIxFH/KKu7F+53TgW8tAx98kvg==
X-Google-Smtp-Source: APXvYqxinky+ntfvJ2fRWsZ+b8F5Y/Z5cPKbw0yUxaaciqxQwd0QSNY2gzdXDA5iel8lR0dLOCRl5BtPwtG0fUbvLNc=
X-Received: by 2002:a54:4718:: with SMTP id k24mr2386003oik.146.1566553308475; 
 Fri, 23 Aug 2019 02:41:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190822105302.26823-1-berrange@redhat.com>
In-Reply-To: <20190822105302.26823-1-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Aug 2019 10:41:37 +0100
Message-ID: <CAFEAcA8ixfV4yL=WVhQxnZX6yQb4C59XdNpqOGbnwJW1y98ZjA@mail.gmail.com>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::234
Subject: Re: [Qemu-devel] [PULL 0/3] crypto: autofree patches
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

On Thu, 22 Aug 2019 at 11:54, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> The following changes since commit fe066b4848bab4f9365a419f3c8ba59ccecf67=
c0:
>
>   Merge remote-tracking branch 'remotes/vivier2/tags/trivial-branch-pull-=
request' into staging (2019-08-21 16:59:22 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/berrange/qemu tags/autofree-pull-request
>
> for you to fetch changes up to 57b9f113fce2a2231a47e9295c1d461e9ff7f0f7:
>
>   crypto: use auto cleanup for many stack variables (2019-08-22 10:56:57 =
+0100)
>
> ----------------------------------------------------------------
> require newer glib2 to enable autofree'ing of stack variables exiting sco=
pe
>
> * Bump minium glib2 version to 2.48
> * Convert much of the crypto code to use automatic memory free functions
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

