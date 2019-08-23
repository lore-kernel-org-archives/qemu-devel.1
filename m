Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D079FC3A5A4
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 16:31:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F452233A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 16:31:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d13aVcI/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F452233A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1CTP-0002I6-DU
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 12:31:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45368)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i1CQd-0008P7-BN
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 12:28:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i1CQZ-00068T-Ee
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 12:28:43 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:34568)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i1CQZ-000684-5o
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 12:28:39 -0400
Received: by mail-pl1-x642.google.com with SMTP id d3so5866709plr.1
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2019 09:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=nuK2lp/CodhYAyc6Wpf+jpECVEBYEi9MOcbES8SGeCI=;
 b=d13aVcI/ciBaenuqQ0Vfsj5mRmqaQpXC4qvTZh0b3nQnLJ0GqOjP6B73H2d7NriT5p
 nnvMo4O2a+HDMzbPfos6/B3Hi7uSJRMysWfloa8DExKp9VYvVxj+O+sVIPkfa3lQ8GkP
 zsI+hPRII1eizuNXBXJEzYE2Mm2ZCI/pKPjayod5JxdDb0mTIzYA9uyJHF769Z/+M12g
 2ENKY4hzSgA26YDsKeCnYo+MIhI5cbToUicG2DTpKCyptF/bu7b+/ee3DUuo6jphteAz
 bFNCYMyLKpcUSX0n3eLI4/5nh/mwUba2LhldI/H7IDKijRqI+EH9xBW3Ky/1hwBl3qoF
 CYdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nuK2lp/CodhYAyc6Wpf+jpECVEBYEi9MOcbES8SGeCI=;
 b=SsXtTEbzJaDdKeDzGAqEe7wzg7JFVuPrHja0TTyfHQ7ABGlHJNz8glAUnjvMpq4bDb
 fjZGdoznC3ai4o7oRei5ZSREIbdO/97H3tSvCy6+vw0oTX//Hk5hTwnJbVZtoZTaUnKb
 JeUEkeZKqBTDvaFpxJ2+gD6FEPswU1mnknv8ftVl5jWu3SiIxuc2fHNiDgKo/oHeGOw9
 osEatYNNZ/G0YI8+eFWkT1dPXjLMVslS9En+xhRnsjVtpLZx9uTFIIiNStJqlhLB/Pcp
 RE/50248RVID3WjHTUbRUfjYmpo8lU37lX5cYQdjxgC1BE3QqRPIFLdmaeOpcOe6eNlD
 qMdg==
X-Gm-Message-State: APjAAAUaW5APD5fVVIVOCjm0MvFqpeasiowJgYVc49zXAQXLNzxr9az/
 dIyuXdnnOuCRsW9dwOv3wpI1TA==
X-Google-Smtp-Source: APXvYqxuRXDOe0SzpVwwksTqxd7Xgybf1shPQ8lsH3ZDWrdneFhEl4wgCeROs3USSsSf2UK2XD0Q2g==
X-Received: by 2002:a17:902:eb:: with SMTP id a98mr5489455pla.75.1566577718082; 
 Fri, 23 Aug 2019 09:28:38 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id u7sm3053337pfm.96.2019.08.23.09.28.36
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 23 Aug 2019 09:28:37 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190819213755.26175-1-richard.henderson@linaro.org>
 <20190819213755.26175-22-richard.henderson@linaro.org>
 <CAFEAcA9VyafAcmhy2t_rSLBM7LEjn7qhGzbETjcnNbFnQw0GhQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <8ae35689-69a2-2af6-2f5d-f2cce6aabaf3@linaro.org>
Date: Fri, 23 Aug 2019 09:28:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9VyafAcmhy2t_rSLBM7LEjn7qhGzbETjcnNbFnQw0GhQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: Re: [Qemu-devel] [PATCH v2 21/68] target/arm: Convert
 Synchronization primitives
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

On 8/23/19 8:28 AM, Peter Maydell wrote:
>> +    gen_aa32_st_i32(s, tmp, addr, get_mem_index(s), mop | s->be_data);
>> +    disas_set_da_iss(s, mop, a->rt | ISSIsAcqRel | ISSIsWrite);
...
>> -                                switch (op1) {
>> -                                case 0: /* stl */
>> -                                    gen_aa32_st32_iss(s, tmp, addr,
>> -                                                      get_mem_index(s),
>> -                                                      rm | ISSIsAcqRel);
>> -                                    break;
>> -                                case 2: /* stlb */
>> -                                    gen_aa32_st8_iss(s, tmp, addr,
>> -                                                     get_mem_index(s),
>> -                                                     rm | ISSIsAcqRel);
>> -                                    break;
>> -                                case 3: /* stlh */
>> -                                    gen_aa32_st16_iss(s, tmp, addr,
>> -                                                      get_mem_index(s),
>> -                                                      rm | ISSIsAcqRel);
>> -                                    break;
> 
> Any particular reason for doing separate gen_aa32_st_i32()
> and disas_set_da_iss() calls rather than using the _gen_aa32_st32_iss()
> function that the old decoder did?

I think gen_aa32_st_i32 with the MemOp argument is preferable to a switch
statement that enumerates the different sizes.

We don't have a version of gen_aa32_st_i32 that also passes the ISS.  While we
could add one, a separate call seems just as easy.


r~

