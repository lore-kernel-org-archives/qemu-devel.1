Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5ED4C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 02:10:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFEAC2072F
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 02:10:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zW40GDvU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFEAC2072F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgIqx-0007rH-Vm
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 22:10:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54372)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgIqP-0007Ll-3D
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 22:09:29 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:45072)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgIqO-0007Ae-Bf
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 22:09:28 -0400
Received: by mail-pg1-x541.google.com with SMTP id n23so614003pgb.12
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2020 19:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=s5GOkmf911HWsyIO9xd2eEkGHtCNOb4DWQD4kY7uhU8=;
 b=zW40GDvUJlhj7a74MG5Ajxire+WK8Asf61VMLb0XWGMPyF48Aq3Zgn1BmECCg6456E
 z3n9k1qkmLUrAYHYLAhFF8WxJWoWRodA6cA3okhhilfOHo6TruzmIijDGy1rEujvTBBq
 nQdr6aDjRKQ5fUrQ90BwyrTVF4O0cyoRP7QLy04hPlp6vmK8oe1m48dwLDQikRwsfldp
 uKI5c0N5uENPy28aM4B/FfmcgtJwuKGbWm693LrezYy73Se+hGtWvkbtNaIxDmtxlDBW
 RSsjkWd9g/FlnLrXjSlFg+eqIuPqEPfkNcNmqncQeJnvohypY+W9c7BGVsW5HRhaHsbD
 ILmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=s5GOkmf911HWsyIO9xd2eEkGHtCNOb4DWQD4kY7uhU8=;
 b=lC0ojAz7vWzrYq1DPQaDulx6tO3YZNbRn8nFhWbFT0QGTHZ58IY6o50LmmwyGmQaAk
 WDmhTnuf6fZlf0PJkhq8LzBzr25l62qYBEdtr/MaVAyLcFdLagN3MALaXoZyEq5EcgGz
 OvxDXMjOP2Ub+/lrhpBh3lUJQfnsLhQvZtyuS0xXENMhX5m4xc8VMdShqc3a2r9mgO9o
 gQxw1e+PGTSwO4Gub1O3KxoMpVibqhEcVCrCf6XsEELKlw9xdgwgysIOnKrbloGKFeS3
 ybAEHBWix8KZ2Yjdn++700n5gXBxB2mm7PwXkGv4CBsdZyiQKO5lAGsawDBfeD9piMXE
 zaYQ==
X-Gm-Message-State: AOAM530hzqkjqimhQi6zCg4VfomioCWOumC6spFCYmXX/OHcxt0SvPHK
 O/uiYdhrOzKZRGlT7d9s3z/Idw==
X-Google-Smtp-Source: ABdhPJzpO/M24Lic8a9joVr6etZ6zStKNEB8VxsfPyxynjWP5Pr0p+Bq0MQfVfnynthdgEnjBBn/lg==
X-Received: by 2002:a17:90b:e05:: with SMTP id
 ge5mr2588551pjb.49.1591150166970; 
 Tue, 02 Jun 2020 19:09:26 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id l67sm370182pfl.81.2020.06.02.19.09.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jun 2020 19:09:26 -0700 (PDT)
Subject: Re: [PATCH v2] target/arm/cpu: adjust virtual time for arm cpu
To: Ying Fang <fangying1@huawei.com>, drjones@redhat.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20200603020208.2089-1-fangying1@huawei.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <16ba1a1a-4562-8141-95c8-8e753f59d4d4@linaro.org>
Date: Tue, 2 Jun 2020 19:09:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200603020208.2089-1-fangying1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x541.google.com
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
Cc: peter.maydell@linaro.org, zhang.zhanghailiang@huawei.com,
 wu.wubin@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/2/20 7:02 PM, Ying Fang wrote:
> Virtual time adjustment was implemented for virt-5.0 machine type,
> but the cpu property was enabled only for host-passthrough and
> max cpu model. Let's add it for arm cpu which has the gernic

"generic"

> timer feature enabled.
> 
> 
> Signed-off-by: Ying Fang <fangying1@huawei.com>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

