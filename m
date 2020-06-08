Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C19C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 10:18:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59208206D5
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 10:18:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mNcn/7uo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59208206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiErS-0005yQ-JM
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 06:18:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53646)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jiEqh-0005M3-Pk
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 06:17:47 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:41845)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jiEqg-0007z6-TV
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 06:17:47 -0400
Received: by mail-oi1-x242.google.com with SMTP id a21so14748801oic.8
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 03:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=srJxCKGBuL6VhALrWVlOrJna20rChonXhTk/SAan94c=;
 b=mNcn/7uoaGVfsEypPhHNg4RkHNQJJrdpCt/Y+BG4os8JMEOmxY0J4sjOsPz3+eP9CH
 eUedjAu74semnLTyXI7wpjIB3k+GH9nFC8F5GO4kxfV/kFSBKSX3uere0wizT18cXTsF
 JwSxtktIccyUFzbJwBOSZGUvOkaltUih7F6y37DriRx8m9AW7iq8GhRGn5n30/fmh+Lq
 XvE1PSx5EyuFmgMhzG/r+3yQ35j3ZBtjrs/qJbmeAjbrU9BUzAtLngpdgCPlFRSw5tql
 acAl0g/LA6Ko1+iN9RSY1BfFLAkRlN6fT5ntyp77FjvkMn31SJMc9ZI6mwpzXf+iw6F5
 neZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=srJxCKGBuL6VhALrWVlOrJna20rChonXhTk/SAan94c=;
 b=O0v0zx3zRlhID03XV9XcFd1ULrCFnneYgPF1DvLUmf8bskcS8L/2v/WSf7cRXiHbpH
 M4NUnhSnx+3e8dYCoFQHyt+l6+e9aq25GeyU+YCflCTATGkK9XlxqIWk7TFsqHMu1YRe
 dHJneQIUUJSZcPh7t5Z9GU22vbYtnO3/RK2ygnU1BeCupdzE494O4E4Gu2T2GpF3I+0L
 zK3rcGhn3DhOYxyYscKFICfDH/jH0MkQDX+lQNsyJMP5tFPd5vE0RzHoXsseSnsoYFil
 gaP87Uv7KBCaJK3/mVxFBJgbiG+RLiIB6MTzGA33AnTS0ECXix8xBwdwoU8Ep50uspgt
 vD4A==
X-Gm-Message-State: AOAM533AF6BTwVrR4yRv3kknvIPWcwCrwxPVpJuNXzCKB+tm4jp/X29e
 s5wSsC8trJU3qTaxdUpDkca4KoUA1nx9zrtzDAoDyA==
X-Google-Smtp-Source: ABdhPJwx4/755y3rXJ1s5dvum+7p5IYeaHep9uLu71dsAWnzQNaxpbRZDSZn9HAxMAJDXLJGFYU8zdfYflhD6ESiPYA=
X-Received: by 2002:aca:568c:: with SMTP id k134mr9338530oib.48.1591611465782; 
 Mon, 08 Jun 2020 03:17:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200602235834.470345-1-richard.henderson@linaro.org>
 <20200602235834.470345-7-richard.henderson@linaro.org>
In-Reply-To: <20200602235834.470345-7-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Jun 2020 11:17:34 +0100
Message-ID: <CAFEAcA94fewE1L4Ex=5_MmhW4V=R3_+uw53LKiA0x=oRquB0aQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] decodetree: Implement non-overlapping groups
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::242;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x242.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 3 Jun 2020 at 00:58, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Intended to be nested within overlapping groups.
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  scripts/decodetree.py | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

