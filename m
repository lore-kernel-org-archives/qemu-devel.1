Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86CC4C54E8E
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 16:40:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 522D92070B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 16:40:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pnazu1lo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 522D92070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYBTf-0004Je-BC
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 12:40:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55204)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jYBSh-0003Il-Dq
 for qemu-devel@nongnu.org; Mon, 11 May 2020 12:39:27 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:40561)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jYBSf-0001la-9e
 for qemu-devel@nongnu.org; Mon, 11 May 2020 12:39:27 -0400
Received: by mail-pf1-x444.google.com with SMTP id x2so4979482pfx.7
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 09:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ReaqC1vUYuLUY6DMS8He004r5qrLKP3LM3/d98FNdc8=;
 b=pnazu1loHKhJ1qOneM0Ui+NYFSYk9rJrQdg48G0e8wpTdWPHtVk0kSzOCMHNKcHelw
 qJcTi93a+wv+LwAcOMreU+NRgr+LhUZVBN9nEY/gSh8WFAfnH68E+rLXSO0VVRkX4Uqf
 b0CPgo515tmaROGvIk6YNnCRJRkeQ1mhpQkOSWLFscIiCL9u2W+wfqi0p6/oNU0lEEkt
 MvUjUHsgdsneYqIdBFbADkWpJblq2ouX8ueXMlIsjBeuhEBfKlbBpZK2E8bRLClwLATK
 YCQRH0UHmfU3pf8zaCsrmvjtGs5i6rNeJMM5oZxUD8bmmVwvwQfVnAI4pavo/1+woSQ2
 sRtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ReaqC1vUYuLUY6DMS8He004r5qrLKP3LM3/d98FNdc8=;
 b=QjwOVEFtwVJrcfCCvRuxqtFUSPJydq+LmOhwu6lkPYjqlmrtneIt3QGCg5rkKHfq4t
 XxOUL2QbheFZkLh7BeKoS8GvTHuwuXNZ3/2Qm2/VI4kUmAb/D9IF1jBAKh/XQD8yDh2O
 L1y80go/ULVfkm9ZQEjNEyLcAAAI59axEu7O5dU9/UiAMUyVIU0d1m+V3S6Tja1bJXnI
 u9YXBOP4fp/CDKjJHf1bcRv7Fo+3BDmoGa+omdlTSU66yqqVndD+b40izeuHiPtRM9De
 EiGEC52JgtU8bLk8VbQwYY/EAv7JfZsWy7a30dszvMz7QYEEN9RNI19kk721o0PyjvTS
 gYWw==
X-Gm-Message-State: AGi0Pua2AbYo/QGOViGKXoDXJCZ0y2w/lgDurMqOMf+a3nWE/qQrzA47
 zirVfAHoFqgzkZHXFlMFJt38+g==
X-Google-Smtp-Source: APiQypJWwcEMyTcIxEcRqjeNMyyEPInkZrrkUaDi//wFNhOznULesSvemxTQswItfoI+7jGReiCD+g==
X-Received: by 2002:a63:f555:: with SMTP id e21mr15290639pgk.254.1589215160827; 
 Mon, 11 May 2020 09:39:20 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id n69sm10109792pjc.8.2020.05.11.09.39.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 May 2020 09:39:20 -0700 (PDT)
Subject: Re: [RFC PATCH 1/8] riscv: Add RV64I instructions description
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, peter.maydell@linaro.org
References: <20200430072139.4602-1-zhiwei_liu@c-sky.com>
 <20200430072139.4602-2-zhiwei_liu@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <eb866cde-b8c1-f722-d364-1ae015bb277d@linaro.org>
Date: Mon, 11 May 2020 09:39:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200430072139.4602-2-zhiwei_liu@c-sky.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, wxy194768@alibaba-inc.com,
 wenmeng_zhang@c-sky.com, palmer@dabbelt.com, alistair23@gmail.com,
 alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/30/20 12:21 AM, LIU Zhiwei wrote:
> +LUI RISCV imm:20 rd:5 0110111 \
> +!constraints { $rd != 2 && $rd != 3 && $rd != 4 }

I think it would be helpful to add a function for this.  e.g. greg($rd) and
gbase($rs1) (including $0).  It would keep the constraints smaller, and avoid
mistakes.

These functions would go into risugen_riscv.pm.

> +ADDI RISCV imm:12 rs1:5 000 rd:5 0010011 \
> +!constraints { $rd != 2 && $rd != 3 && $rd != 4 && $rs1 != 2 }

Since all of sp, gp, tp are not in risu's control, why is rs1 only excluding
sp, and not gp and tp as well?


r~

