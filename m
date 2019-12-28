Return-Path: <SRS0=DnLG=2S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02CC9C2D0C8
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Dec 2019 21:19:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCB2320409
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Dec 2019 21:19:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P9SMqlAK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCB2320409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ilJUo-00062W-TV
	for qemu-devel@archiver.kernel.org; Sat, 28 Dec 2019 16:19:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51474)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ilJTw-0005bw-Dq
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 16:18:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ilJTu-0001O8-WE
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 16:18:43 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:39928)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ilJTu-0001Hx-OY
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 16:18:42 -0500
Received: by mail-pf1-x444.google.com with SMTP id q10so16443644pfs.6
 for <qemu-devel@nongnu.org>; Sat, 28 Dec 2019 13:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=j4DjchMA678CXLauG019IEdMkEYmXmUE4GeLbzXHXtg=;
 b=P9SMqlAKRN6Aaf9CqRnHptxCuuD6ChCxQTthEx9HmdU/7ZygKI02ik5/SO77Ma+vRk
 ZbA4DIqkwlo1sjGfokeVyGULu02HXNBEGDewbYMJIglSCa4FmfgSrIdIFJoLN6vdX6Eh
 Cu9sDkKZXRin1UX7n5MeyhdE6INeAoh6iSnlfFxzmN/6I3sWU4RZdv2lLiR8FU3ihZlR
 ZHhT5FZjD0o5r6GtpmTLz0x8ZXOY1jJn6pndvlMLvk5tHhhGzwyierYh8DQbQIvEHNFC
 H3A5gDbR96FGKvHIkQLswQowCbApYB8R2p/YwkJ3z6ksORWjGgDjc52vw2Qpx8W2HPTP
 hi3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=j4DjchMA678CXLauG019IEdMkEYmXmUE4GeLbzXHXtg=;
 b=F3ak6TyI360JfqBBicdYIddSZmeHwPN+WFcfoBxJqR9LGOZJBIehtUQ4tSYimPleJ0
 myVIXvktNKKs/XzRR2jYJkxrdE3uBTrawSfGWmQZ6PULjGJSeQC8Y+b+XF4hFm6QhYas
 3VDYovzVmFrQwhpeKqp4rBDaVxjvmIU6XI7HsRxcFnoKtxlf1O23OWYqY8qzgaY5XeeL
 yPMsIpB+kAmCS0SIIrygFZ/OUcT7QmOKFT5U2U+SwgQNMZbC6yE8JhXpmNY68A60srd5
 7gEvlyFjW3ty/4+/bNklrItI9OcRuaBBSiQt1mpdY49LZVAUAqDyMgrpsL2M/DSRTVYj
 D5JQ==
X-Gm-Message-State: APjAAAW1Nrv5asVxiaSn0LISw4tyETsCUTsgE5RisCYQQuUWeUaHsvDu
 teHuvQ2QcshrFEGL4Nt4pHweiw==
X-Google-Smtp-Source: APXvYqw/PkBnkavyk31R3pd1k7JtESq204nIP1J3j30ltsGZ8xVypv4imjezaUZDi5zyXM13YSrFZw==
X-Received: by 2002:a63:a54d:: with SMTP id r13mr62115904pgu.138.1577567921442; 
 Sat, 28 Dec 2019 13:18:41 -0800 (PST)
Received: from [192.168.1.118] (194-223-58-9.tpgi.com.au. [194.223.58.9])
 by smtp.gmail.com with ESMTPSA id y14sm26658516pfe.147.2019.12.28.13.18.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 28 Dec 2019 13:18:40 -0800 (PST)
Subject: Re: [PATCH v2 26/28] target/ppc: Use cpu_*_mmuidx_ra instead of
 MMU_MODE*_SUFFIX
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191216221158.29572-1-richard.henderson@linaro.org>
 <20191216221158.29572-27-richard.henderson@linaro.org>
 <875ziabwrn.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a748c624-d1d2-cd76-bee4-048abea9d4f5@linaro.org>
Date: Sun, 29 Dec 2019 08:18:35 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <875ziabwrn.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
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
Cc: David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/21/19 6:51 AM, Alex Bennée wrote:
>> --- a/target/ppc/mem_helper.c
>> +++ b/target/ppc/mem_helper.c
>> @@ -177,14 +177,7 @@ static void dcbz_common(CPUPPCState *env, target_ulong addr,
>>      } else {
>>          /* Slow path */
>>          for (i = 0; i < dcbz_size; i += 8) {
>> -            if (epid) {
>> -#if !defined(CONFIG_USER_ONLY)
>> -                /* Does not make sense on USER_ONLY config */
>> -                cpu_stq_eps_ra(env, addr + i, 0, retaddr);
>> -#endif
>> -            } else {
>> -                cpu_stq_data_ra(env, addr + i, 0, retaddr);
>> -            }
>> +            cpu_stq_mmuidx_ra(env, addr + i, 0, mmu_idx, retaddr);
> 
> I assume the possibility of a user-mode with epid is elided in the
> translation phase by avoiding gen_dcbzep although I can't quite see
> where they get called from. Anyway:

I suspect that dcbzep (vs dcbze) is supposed to be privileged, but I can't see
that enforced anywhere.  Certainly one can't write to the EPSC register from
userspace...


r~

