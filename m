Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C36F5C48BD3
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 10:37:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93497205F4
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 10:37:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EVZzg11w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93497205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hg5JB-0004Tt-IT
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 06:37:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53431)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hg5HT-0003Hy-4s
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 06:36:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hg5HS-0008FZ-40
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 06:35:59 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:40170)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hg5HR-0008CZ-RZ
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 06:35:58 -0400
Received: by mail-wr1-x441.google.com with SMTP id p11so2116697wre.7
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2019 03:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=4AJoC2iAU5fpT9kEEs/GU8jz/nopVcOv/NTMQ5/ecCo=;
 b=EVZzg11wHRwOlKQUR8d3WVj97IQmuewveXP5thUitcnBotd++2OTD32kV4TPADFadd
 PoreFmGdamwhf1ngPqnu7NVYN6bHaDDkHao7tdm9D6awAkCFrYYq/ufVdhzDuJOu73Y8
 czPZFj8RbtwQgkSp9yFLi9O8WNzksQxcEzp4W3HeY3nESFqu/GXKemrL8Y1lLTkjkXrL
 FZR7mK3m1xpIenVwgLk/FV3bAfnFZoymw+6cCbCGkaMJ2tpvQdLWOh63CjsnxhkAw168
 GwboO/abwWONNwFGCZsba/E3CYn+1ycsY/8uVmn4Esg1+6t7iZJ1mdY6vE9F+LD8Mkbb
 yP9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4AJoC2iAU5fpT9kEEs/GU8jz/nopVcOv/NTMQ5/ecCo=;
 b=DBiNad4KCr7i5yV1lu5ULFUttvGspQvuQF0P1XJNHhKis/ILgTfIItKNqv593JQ0y/
 rFqhMpB/xbGe+dO+jTr+tk/VjQSI5P2I/qT0r9vwfy5Bw9jSmccRwN3mXh9GeWGpeAOP
 py9z69w8VpKCPorMmuXwQamzB050Vzyo8c2Uphva3CnfaLLwVnCDl00gNZDEjgDKC5uu
 bRFsCmO13yhqSgV3GzhYAhxbV1nLy4cViU9Nqy+jjEkwNJhLMmGAiCnZlDWOc7wrDB1L
 BdjRn9gGGDzIePuzvTHj/SyD96z3wE7CPT7OiRxlWBqft6Cfvd4xdfCFwPidok4cji2Q
 DaKw==
X-Gm-Message-State: APjAAAUydlAlJPT7H4RIcLif0bzSttw4SMxj9u81LfVagNMinAy1vlAL
 v+t9S3LYPM2VGCPetGfhEWbEzw==
X-Google-Smtp-Source: APXvYqzAhm/dHhe3gHlv/GR89WtqA35gmYg5CIM4dYyKYz4GCxG8Yay6+si7pihRtQsI1POGrfBC7A==
X-Received: by 2002:a5d:4a8d:: with SMTP id o13mr2999826wrq.350.1561545356604; 
 Wed, 26 Jun 2019 03:35:56 -0700 (PDT)
Received: from [192.168.2.137] (93-34-153-63.ip50.fastwebnet.it.
 [93.34.153.63])
 by smtp.gmail.com with ESMTPSA id s63sm1088807wme.17.2019.06.26.03.35.55
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 26 Jun 2019 03:35:56 -0700 (PDT)
To: Andrew Jones <drjones@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
References: <20190621163422.6127-1-drjones@redhat.com>
 <20190621163422.6127-10-drjones@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <0915045d-61e2-acc1-39d1-99fe758a7d0d@linaro.org>
Date: Wed, 26 Jun 2019 12:35:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190621163422.6127-10-drjones@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: Re: [Qemu-devel] [PATCH v2 09/14] target/arm/kvm64: Move the
 get/put of fpsimd registers out
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
Cc: peter.maydell@linaro.org, armbru@redhat.com, eric.auger@redhat.com,
 imammedo@redhat.com, alex.bennee@linaro.org, Dave.Martin@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/21/19 6:34 PM, Andrew Jones wrote:
> Move the getting/putting of the fpsimd registers out of
> kvm_arch_get/put_registers() into their own helper functions
> to prepare for alternatively getting/putting SVE registers.
> 
> No functional change.
> 
> Signed-off-by: Andrew Jones <drjones@redhat.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> ---
>  target/arm/kvm64.c | 148 +++++++++++++++++++++++++++------------------
>  1 file changed, 88 insertions(+), 60 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

