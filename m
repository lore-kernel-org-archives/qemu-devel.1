Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E1AC433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 16:49:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73A4520724
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 16:49:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dnp0OSan"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73A4520724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrlLY-0001se-PU
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 12:49:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53966)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrlKa-0000oR-1N; Sat, 04 Jul 2020 12:48:00 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:51600)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrlKY-0007B7-Kl; Sat, 04 Jul 2020 12:47:59 -0400
Received: by mail-wm1-x344.google.com with SMTP id 22so34915395wmg.1;
 Sat, 04 Jul 2020 09:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=DUsDDSTEosKkFM+c6Mj89LyW1uuNlqCKd8wMhvmfhPM=;
 b=dnp0OSanvhIYefRKhlHqUY+ZEXR74U9Lakt5r7JgwvsHwZqkm4+jhYjOZ1JUXTFKYB
 yRulKswAssKt9DxoM7Hh9AXCHIYGDI5GqC1ctxmzEv1e0htTQnaUtALu6IHrUAZY9txN
 j1nerXgylqAPkbpGyShdA1D+Tuvnc8ah3aUiw1Edh+kKJmLT23sWv3zsc/nvv4DHjR0j
 tonf7Ux0TIlWfKv3HCN+3VwJnzlECAAazPvVXslQfu8umzGlBl4a7X3v0z16zu4f96Ht
 yfOW5YUlr3reSsD/ekqE60sJ1EpRxcmN4cMHKiYDtt67FNl4A0s+jrXaYSGwB0wKKPt8
 1pAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=DUsDDSTEosKkFM+c6Mj89LyW1uuNlqCKd8wMhvmfhPM=;
 b=aONUV9Vvq41LmfFVxFsaNY8lpPr4/vNyEIqgnxbiwFH0Tq52vOm9We5radYclt3i8j
 /MkB/NcdwmkY2ffxA369KUj9iev1jxYHBwfAvYsY3ggeAdIp/xDAqbmDQEEArNp4OOEX
 huere55ILSoWyXkMemSBaNF6gX24y/gyy98Wrhc2rhchPe3cAsVbj6gpWMwDs8nvgKhR
 VMI9+XJY1hw8gv/3hkdh0odFFk3bw0JUDItq7JztDYfJZ+C2ImOZN6waQUT/qyWU7icx
 7EXK135Hv2hG6C1hNExhBV2lIiQ1V6wFwMj49V3a8F3TtsOSNf5Humz/lHnTn0SK6bLn
 CknQ==
X-Gm-Message-State: AOAM531Az6A6VDVSKgewj7dll9/95HDd3KqM2T6wVGdgoDzgz+6mUNyU
 2Rrpsu7bpRZuwD4SaUtaUoIOzeQyzLc=
X-Google-Smtp-Source: ABdhPJwng0Q3BSYBXM3my2lcg+RdX0WBdAOtU/74OzWTfQvK2kLccfdb0i4jieJXn5eCNonC/aKe0g==
X-Received: by 2002:a1c:408b:: with SMTP id n133mr41204583wma.88.1593881276366; 
 Sat, 04 Jul 2020 09:47:56 -0700 (PDT)
Received: from [192.168.1.39] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id u186sm17294350wmu.10.2020.07.04.09.47.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 04 Jul 2020 09:47:55 -0700 (PDT)
Subject: Re: [PATCH] hw/core/qdev: Increase qdev_realize() kindness
To: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
References: <20200620153837.14222-1-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <9d25d07e-0d2d-e202-08e1-a389e964decc@amsat.org>
Date: Sat, 4 Jul 2020 18:47:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200620153837.14222-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

ping?

On 6/20/20 5:38 PM, Philippe Mathieu-Daudé wrote:
> Since commit 510ef98dca5, qdev_realize() aborts if bus-less
> device is realized on a bus. Be kind with the developer by
> displaying a hint about what is wrong.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  hw/core/qdev.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index 2131c7f951..dd3c90d37a 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -392,8 +392,11 @@ bool qdev_realize(DeviceState *dev, BusState *bus, Error **errp)
>  
>      if (bus) {
>          qdev_set_parent_bus(dev, bus);
> -    } else {
> -        assert(!DEVICE_GET_CLASS(dev)->bus_type);
> +    } else if (DEVICE_GET_CLASS(dev)->bus_type) {
> +        error_report("%s: Unexpected bus '%s' for device '%s'",
> +                     __func__, DEVICE_GET_CLASS(dev)->bus_type,
> +                     object_get_typename(OBJECT(dev)));
> +        abort();
>      }
>  
>      object_property_set_bool(OBJECT(dev), true, "realized", &err);
> 

