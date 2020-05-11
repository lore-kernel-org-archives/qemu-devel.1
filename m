Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18195C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 17:43:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D163B206D6
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 17:43:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jdiobxt6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D163B206D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYCSu-0007hY-Tc
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 13:43:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36794)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jYCS6-000723-5u
 for qemu-devel@nongnu.org; Mon, 11 May 2020 13:42:54 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:39011)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jYCS5-0005bC-Eg
 for qemu-devel@nongnu.org; Mon, 11 May 2020 13:42:53 -0400
Received: by mail-pj1-x1044.google.com with SMTP id e6so8137020pjt.4
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 10:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=wUGPC9jeVRgAyUHhHrqyMWgQxX6TBmlgZjWBWEzJ2uE=;
 b=Jdiobxt6z+cA6DAmINpvLq8S8YtvSHRfXc1HYhc0NDg9naC3Nuwz+jgXZ8cybCTOKv
 wzAJ8e0YJ6Ek32I50pDOLov77eq/YXzwxO9QfHfLLIJuSG9p7zQeSbyhRa/33EE9r1YM
 dkBn3513kkOv5LowsUDCLl9paON0sBtkMCpNwGWu+MkW0wQ4hLq5vDucerwaGxSnrkTU
 TZAZWRUnwubBJN+n8SR6Hi2YEG10vi7FR3wJXt1dYIplvwzPCLcd+39eBLClyH4ppqW4
 A6IE2PGfBLB0bAEGMreOb6wNch8K9tNaWIp2DrRqec0OdFnOhu2MwzdGTSPSRvAoUyqB
 ljvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wUGPC9jeVRgAyUHhHrqyMWgQxX6TBmlgZjWBWEzJ2uE=;
 b=tXqmwAZHHRfpDCHtwqRlFgaJGbJjY12bLKJuTvAQl6qNIeZ6T9WtDz9JFes3W+Gs5M
 fyJp1ZGs1bwqUMLfVmitH0bOB7jYB9PQZ2LperESZC+Ldl4HXudw1f9NM6s2c2BoLltW
 h8ZVLAW1OCCxopCWRdvUOS4NSKaIBpKlwayPEQ1hSX64eOU4ybyALwIqu0ydq0lPPYvW
 ErmkNBLUesZ4JT91aSyDf6J4J7gg8WUOpPrdFjIQz0fyf1SjeDTy6q12c+vT0zPHrmeS
 Ew+1pOk2ZDUKMthEzi5vfWgNLZqq3VQfxM3pMiqfGPqvJD0O8++Km6MgXv7SPCAE2lzq
 vnCQ==
X-Gm-Message-State: AGi0PuYiezYgxBPxBBv6g20sLhtQjQX9m79H0nmC87i1fH148gdRCubN
 QbDRs8AC0x8ycyCC4Qyb6xQj9Q==
X-Google-Smtp-Source: APiQypLgjGf++eRcokyH7MM52jTOvWjfBrX/a/pn6a8dkpGU5dMS1/QzvE7npWRSITVhS1fCIHQy/w==
X-Received: by 2002:a17:902:aa94:: with SMTP id
 d20mr15679185plr.15.1589218971552; 
 Mon, 11 May 2020 10:42:51 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id c1sm9720342pfc.94.2020.05.11.10.42.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 May 2020 10:42:50 -0700 (PDT)
Subject: Re: [RFC PATCH 3/8] riscv: Define riscv struct reginfo
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, peter.maydell@linaro.org
References: <20200430072139.4602-1-zhiwei_liu@c-sky.com>
 <20200430072139.4602-4-zhiwei_liu@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c30f74cb-464d-9288-1575-e5c20ccdee03@linaro.org>
Date: Mon, 11 May 2020 10:42:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200430072139.4602-4-zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1044.google.com
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
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, wxy194768@alibaba-inc.com,
 wenmeng_zhang@c-sky.com, palmer@dabbelt.com, alistair23@gmail.com,
 alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/30/20 12:21 AM, LIU Zhiwei wrote:
> +struct reginfo {
> +    uint64_t fault_address;
> +    uint64_t regs[32];
> +    uint64_t fregs[32];
> +    uint64_t sp;
> +    uint64_t pc;
> +    uint32_t flags;
> +    uint32_t faulting_insn;
> +
> +    /* FP */
> +    uint32_t fcsr;
> +};

There's no need for a separate sp field, since that's regs[2].


r~

