Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF72C32751
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 17:36:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3512320679
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 17:36:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A+OiYnMy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3512320679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hssWS-0003or-AI
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 13:36:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36964)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hssW3-0003EX-HW
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 13:35:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hssW2-000794-Li
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 13:35:55 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:36932)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hssW2-00078E-EG
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 13:35:54 -0400
Received: by mail-pg1-x542.google.com with SMTP id i70so21652284pgd.4
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 10:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=JprkFZG+B7lsQyizGQWAjBZCNRt08yRpbp4jzY2Xmw8=;
 b=A+OiYnMyEJiJgxJajenHptTJyg9iXXiPXxKNnKx1J1qXjv8RBwpV2MSJHNwvdux6Er
 3swA6XW+h1AJIGEH5KrBeifG3XGCt4gIpzku+dSCKTIjIlo3s6rV1dIg0hF2ZsdceNAn
 VCDZmVm/GmxyA2bUnhsU+nWLSZPLfBY/YAFQWB2m9p6iYgOu/3j96LdYnLLUyTQU89OP
 ME1GFFG2ITks3MqXa6zRlK6rkVEmiH2kvC+KmTAO6cmjQHSWX3c1vpgXPdho3wc2X96b
 gq67UWKXq0fFEx+oMtT+1msReMOAmyAChwHE4ZfXLpXhAlAvCGK99FHtajRXQ1glwzf4
 q64g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=JprkFZG+B7lsQyizGQWAjBZCNRt08yRpbp4jzY2Xmw8=;
 b=p4TcrKkoNiOWJMmiBDS+9hirFmYJbjF2eadN7nlYLAFnRQfJ9zONNnSZ0ctuHBaTcR
 4YlWoGvf9od5YkYP9GdOfKi5loOmtSbLFvoSlDV9CphsVhFo8ae/vQW2bnwfiAQ6Qtb3
 xExHGAzmTeH5BA9B5hcMtEk60GQPsmxFVCUZKVu3mgIVpiGeXQCG1ouYmog8e4RxhUAr
 qdaUf+yCAjvMEHvPXNQlB8pZj9WasBSizIZxR5b/rlJjvguuuZiuPJF+EzZqa5nvNsBq
 kJZuot3RP0+BspR7SZLbBtojCpXzw2auGkE0n7LJhOI3Aii137r1QpDMYxLmqQF/mHz/
 HqFw==
X-Gm-Message-State: APjAAAWgqLr7QmnCagFb07umgBefT7Sqsxfd14gQUtSF0ezAuStDJVdZ
 Y6FjALcjKSBFxlQs2ufPOiec6Q==
X-Google-Smtp-Source: APXvYqxYERyQfQCpRFNnk7YcRP24HtAq0RkMTNUCFiGZ/xjUV1rhsm0cKWFyoIf9EasFiz2BtZNjyg==
X-Received: by 2002:a63:d23:: with SMTP id c35mr114266663pgl.376.1564594552770; 
 Wed, 31 Jul 2019 10:35:52 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id j5sm60150622pgp.59.2019.07.31.10.35.51
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 31 Jul 2019 10:35:51 -0700 (PDT)
To: Bin Meng <bmeng.cn@gmail.com>, Alistair Francis
 <Alistair.Francis@wdc.com>, Palmer Dabbelt <palmer@sifive.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 QEMU devel <qemu-devel@nongnu.org>, QEMU riscv <qemu-riscv@nongnu.org>
References: <1564577101-29020-1-git-send-email-bmeng.cn@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <581a0284-c658-265f-1b0f-6f4be5406cee@linaro.org>
Date: Wed, 31 Jul 2019 10:35:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1564577101-29020-1-git-send-email-bmeng.cn@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: Re: [Qemu-devel] [PATCH] riscv: rv32: Root page table address can
 be larger than 32-bit
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

On 7/31/19 5:45 AM, Bin Meng wrote:
> -    target_ulong base;
> +    hwaddr base;
...
> -        target_ulong pte_addr = base + idx * ptesize;
> +        hwaddr pte_addr = base + idx * ptesize;

I believe that you either need

    base + (hwaddr)idx * ptesize

or change the type of idx to hwaddr above.

Otherwise the multiply overflows before it gets promoted with the add.


r~

