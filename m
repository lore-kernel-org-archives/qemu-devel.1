Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB53AC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 18:41:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8488920789
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 18:41:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UkDHB4rm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8488920789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joWoj-0003lK-Q8
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 14:41:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37648)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1joWl9-00084Y-Ma
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 14:38:03 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:43588)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1joWl8-0006LB-1M
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 14:38:03 -0400
Received: by mail-pl1-x642.google.com with SMTP id x8so2269926plm.10
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 11:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=eM5FPiajM7AFbx2N5dEjtLk/OaxIvjo+/KMdmbWBpgY=;
 b=UkDHB4rmk6oPsQ3M6hXr9XS7pF5xuwzgbJlKAr48atHyFd1nMH35w37mubIJy7aSKT
 XCLTku9ClZAiq1kLj4foeJujPA6JnCI3kbEOAufCk4uRiBeiutZOx2phBZIE0tnw0A2V
 /vbYs7zBkdlwraxLZ8288w4RlEAro9r56L20V/VstK+ScqjXUTkGppzTB64060qyfbDj
 /lkQVEEobOqkpHiA23w0bE83AXXhDQHoTGUPisKrOVxoY0jloApvRYil6AWQhVCt/Zhm
 E2H1AFft151bJT7tEazKAtY7eGBsrbzpcfDxA5ZcxJwg6+rc15iHxtPQV1ELRAC2B5tc
 9PYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=eM5FPiajM7AFbx2N5dEjtLk/OaxIvjo+/KMdmbWBpgY=;
 b=sIOcmbsnSgEgWR90A2NAIJMGfaXS/wephRsIC/iAuyR7bh1HrD9jchtPIoIYEM7/M5
 8uUT+VETfd53imYJi+d1U9FLrEvqgzHBd5yGFJaNVklIqeUK/ttoXyT9/BNhuozRGYUD
 FCPNdA/rQBxb88eFGebhUxTdE3tQPEescpeHedx4zxBqUrt4zH69teGy4d7amUkVh6wo
 ViI+dNUGcV7W/CgNm3YZuT9JJ3WvLvKd7qQjKhjRD5yl48PAhcrREN+F/5FRDtlHJzTA
 4+3Bbqzn9MOea5v2FXOv7m37sUtn9IOQ0a3MZPG6DvdJDsBokAQfn/hJS2Ovf8bAoF3V
 cAkg==
X-Gm-Message-State: AOAM5329tyIRZ0Gg8nbJD/AzrLC5e4J6i/RoHA0IgDaql80wGgjK3TUM
 250VKx78o0xr3I6IxyCZS55Pug==
X-Google-Smtp-Source: ABdhPJyi2h7CnL9sjJbXxUAWWOs4JgYrkN25pkvGNkJ7CfqJD0soruyuT8fjSb92WGCBKsENKYZNbw==
X-Received: by 2002:a17:902:6bc5:: with SMTP id
 m5mr34385895plt.101.1593110280259; 
 Thu, 25 Jun 2020 11:38:00 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id q184sm2482598pfc.82.2020.06.25.11.37.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jun 2020 11:37:59 -0700 (PDT)
Subject: Re: [PATCH v3 8/8] target/ppc: add vdiv{su}{wd} vmod{su}{wd}
 instructions
To: Lijun Pan <ljp@linux.ibm.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
References: <20200625170018.64265-1-ljp@linux.ibm.com>
 <20200625170018.64265-9-ljp@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <4561adf0-2be1-e9c3-49d8-9de8c414ec40@linaro.org>
Date: Thu, 25 Jun 2020 11:37:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200625170018.64265-9-ljp@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x642.google.com
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
Cc: david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/25/20 10:00 AM, Lijun Pan wrote:
> +#define VDIV_MOD_DO(name, op, element, sign, bit)                       \
> +    void helper_v##name(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)       \
> +    {                                                                   \
> +        int i;                                                          \
> +                                                                        \
> +                                                                        \
> +        for (i = 0; i < ARRAY_SIZE(r->element); i++) {                  \
> +            if (unlikely((b->element[i] == 0) ||                        \
> +                (sign &&                                                \
> +                (b->element[i] == UINT##bit##_MAX) &&                   \
> +                (a->element[i] == INT##bit##_MIN))))                    \
> +                continue;                                               \
> +            r->element[i] = a->element[i] op b->element[i];             \
> +        }                                                               \
> +    }

Missing braces for the if.  Extra blank line before the for.

I see that the ISA document says divide-by-zero produces an undefined result,
so leaving the previous contents does seem to be within the letter of the law.

However... Are you able to test what real hardware produces?  It would be nice
(but not required) to match if it is simple to do so.

Whichever way we go with the undefined result, this deserves a comment.


r~

