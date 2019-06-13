Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B417C31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 15:09:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F09DF20896
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 15:09:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cm/pRn7+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F09DF20896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40742 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbRLw-0001hV-9A
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 11:09:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52886)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hbPrO-0000Gi-Cx
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 09:33:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hbPrL-0000uy-JO
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 09:33:45 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:35248)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hbPrH-0000ry-Tw
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 09:33:41 -0400
Received: by mail-wr1-x441.google.com with SMTP id m3so1838919wrv.2
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 06:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=vDycYkpBBaB/Jl0cqSCwG7VUAJgXuKuroLUoQLhjjZU=;
 b=cm/pRn7+jjCDudLpSezgO1TgY9/v9vEUuPurKAuNvfDv0KA5vwWJDPrtX6s2/1iPgZ
 B1DeECbHYiHX+EOuiMG6KWxbG07Q2rsaKOZi8pX311ciw8pTLpxbJ5LDs4SBcfgRuG+j
 RWglNfTE8BvsCTdr+4AS4WItgw/nO/0BRcCnbgDFNMLa/JuJVUuA+WsWIntTjjZpCzCq
 XNI2Dx53McYLvuCyLJc5h44vxpuqJBtXS8/K/ZtSPahfii/uxoxoUWc/A54UiAaj9Kvy
 lOeOcziKvW+EgB4/OC57DSiBKPBqqZtCPQXdXJ+7EVM1TJulZyYllZ6ZCmbbKz+Dw72L
 ZTng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=vDycYkpBBaB/Jl0cqSCwG7VUAJgXuKuroLUoQLhjjZU=;
 b=AynMsHpDhAjp0kouE2MzkaxKGyJ5ZnH86l7OSTipzldkEBMQxXb+8PpuqkAR1LPcZW
 b3c4yg/wE+qA+k1ng8KwqkUPX4FoizJk/Z3Gj0PhLI6B360Q1MjxV0hV2vrcsMUdmGuF
 CEE/cSP1lbhYO4kz9Gda7ev9ERPB3Wqxpx0J+C9rue+nSQlOFZH/69ZoSrsFWtPckLZ6
 DS5K+m1BRoo1LYWY2L75K1sQv/0k0y/2brC4WETsyn4IKzsImhyvmYtXQeGrWV8t11fk
 7C2y/mB6h6NP9hFCGkFATCoj5Hl/tSh7/l+CEbG88FS/PfMDysX8hBwHynhaynbyvVNF
 SdkA==
X-Gm-Message-State: APjAAAUebYPedHM1v0RZLIs/hFWC3/60E11e5iGY+DxbicCL5Hw4M8YK
 eAq5/7mnVkDFJp+84CdGAt4hjw==
X-Google-Smtp-Source: APXvYqxbukC3wuoYLIcAFUFF7rtznwf5iOeYlSOH8C6ZtTJiTtZylUrTS/tmoa9gzf42d72JZ14PBw==
X-Received: by 2002:adf:e8cb:: with SMTP id k11mr58471356wrn.244.1560432818296; 
 Thu, 13 Jun 2019 06:33:38 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id c65sm4387239wma.44.2019.06.13.06.33.37
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 13 Jun 2019 06:33:37 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6299D1FF87;
 Thu, 13 Jun 2019 14:33:37 +0100 (BST)
References: <20190517174046.11146-1-peter.maydell@linaro.org>
 <20190517174046.11146-4-peter.maydell@linaro.org>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-arm@nongnu.org
In-reply-to: <20190517174046.11146-4-peter.maydell@linaro.org>
Date: Thu, 13 Jun 2019 14:33:37 +0100
Message-ID: <877e9pehji.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 3/4] hw/arm/armv7m: Forward
 "vfp" and "dsp" properties to CPU
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> Create "vfp" and "dsp" properties on the armv7m container object
> which will be forwarded to its CPU object, so that SoCs can
> configure whether the CPU has these features.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  include/hw/arm/armv7m.h |  4 ++++
>  hw/arm/armv7m.c         | 18 ++++++++++++++++++
>  2 files changed, 22 insertions(+)
>
> diff --git a/include/hw/arm/armv7m.h b/include/hw/arm/armv7m.h
> index e96a98f8093..d2c74d3872a 100644
> --- a/include/hw/arm/armv7m.h
> +++ b/include/hw/arm/armv7m.h
> @@ -43,6 +43,8 @@ typedef struct {
>   *   devices will be automatically layered on top of this view.)
>   * + Property "idau": IDAU interface (forwarded to CPU object)
>   * + Property "init-svtor": secure VTOR reset value (forwarded to CPU ob=
ject)
> + * + Property "vfp": enable VFP (forwarded to CPU object)
> + * + Property "dsp": enable DSP (forwarded to CPU object)
>   * + Property "enable-bitband": expose bitbanded IO
>   */
>  typedef struct ARMv7MState {
> @@ -66,6 +68,8 @@ typedef struct ARMv7MState {
>      uint32_t init_svtor;
>      bool enable_bitband;
>      bool start_powered_off;
> +    bool vfp;
> +    bool dsp;
>  } ARMv7MState;
>
>  #endif
> diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
> index c4b2a9a1f5c..7caf9bd3364 100644
> --- a/hw/arm/armv7m.c
> +++ b/hw/arm/armv7m.c
> @@ -190,6 +190,22 @@ static void armv7m_realize(DeviceState *dev, Error *=
*errp)
>              return;
>          }
>      }
> +    if (object_property_find(OBJECT(s->cpu), "vfp", NULL)) {
> +        object_property_set_bool(OBJECT(s->cpu), s->vfp,
> +                                 "vfp", &err);
> +        if (err !=3D NULL) {
> +            error_propagate(errp, err);
> +            return;
> +        }
> +    }
> +    if (object_property_find(OBJECT(s->cpu), "dsp", NULL)) {
> +        object_property_set_bool(OBJECT(s->cpu), s->dsp,
> +                                 "dsp", &err);
> +        if (err !=3D NULL) {
> +            error_propagate(errp, err);
> +            return;
> +        }
> +    }
>
>      /*
>       * Tell the CPU where the NVIC is; it will fail realize if it doesn't
> @@ -260,6 +276,8 @@ static Property armv7m_properties[] =3D {
>      DEFINE_PROP_BOOL("enable-bitband", ARMv7MState, enable_bitband, fals=
e),
>      DEFINE_PROP_BOOL("start-powered-off", ARMv7MState, start_powered_off,
>                       false),
> +    DEFINE_PROP_BOOL("vfp", ARMv7MState, vfp, true),
> +    DEFINE_PROP_BOOL("dsp", ARMv7MState, dsp, true),
>      DEFINE_PROP_END_OF_LIST(),
>  };


--
Alex Benn=C3=A9e

