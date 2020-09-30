Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	PDS_TONAME_EQ_TOLOCAL_SHORT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD4B6C4727F
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 10:37:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CE512064B
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 10:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G6OcDrea"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CE512064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNZTx-0000DF-3W
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 06:37:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46362)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kNZHM-0001ZO-PW; Wed, 30 Sep 2020 06:24:08 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:54075)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kNZHL-0006gq-7q; Wed, 30 Sep 2020 06:24:08 -0400
Received: by mail-wm1-x341.google.com with SMTP id x23so1105307wmi.3;
 Wed, 30 Sep 2020 03:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=LdOsLUwLttg3TTRdEYkX/X58pBuNh6nHyitgH94HsTE=;
 b=G6OcDrearV2mWLt49oERnsH10lQWSc6R54bDA+UbSFQspzPTeUpddsBSXN5vqC7+lN
 uil9PloPV/qyz9/kUFxo5KbWGkCGhEovToUpoOVTkTSXIy9e7hZ4xIXA/75Z2X1Xq01W
 WbvyWBCC4+5iiw88WvqaDxcwaubZr0DEGGNNWv/Rktwku3yZZyqRGurZVbFjhUzt5gOr
 n5XsKAQXDPFYbJ8PhTErBbhFxRSoto1BLwW1P2hNe3EUzjc4iFvTU93pzoJtmPovD9yE
 8hdXqbqwCyUwNNksdhJEymetkjx/pkIzbM1UO9ntk/qfKEJEf7Rn9d3ng6IkLBETQRnn
 wlhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LdOsLUwLttg3TTRdEYkX/X58pBuNh6nHyitgH94HsTE=;
 b=K0HJx/COi5TFhwy+1PVT0ve/MNWyGsuLgFE41ijkwajehXX2K8+NMH6CJwy18qSxFp
 qWqHwBAV8wCPqJmYuuxvmKDu/V2EaA3TDOPy2Pa4f5kp+pOCUlqFOJ+PX/ept+iHQYDZ
 XmEtyO/tWvTCjom20k617VyPUvPtXk/AxlSNW406aADO+Be5a/QaPbp4DTwDMRMCtveM
 qHriatPuotoRnrfRBDwSMOg0myaC5MejdOv744Xzd07sq4COgDen9A873ApfGkqtukiL
 5mxnxc9BDuCjfVorn93iyXgfhSfs248G//pFL302JaM9jf+ckKbS/a2LRIpAskpfhSjC
 KeOQ==
X-Gm-Message-State: AOAM531xWc15P8zetl1gwH9QHcKwX8q0BmC6DqoVJC/wDLf/2CIMAIVX
 /tgCuuX6t8pv0/Ii3jKdQx7IQXVbiwE=
X-Google-Smtp-Source: ABdhPJwku4naBXwd0TJ/cYUxYnkOSHR4YsimMuniwubo8DbabGRKSb4u3GfGu6lZp3qelBw9r+cWMw==
X-Received: by 2002:a1c:740c:: with SMTP id p12mr2205964wmc.176.1601461445263; 
 Wed, 30 Sep 2020 03:24:05 -0700 (PDT)
Received: from [192.168.1.36] (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id u66sm1956408wme.12.2020.09.30.03.24.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Sep 2020 03:24:04 -0700 (PDT)
Subject: Re: [PATCH RFC 09/14] sh4/: fix some comment spelling errors
To: zhaolichang <zhaolichang@huawei.com>, qemu-trivial@nongnu.org
References: <20200930095321.2006-1-zhaolichang@huawei.com>
 <20200930095321.2006-10-zhaolichang@huawei.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <96c0b893-735d-d2a0-fe27-1a855de3947b@amsat.org>
Date: Wed, 30 Sep 2020 12:24:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200930095321.2006-10-zhaolichang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.199, NICE_REPLY_A=-0.001,
 PDS_TONAME_EQ_TOLOCAL_SHORT=1.999, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
> I found that there are many spelling errors in the comments of qemu/target/sh4.
> I used spellcheck to check the spelling errors and found some errors in the folder.
> 
> Signed-off-by: zhaolichang <zhaolichang@huawei.com>
> ---
>  target/sh4/cpu.h       | 2 +-
>  target/sh4/op_helper.c | 2 +-
>  target/sh4/translate.c | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>


