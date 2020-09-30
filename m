Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C5B0C4741F
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 16:07:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6254520789
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 16:07:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RYzbEH9h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6254520789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNedc-0007mx-93
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 12:07:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54144)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kNeav-0003iy-KN; Wed, 30 Sep 2020 12:04:41 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:44816)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kNeat-0002V1-Lj; Wed, 30 Sep 2020 12:04:41 -0400
Received: by mail-wr1-x444.google.com with SMTP id s12so2409160wrw.11;
 Wed, 30 Sep 2020 09:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=hs5vqL59cUVYdmlX5YvsQb4qbPCF3sP+8s5tcI3TRE4=;
 b=RYzbEH9hVtLi8RAGe9RTntuGtYzL9mdwr/HNMlKRLS3ZIVCnWtFLz18nzYRI8MbnVA
 nahhRLootm+nYRp5lrLBEV7Q80XJs9iDO2J8PRxcBl2y9D3GH+JpQNHqb+DX1QtcndX7
 4evLNbJaDd0GgDUz/zFKQ6Sn4JcZLJXWHXUhw+fRr0W2LPy+uC2l2N0n1BXQV75dFymc
 II0vDe6JHKHs0OHAD28l44JbJBnPhydJdj1FaGIpnPry1quiFBz04ODGs+yey3YXJH0o
 j19SK8p0zkFqXupGE2dGzTY3wnU3uHbrX4wrtcGc2S+zj+LE7zJwbVzVeC/+VrsiE15j
 CzzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hs5vqL59cUVYdmlX5YvsQb4qbPCF3sP+8s5tcI3TRE4=;
 b=mXv7rF04OcLhSpS/grwgvdVk/IVSZRcUwzlosXaUbaCdDhH2yPLOYDOdoRnfhy5f+Y
 0UwochVGmgy4xcXd9CWzTTIneDLIEju/qaiJeMQUCf0bW+JoTmz2XYvo/F0GbPL1gVwP
 fSHrOFn7QGCUnloalAg056pkaCE74WA6Xwd4iqGgQF0/SmttWkDskt/MZZZ9PnjrZ5+s
 FNFklwiwKjewjPF0/Kd8RIP8547XAeUPOwejicJJR6/eeL9O+4aaBmkm1DmXj2tlYrOx
 MRqb5SWAFKU/KED3X/ePohJYcfSJLtKhI7LkXs6TH6D9qPgfPVu9UdWLV8Td/glDnPqN
 mSSw==
X-Gm-Message-State: AOAM533ID7wmxZXt3DgAZbWDOzlCq7tdVh7Ssexh0KMiOgT146vKONee
 eiSZ76rFKQ3KSbeFi8TciPoIN2uLeOQ=
X-Google-Smtp-Source: ABdhPJw9qa1GL4DaEH12nLQ8IDUqSiMcXnng2b/gPhPPSEsr+Tx7HaUGBteZRycH513f/OC7ujJjNw==
X-Received: by 2002:a5d:630a:: with SMTP id i10mr3822362wru.137.1601481877301; 
 Wed, 30 Sep 2020 09:04:37 -0700 (PDT)
Received: from [192.168.1.36] (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id y1sm3506557wma.36.2020.09.30.09.04.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Sep 2020 09:04:36 -0700 (PDT)
Subject: Re: [PATCH RFC 12/14] arm/: fix some comment spelling errors
To: zhaolichang <zhaolichang@huawei.com>, qemu-trivial@nongnu.org
References: <20200930095321.2006-1-zhaolichang@huawei.com>
 <20200930095321.2006-13-zhaolichang@huawei.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <5c080406-6041-79aa-875d-f0e3e7b5798f@amsat.org>
Date: Wed, 30 Sep 2020 18:04:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200930095321.2006-13-zhaolichang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/30/20 11:53 AM, zhaolichang wrote:
> I found that there are many spelling errors in the comments of qemu/target/arm.
> I used spellcheck to check the spelling errors and found some errors in the folder.
> 
> Signed-off-by: zhaolichang <zhaolichang@huawei.com>
> ---
>  target/arm/cpu.h           | 2 +-
>  target/arm/helper.c        | 4 ++--
>  target/arm/m_helper.c      | 2 +-
>  target/arm/translate-a64.c | 4 ++--
>  target/arm/translate-sve.c | 2 +-
>  5 files changed, 7 insertions(+), 7 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

