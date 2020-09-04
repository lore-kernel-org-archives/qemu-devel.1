Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C2FC433E2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 15:58:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E770220722
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 15:58:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KmY+x1TI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E770220722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEE6g-0007xb-1d
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 11:58:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57442)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kEDyl-00029B-9f
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 11:50:19 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:41018)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kEDyi-0008Qw-Mx
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 11:50:18 -0400
Received: by mail-pl1-x642.google.com with SMTP id m15so237359pls.8
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2020 08:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=THJZW21FF74Vq1VvI0l1acAlfjvztbbRt1pw9mIYjeE=;
 b=KmY+x1TI1ccqeNhLDsK8mrDrmpiIE8Lk7BgM+apCzHbapjYs9UXkw3EwnK7NsqjIiO
 AVAgbSmBQcSvJDQocs13Bz9/OtTHOtrs9jrZpp6/GS2AQ4ov00dz3/fAk/lfjZooQmzW
 KCWJpbPY1fDm5gQjbqfASsraFGo7x5stWFJrzfAErZZi7y+ZuXKzfRsDQp65cPlZdLrA
 EzdSn0S+Spx3D29BshuZxPbDOg2QuuoMLRkV/Dp5VS4ZPv/jWypD2Osz5my7wn4hSmVA
 iaYbTwf59+l8r8qMiHUf1zmR9Vfpqur7FaPdE7Olgy3sq14s+IGd7TZiVoycoHyuhOnu
 jxZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=THJZW21FF74Vq1VvI0l1acAlfjvztbbRt1pw9mIYjeE=;
 b=npu8qYxn+lAIuKgIe8ho9dvn5kL3htZpN5inrReYATXcsrCnbSWIKWSw2FsrnSae8c
 RWN/2onWrOb8l/lbhaF9kmSkXvf7Xemq0MK2tN6jGrIuyWEnxeLwSegIHQlZRPB6jIW5
 mXps/zq81pQ/riSsnNstDbspdDnI9HQ5UZi1s6A47ETRADqiwET6elJVjoE5sUj4TL+l
 e8gugDJHuiQ583LNmiuaFOzMhv040gnlIcLKLgOTTwVa/o6loIrfxIVchN3Qso6tJQVr
 +IkotLJerjcH2fut719GPyAYUY58oPOdQXQYz6tWTrGFXm66ru3Eecoh9BitWrz9W37r
 VBzw==
X-Gm-Message-State: AOAM531hGqI7Kim6T16slbx0NyaE8HP/cFFLX3vWoLRenCn6zrE0Rq+V
 GGrVZFqSwYv01arkRcMaak9WYCrPmHZ4FQ==
X-Google-Smtp-Source: ABdhPJzno5MQCOeBwr6zdvY9wFHPK/LGmU7B5NzMll8EEbp8DjC+DIDzo5k4FaFuJPd2ku7aj29Qng==
X-Received: by 2002:a17:90a:530c:: with SMTP id
 x12mr7844355pjh.223.1599234614913; 
 Fri, 04 Sep 2020 08:50:14 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id n2sm7149574pfe.208.2020.09.04.08.50.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Sep 2020 08:50:14 -0700 (PDT)
Subject: Re: [PATCH 0/2] Remove KVM support for 32-bit Arm hosts
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200904154156.31943-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e8ad0832-8891-6398-7b9e-d844b4f6eaa1@linaro.org>
Date: Fri, 4 Sep 2020 08:50:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200904154156.31943-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.107,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/4/20 8:41 AM, Peter Maydell wrote:
> Peter Maydell (2):
>   target/arm: Remove KVM support for 32-bit Arm hosts
>   target/arm: Remove no-longer-reachable 32-bit KVM code

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

