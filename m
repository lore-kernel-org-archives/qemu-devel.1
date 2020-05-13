Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C63ECC2D0F6
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 02:05:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EA26206CC
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 02:05:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iAzgZcBY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EA26206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYgmH-00089Y-Ni
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 22:05:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45612)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jYgle-0007TW-Jm
 for qemu-devel@nongnu.org; Tue, 12 May 2020 22:05:06 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:36961)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jYgld-00069b-GC
 for qemu-devel@nongnu.org; Tue, 12 May 2020 22:05:06 -0400
Received: by mail-pl1-x642.google.com with SMTP id x10so6205624plr.4
 for <qemu-devel@nongnu.org>; Tue, 12 May 2020 19:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=I2UU26+f+ZXjuS9qDowqzQXS4x4IEq1aNJA0q7Alt08=;
 b=iAzgZcBYy3CEoidbNqt0fPPxDCPhAY+rbkAFe03yWVfaeWfBW5LeIz1booCv8OMqv3
 VVCanuV0VyfcYIbrYdRfQBXXy63hrWhFb+a1Z/5ibQfwX3cw9nC5Lf0uCpfd1DBNS+lt
 ryh9jcItXPZLp99i/IM3t+VKO7u+Lmg4CSV33mhRGDICXKOe2WW96GGi3bzTLb4QI5Z5
 KLwAm73CryzsSV1/wtmjy708O6TH+ffqOiGOciP61UxkRWYIZ1mW6gmlutmQ9uwpd/AG
 JP2bqk8kUImz9KWKtMKz62blobf+yG66TMp5Y+Uzs/ldms3KkO6z/NkFSBCXppL/41ID
 8DDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=I2UU26+f+ZXjuS9qDowqzQXS4x4IEq1aNJA0q7Alt08=;
 b=a/FYjHIO4DQmesVkij2Ri6i60tbaCajsAvVBBUQCiDuDdRL5pAAwm1TL9jqIeKt1fV
 NjldfwkRAlCl16zST6tktFRTGOot2qXkDZEsHOgNqaEszbzGHLwYtUPhvG+AsVXJr4wO
 2ZmSD9B+GKzfBgPs/y/VZqY+ENY52WE+5IioQxxuustxmywy1Y9/eXmwWFghrG78qXH2
 YxgGjlWsjGMtCVLU9EZI50yBZDdXZUeFxX9I3lqKAiLAWtGROVogUc9vyftM2/SPE2xa
 nCufk7TAVHOqxDldPFLKpeP1BvajJGIqfM9s1GHq+XeNwUzOoARAPnYkP63y7U7Qm/w7
 2abQ==
X-Gm-Message-State: AGi0PuYgXaDi3/J0GEZqmsKlui+/TFBqTGUuUb/OiAA7ZQTk921VR7sS
 M3ube3m7otjSKYKbEWnkDrY9p5lYB9I=
X-Google-Smtp-Source: APiQypJ5uzBjYiSlmK+qZcnbtHNnYJL5IH3p3kOap8Oej/zHjLIH2ZkXdJVtCcVkvLbE+Ud6zMU2yw==
X-Received: by 2002:a17:902:aa4b:: with SMTP id
 c11mr22990746plr.211.1589335502945; 
 Tue, 12 May 2020 19:05:02 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id i11sm1885810pjs.44.2020.05.12.19.05.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 May 2020 19:05:01 -0700 (PDT)
Subject: Re: [PATCH v3 02/16] target/arm: Create gen_gvec_{u,s}{rshr,rsra}
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200508152200.6547-1-richard.henderson@linaro.org>
 <20200508152200.6547-3-richard.henderson@linaro.org>
 <CAFEAcA9q6ZJqEzgfSTgLiFp0a708yhGjrEGArqhCKUQDVp8XLg@mail.gmail.com>
 <CAFEAcA9=yrvEZGRW0rj_1UyRQd0VFYCq7OWtN8ePGvsBajkaFQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <bc85862d-bdce-3531-3776-3cdd65fc9e70@linaro.org>
Date: Tue, 12 May 2020 19:04:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9=yrvEZGRW0rj_1UyRQd0VFYCq7OWtN8ePGvsBajkaFQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x642.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/12/20 6:46 AM, Peter Maydell wrote:
> +void gen_gvec_srshr(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
> +                    int64_t shift, uint32_t opr_sz, uint32_t max_sz)
> +{
> +    static const TCGOpcode vecop_list[] = {
> +        INDEX_op_shri_vec, INDEX_op_sari_vec, INDEX_op_add_vec, 0
> +    };
> ﻿﻿﻿
> Is there documentation somewhere of which vector operations don't
> need to be listed in the vecop list? Here gen_srshr_vec() also
> uses 'dupi_vec' and 'and_vec', which aren't listed, presumably
> because we guarantee them to be implemented? (Hopefully we don't
> encounter a future host vector architecture which breaks that
> assumption :-))

Yes, though perhaps not perfectly easy to find: it's at the top of tcg-op-vec.c.

Correct, that the logicals and mov/dupi etc are mandatory and should not be
listed.  Moreover, I assert that they are *not* listed, so we get a
CONFIG_DEBUG_TCG check of this list both positive and negative.

I'm going to hope that no future architecture is so irregular as to not
implement logicals.  ;-)  Or even be as irregular as Intel.

>> I think the VRSRA case needs the same "shift = -shift" as VRSHR.
> 
> With this bug fixed,
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Thanks, fixed.


r~

