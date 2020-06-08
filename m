Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26049C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 10:01:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3F7A206A4
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 10:01:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="peyBquSp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3F7A206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiEbD-00044P-1p
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 06:01:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51782)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jiEZa-0002zc-Cu
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 06:00:06 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:36002)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jiEZY-00058o-Ln
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 06:00:06 -0400
Received: by mail-wr1-x443.google.com with SMTP id q11so16712514wrp.3
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 03:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=GmKdEmcm5vY1eB0zlqN9oxlTJblmmIGMDdTfzjUAYZ8=;
 b=peyBquSpDe80mqQMhAbEI8q0Kb8GCx4n7mq+UpMBVbBNHJFT4eYTKG/Dioo2MXh8G2
 W011rrECwTmQwh1BDyueENBmGuTFAN3I3UlghyxyOtaEcT5Imd6PXTv76kYVu+rO4gsZ
 hrLLnWbbb/VHTcIwFeq+wIA3yi9/gO2ox+PF1JcIZfOnU/r7TnFjqLlPvGvlQT28fJ12
 3LIsrtrfzZgdtm2OPN54RA0vchabkXYskOQEvdx/cpuesuuYOXf5AIImVPF8cxuGRkj4
 4vCRYvvKsr2fxKfxq2Jgkm9Ftyb6FZQ0+tuPUxk/CLoMYTvO4VcmzRMNBT1yq7Mii97I
 x1WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=GmKdEmcm5vY1eB0zlqN9oxlTJblmmIGMDdTfzjUAYZ8=;
 b=cToLM8xSE3wGp+QvPitS3fs3Xfz8FQw3Ys9nvsmR5v/Xq1ZGwqo1rkj96dtVwzzM0l
 X+YTmmgDWRe+K/Ii+igQ+X6lv/cxqsFnrfn4sgDLWVjNPpA61aXMTrmbQs4a8IIGnQiV
 KBQWd9W9GCQc4PK1Js+faOGT4nuckRuZJMh5d9eBERiakPd+wo8aE7a8FdYZhwdLeRcn
 Pw6PA7U+iSJEbyI5yrKda41HOkrLeAyjlRdY9IGt3hQUhbDN9DwKvxks7ARPA/uqiGYG
 T8znywegwvTJRn4mweJWcmSFAynAbljT7RRLTYsCAbPjDNwFykt5Rgy2tdO+m8xBQqtd
 1lxg==
X-Gm-Message-State: AOAM530MhaQC4QBHOO6+oAYCUTm4K40OemWytraYC/ycBPlvsBCMwq+p
 pU06ebA8L6H+SH3raOakaVoyKw==
X-Google-Smtp-Source: ABdhPJx+bfD5F5JnqPNOU1qZBGq3s3+o8NY0ZlkggXP0Jbl8/aZIakTD2r1HTfdYxvIiVXgONCABNQ==
X-Received: by 2002:adf:a1c1:: with SMTP id v1mr23372008wrv.205.1591610402897; 
 Mon, 08 Jun 2020 03:00:02 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id t189sm22167015wma.4.2020.06.08.03.00.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2020 03:00:01 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 29FE01FF7E;
 Mon,  8 Jun 2020 11:00:01 +0100 (BST)
References: <20200605093256.30351-1-philmd@redhat.com>
 <20200605093256.30351-3-philmd@redhat.com>
User-agent: mu4e 1.5.2; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v6 02/11] MAINTAINERS: Add an 'overall' entry for
 accelerators
In-reply-to: <20200605093256.30351-3-philmd@redhat.com>
Date: Mon, 08 Jun 2020 11:00:01 +0100
Message-ID: <87tuzl7u8u.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x443.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  MAINTAINERS | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 948790b433..f725c12161 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -415,6 +415,17 @@ S: Supported
>  F: target/i386/kvm.c
>  F: scripts/kvm/vmxcap
>=20=20
> +Guest CPU Cores (other accelerators)
> +------------------------------------
> +Overall
> +M: Richard Henderson <rth@twiddle.net>
> +R: Paolo Bonzini <pbonzini@redhat.com>
> +S: Maintained
> +F: include/sysemu/accel.h
> +F: accel/accel.c
> +F: accel/Makefile.objs
> +F: accel/stubs/Makefile.objs
> +
>  X86 HVF CPUs
>  M: Roman Bolshakov <r.bolshakov@yadro.com>
>  S: Maintained


--=20
Alex Benn=C3=A9e

