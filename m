Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B1B7C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 14:35:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A2422177B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 14:35:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vXc1pX2E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A2422177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAwW4-0001Fa-Ek
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 10:35:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45476)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAwVV-0000pK-2C
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 10:34:33 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:42146)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAwVT-0005jx-HY
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 10:34:32 -0400
Received: by mail-pg1-x543.google.com with SMTP id g1so1108535pgm.9
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 07:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=CPkmGFObJrzj6Vz259X9NlyAgcPYN6V6ePMw+OQBPj4=;
 b=vXc1pX2Ecqrxb4sOJ5tvF/FE9Q5i0zNqHNwtlu23cQ0AIpaj1RnhHOQY6KOuju+pye
 NXV4qA9ZHPnsEZ2/nRQsHhAToqQv3PVdg8U0lxMMDilZ0mW7GC8ImpQAUtY9xYkSiKUL
 sYTx8jbps51JHjLoTbBrFc9Z3YIASaEuA32UZaNbe64Wa6jJQYN3YS1PTL2hWwRrWZDG
 elZ49foG6XtND297PDv9q2b+PkDYyeDMJxi+IwPQP3TSZLnBcZ/liJLeqVlmWAyE09pk
 aRIHjdh+F0+bEDoPZ/89mziJ4+tyEEMYOzLzFhlK4s6RcLKjVnRZnxQfF8rApSkL1W0H
 8/Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=CPkmGFObJrzj6Vz259X9NlyAgcPYN6V6ePMw+OQBPj4=;
 b=RzVC8BiJIm/0qxLbWnnKR7jEX5jLjP6PU4GQGJ3IvnW5ooGRcevVtUnhDRtbNUP6Mv
 DxCRU+VuMpZcZvQTUSy6zJ7kPvIRPnYFOIvHXGnfTSST6KVmmUg4woGksqDotvX63aBP
 UwczaVymI1JoqG9ADjH10cCtPjUx2WFjNrZfqSvVRec/+JcXd6VBC7pX78BGm8QYn4cK
 81AbU/RvskckpCC31hxarSSM+zNdH7DwSs0zb6V1HWdxAS6okZF6ov56KQtf6ydvboHu
 WOxhURv0kttAHVENo3TEkiMwHzO0gt0YejwFsMlnAgDqkEtaoWHiDEkYaREfDVrI2ATK
 7bAw==
X-Gm-Message-State: AOAM532z97VAVZL2JQfs5YxLzjslI1MFx3gfUnhPDzFlaZunU3L4+ev3
 fOvlDJ9zMt66aqEuQucNWGOnHQ==
X-Google-Smtp-Source: ABdhPJw2uZW956peViVPG3fSj+Gf6hDNuM3zU0P17FhCs7wazn7mMzCtAoe/2DmVnpI8QZjdSg3MNg==
X-Received: by 2002:a05:6a00:22c9:: with SMTP id
 f9mr12348078pfj.212.1598452469891; 
 Wed, 26 Aug 2020 07:34:29 -0700 (PDT)
Received: from [192.168.81.79]
 (h216-228-167-147.bendor.dedicated.static.tds.net. [216.228.167.147])
 by smtp.gmail.com with ESMTPSA id b185sm3191842pfg.71.2020.08.26.07.34.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2020 07:34:29 -0700 (PDT)
Subject: Re: [RFC PATCH v3 12/34] Hexagon (target/hexagon) instruction
 attributes
To: Taylor Simpson <tsimpson@quicinc.com>, qemu-devel@nongnu.org
References: <1597765847-16637-1-git-send-email-tsimpson@quicinc.com>
 <1597765847-16637-13-git-send-email-tsimpson@quicinc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5d13ad4c-6ff7-8ccc-c5eb-303c97cd9664@linaro.org>
Date: Wed, 26 Aug 2020 07:34:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1597765847-16637-13-git-send-email-tsimpson@quicinc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.239,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: ale@rev.ng, riku.voipio@iki.fi, philmd@redhat.com, laurent@vivier.eu,
 aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/18/20 8:50 AM, Taylor Simpson wrote:
> +#define ATTRIB_WIDTH 32
> +#define GET_ATTRIB(opcode, attrib) \
> +    (((opcode_attribs[opcode][attrib / ATTRIB_WIDTH])\
> +    >> (attrib % ATTRIB_WIDTH)) & 0x1)

Can you define GET_ATTRIB in terms of qemu/bitops.h?

I'm leery of ATTRIB_WIDTH being separate from the actual definition of
opcode_attribs, over in opcodes.h.

Why does attribs.h need to live separately?  They're clearly closely related,
and cannot in fact be used separately.


r~

