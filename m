Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C23AC19759
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 15:19:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F750206B8
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 15:19:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZlUmgz4O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F750206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htCrC-000696-A2
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 11:19:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35953)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1htCpu-0004xA-MB
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 11:17:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1htCps-0000Th-IC
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 11:17:46 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:45536)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1htCpq-0000ND-P7
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 11:17:44 -0400
Received: by mail-pg1-x541.google.com with SMTP id o13so34367297pgp.12
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2019 08:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=GlAKrGQlgH/5jUHmQU0Fuut7i627lnAPELR4y8x8ls0=;
 b=ZlUmgz4Oq0IZ2/4ehAYcEknU5shMpFLEmd3EFConLBCj+jU+RpuDiGmWOsU+QgX+fH
 oGD7FBUOWdd+RBzO1//0KwmuCzozVahUMf6CSZB6UI3mpejID6Z5br7z7o+fW5p8Vm6O
 3MtCrLsRGaycXWIM9Q0zTOBeylKSfGEinIJ9oJIM/dbU7M9Goz5RtBYjUmdhz82vPiPu
 cnzJKRfwongV/BLfn3nv1Hce9RKEGBlgBfyN7zilzq0PXVEViQN4NWyCNdqkjGp6+vNw
 F3UA0h2GlTOKQDpF5v8buXnkyCMMNU1Dqq+JZiM/HFqG5vF+Uat0CLUzWT/Kqkiyk6UY
 Be5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=GlAKrGQlgH/5jUHmQU0Fuut7i627lnAPELR4y8x8ls0=;
 b=HHMbV85C01ygtcGXQ9oxushzKmWWRrEU5hdI0YMgcOD2veEAy8C0Geojcw+n/5qKZY
 25zus6VvAmjOCAyBs14qsXvDufOdVIa0fm68BwcfIJVR98Pg8onnzYGACSHr4g03m+n5
 IZ3XpOnws/NvS0D+Nez7QM19jWTr5biMHjw1rm6hbNsq62yh5pl+yPu3L6yggoSRlzsi
 cuE2e37RFW77NvNt94WXiZWgCuiDo2CWwenb3lIFdnawDnTW/VRXA0vx6bP/0cvHe7hW
 Bfd3dF3pvdYzKpRUYq1kBqGiBUAQURRahI0Hu11/U8fW+n+zr6Ntn2gAoeFEnF+aQUi1
 wigg==
X-Gm-Message-State: APjAAAXZYCgePtxv9iFHN92LygAC7URxu4XHEEgkBL0ENgeVIsUkw2ve
 H0+VkjlYxgG2kBfX6k4AoCdmJQ==
X-Google-Smtp-Source: APXvYqwiYBrU/sarkYg+hRyYwGTXk21QgPUoJOOyvfjZDHp7HHFHFwLet8Q7TV8RNRKTLZzhtsvd2g==
X-Received: by 2002:a62:17d3:: with SMTP id 202mr54194357pfx.198.1564672659974; 
 Thu, 01 Aug 2019 08:17:39 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id 22sm82001928pfu.179.2019.08.01.08.17.38
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 01 Aug 2019 08:17:39 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190731160719.11396-1-alex.bennee@linaro.org>
 <20190731160719.11396-8-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <fe3567d2-57d0-bbdc-9d5f-55462b9c81a4@linaro.org>
Date: Thu, 1 Aug 2019 08:17:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190731160719.11396-8-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: Re: [Qemu-devel] [PATCH v4 07/54] trace: add mmu_index to mem_info
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
Cc: Riku Voipio <riku.voipio@iki.fi>, aaron@os.amperecomputing.com,
 cota@braap.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, bobby.prani@gmail.com,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/31/19 9:06 AM, Alex Bennée wrote:
> We are going to re-use mem_info later for plugins and will need to
> track the mmu_idx for softmmu code.
> 
> [TODO: convert everything to use TCGMemOpIdx?]

Probably easier.  At the moment,

> +#define ATOMIC_MMU_IDX oi

this is mis-named.  It works because

>  static inline
> -uint8_t trace_mem_build_info_no_se_le(int size_shift, bool store)
> +uint16_t trace_mem_build_info_no_se_le(int size_shift, bool store,
> +                                       TCGMemOpIdx oi)
>  {
> -    return trace_mem_build_info(size_shift, false, MO_LE, store);
> +    return trace_mem_build_info(size_shift, false, MO_LE, store,
> +                                get_mmuidx(oi));
>  }

you're also inconsistent about the arguments between user-only and softmmu.

Without doing everything, maybe just use

#define ATOMIC_MMU_IDX   get_mmuidx(oi)

?

r~

