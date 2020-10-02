Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3623FC4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 07:10:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C365206DD
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 07:10:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lmichel.fr header.i=@lmichel.fr header.b="Kxv+7D7j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C365206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=lmichel.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOFCr-0000H1-AJ
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 03:10:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52448)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc@lmichel.fr>) id 1kOFBP-0007Oj-GE
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 03:08:47 -0400
Received: from pharaoh.lmichel.fr ([149.202.28.74]:45088)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc@lmichel.fr>) id 1kOFBM-0000eq-9E
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 03:08:47 -0400
Received: from localhost (sekoia-pc.home.lmichel.fr [192.168.61.100])
 by pharaoh.lmichel.fr (Postfix) with ESMTPSA id 60F4DC60F16;
 Fri,  2 Oct 2020 07:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lmichel.fr; s=pharaoh; 
 t=1601622501;
 h=from:from:sender:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3Gzia367EIGid+ILaNRwPsjAKcAVXY3401W+K1fkVRE=;
 b=Kxv+7D7jMoDdU5QInJfYEtnE72vjIrSZP+BoUMA5aFoItUAkFsqTVC6mURvgGH8FouxLhc
 CgmGmjAZ6HiZrk8wJ2ocG+B1K9H3gmlxN58spyyn0qReOO/Y4UPNjc85nFt5PUaHEm/8ca
 gMnBCRe9XfKBrnyUR8Jc+ZPWeqdxU18TDbYcXaQWFdOWt8+dIrWVWr77+pp8R4uNnyfG8R
 1guApLiPmekCnVT177MYHSci3UoGJoyltCJ5L4MDWzeuVFGCGhhj+NpAz/uhSqwLQFx2fR
 fJN9DkgPEpSfHJylE1o5Rw+tUx8tf5B/IqT0fgaJlpsE2eD5B6ectv0Mb0w22g==
Date: Fri, 2 Oct 2020 09:09:19 +0200
From: Luc Michel <luc@lmichel.fr>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [PATCH v2 1/3] util/cutils: Introduce freq_to_str() to display
 Hertz units
Message-ID: <20201002070919.pv3pt6kt3frcktid@sekoia-pc.home.lmichel.fr>
References: <20201001164322.1585392-1-f4bug@amsat.org>
 <20201001164322.1585392-2-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201001164322.1585392-2-f4bug@amsat.org>
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=lmichel.fr;
 s=pharaoh; t=1601622501;
 h=from:from:sender:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3Gzia367EIGid+ILaNRwPsjAKcAVXY3401W+K1fkVRE=;
 b=CXgskYuXS653wN0JstiN9Y8KzTsicXx/DOkud7hkPx5h56jTg7Pc9p5gnzEbnO5epXR9eI
 AdIW4SgnTw6PWfNS60J3lcyGH+9fMO16gzIUyxvwl13dj8Oh4NH/SKz46zPQc9slr+dVmJ
 gE6AyYCRehYH1EokigNT0MWMXeOUAoB45veiQOiD+g00qnWFOPCh0e5La1eBC35PZuoPKq
 IucM2+26DHFevSiYUMC7HJer3dCSpDhoK7w3XgR+AcR9mxzuwWWrLE/wcYo+dhi8Tk5fU3
 4ITd/wfNiFa7SD+mX4TrYGUAcpAwe9ez4OGmc+YCPgzs8UwioyqTx2p5WHhGxw==
ARC-Seal: i=1; s=pharaoh; d=lmichel.fr; t=1601622501; a=rsa-sha256; cv=none;
 b=JrqSeb3OBRs5qd2OsfD2K+nW6iD10xfTREGJyjI0rv6c7s3mY4rTZQrifutyy6+QD8GbX4X9Ey3rNHyjWHDzmmOgnVp0qoUKAaNlpNaFzaRk3qMCxZbqF5oHuHDMf6u7QQAZIdFH79qOLwvu0PVUaVvNdy28h6RtJk+8PVhOeuxH5v15LMoE0j36VJLNdLJ2e/aH3e0Umg+q1MCR5oKoAmiSoe6hVSvzkaMrAR0NMMrmFmYy2m0C5pBiyinHwE4DANU4XJw/T/Altr5YBxp9X4eD5eXouCwWMH2/ZVEsIs3Mhc6YYhor8eJ/pTJLQrHtdgmK5ifXnuZPEE8xrvOyvQ==
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=sekoia smtp.mailfrom=luc@lmichel.fr
Received-SPF: pass client-ip=149.202.28.74; envelope-from=luc@lmichel.fr;
 helo=pharaoh.lmichel.fr
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/02 03:08:22
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Havard Skinnemoen <hskinnemoen@google.com>, qemu-devel@nongnu.org,
 Tyrone Ting <kfting@nuvoton.com>, Alistair Francis <alistair.francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Damien Hedde <damien.hedde@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 18:43 Thu 01 Oct     , Philippe Mathieu-Daudé wrote:
> Introduce freq_to_str() to convert frequency values in human
> friendly units using the SI units for Hertz.
> 
> Suggested-by: Luc Michel <luc@lmichel.fr>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Reviewed-by: Luc Michel <luc@lmichel.fr>

> ---
>  include/qemu/cutils.h | 12 ++++++++++++
>  util/cutils.c         | 14 ++++++++++++++
>  2 files changed, 26 insertions(+)
> 
> diff --git a/include/qemu/cutils.h b/include/qemu/cutils.h
> index 3a86ec0321..4bbf4834ea 100644
> --- a/include/qemu/cutils.h
> +++ b/include/qemu/cutils.h
> @@ -158,6 +158,18 @@ int qemu_strtosz_metric(const char *nptr, const char **end, uint64_t *result);
>  
>  char *size_to_str(uint64_t val);
>  
> +/**
> + * freq_to_str:
> + * @freq_hz: frequency to stringify
> + *
> + * Return human readable string for frequency @freq_hz.
> + * Use SI units like KHz, MHz, and so forth.
> + *
> + * The caller is responsible for releasing the value returned
> + * with g_free() after use.
> + */
> +char *freq_to_str(uint64_t freq_hz);
> +
>  /* used to print char* safely */
>  #define STR_OR_NULL(str) ((str) ? (str) : "null")
>  
> diff --git a/util/cutils.c b/util/cutils.c
> index 8da34e04b0..be4e43a9ef 100644
> --- a/util/cutils.c
> +++ b/util/cutils.c
> @@ -885,6 +885,20 @@ char *size_to_str(uint64_t val)
>      return g_strdup_printf("%0.3g %sB", (double)val / div, suffixes[i]);
>  }
>  
> +char *freq_to_str(uint64_t freq_hz)
> +{
> +    static const char *const suffixes[] = { "", "K", "M", "G", "T", "P", "E" };
> +    double freq = freq_hz;
> +    size_t idx = 0;
> +
> +    while (freq >= 1000.0 && idx < ARRAY_SIZE(suffixes)) {
> +        freq /= 1000.0;
> +        idx++;
> +    }
> +
> +    return g_strdup_printf("%0.3g %sHz", freq, suffixes[idx]);
> +}
> +
>  int qemu_pstrcmp0(const char **str1, const char **str2)
>  {
>      return g_strcmp0(*str1, *str2);
> -- 
> 2.26.2
> 

-- 

