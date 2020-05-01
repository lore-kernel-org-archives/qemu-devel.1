Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AB64C4724C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 09:42:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CD012076D
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 09:42:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eXrpfrMV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CD012076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUSBG-0001BQ-AY
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 05:42:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60854)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jUSAF-0000T6-8m
 for qemu-devel@nongnu.org; Fri, 01 May 2020 05:40:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jUSAE-0007xf-CA
 for qemu-devel@nongnu.org; Fri, 01 May 2020 05:40:58 -0400
Received: from mail-oo1-xc43.google.com ([2607:f8b0:4864:20::c43]:35815)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jUSAD-0007rB-Sq
 for qemu-devel@nongnu.org; Fri, 01 May 2020 05:40:57 -0400
Received: by mail-oo1-xc43.google.com with SMTP id t12so612242oot.2
 for <qemu-devel@nongnu.org>; Fri, 01 May 2020 02:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=86cJaDzcj/Fg8SZUL/fVe5/8isuLytAcuUban1rHdMU=;
 b=eXrpfrMV/EEDeWsxyJacPFHs31DOzO8+yiefKxQOg60hH0rasGlZIE9yni4RZ4WYD5
 kGvL1ENN6c1G1d+1Jeqa5mC6FFDKZhAR7o6Gvxhh8xR0W5jJqo0NX0LK/cKe60N5pTsn
 +3LOw4gojL2zU5hE2SFhHrqSFRUJI2K3c1y2xH1nzh9238vBzKEkpd2rkWTW++fgSYYm
 4TdRgeNBeb3lQ+07LlS+4S2CuMMqsNBgMhPKXIomoyMPnefM3TgLBFlXY0hbZ3i5Q9pi
 dIM/CSiB6QMxw3ALxWFgyvcAOycnnIK0lXL7sEw3gEFAcPMOS/gnsY0yLO0otFXBcfSB
 m65Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=86cJaDzcj/Fg8SZUL/fVe5/8isuLytAcuUban1rHdMU=;
 b=L7mOclf1HeGpTCES42RE+p8EqR/cMA/JBeoNcu8fmOOFm1hJbNCQAiXQiUPb3rARZm
 QP1jhoO8PbrIB/UCk91q8cTYkF8A1kduGwaOwv+/E/vhuqOUm6rjpKFdJcvPv/VV2/9e
 Rdi4n6V9ClguIXdz3miC/yvjab0oSRA7snxcxL3RERJwF6YKp5zEW60diLi2Jctke7Zz
 N4EfzeP1kGgCXUFFzgG14HOlMarR28yl+vXbMiiGM3W8blwoitOqGCEpjYlO31RAsxdA
 Co1DDgakHDMcAiCJs+EHYqD6EuWwra5tNiimpuBXnxCv/NFWXOYiv+5iE4Z+yZl8OW9t
 Xnbg==
X-Gm-Message-State: AGi0PuZ6Hi1OTf1oAMNGoCczOKYnG1AT5Yd5fDLprjhKPQB2Qha8MMqr
 wVhdvRfxr0RAYv5ijd0q4V5bz0GY4kSGPy71uALeOA==
X-Google-Smtp-Source: APiQypIfJHKoO8HD9dUNa+Iv86UFI/dkdzaJws/AlE31zw42t5xfWUTUS46KTX/Bbbw/Ls8/GsdQ0oUROMyxjNL9wUc=
X-Received: by 2002:a4a:890b:: with SMTP id f11mr3033428ooi.85.1588326055957; 
 Fri, 01 May 2020 02:40:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200427143145.16251-1-eric.auger@redhat.com>
In-Reply-To: <20200427143145.16251-1-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 May 2020 10:40:45 +0100
Message-ID: <CAFEAcA9ePwOFkX1pbh=FfryYbxteSAevHHU+_Cp0WX6_obVYgw@mail.gmail.com>
Subject: Re: [PATCH 0/2] virt: Set tpm-tis-device ppi property to off by
 default
To: Eric Auger <eric.auger@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c43;
 envelope-from=peter.maydell@linaro.org; helo=mail-oo1-xc43.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::c43
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
Cc: Andrew Jones <drjones@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Eric Auger <eric.auger.pro@gmail.com>, Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 27 Apr 2020 at 15:32, Eric Auger <eric.auger@redhat.com> wrote:
>
> Instead of using a compat in the mach-virt machine to force
> PPI off for all virt machines (PPI not supported by the
> tpm-tis-device device), let's simply change the default value
> in the sysbus device.
>
> Best Regards
>
> Eric
>
> Eric Auger (2):
>   tpm: tpm-tis-device: set PPI to false by default
>   hw/arm/virt: Remove the compat forcing tpm-tis-device PPI to off
>
>  hw/arm/virt.c           | 5 -----
>  hw/tpm/tpm_tis_sysbus.c | 2 +-
>  2 files changed, 1 insertion(+), 6 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Stefan, feel free to take these through your tree if you
think that makes sense.

thanks
-- PMM

