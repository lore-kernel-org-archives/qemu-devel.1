Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17DE2C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 14:55:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBAFC2067B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 14:55:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gabaamDJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBAFC2067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAxqK-0005sa-Nx
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 10:55:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58999)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iAxlD-0001MR-Fr
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 10:50:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iAxlB-0002FA-BH
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 10:50:18 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:38861)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iAxlA-0002Da-Uq
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 10:50:17 -0400
Received: by mail-pl1-x641.google.com with SMTP id w10so1734311plq.5
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 07:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=wBnU7eQH7P9dq4SImhH4m+UMr+hvTy4A4AU61yNo/3Q=;
 b=gabaamDJqbVBPQ5OaB4VLzMvr0A8cOkh+P/+ET+m7UIaDLZ2O9q+xlLIOdUe2tLuqa
 8XTs6UtDBdkuOWZqPmSUGufX6Ocu3v6wrICglV31n46T64ptZa0hrABRhq3hwIfGoR2I
 6chrxZLQXDMqAnRFl2MgnwODFRrqnZhKaFmOZ2o38QGdDTntYLs1ufjOHezhxetItDv/
 uYNdWwX3vkNCsfLuFWUHOi/J5AtsAWwq/vrF+4tICZCKFszOuhP253ZUCUrieg7/J7Y5
 8deEfiEhnJ+8FRLUFItbH2PsAORjf1VeITF7AZWl2he78V8J79T+kUflXnPmDUqyKOyp
 VEOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wBnU7eQH7P9dq4SImhH4m+UMr+hvTy4A4AU61yNo/3Q=;
 b=MB/zz2gcNFpZokFAWN4/nl+yhmqk1wgxnayH7kq2BbIq5g6wiLE2aKvuejy76HOTb3
 Fjmwv5tkVQExV2CWBzrr7B4UvpR1jveoDaVMgK4mIAk2NekI4S1xCQIXZFeLkAqK5ZuM
 rPs5vBhzoQ+eOeoYJppxM1WgVfw49AjFi6/cD9ehuOGU9yArr4LzyPuRtwd1Z90msAFr
 XKiY3lnHPySMTeX21oS6f3cib3ACjFAlJWoZxywY/esMgO0yt6HbjontzwNSsXlFuifz
 tv/+jo91/r+ko5zGsXuQ2mvj1WjsUZThFj59aQlraOZby1eLHTnsyuoNm3nhZs5n5ZI9
 DJoQ==
X-Gm-Message-State: APjAAAXL4BsQGOsAK+GHKNvpFmQTG0iJIzffQWbAcF4xXmFM1j0H6nvM
 kXoPAHdbbrNXXYtmtJ9l9oO+qA==
X-Google-Smtp-Source: APXvYqwqsuul27S5q5PuartbeWbNJL8et0wV8hhDiLroFlUV+MrmjNXM4uizdwfm1AgLdYs3Gw15AA==
X-Received: by 2002:a17:902:6b84:: with SMTP id
 p4mr10618381plk.168.1568904615163; 
 Thu, 19 Sep 2019 07:50:15 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id s141sm10546361pfs.13.2019.09.19.07.50.13
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 19 Sep 2019 07:50:14 -0700 (PDT)
Subject: Re: [Qemu-devel] [Qemu-riscv] [PATCH v1 10/28] target/riscv: Convert
 mie and mstatus to pointers
To: Alistair Francis <alistair23@gmail.com>,
 Jonathan Behrens <fintelia@gmail.com>
References: <850360df8fc15a3671bf2237f972ebaf09110015.1566603412.git.alistair.francis@wdc.com>
 <mhng-b813f03d-c23e-405a-8213-c4c9b22a6831@palmer-si-x1e>
 <CANnJOVFNqXEg9KkJC4CHkt0KTt2_6HjyhU2CvMROW+e79mDncA@mail.gmail.com>
 <CAKmqyKMfODSjbBm5ZgmHYYzzrf3B_4WEbANeKXo6rSO6V5Pzeg@mail.gmail.com>
 <CANnJOVGPW1ppNdx+=KAvgNhgGQPvJxjyGY=rxunicu=f++xhiQ@mail.gmail.com>
 <CAKmqyKPQPrPKdkaRjZ7P75jamuqEq6BABir56VrYGm=ZSFpAww@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <18b87754-d5b2-e4f1-bdc5-92ad26b97379@linaro.org>
Date: Thu, 19 Sep 2019 07:50:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAKmqyKPQPrPKdkaRjZ7P75jamuqEq6BABir56VrYGm=ZSFpAww@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
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
Cc: Palmer Dabbelt <palmer@sifive.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>, Anup Patel <Anup.Patel@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Atish Patra <Atish.Patra@wdc.com>, Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/18/19 4:47 PM, Alistair Francis wrote:
> I'm not a fan of the pointer method that I'm using, but to me it seems
> the least worst in terms of handling future code, keeping everythign
> consistnent and avoiding complex access rules.

FWIW, I prefer the "banked" register method used by ARM.

enum {
    M_REG_NS = 0,    /* non-secure mode */
    M_REG_S = 1,     /* secure mode */
    M_REG_NUM_BANKS = 2,
};

...

        uint32_t vecbase[M_REG_NUM_BANKS];
        uint32_t basepri[M_REG_NUM_BANKS];
        uint32_t control[M_REG_NUM_BANKS];

The major difference that I see is that a pointer can only represent a single
state at a single time.  With an index, different parts of the code can ask
different questions that may have different states.  E.g. "are we currently in
secure mode" vs "will the exception return to secure mode".


r~

