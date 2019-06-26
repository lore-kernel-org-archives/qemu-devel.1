Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F22FC48BD6
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 18:38:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BCFA20663
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 18:38:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IAwrIYNv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BCFA20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgCoL-0000EX-Nj
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 14:38:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44372)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hgCfq-0001pf-Ca
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 14:29:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hgCfn-0008Dr-OI
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 14:29:37 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:38814)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hgCfl-0008AJ-Ma
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 14:29:35 -0400
Received: by mail-wm1-x342.google.com with SMTP id s15so3070849wmj.3
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2019 11:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=1n5QiABTWciMS0q0y9WNnnFhDdlj0CeEHuOMayANtG8=;
 b=IAwrIYNvITrybO6rxkmsRwSjC446xCs0f+8GEGn+LO2tbyv8S7FQwifHhm10m/j2PD
 /SWvQhGzBUotKec3ljlyBYPr11TW1aoDHnqFVB2XW706LeGfLmGK23TAjHGcvnWTH5d2
 l2pCT+9Pl0EH3jkKSXQX+w9mZ8W95CgOZeTKVP7XheZ24K1pEq+a5ge8nyksCspQz0KV
 u7tx+1SXXYc8/3xzIHnRtmv7LAbq1BapauKGl8SU1unWwM0V0bED63zO8AeHFmE1j1dy
 i8nD081z9WHrkt6NlfBsJUG3zpt7u2z0stCEgpaHsO4NnV/ciuWWON+1QUqxDI/udx2y
 Cfuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1n5QiABTWciMS0q0y9WNnnFhDdlj0CeEHuOMayANtG8=;
 b=GEarbmJsK+m8aWfqICjC2PQGzbTeG/k+OkRXbwXR56BF7kzgrHOSoEsOhyVAsh5924
 l+0PlJYrbQzxbN1fzRIR7m0Pf9guZBrreH3kfQSv8IekXeYSwFVQl4tRylXva5euhcMB
 iq3xlyJCriadEc3UVel47MbslLZevlPsjl5Rtu6p4n6v29bxbaXWTGocXN0W9lGkUoUK
 08o/ZpPzBKh0fn6Z3E1axXWEuEpc3kfGyTPAWMGSVGjkY2jk9n9nWw9eWxNCXFiIkJOJ
 5uYk+sQGzbnomMs8yBKCZXfDYwh3dAQ1cU4Bdj71JmOoid0AFJ+t7ZLCfJ0Rnbc5OoUN
 untg==
X-Gm-Message-State: APjAAAWIw6UFmHJkGGW4w/KWJZ86Clhum/9d8czzHmD21wuU3VqKOq2R
 gVdrdN2Ofzu+QwNGMCuvYPhFpgomzx33tQ==
X-Google-Smtp-Source: APXvYqyby45m8D53FGqqv6wAHMsB1FmV36x9ovTlbhb4geHnV+qpXVSmmMpl1tHBnL/2X4MG0XLkOA==
X-Received: by 2002:a1c:f116:: with SMTP id p22mr255081wmh.70.1561573770929;
 Wed, 26 Jun 2019 11:29:30 -0700 (PDT)
Received: from [192.168.2.137] (93-34-153-63.ip50.fastwebnet.it.
 [93.34.153.63])
 by smtp.gmail.com with ESMTPSA id 32sm34578664wra.35.2019.06.26.11.29.29
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 26 Jun 2019 11:29:30 -0700 (PDT)
To: Stefan Brankovic <stefan.brankovic@rt-rk.com>, qemu-devel@nongnu.org
References: <1561115232-17155-1-git-send-email-stefan.brankovic@rt-rk.com>
 <1561115232-17155-2-git-send-email-stefan.brankovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <1a9908ef-2316-ff69-a3dd-d6987eb1ef38@linaro.org>
Date: Wed, 26 Jun 2019 18:03:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1561115232-17155-2-git-send-email-stefan.brankovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: Re: [Qemu-devel] [PATCH v3 1/8] target/ppc: Optimize emulation of
 lvsl and lvsr instructions
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
Cc: david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/21/19 1:07 PM, Stefan Brankovic wrote:
> +#if defined(TARGET_PPC64)
> +    tcg_gen_andi_i64(sh, EA, 0xfULL);
> +#else
> +    tcg_gen_ext_i32_i64(sh, EA);
> +    tcg_gen_andi_i64(sh, sh, 0xfULL);
> +#endif

Didn't see v3 before reviewing v2, however as noted there, tcg_gen_extu_tl_i64.


r~

