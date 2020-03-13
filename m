Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 191B9C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 14:55:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1846206FA
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 14:55:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HR+CBC7V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1846206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCliT-0002of-1U
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 10:55:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46783)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jClhk-0001sd-E7
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 10:54:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jClhi-0004iP-CJ
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 10:54:28 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529]:37972)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jClhi-0004h0-73
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 10:54:26 -0400
Received: by mail-pg1-x529.google.com with SMTP id x7so5116603pgh.5
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 07:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=6FsArFb4Vrvq32VdMV4+A17UUaORsh925W18m3nZ+bU=;
 b=HR+CBC7Vfu4Qw17TRM3f6/XXRv245HdJPQp80GnOqzWDZ7VG4wwtoyfXthZ2PepS8f
 GXNKiNRJuRRSNR74TKbHIk2KQgUKuk3OP3z2dCEzM+z3shP6bwjH1rysjEzU77BHFcLY
 9D2SFn2z06fb9g9pberks7T7IbDlSoq1YdO01uYYiDqmV0Pkk39uQpoLhHgZwoyXDIWF
 GoVkE11L2zVtflDdXvhSwehJpmjh4LC3z8A1/hLXuThHtNSwtoy0yzXzeq8MLz6Q0AcW
 JKLGGaz9PQz62JTT0VoNbcdLNUL9eQEkOkftMZ9VWAymGkp9icA1pkDwRhiWW+O2666c
 U1sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6FsArFb4Vrvq32VdMV4+A17UUaORsh925W18m3nZ+bU=;
 b=kFFpKbl197KoDBnyb7cmvpVvQ5+fawJNtiQnISCvqZK1xDRtG9JCMayEN75j2tklLM
 a3HgFKcE/Ct3vHbs5PKOXBKuZ5syYtW8nb8LfEXATd+OsaPW1nVL4rnIlCenlERLWEif
 ayIHpCAYMzCWw4CcPiOD6dmKhBn5Ic8wpzut30e74p/RBq4hAw+2Wlts3+z+ffNjpjjO
 g40yjp8BsFyDG5hSuHkCVEutqq8O4BQ4kOWpVGxsJW4X7AJNSuk8GQMPEXj5I4NEsE9J
 h2GcuR4ZH3PviFSpkiSGxAhiNL9C+lFXEEIraEsMxrjNp02tWmrCvD1uWWNcQZZBBp+X
 4DPQ==
X-Gm-Message-State: ANhLgQ2iviv27/6eL46OQDnAXkMCkysLw7tGoQf3kvhMl7YTORy+0cuO
 k9DQeqoB/4DqX7OpqTTLv9dNNh2wpVk=
X-Google-Smtp-Source: ADFU+vtSUNBfz5E77+a14l7ozCoEVmk0i+0j3/rNZYIf0WAdVWBKBNAzKgvkj+NoMYAIRsNKO7vgOg==
X-Received: by 2002:a62:3487:: with SMTP id b129mr3098727pfa.150.1584111264817; 
 Fri, 13 Mar 2020 07:54:24 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 x190sm59562722pfb.96.2020.03.13.07.54.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Mar 2020 07:54:24 -0700 (PDT)
Subject: Re: [PATCH 2/5] target/arm: MTE user mode disassembly
To: =?UTF-8?Q?R=c3=a9mi_Denis-Courmont?= <remi@remlab.net>, qemu-arm@nongnu.org
References: <20200313140023.83844-2-remi@remlab.net>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b72a1acc-eec1-376a-0fef-caa55799d517@linaro.org>
Date: Fri, 13 Mar 2020 07:54:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200313140023.83844-2-remi@remlab.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::529
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

On 3/13/20 7:00 AM, Rémi Denis-Courmont wrote:
> +/* Extract an Allocation Tag from an address */
> +static void gen_extract_tag(TCGv_i64 dest, TCGv_i64 source)
> +{
> +    TCGv_i64 sign = tcg_temp_new_i64();
> +
> +    /* See ARMv8.5-A AllocationTagFromAddress pseudocode */
> +    tcg_gen_extract_i64(sign, source, 55, 1);
> +    tcg_gen_extract_i64(dest, source, 56, 4);
> +    tcg_gen_add_i64(dest, dest, sign);
> +    tcg_gen_andi_i64(dest, dest, 0xf);
> +    tcg_temp_free_i64(sign);
> +}

In addition to everything else, I see that you're working from quite an old
beta version of the memtag spec.

Please grab the most recent Arm ARM, F.a:
https://developer.arm.com/docs/ddi0487/latest

The current version does not really distinguish between logical and physical
tags, so there is no add:

bits(4) AArch64.AllocationTagFromAddress(bits(64) tagged_address)
    return tagged_address<59:56>;


r~

