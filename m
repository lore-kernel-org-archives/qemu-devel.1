Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 985C8C432C3
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 08:50:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63D3820748
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 08:50:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n5fDL/GQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63D3820748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWcjT-0007fU-FB
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 03:50:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52667)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iWcg6-0004Ks-Om
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 03:46:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iWcg5-0001lQ-QY
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 03:46:34 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:42671)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iWcg5-0001kw-Ir
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 03:46:33 -0500
Received: by mail-wr1-x443.google.com with SMTP id a15so18350673wrf.9
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2019 00:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=39OfZ/J1dOFY5eLk7gwS8kBRO4HQ1+nXIDUn6BWoxos=;
 b=n5fDL/GQCpyriBsTqwv0bXwa8J3DVytdiLnLHZlxsjUCfmvsiA2lQcA/NMYtpaRjw9
 rfxFLp3MuFPdeZJZV3kE7o9TEB1Tx2CMEg6jDWXt31f7IjNZ1K/g5yXW54JIew9Ajouv
 QNxR0DsQyBGz6v5/5d9HfhR7QWl3fEdR97czUN4mu59VnXYZmvdZpPTRrLO0+7B5k9yj
 k7ndBee1DT3BErPzjHf1qyN7iq1bHbRDIkhWwgAOsIksNQ5gYJ+RBifYO7ifGwjyMrvA
 tCnREZvFkwUgQGi/A6jnchMANoLYXA5b6FbgKbosPPix3mg45CA7Obj1pYkTJJEtBghb
 Fvxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=39OfZ/J1dOFY5eLk7gwS8kBRO4HQ1+nXIDUn6BWoxos=;
 b=bIHzj+ZFfs5NImIuT8CDTAwyyb9wAvIq+af/Pt4a19NjL/ON5D5fGPWwyBxXygp8gE
 BnvTFQ27NKd//1HwT/5cw/yAa4e2O2brwXFykCahgWuRP97eyxIk4egufMH6MXc7FOHt
 W/ICCuquKmhDGhvD3b3cDAvTebSKLM9Lyt5kI++EN/Ik7ofgbt61KJOGEgzL32YfmdvG
 VkcwoSIqyFBPG6Oj2jogFOmXgdRD6FZnVltfjraMMLF90lLobGX89CrH5+3iKwKyGjKR
 56CPriEobjWGYt0NuTeF9ck7CBakXDkYc2Y8cWQzJ+G65rzwsY6ZdmTzKHX3M4vbbq0v
 1w3g==
X-Gm-Message-State: APjAAAVMlFWVGsCuPmyMVKMPPMHSqiXhRnN7OLFQt9UPgNK4LAU9Tng2
 3QShpkVSl4ylzt2IumGRFkv3IJ0REMoqKA==
X-Google-Smtp-Source: APXvYqy+o5zQNEBg5xErOPnx+93cChLNwmyDEiU3ElYtv7yTbH5XWp8GY9buCQj8X7mkEzj6O0SVxg==
X-Received: by 2002:adf:ff90:: with SMTP id j16mr19971770wrr.361.1574066792610; 
 Mon, 18 Nov 2019 00:46:32 -0800 (PST)
Received: from [192.168.8.102] (65.red-79-149-41.dynamicip.rima-tde.net.
 [79.149.41.65])
 by smtp.gmail.com with ESMTPSA id 11sm20378524wmb.34.2019.11.18.00.46.27
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 18 Nov 2019 00:46:32 -0800 (PST)
Subject: Re: [RFC PATCH 11/11] target/arm: generate xml description of our SVE
 registers
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191115173000.21891-1-alex.bennee@linaro.org>
 <20191115173000.21891-12-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <d3d7db44-6492-7309-1864-fd67d85bd404@linaro.org>
Date: Mon, 18 Nov 2019 09:46:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191115173000.21891-12-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: damien.hedde@greensocs.com, Peter Maydell <peter.maydell@linaro.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>, luis.machado@linaro.org,
 alan.hayward@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/15/19 6:30 PM, Alex Bennée wrote:
> +int arm_gen_dynamic_svereg_xml(CPUState *cs, int base_reg)
> +{
> +    ARMCPU *cpu = ARM_CPU(cs);
> +    GString *s = g_string_new(NULL);
> +    DynamicGDBXMLInfo *info = &cpu->dyn_svereg_xml;
> +    g_autoptr(GString) ts = g_string_new("");
> +    g_autoptr(GString) us = g_string_new("");
> +    int i, j;
> +    info->num = 0;
> +    g_string_printf(s, "<?xml version=\"1.0\"?>");
> +    g_string_append_printf(s, "<!DOCTYPE target SYSTEM \"gdb-target.dtd\">");
> +    g_string_append_printf(s, "<feature name=\"org.qemu.gdb.aarch64.sve\">");
> +    /* first define types and the union they belong to */
> +    for (i = 0; i < ARRAY_SIZE(vec_lanes); i++) {
> +        int count = 128 / vec_lanes[i].size;
> +        g_string_printf(ts, "vq%d%s", count, vec_lanes[i].suffix);
> +        g_string_append_printf(s, "<vector id=\"%s\" type=\"%s\" count=\"%d\"/>",
> +                               ts->str, vec_lanes[i].gdb_type, count);
> +        g_string_append_printf(us, "<field name=\"%s\" type=\"%s\"/>",
> +                               vec_lanes[i].suffix, ts->str);
> +    }

Really?  Separate 128-bit registers for each Zreg lane?
Surely that's not what gdb does...


r~

