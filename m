Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 035D9C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 17:41:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C111B20781
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 17:41:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jePfukRi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C111B20781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joVsf-0006hb-Rj
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 13:41:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50702)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1joVrP-0005bu-S1
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 13:40:27 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:35557)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1joVrN-0006G2-Qj
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 13:40:27 -0400
Received: by mail-pl1-x644.google.com with SMTP id k1so3105402pls.2
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 10:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=gU+ZGyKi3tFABS602rQy/iyGMFx00J4N5JtPzbQYbfI=;
 b=jePfukRiWLqzSNZ0vJBOcEVcJ10YqE3Ld5JyTbiYpn/61pev6GG3wyqzqtyiUlNYP5
 N09Tmtv6lxO2IIrywb8oDTqu6PT9TV358UUeturb7nzLvz5BIZ6Su46dREl08SKACiTk
 naFioyEpe1a8+ixlXlD8hoH/9GR3NWCftF2bcIKeu5RBtQc18V2/0ATma8TjToEBKdv2
 2q/dcTatAOpJKPXku831jhdt8wALiXz9d82jE37w7P5p6CPtdUnmkOryXpYuz48qN3jD
 r8/yZL/uX3GAMSgeX52j4lh4IVKdmIXB0hzOnkc0BLpnUSC7xPVqmlWCn3dRCQZLSxUk
 iCFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=gU+ZGyKi3tFABS602rQy/iyGMFx00J4N5JtPzbQYbfI=;
 b=l80tap1ajnkcLpjQKmV9nniDc5/KksQKGPi5U8iIxQx2bwKT2SS+IAdan9n/r0n9i7
 k8L8+ZFrt0m9vFVGKhHOk51KNoocJOpljyKRif6RAaHVdO3eF7+DSQGkPnlkP2z1j4JP
 FQ9NSqKb9/35IgoUSQKWhsl4+kMLjBuJWG3uDsfODxZlrWFF48N2cvYm2DSeyJOMU3+h
 rzOBqIy/zQPTA1jO61Il340SDtX1Q4cVisvwZcPoL5eX0ffJRVoq206WXx6tDv2I8a41
 Y76QfDXvoP69DxsTA7DWgjQy7trTDJZBmSgVCUAK+Lgg9D51l/VigXFPOa1sjXXNfNpa
 osZA==
X-Gm-Message-State: AOAM5330pURMCFolft02kHBWYwAS611t8W/R2A4ccvd8wqusJ0uCX9ax
 kJvdiodfEqI6E6PCUuUCxMspIQ==
X-Google-Smtp-Source: ABdhPJxgruP4E79++DKPygAmqAsrEdbWzL+O1mZ3H2jdoPgcFgreGF7i0LjbkkQvpDsekLAVxySWUQ==
X-Received: by 2002:a17:902:b48f:: with SMTP id
 y15mr7914739plr.284.1593106824237; 
 Thu, 25 Jun 2020 10:40:24 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id 66sm7773808pfd.93.2020.06.25.10.40.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jun 2020 10:40:22 -0700 (PDT)
Subject: Re: [PATCH v3 1/8] target/ppc: Introduce Power ISA 3.1 flag
To: Lijun Pan <ljp@linux.ibm.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
References: <20200625170018.64265-1-ljp@linux.ibm.com>
 <20200625170018.64265-2-ljp@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <bc918ea4-8023-9186-b603-27e9050ac8d2@linaro.org>
Date: Thu, 25 Jun 2020 10:40:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200625170018.64265-2-ljp@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x644.google.com
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
> +    /* POWER ISA 3.1                                                         */
> +    PPC2_ISA310        = 0x0000000000100000ULL,

This goes in the first patch, but...

>  #define PPC_TCG_INSNS2 (PPC2_BOOKE206 | PPC2_VSX | PPC2_PRCNTL | PPC2_DBRX | \
>                          PPC2_ISA205 | PPC2_VSX207 | PPC2_PERM_ISA206 | \
> @@ -2199,7 +2201,7 @@ enum {
>                          PPC2_BCTAR_ISA207 | PPC2_LSQ_ISA207 | \
>                          PPC2_ALTIVEC_207 | PPC2_ISA207S | PPC2_DFP | \
>                          PPC2_FP_CVT_S64 | PPC2_TM | PPC2_PM_ISA206 | \
> -                        PPC2_ISA300)
> +                        PPC2_ISA300 | PPC2_ISA310)

... all of the rest belongs in a separate patch, which will be sorted to the
end of the patch set.

It's ok to keep the second patch at the beginning during development, so that
you can test each instruction as you add it.  But for final commit you do not
want to enable the feature until it is complete.


r~

