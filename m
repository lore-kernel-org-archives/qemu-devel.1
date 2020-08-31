Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A52A9C433E6
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 18:48:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DD55206FA
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 18:48:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uIIbZkly"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DD55206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCorA-00078d-Ij
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 14:48:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41250)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kConw-0002sY-Q3
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 14:45:20 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:44237)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kConu-0007px-A9
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 14:45:20 -0400
Received: by mail-ej1-x642.google.com with SMTP id bo3so9841942ejb.11
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 11:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mK71VREtEkOu9ZKpeTR3KQKmWZikJ6Qi7gLJ4nuKuVw=;
 b=uIIbZklyGSfvKaWE0kBwQK7R1HoP8K8cRhSaFZ/g+rPl3d8wdKeyHDwSJmQ88aMPMd
 9S8Kx6sYc+0J6k5ynLDv4DqQCz30gSuqUfLej/Fhl/ITz6JauD+hxKpaH/eakD2hZiSM
 Qjge+qKICCRaYdFluSex4OMnduJNF/yXpnMwQvPJ/ahsMVoj7wLg4QnIhKiEqeUOFtB/
 CCQ9Z5laxjZL7pkqZTw0xV0r3wLdt8KVWpQvsbxFEZFYPhk3LXDZhVnwDFmYg0UV35y4
 ZO0nEW6z339zUVHpK+2TVTa7HxnJJ/DIRH2RXEqY0+0/MKwO5/LQpZ2/LyV6mx5F40zb
 eheg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mK71VREtEkOu9ZKpeTR3KQKmWZikJ6Qi7gLJ4nuKuVw=;
 b=BOll5NkaAt6jA1mSf2/xirS9o9lcYlavunNzy3PdGoPpym6GvNfibMSUoyr3y9z1Lw
 8S0qqdbbkUfxw0h6EAP+hRsfIrPj1tZjGSw+Q6aJIQFpgm6o4T3csHWNmodAcCa4XQUw
 Ogqy9hkpquy5ycwkQr8sVhe7eFcnG2IehUFavi+6ZBfEYNcgfaFwdXQlUccGEiBZZXGZ
 hDEafb3CZY5KMX91OvGKq6oc2K502g/cB1X086qhAqvveU+//jshjlfk1+4DuTK5IV8v
 dEjjpZvybXylHtbZChukAs8uO9pkZxzhvqGNAzetO+tjNUcGdovRFRv9FdVZtSv4ZZD3
 /tcw==
X-Gm-Message-State: AOAM531abMQ4GgfK4L4IWaQAEmCxDEXLSN8+y3i55EKcEkZeec7kGgyR
 mWOF6ybAcKIGsro28Q8LV+IsBVFmmlZFfSDE+5n1+g==
X-Google-Smtp-Source: ABdhPJz3jI/KRhnvVO7YoF0+NXZDe52+nP36pw8JsW/jiwbgp6e8siFqt6k6DL+lAo+PuqEgKRE8cWaycispLcA7mR0=
X-Received: by 2002:a17:906:f28b:: with SMTP id
 gu11mr2158357ejb.407.1598899516497; 
 Mon, 31 Aug 2020 11:45:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200825192110.3528606-1-ehabkost@redhat.com>
 <20200825192110.3528606-52-ehabkost@redhat.com>
In-Reply-To: <20200825192110.3528606-52-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 31 Aug 2020 19:45:05 +0100
Message-ID: <CAFEAcA_4HRgdzTf7NUO8=_LrvK+-gMDzHywRffxx=-h938zQrA@mail.gmail.com>
Subject: Re: [PATCH v3 51/74] arm: Fix typo in AARCH64_CPU_GET_CLASS definition
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 25 Aug 2020 at 20:23, Eduardo Habkost <ehabkost@redhat.com> wrote:
>
> There's a typo in the type name of AARCH64_CPU_GET_CLASS.  This
> was never detected because the macro is not used by any code.
>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
> Changes series v2 -> v3: new patch added to series v3

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

