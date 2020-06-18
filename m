Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3453C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 16:13:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8ECF62080D
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 16:13:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sOpBM3ix"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ECF62080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlxAe-00011U-Pt
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 12:13:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44768)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlx9k-0000KG-Lb
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 12:12:49 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:35652)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlx9h-0007Kd-Q0
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 12:12:48 -0400
Received: by mail-pf1-x444.google.com with SMTP id h185so3004092pfg.2
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2020 09:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=w8f6R9ASZrt/RtlltLDdWpOWT0IDLH/5n6K11WS2PRg=;
 b=sOpBM3ixtF3o+lHqUyO+JOrLGJ59F5P2s1WNYg+o8ozhf4MKWRvQxeOobFUvI+V95q
 u7jb9bLl6u4Zan9DUI17SeT+yy5VAiRRG5Ng/XPGZITfkzaTS+QUAOWGc3LiiEeBPQ22
 I+V28GNMeg3asHNOTG//5+twPY+Ab1QEW5S/TKSBzsICpeuRujK2XiKqnwhvswkeVtQB
 z3Cmd8OoYpK4hkNx5xIqwdM/DFjcjAXo99mF9zmoanbRAOOyZ+j3CgVrJK1WQRrHlgmE
 I1H+jSFePhc9LfmUnXnh3gw7YqUHqjD5notcOe+C1J0/gIVimvZyW+aMnqSj2P8P9Iy9
 0DdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=w8f6R9ASZrt/RtlltLDdWpOWT0IDLH/5n6K11WS2PRg=;
 b=ZVA2x6t6VyoclG+UJfluH9koKKn7dPDqYpobyy7RXx0+8FGBFKjvHatt2S5cUVaA4Z
 v/WXeg9YolWuOpJ9GllBGvmqAfG4NAN8QWvATNbbQE+Lb//Zlnk06zDEh3XC1o6qW+Wo
 QociZJEaCrn3b/OXOIEcBmtxvZmLsCCvvNcWlfwXuvcQwFnLxTccuMC6DEVz4tsN5fDx
 6uBR/Yv91/7dh6qWafhtEBpD0CPHuwzz48L9/6KEohxozGI0u3q20Ja7zKeYf9tA1LAU
 OSa247S0NJkE29Te260ibwrQW3C4IUnt+9woMacyxmZD4Lwq4atA2SAo954KrfxJztoF
 rcyA==
X-Gm-Message-State: AOAM533XhWgtVMtDEOzTU1euRZ6w/jmuS9odyuHDh+YvKotem/zJx/+8
 tNymvYRVIDUJ+pjwi4ubjf+V2A==
X-Google-Smtp-Source: ABdhPJxRoACp/IGBS922BqWSX/dqiNIWCtcp+25QiJx7Q3wUivov515PgYoxjiiiKLqyUrhVE6PMvw==
X-Received: by 2002:a62:7bcd:: with SMTP id w196mr4116737pfc.73.1592496764044; 
 Thu, 18 Jun 2020 09:12:44 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id x77sm3468469pfc.4.2020.06.18.09.12.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jun 2020 09:12:43 -0700 (PDT)
Subject: Re: [PATCH v7 10/42] target/arm: Implement the ADDG, SUBG instructions
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200603011317.473934-1-richard.henderson@linaro.org>
 <20200603011317.473934-11-richard.henderson@linaro.org>
 <CAFEAcA-QZ_D1tQMv785xsxWwcEKmM76dK4Mvgx=y7eyb_mUqEg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3b1b50b8-061e-8422-2df0-e8df6f856941@linaro.org>
Date: Thu, 18 Jun 2020 09:12:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-QZ_D1tQMv785xsxWwcEKmM76dK4Mvgx=y7eyb_mUqEg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Stephen Long <steplong@quicinc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/18/20 6:17 AM, Peter Maydell wrote:
>> +        imm = (imm >> 6) << LOG2_TAG_GRANULE;
...
>> +            TCGv_i32 tag_offset = tcg_const_i32(imm & 15);
...
> Given that we don't really share any of the codegen with the
> existing disas_add_sub_imm() insns, and the insn format isn't
> the same (uimm6/op3/uimm4 rather than an imm12), I'm tempted
> to suggest we should structure this the same way the Arm ARM
> decode tables do, where "Add/subtract (immediate, with tags)"
> is a separate subtable from "Add/subtract (immediate)": so
> instead of disas_data_proc_imm() sending both case
> 0x22 and 0x23 to disas_add_sub_imm(), it would send 0x23
> to a new disas_add_sub_tag().

I'll do that, because...

> But this patch is functionally correct...

... I've just noticed that it isn't correct.

I drop the low 6 bits of the 12-bit "imm" on the first line, and then try to
read the low 4 bits on the second line.

Oops.

r~

