Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0777C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 09:43:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D01920EDD
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 09:43:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VzFzE+b3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D01920EDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvHTU-00061k-Uv
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 05:43:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55448)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jvHSw-0005aa-Ha
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 05:43:10 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:33362)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jvHSu-0002dm-7I
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 05:43:10 -0400
Received: by mail-oi1-x243.google.com with SMTP id k22so13481194oib.0
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2020 02:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=MPP3Twfnjxjg1wcbUz4GcIYPL+iJLz2plDE3PHe+6rE=;
 b=VzFzE+b3OAY/izHmVve7RJrjqnxD+kLzit+cPf2QPwxuToKgquMV2PDMGg08IRTgjp
 c07+xoWwKPqPUw7ElwW4q6rxYRNK77XU84mrxouLl8EIpU0vSng3MKDxj+9bdEpq+UKr
 7gUvigWSqHug77/e3EI9YMlPLi42PWJSGNZeda84nITqHI6vUDuA+pfxHYUtmd7p9YDr
 ZT5JpjRD1UYt37XIomDzBEmg951QBX2m7wJ8tKPmtFykKgRtm+iX2i98Y5z0JVpCl2bY
 w71DHgvQ9/gicL31FqlcHFKinYHyYSCBTIT5X8cSQ3FJnAQD0O+PawijE0k3F+bABVUC
 ml4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=MPP3Twfnjxjg1wcbUz4GcIYPL+iJLz2plDE3PHe+6rE=;
 b=YITcv4pfbRCdu1OQC/DqjaYfGPjCt2GlN4Fu6nKUzb1TQPK1t16V6poen4GUeV9ic2
 kN2dIWHWpm+tA9P/UsWA9B6X1zs15/1PfyHoIRn3PEPHbnZ8T7hJagzTgzj/F6ssRtdH
 twU75zLpYhva5aLO/xc0i2wS382LjuwvHPHskhcN0DzuqOUkO0MrbmQwc0BK0++u7nvG
 /2T5f92/xweSw4HP6/xvWcbgwYGtghpyYiL4XIPSdj/uSdxji1cWQk2Hi2zoNLfDMQVb
 8Miun6777mUSvQmVqMEAA4kbEB8E6GyEe+UKWrf0DzWUGy/iFxAa2iFXrh9NKNeTtBiJ
 TjDw==
X-Gm-Message-State: AOAM532kjTPqWxNZ3GQx9mAGGYndOKZ+VwnuCJtTLw/QndJ8viEqFUE6
 otnkNgmvniKqQyzr/05jU28s0GOEey8grIWcn5s7Uw==
X-Google-Smtp-Source: ABdhPJz2tv9K/qHDnO3Cs+SCtvUZga8SnTi1L9xAwdwkBSQZI1HIvrdsjSQF4D2bLix3p+D4heHCYg/Rn6LbHTeDA0k=
X-Received: by 2002:aca:54c9:: with SMTP id i192mr2906492oib.163.1594719786823; 
 Tue, 14 Jul 2020 02:43:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200714083631.888605-1-ppandit@redhat.com>
 <20200714083631.888605-2-ppandit@redhat.com>
In-Reply-To: <20200714083631.888605-2-ppandit@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Jul 2020 10:42:55 +0100
Message-ID: <CAFEAcA9QWLmi1fGuPW93GXFKV2KCwNs6Xp3U9MU2r4wtendzhg@mail.gmail.com>
Subject: Re: [PATCH 1/1] MAINTAINERS: introduce cve or security quotient field
To: P J P <ppandit@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::243;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x243.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Prasad J Pandit <pjp@fedoraproject.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Greg Kurz <groug@kaod.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 14 Jul 2020 at 09:40, P J P <ppandit@redhat.com> wrote:
>
> From: Prasad J Pandit <pjp@fedoraproject.org>
>
> QEMU supports numerous virtualisation and emulation use cases.
> It also offers many features to support guest's function(s).
>
> All of these use cases and features are not always security relevant.
> Because some maybe used in trusted environments only. Some may still
> be in experimental stage. While other could be very old and not
> used or maintained actively.
>
> For security bug analysis we generally consider use cases wherein
> QEMU is used in conjunction with the KVM hypervisor, which enables
> guest to use hardware processor's virtualisation features.
>
> The CVE (or Security or Trust) Quotient field tries to capture this
> sensitivity pertaining to a feature or section of the code.
>
> It indicates whether a potential issue should be treated as a security
> one OR it could be fixed as a regular non-security bug.

How does this interact with the way we already document our
level of security support in docs/system/security.rst ?

> +       C: CVE/Security/Trust Quotient
> +          H:High - Feature (or code) is meant to be safe and used by unt=
rusted
> +                   guests. So any potential security issue must be proce=
ssed with
> +                   due care and be considered as a CVE issue.
> +          L:Low  - Feature (or code) is not meant to be safe OR is exper=
imental
> +                   OR is used in trusted environments only OR is not wel=
l
> +                   maintained. So any potential security issue can be pr=
ocessed
> +                   and fixed as regular non-security bug. No need for a =
CVE.

The difficulty with this is that MAINTAINERS is not set up
with a split between "security issues" and "non-security
issues". For instance this stanza:

> @@ -149,6 +161,7 @@ ARM TCG CPUs
>  M: Peter Maydell <peter.maydell@linaro.org>
>  L: qemu-arm@nongnu.org
>  S: Maintained
> +C: Low
>  F: target/arm/
>  F: tests/tcg/arm/
>  F: tests/tcg/aarch64/

you have marked "Low", but the files it covers include
both ones used by TCG (not security-critical) and ones
used by KVM (security-critical).

Also, MAINTAINERS is not user-facing. If we want to say
that vvfat or 9pfs are not suitable for use on a security
boundary and that we do not consider bugs in them to
be security issues, we should do that in the user-facing
documentation.

Broadly speaking, it feels like you're trying to come up
with an automatic way to say "does this patch touch a
security-relevant part of the code", and I'm not sure
that that's possible.

>  GIT Data Mining Config
>  M: Alex Benn=C3=83=C2=A9e <alex.bennee@linaro.org>

Something in your patch workflow is mangling UTF-8 characters,
incidentally.

thanks
-- PMM

