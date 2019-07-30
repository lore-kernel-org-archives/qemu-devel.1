Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6340DC433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 02:12:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E23C2064C
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 02:12:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CwJsxsCX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E23C2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsHcu-0002vs-DT
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 22:12:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46733)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hsHcM-0002Oq-UP
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 22:11:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hsHcL-0001HG-U7
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 22:11:58 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:44571)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hsHcL-0001G3-Ma
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 22:11:57 -0400
Received: by mail-pg1-x544.google.com with SMTP id i18so29188305pgl.11
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2019 19:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=MXKsa4ZZukKO+/Awb3SeWnZHOK6Chwd+S4t8E6g5bMo=;
 b=CwJsxsCX4vvqzM9szGcxNw9zvfpYnfCgUV7bn/76s3buVSb19T2zK0PHl8mPJs7QJ9
 bTNu1cs38v+wDokUi44vzJz2/ZX1hhE0iIMF+L/+iOU+e8cfXbIBSxln3QDGc43a3Fhn
 sRPWqQHtWfkxyyUVOvpt73xLfQ88onYuMpxHeFagXkPh2fO+9rXmhhhfgR9BFTd9lCo9
 yiIaRMqmKUUn6HrYffzw6ZAbohq4mnDzYNINE4JS3fctLaeiAyZTmbRboqqWf+SjW9Os
 KZLko6b0TshT7N+0qcYHikLdJjs2OKT/xHO+njY+XmW8+QToRE9iDmAdUEIEiFZj37Fe
 8JMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MXKsa4ZZukKO+/Awb3SeWnZHOK6Chwd+S4t8E6g5bMo=;
 b=NKqx0KYTU0mV9RDtOWJHJk/U60GNTVFzbIc9C3vPJ8hhgHCXTbF7IBet/wn6/uuiEz
 LEsfwNFNhCaix7Z3E/oLg+t8i+E+YeERVkUks8tUsufqbFkVEsQ/H7dAktdMxk4giWzo
 O26efXmpZImYDyrfeZQ3FzIQnpakWqFBSREgRoNmWGCetLvWCMVoBvqcFRoqs0sr4Rw1
 faHmdTmxr7Ezwhp/kE6cw3cTfxylZQDQ91j2fMLJepAu0nqiFE4BmhSCmBS/rnebfEUQ
 Hk0y+ltWfnlFi9za3so0jM8fuq0q2l/HJWAIvZxy1hB64Az9Oe30iDlAOSFXHZMxf11W
 JVcg==
X-Gm-Message-State: APjAAAUJsqFCR1/9T68KKT12JCDe7TUlcQChZ/uQePSJMen0Ov8w9IWl
 Y/rMZO3X2vka0e4eNA9lQb1EKA==
X-Google-Smtp-Source: APXvYqxnoCVjuN0mxPSlbZyhymVmkXHeiIe3EAw9OlrGIPjOtbyJesbeCY4MO2EIrXvRDNChqPR9DQ==
X-Received: by 2002:a62:2f04:: with SMTP id v4mr38496132pfv.14.1564452716183; 
 Mon, 29 Jul 2019 19:11:56 -0700 (PDT)
Received: from [192.168.101.105] ([75.147.178.105])
 by smtp.gmail.com with ESMTPSA id f197sm62189737pfa.161.2019.07.29.19.11.54
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 29 Jul 2019 19:11:55 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190726175032.6769-1-richard.henderson@linaro.org>
 <20190726175032.6769-5-richard.henderson@linaro.org>
 <CAFEAcA-W7idBRdD-DHxrVqfnBsKmAOPZoQAJkaUVOcjnLnGugw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <c7a3ef78-d541-aa0a-21a5-8b4f48db1fd7@linaro.org>
Date: Mon, 29 Jul 2019 19:11:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-W7idBRdD-DHxrVqfnBsKmAOPZoQAJkaUVOcjnLnGugw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: Re: [Qemu-devel] [PATCH 04/67] target/arm: Remove offset argument
 to gen_exception_internal_insn
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
Cc: qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/29/19 6:52 AM, Peter Maydell wrote:
> I'm not so convinced about this one -- gen_exception_insn()
> and gen_exception_internal_insn() shouldn't have the
> same pattern of function prototype but different semantics
> like this, it's confusing. It happens that both the cases
> of wanting to generate an "internal" exception happen to want
> it to be taken with the PC being for the following insn,
> not the current one, but that seems more coincidence to
> me than anything else.

I don't like "offsets", because they don't work as expected between different
modes.  Would you prefer the pc in full be passed in?  Would you prefer that
the previous patches also pass in a pc, instead of implicitly using
base.pc_next (you had rationale vs patch 2 for why it was ok as-is).

Shall we shuffle these patches later, after the Great Renaming of Things Named
PC, as discussed wrt patch 6 (pc_read and friends), so that the "offset"
parameter immediately becomes the Right Sort of PC, rather than some
intermediary confusion?


r~

