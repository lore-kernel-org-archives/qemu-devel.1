Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D33F2C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 16:32:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BA4A21726
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 16:32:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wwlX532c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BA4A21726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1CUE-00033j-8K
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 12:32:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45658)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i1CSI-0001j4-GV
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 12:30:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i1CSH-00073U-Ha
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 12:30:26 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:45380)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i1CSH-00072u-9k
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 12:30:25 -0400
Received: by mail-pf1-x442.google.com with SMTP id w26so6758715pfq.12
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2019 09:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=fdt9EqP0P7b27VUPh4heMoj7hsoyqjVg1Sr8Lx78roo=;
 b=wwlX532cRNzmFiB4nfUNkgs9HBopRBq//n52798k5cXZD2RB1Q+505I+HBsZb/G6mc
 S5ULWY94PX9d+M5b7dzl90H6G1f96BPPjw9IRA6rQog/kLcQP8UtGnYipvDcciPNqnt0
 gTaKtpcGT+vCUI6/JWkV5nZoDNJYh3egVvoaGbUKAUs9+VhqSBiNq63SjbitRCsq80il
 r7NdYUI0ZPw+x6rmDaTbJApSc13R33c2udMuUunmI+Tv/Ad853IpZVrhrHX6VZoJ1B7H
 LZDOI17kvhUNgCKY1lao59kDu7YUW5raUZQ0AsDI/wlC0biyApSKOyfSTa8VUgs9eUWK
 JORg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fdt9EqP0P7b27VUPh4heMoj7hsoyqjVg1Sr8Lx78roo=;
 b=FgaPGwI/oMwpx7KPTKX05xwQVr/+nh3OBGDkTgr9Pp1ficQfwJkNa3xFmFBZL3VcUz
 UPgajgL4UjxS005Nw+v/q31tSsRw8HcbiKK8uJodVUFrFo5Reoev6VetLDl1i/X2s8iC
 ea2xpdCZLe4rcH9Rzhv081eL/QzYAzMHdzvaNcZtHwDKJKrvewzbeNo3IGUeeK5GiOwU
 aNPaSz0S7NZMrgGwauCGzRAxtWxlAw0V8uTeATp1c9LDV2xcmvI+LVZstt1aCHzF4/Ox
 /6YY5HSAMkzCVGelr98aKFpkighYRcoykXofGfL1ru6Zevc6Uug32lh35TBHi+ynpA4d
 8BJA==
X-Gm-Message-State: APjAAAVkvU6dwFZamcjm8YAl6GSjBW9q8Lg500TX/1BJRrXNlFcvMSOv
 Ta14A3E551jr/S/ZwOHUuFRZ8Q==
X-Google-Smtp-Source: APXvYqzUnd9sFoHJRmj0Apc4B1V8HDdMSlWXWeuc1sHu2uOjpcKdUwkRujl2UBfW3C/BqkIOpYrpEw==
X-Received: by 2002:a65:448a:: with SMTP id l10mr4642619pgq.327.1566577823992; 
 Fri, 23 Aug 2019 09:30:23 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id y194sm4213636pfg.116.2019.08.23.09.30.22
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 23 Aug 2019 09:30:23 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190819213755.26175-1-richard.henderson@linaro.org>
 <20190819213755.26175-23-richard.henderson@linaro.org>
 <CAFEAcA_ctR2KvXkpw=q4mx1aZRzUJFK44kwWUHHe1XN8qsFBLA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <3c662805-072b-35ef-dff7-921b37b5fe89@linaro.org>
Date: Fri, 23 Aug 2019 09:30:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_ctR2KvXkpw=q4mx1aZRzUJFK44kwWUHHe1XN8qsFBLA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: Re: [Qemu-devel] [PATCH v2 22/68] target/arm: Convert USAD8, USADA8,
 SBFX, UBFX, BFC, BFI, UDF
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/23/19 8:39 AM, Peter Maydell wrote:
>> +static bool op_bfx(DisasContext *s, arg_UBFX *a, bool u)
>> +{
>> +    TCGv_i32 tmp;
>> +    int width = a->widthm1 + 1;
>> +    int shift = a->lsb;
>> +
>> +    if (!ENABLE_ARCH_6T2) {
>> +        return false;
>> +    }
>> +
>> +    tmp = load_reg(s, a->rn);
>> +    if (shift + width > 32) {
>> +        return false;
> 
> This UNDEF check should go before we
> generate any code with the load_reg().

Oops, yep.


r~

