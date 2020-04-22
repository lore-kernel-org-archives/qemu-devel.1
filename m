Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 861D9C54FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 17:04:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5238120776
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 17:04:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pWTCahGJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5238120776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRInu-0003Nr-Ei
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 13:04:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56048)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jRIlu-0000wU-KR
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 13:02:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jRIlt-0003Me-Na
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 13:02:50 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:37587)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jRIlt-0003CK-An
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 13:02:49 -0400
Received: by mail-pg1-x544.google.com with SMTP id r4so1400723pgg.4
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2020 10:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=V6wCUFgTe+VWscykJK3oZCRRAChfccvJ/WybncX0PoM=;
 b=pWTCahGJ9jAS/mLwdf8fcCU+57Bxxi7ci26YH48WOQ+LhaUVMkA41m5xN7+rtn7pf3
 rtg2Q7l8pypSVHb6NxvCcgUxkElKOz5Jibucld6JC7njqchELrIgHq7ovzTB6jDRsTgd
 xXpPv8BXcJ+LAdWvObLOC0hsi5LMGxeOu52KyQVjRJh7CObPI+wW2XzSSFROG9hTNYop
 N9KF8Lw8pmgOdFY81420HRs5MNgHX20yysa49dNMrgzFzBxz8KOpNmXyq3tcow62kn6e
 b7Z/iOwWbsr91cSoh5yq6xjHv+tjIBJuFJxMUmcDVsuUJDU7ugqV2Q5AxOflzEvHcs5p
 lv2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=V6wCUFgTe+VWscykJK3oZCRRAChfccvJ/WybncX0PoM=;
 b=q/3pEWLxRIHVdE9GZHD3iMpqSLSaORRIIxfM4aYtl0uAGQcWbXA9MDIeGrab3R7fEL
 iGkWnCqKsC5+2414wxtimPplNbY1iGf3IqDt0NT8SwRzU5WAfvBYuxyz9+kH299ecpjm
 O/htLzyaXN+PbB8zrf3tegHN8XFPWuN/a+8C3KG548XRzzNvRu3WILil/4N0xg27SFT1
 SoP1zj4N+xI4AnHdB8sZc9p93eAp75Prp5PVKZBKp+ikF7UM+k/PfqwvV6+s0eoSsmQy
 ck+DkuTNcv4RTX5YYPbdCrbGRINyGTDYdUjvcA6MkYlS/7tU8P2/9lDnef0PRZJBZuu9
 efWw==
X-Gm-Message-State: AGi0PuZXmw4CHjUzI0Jobv/w2YbX/G6ASEsSmXIxTY2Kwu87BmYd3GHi
 MtGTymgmDnhCB9aOEVv8E2DkuY4MHk0=
X-Google-Smtp-Source: APiQypJwftw5amSqAPuVAc/GlMWlS20YIrvH/xIsbCQP6tPWcg4THJt9VGIya66CuYCu6RwYPEMudQ==
X-Received: by 2002:a63:1c50:: with SMTP id c16mr27044651pgm.255.1587574963008; 
 Wed, 22 Apr 2020 10:02:43 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id p2sm4898905pgh.25.2020.04.22.10.02.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Apr 2020 10:02:42 -0700 (PDT)
Subject: Re: [PATCH v2 13/36] tcg: Use tcg_constant_{i32,i64} with tcg int
 expanders
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20200422011722.13287-1-richard.henderson@linaro.org>
 <20200422011722.13287-14-richard.henderson@linaro.org>
 <87k127cx3l.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b0e95ae2-657d-8d74-686d-17375c090e02@linaro.org>
Date: Wed, 22 Apr 2020 10:02:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <87k127cx3l.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::544
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

On 4/22/20 9:18 AM, Alex Bennée wrote:
>>  void tcg_gen_brcondi_i64(TCGCond cond, TCGv_i64 arg1, int64_t arg2, TCGLabel *l)
>>  {
>> -    if (cond == TCG_COND_ALWAYS) {
>> +    if (TCG_TARGET_REG_BITS == 64) {
>> +        tcg_gen_brcond_i64(cond, arg1, tcg_constant_i64(arg2), l);
>> +    } else if (cond == TCG_COND_ALWAYS) {
>>          tcg_gen_br(l);
>>      } else if (cond != TCG_COND_NEVER) {
>> -        TCGv_i64 t0 = tcg_const_i64(arg2);
>> -        tcg_gen_brcond_i64(cond, arg1, t0, l);
>> -        tcg_temp_free_i64(t0);
>> +        l->refs++;
> 
> Hmm is this a separate fix?

No, it's expanding what tcg_gen_brcond_i64 would do for TCG_TARGET_REG_BITS == 32.

>> +        tcg_gen_op6ii_i32(INDEX_op_brcond2_i32,
>> +                          TCGV_LOW(arg1), TCGV_HIGH(arg1),
>> +                          tcg_constant_i32(arg2),
>> +                          tcg_constant_i32(arg2 >> 32),
>> +                          cond, label_arg(l));

Because we have two separate TCGv_i32, from tcg_constant_i32(), which cannot be
packaged up with TCGV_HIGH/LOW.


r~

