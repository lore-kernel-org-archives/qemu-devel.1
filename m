Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE76C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 20:34:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 118E12074A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 20:34:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GV1rMkKl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 118E12074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBl5L-00078w-AP
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 16:34:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56040)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBl4g-00069d-Hu
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 16:34:14 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:56238)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBl4d-00045C-Sq
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 16:34:14 -0400
Received: by mail-pj1-x1041.google.com with SMTP id 2so113429pjx.5
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 13:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=OQygBWHACdJLdEJnsxYXuKSltvPMBiSKkoQRYnAo6OY=;
 b=GV1rMkKleRFKRvpRfMUQ2JP3E1oBk/27tOlFyKhgzLQ6Jn+8uhUL0aprxYPYbaxZKF
 W5V01ZsSLOUTM2QxgQZSSbjDnBlWacY4QqW3PYc/DHo9Bq2lAFQy20Cxjyqoenas6yme
 tD9Yx1X1TTRlKblrItXMJIZg8nbZ/haz/U0rwOw9/3LAqajuh4drTNf6vI2Jg0bm06bE
 dQCncQ3hIhLGQ1zaZFTWhSRwzniH0fMbS951N3hOdjCi7m00eH1jqpsdTNFlq6SL1h9v
 fC2tJiZpYGhMfz0GN7vqCK6qo29fK1W+LIOGCWi3WNOWD+I1NC3C0lMxNmG3Xukiu2dK
 kdNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=OQygBWHACdJLdEJnsxYXuKSltvPMBiSKkoQRYnAo6OY=;
 b=NMQgffrYFfew9R7d41zspnls+We9wQ9x3A0qwNV/0C2sD2ME1kwTgA9FOeynwuRMxW
 dc57LzM7At2IG8zRYOfi1MaDm1INXAZwFpay0qrVPOFs7WhtoDapQvQGoW1qWfbM2H+H
 +fw0qmpt0PmP60OHrwyWjsIlPmnBPqJlBhC+M+yYYws8aP5ZeQcvEXoo29ztBwPEzuZ1
 wOLBSvC0P0GJdbhPA3Jx2Yg5C2BwMYu5CiRCfzW9CsG3PXX+K+igo3F8o3EnEwC1Xmva
 HtnCb6/AR6VQ3mj+VuREKDd4+jZHM+pfxC5x5bfTqc/WN2otlx5O/Buri3n08n1/T+EZ
 JaqQ==
X-Gm-Message-State: AOAM533aB9xdoulnvYBXGH94i7URNyaq2VDaEbwT8G8uCA+cu4AY6NtN
 98e7MUF4Rkm3z0WBwKJuLHD9rw==
X-Google-Smtp-Source: ABdhPJyVnRFKUYzrUwU2xSU3ogyOWET1xIXm5wGY5vIXF7lGH9PD9odQMz1wHbVG44sDuPvYs9rkkA==
X-Received: by 2002:a17:902:e787:: with SMTP id
 cp7mr500565plb.125.1598646850519; 
 Fri, 28 Aug 2020 13:34:10 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id y1sm289191pfp.95.2020.08.28.13.34.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Aug 2020 13:34:09 -0700 (PDT)
Subject: Re: [PATCH v1 2/2] target/microblaze: Improve transaction failure
 handling
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org
References: <20200828113931.3252489-1-edgar.iglesias@gmail.com>
 <20200828113931.3252489-3-edgar.iglesias@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3556c713-8635-2868-cd4c-387fcef6c50c@linaro.org>
Date: Fri, 28 Aug 2020 13:34:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200828113931.3252489-3-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1041.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.809,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: figlesia@xilinx.com, peter.maydell@linaro.org, sstabellini@kernel.org,
 edgar.iglesias@xilinx.com, sai.pavan.boddu@xilinx.com,
 frasse.iglesias@gmail.com, alistair@alistair23.me, frederic.konrad@adacore.com,
 qemu-arm@nongnu.org, philmd@redhat.com, luc.michel@greensocs.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/28/20 4:39 AM, Edgar E. Iglesias wrote:
> +    if ((access_type == MMU_INST_FETCH && cpu->cfg.iopb_bus_exception) ||
> +        (access_type != MMU_INST_FETCH && cpu->cfg.dopb_bus_exception)) {
> +        cpu_restore_state(cs, retaddr, true);
> +        env->sregs[SR_ESR] = access_type == MMU_INST_FETCH ?
> +                             ESR_EC_INSN_BUS : ESR_EC_DATA_BUS;
> +        env->sregs[SR_EAR] = addr;
> +        helper_raise_exception(env, EXCP_HW_EXCP);

I think it's better to use cpu_loop_exit_restore, adding the one line for
cs->exception_index from helper_raise_exception.


r~

