Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53A02C433E3
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 09:59:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22D96206DA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 09:59:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aBdzjF7v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22D96206DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7yOv-0001V6-Bq
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 05:59:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39474)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k7yOK-0000xL-CX
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 05:58:52 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:40379)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k7yOI-0005HU-UO
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 05:58:52 -0400
Received: by mail-wm1-x344.google.com with SMTP id k20so16383708wmi.5
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2020 02:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=T2gr4kCyZSb8TF9QqzNInn0k/VrEXpMgcdS7NOtKAPo=;
 b=aBdzjF7v9B4+BroZ20XCNg2bRO8mpUp6IUtpQy9hgI5G7LuA8yh6LHf4krR1izLzVz
 tV/Y0pG/6zHPQG/Iv726zbskDeIlPoF7mzsvTGMb9XimZ62QuWu+tCfftQC/ouKr//+R
 OFtJeKn6oN6SMIBA3eEA4OBGKzrVcxajqv4soxQK3IKcu88IlTiez/wTgycpwyQAoH3z
 pT7LB5nWtVdDkFnVzcjWhydSJdanbHJ2mZReLT1eBSZ3DuMkOGWTqGLoWKVO58wYwZj7
 1PPgoiDOszZJYPxrpqFwtcOf2yTOAavhxjdM6yndkLovm7ckNJhcfhe8AMZFZbt/+ISU
 5X7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=T2gr4kCyZSb8TF9QqzNInn0k/VrEXpMgcdS7NOtKAPo=;
 b=iR4vE5N8yyQxg+RiPnQfv3KY4rkWA7zye8B+lwEHuvYAlcyQtPwkKj3bMB53Vvwklz
 YR16cxxKiYMnHCe7sa6kUOHjEDCRUObeQ/ghgCP04FKYiKASVSaBlLa2ys773Yxu1uXI
 IBLoRZl1/l1RSuWlhAfOnHYOKFGnER7JH8hIVhDS3qvQN6qpXbmA4ZAnbSS71nSF421a
 lXSPb7+pfDHH5neq0iO/59NyME2oehlMno8Hq4rXRfd20fLQYhqgmZFwWL5ZHk8odl3t
 4ShRbyLkVeGy1u+OOdi6Bt4abY1YL08d3N7C7tLdtClf5eq+F7B7gDWddm+Hz5gtA/ze
 8yvQ==
X-Gm-Message-State: AOAM533AlPb2Hb5jeLEE3CCF3hs6T4Px2ooSHzSiYmS8tbpZA7H15hAu
 C+RuPu8WZI+IHKuOR2iX9Pk=
X-Google-Smtp-Source: ABdhPJwojwQ+/SNqlO5GwYlo7iVzjz+sJWyNW2Kve2mQiJljtTkysgxW+67T/K5kaNP+duIDrpC4wQ==
X-Received: by 2002:a7b:c40a:: with SMTP id k10mr17777756wmi.127.1597744729612; 
 Tue, 18 Aug 2020 02:58:49 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id j2sm33624856wrp.46.2020.08.18.02.58.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Aug 2020 02:58:48 -0700 (PDT)
Subject: Re: [RFC PATCH 1/9] memory: Initialize MemoryRegionOps for RAM memory
 regions
To: P J P <ppandit@redhat.com>
References: <20200817161853.593247-1-f4bug@amsat.org>
 <20200817161853.593247-2-f4bug@amsat.org>
 <nycvar.YSQ.7.78.906.2008181445190.306228@xnncv>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <ae655ddd-e435-da9a-59df-41e1ad3ff1ce@amsat.org>
Date: Tue, 18 Aug 2020 11:58:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <nycvar.YSQ.7.78.906.2008181445190.306228@xnncv>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Stephen Checkoway <stephen.checkoway@oberlin.edu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/18/20 11:52 AM, P J P wrote:
> +-- On Mon, 17 Aug 2020, Philippe Mathieu-Daudé wrote --+
> | Fix by initializing the MemoryRegionOps to ram_device_mem_ops, this way the 
> | memory accesses are properly dispatched using 
> | memory_region_ram_device_read() / memory_region_ram_device_write().
> | 
> | Fixes: 4a2e242bbb ("memory: Don't use memcpy for ram_device regions")
> | Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> | ---
> | Since v1: Corrected description (PJP)
> | Cc: P J P <ppandit@redhat.com>
> | ---
> |  softmmu/memory.c | 10 ++++++++++
> |  1 file changed, 10 insertions(+)
> | 
> | diff --git a/softmmu/memory.c b/softmmu/memory.c
> | index 651705b7d1..8139da1a58 100644
> | --- a/softmmu/memory.c
> | +++ b/softmmu/memory.c
> | @@ -1517,6 +1517,8 @@ void memory_region_init_ram_shared_nomigrate(MemoryRegion *mr,
> |      Error *err = NULL;
> |      memory_region_init(mr, owner, name, size);
> |      mr->ram = true;
> | +    mr->ops = &ram_device_mem_ops;
> | +    mr->opaque = mr;
> |      mr->terminates = true;
> 
> 
> I wonder if 'mr->ops = &ram_device_mem_ops' could be done in 
> memory_region_init() instead?

I don't think so, because to use &ram_device_mem_ops handlers use
mr->opaque and mr->ram_block, so alias/io/iommu/rom types would
directly crash accessing these NULL fields.

> 
> Otherwise looks okay.

Thanks!

> 
> Thank you.
> --
> Prasad J Pandit / Red Hat Product Security Team
> 8685 545E B54C 486B C6EB 271E E285 8B5A F050 DE8D
> 

