Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C54C433E8
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 13:53:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93B54206F5
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 13:53:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x/Ub+YUI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93B54206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0Q30-0006iM-Tm
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 09:53:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48996)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k0Q2H-0006DP-LM
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 09:52:53 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:45381)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k0Q2C-0004Ny-QE
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 09:52:53 -0400
Received: by mail-oi1-x241.google.com with SMTP id j11so17484946oiw.12
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2020 06:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tbppK52n3H9pWzeUVQb33/TDF6fZaPSYmG0qcIei3hw=;
 b=x/Ub+YUIS6uGtxIjMSTT61IDC6d2UlPFWGGIvf9MrzWFxb27iKFpRL461Apv+NpjaA
 iZ1LUP0S/lEXLT/le/JzO1+LI3vC/oPws/SyCP4Z2OpYx/qVjjFJoHR3xZ4uBaFyUCsy
 8RY5eIyRz41aE6kTZwqlIa+5/rcJxkrLBGL5+695bz6Ze9MxWegDN/UOJO3lBxabVxsO
 OfMKbFS2RhoUxXNTj85lQL6dOEPlZTujreUrK2476FHrM3VuID68KNQHC3yDbGNeAu9S
 Fn0gQApf1bNomw2GMNDBmW1aocpYxxf0R4TAQlhX+sl9y23NuQrORSifMwFoIZXvSThl
 2ZBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tbppK52n3H9pWzeUVQb33/TDF6fZaPSYmG0qcIei3hw=;
 b=DlSWZjkBrAV7/nvGs5X/1st+0usIcn9FNec+JvU4rIX+YiOkin22LYhqH/+66TdfkP
 hAEBspIkW3rf3p6Q5KTltMyFdZSSLtHEJs68wCbvGyFEOD9rHbBAOmNw9miUKD9CpagP
 polKlzS907GnpyblMQqJyteTHJPRiunw+/4QwqkkPGunFWn8vhhCcblNufda8bg8XteV
 XZpFk6s8QK8OvmRHVTbegrxKQSTt3axbFWtjJR313o1c9JzYLCYXLhdEgWOHjL3akw75
 czyeDYArGMnqmcVF0opjLsb5hxcmrfgPBGs7olA0fnyW44PO3BeQ3DY19QVLO6AWSVGW
 0tKQ==
X-Gm-Message-State: AOAM5304C3U31nj3tVDKD1kmtvK3+x1nud8ujmhrF8kniLLdxMUQzMFG
 gNhYUB4kUv/ut9VqROZNJxOM3epkDuuwC2IuLGTskw==
X-Google-Smtp-Source: ABdhPJxKKglY96Rl4MiZpcLd1k5WwpPze7wAzwVEeSyz1fRU5GvIcu5mW8Ki3olmjmFK7Eyb1x1prZHtIDHf/mtaCxI=
X-Received: by 2002:aca:2819:: with SMTP id 25mr3333679oix.48.1595944367476;
 Tue, 28 Jul 2020 06:52:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200727140522.251815-1-cohuck@redhat.com>
 <20200727140522.251815-3-cohuck@redhat.com>
In-Reply-To: <20200727140522.251815-3-cohuck@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Jul 2020 14:52:36 +0100
Message-ID: <CAFEAcA_1xECE+ESWoioHFSF_mwDG11NrR2=J3NWx2X+OGg3SZw@mail.gmail.com>
Subject: Re: [PULL 2/2] s390x/s390-virtio-ccw: fix loadparm property getter
To: Cornelia Huck <cohuck@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::241;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x241.google.com
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
Cc: Halil Pasic <pasic@linux.ibm.com>, qemu-s390x <qemu-s390x@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 27 Jul 2020 at 15:05, Cornelia Huck <cohuck@redhat.com> wrote:
>
> From: Halil Pasic <pasic@linux.ibm.com>
>
> The function machine_get_loadparm() is supposed to produce a C-string,
> that is a NUL-terminated one, but it does not. ElectricFence can detect
> this problem if the loadparm machine property is used.
>
> Let us make the returned string a NUL-terminated one.
>
> Fixes: 7104bae9de ("hw/s390x: provide loadparm property for the machine")
> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Message-Id: <20200723162717.88485-1-pasic@linux.ibm.com>
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  hw/s390x/s390-virtio-ccw.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index 8cc2f25d8a6a..403d30e13bca 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -701,8 +701,12 @@ bool hpage_1m_allowed(void)
>  static char *machine_get_loadparm(Object *obj, Error **errp)
>  {
>      S390CcwMachineState *ms = S390_CCW_MACHINE(obj);
> +    char *loadparm_str;
>
> -    return g_memdup(ms->loadparm, sizeof(ms->loadparm));
> +    /* make a NUL-terminated string */
> +    loadparm_str = g_memdup(ms->loadparm, sizeof(ms->loadparm) + 1);
> +    loadparm_str[sizeof(ms->loadparm)] = 0;
> +    return loadparm_str;

Hi. Coverity points out (CID 1431058) that this code now
reads off the end of the ms->loadparm buffer, because
g_memdup() is going to read and copy 9 bytes (size + 1)
and the array itself is only 8 bytes.

I don't think you can use g_memdup() here -- you need to
allocate the memory with g_malloc() and then fill it with
memcpy(), something like:

    loadparm_str = g_malloc(sizeof(ms->loadparm) + 1);
    memcpy(loadparm_str, ms->loadparm, sizeof(ms->loadparm));
    loadparm_str[sizeof(ms->loadparm)] = 0;

thanks
-- PMM

