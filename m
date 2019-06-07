Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A6E6C2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 13:39:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6B8620840
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 13:39:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6B8620840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51210 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZF5L-0005CT-5h
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 09:39:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38371)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hZEz6-0008Ez-KQ
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 09:32:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hZEz5-0004RT-CD
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 09:32:44 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35685)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hZEz3-0004GR-F6
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 09:32:43 -0400
Received: by mail-wr1-f65.google.com with SMTP id m3so2214678wrv.2
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 06:32:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1Q666j7humCTdTOdaQNFaKglmH5x/Xog3PLma8yHMP8=;
 b=NkxAI8ZCETIstfRjd4ybfKu/0O8bIgL0b+YOMnTSrXbtbssWAT+nh1nd+bD2Q/bhrn
 b4b/h0w9ZxkHd82VQ0pgeHYuax1BkTyHAmVlapTVr7BLAZOz/6taKKFrmbxeSFytXuhL
 06pwqehSXufq5FexsrYwUSA0KXOdfcMwITNYCecAQ3B0aBnjI5gWM/eDyx/6s8FJzFD9
 CMWgFJ4bpyihjwEh3rsVSs4e62V7WFSdtsZUpj2V6GYjBAQFqqoUgBJm9Fel4DdCMDTv
 SUZTCJBG+2GLf8keyqSx0hU7Xh2dB0XPPfCczSOT5VmUtr9bZixXS041PmL+EOtZheS+
 qRCw==
X-Gm-Message-State: APjAAAVPQaXmhfO1xFubL8QWndPE0VXozPTJGCg9NsFNRWfGNtjVCoY/
 2k9lYXPZKwLGYhgZNnoRjYo919jecp8=
X-Google-Smtp-Source: APXvYqxN+a2wJiiFec1Hfx2gHgz/IEqIYd+SLLLv6j880+5AhOFRs/B4JX9XhMGkerI5BVDyg2yZYA==
X-Received: by 2002:a5d:6243:: with SMTP id m3mr3114762wrv.41.1559914358688;
 Fri, 07 Jun 2019 06:32:38 -0700 (PDT)
Received: from [192.168.0.156] ([78.192.181.46])
 by smtp.gmail.com with ESMTPSA id y2sm2073873wra.58.2019.06.07.06.32.38
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 07 Jun 2019 06:32:38 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20190517174046.11146-1-peter.maydell@linaro.org>
 <20190517174046.11146-4-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <f210a5de-c3ff-59ea-f2f0-9a6bb1793374@redhat.com>
Date: Fri, 7 Jun 2019 15:32:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190517174046.11146-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH 3/4] hw/arm/armv7m: Forward "vfp" and "dsp"
 properties to CPU
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/17/19 7:40 PM, Peter Maydell wrote:
> Create "vfp" and "dsp" properties on the armv7m container object
> which will be forwarded to its CPU object, so that SoCs can
> configure whether the CPU has these features.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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
>   * + Property "init-svtor": secure VTOR reset value (forwarded to CPU object)
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
> @@ -190,6 +190,22 @@ static void armv7m_realize(DeviceState *dev, Error **errp)
>              return;
>          }
>      }
> +    if (object_property_find(OBJECT(s->cpu), "vfp", NULL)) {

And TIL object_property_find :)
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> +        object_property_set_bool(OBJECT(s->cpu), s->vfp,
> +                                 "vfp", &err);
> +        if (err != NULL) {
> +            error_propagate(errp, err);
> +            return;
> +        }
> +    }
> +    if (object_property_find(OBJECT(s->cpu), "dsp", NULL)) {
> +        object_property_set_bool(OBJECT(s->cpu), s->dsp,
> +                                 "dsp", &err);
> +        if (err != NULL) {
> +            error_propagate(errp, err);
> +            return;
> +        }
> +    }
>  
>      /*
>       * Tell the CPU where the NVIC is; it will fail realize if it doesn't
> @@ -260,6 +276,8 @@ static Property armv7m_properties[] = {
>      DEFINE_PROP_BOOL("enable-bitband", ARMv7MState, enable_bitband, false),
>      DEFINE_PROP_BOOL("start-powered-off", ARMv7MState, start_powered_off,
>                       false),
> +    DEFINE_PROP_BOOL("vfp", ARMv7MState, vfp, true),
> +    DEFINE_PROP_BOOL("dsp", ARMv7MState, dsp, true),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>  
> 

