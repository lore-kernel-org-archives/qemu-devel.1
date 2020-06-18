Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F43C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 23:48:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C3BC207D8
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 23:48:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U2Zmkm7U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C3BC207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jm4Gu-0002uZ-KJ
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 19:48:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43822)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jm4FC-0001lA-P6
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 19:46:54 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:46422)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jm4FB-0003ur-80
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 19:46:54 -0400
Received: by mail-pl1-x642.google.com with SMTP id n2so3146931pld.13
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2020 16:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=1ONxn1/R9FtqfA9BjD7nJxNIe8c5xwB4f5kFzFcmPyA=;
 b=U2Zmkm7U05lXBuIJMHo/aMeXgIRvfk/J73XmmGyNI+RpZcQ6fX7Q4hA9G2MEUPPeYC
 X4+qdPysGLbKmhV7UQvEKpHeCnbh0YmReWVxsxI1KPT2GFPYSARbCSXrzR201WZtUY1l
 aeFDED8NRZUcNCMX0Gay6K/SO5a1ivrjVNRHyF6oYyjsS5x/0vdkgPB03VMfpkggo9bJ
 Dp2YlydBQ+DyzF/ML3VmR4DWZg5cnqKgb6gi8Bt+v7dDKm32aGJzpQ6Bl/cjRctJz0FH
 2UWE5pEOvmUtYDDuB/xt5KAcwuplZMD2GFiDIpPN597lW+42w4fWRB6rKJBQTgDZ4kFS
 d3LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1ONxn1/R9FtqfA9BjD7nJxNIe8c5xwB4f5kFzFcmPyA=;
 b=YVzfxPCjGrIHlnVBpzf9oN1I6bJotUe7Y/TQv0jijJqXO5o5mTdqhDHQ6YssiQFw/d
 EkpLY4UobzYwXA9iWnU2DRC5svYiIkTqA8iPG/Mht57e5kOrR4fZSrjzlO8RLdo4d7gV
 LqXqHZbcSgkedCvPZN8pulN/cAasbbR/zlQq2X7jTFpjbk8Q2eW1nIuQRm4kMQcyHAr6
 s5bGXOYAPPcQ0lBfeMMW5k7v7dWxDqwectPCfu90DrkIQzIU+d7253Kl7BY3M0Q8Swl0
 XuBbiLP0zZm9VQLXA6x2oCS8dF7lPEgWnUw2/zO/xwx1lgO6NjjDeP4OARwOA6avDu/A
 xVCg==
X-Gm-Message-State: AOAM532QcUf+3TpHorjFfyLa4En9A7sGvdZ1B0OklPtmChA9clzOUpgz
 VPcTd2oDpAVaJ6DOM52+4zZgduKSDEU=
X-Google-Smtp-Source: ABdhPJw2VF+7z5LiwFTIExTldOiqHgD37CigeV9ComVD9bxsSyApyZ+FnyR8uT8m8vZ9N0iWYh+euQ==
X-Received: by 2002:a17:902:558f:: with SMTP id
 g15mr5777726pli.174.1592524011445; 
 Thu, 18 Jun 2020 16:46:51 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id s41sm3625933pjc.51.2020.06.18.16.46.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jun 2020 16:46:50 -0700 (PDT)
Subject: Re: [PATCH 6/6] target/ppc: add vdiv{su}{wd} vmod{su}{wd} instructions
To: Lijun Pan <ljp@linux.ibm.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
References: <20200613042029.22321-1-ljp@linux.ibm.com>
 <20200613042029.22321-7-ljp@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1aaee21c-ccb6-8e14-7743-3f745d268788@linaro.org>
Date: Thu, 18 Jun 2020 16:46:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200613042029.22321-7-ljp@linux.ibm.com>
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/12/20 9:20 PM, Lijun Pan wrote:
> +#define VDIV_MOD_DO(name, op, element)                                  \
> +    void helper_v##name(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)       \
> +    {                                                                   \
> +        int i;                                                          \
> +                                                                        \
> +        for (i = 0; i < ARRAY_SIZE(r->element); i++) {                  \
> +            r->element[i] = a->element[i] op b->element[i];             \
> +        }                                                               \
> +    }

You're missing all of the divide-by-zero handling.


r~

