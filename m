Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6D00C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 12:33:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B33C620672
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 12:33:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QM2q96Oq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B33C620672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqFST-000836-TZ
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 08:33:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43002)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqFQq-0006LF-26; Tue, 30 Jun 2020 08:32:15 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c]:42704)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqFQo-0003vp-Gl; Tue, 30 Jun 2020 08:32:11 -0400
Received: by mail-ej1-x62c.google.com with SMTP id i14so20342462ejr.9;
 Tue, 30 Jun 2020 05:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:to:cc:from:subject:message-id:date:user-agent:mime-version
 :content-language:content-transfer-encoding;
 bh=VrkfnazT2yj9IgpFzubDWyH6oSQm7gfNPjHJe2Wng0U=;
 b=QM2q96OqosO7MvFw3Y+wP8QdtAFpkaWTVp+mzG2o9FlTZMZI2rH5M6TnX7mx14Jb26
 FLDpnHfXi4dpFhhK9v83WRUOspM1tXz3OVfVeyicjl9FfETF+euFsdYiAK4WtdcyN92f
 kvgzbEg9z4+epVSSGrq0keO3r4DXPLenbLkHZpTUjoiEn43Ke1hVyZBLhFxzzODiUpFk
 kvL2E5v7h0Nj7iEKZ7ZzznYni90z6j6d9RW0C0HsenHetIeyHTnxZ9+IV3syApjztR0d
 18mLKxvBVYHhUKuo3Zvw2WIEhDuXubtJBMSAcckyX/CcpFfvi7yAraw+t/1+09/5rAi6
 z7sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:to:cc:from:subject:message-id:date
 :user-agent:mime-version:content-language:content-transfer-encoding;
 bh=VrkfnazT2yj9IgpFzubDWyH6oSQm7gfNPjHJe2Wng0U=;
 b=pyf9S03iTwN7VHeGrUvLYNM6nYUGedXjpoZa4mnOFQghyErL5E1hpzdpanHjCslcYS
 rG6uK9zfo4nENhzb9dZhgfv0wtjsWGjOZ0qtnUTwjSqUh2zH4bcKmgLlShRNWtj82lzF
 2Wq+EzeCmdQT6K5c6Kd2KNzZRpeW9N8wuEA5vo0fxc7Sy4Z+InW4tC31j1z+j8JYo+Aa
 2HtJ20r8PQZe0t723UNiZBRHaWtjNhNMQ5Nzqkq+HxY9dqTzm7k3S8DOdtxs/1+vO56r
 hcVPTPge0xa/D/PdFRe3DG7AVo9K/4cGzKCtik7Pd1gwxyPHnwzumduk4d6hT1Xx1ddW
 /GVA==
X-Gm-Message-State: AOAM530DsDkTWwnQ6LR0BTf7kDMVyqUvuY92x6NbpYtw+fTZHrw0OOZ7
 T5AA4kjR+xofkioYWrBnWyso4v7VagI=
X-Google-Smtp-Source: ABdhPJzVgiIqDmiC3ZxAT9YMBWmcZ8xEwX3LcStUO+649ngh44TUr3jvkzuiIuMzO9EJ22qTIj0RlA==
X-Received: by 2002:a17:906:1455:: with SMTP id
 q21mr1697312ejc.139.1593520328064; 
 Tue, 30 Jun 2020 05:32:08 -0700 (PDT)
Received: from [192.168.1.40] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id c9sm2689938edv.8.2020.06.30.05.32.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jun 2020 05:32:07 -0700 (PDT)
To: Eddie James <eajames@linux.ibm.com>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?=
 <clg@kaod.org>, Joel Stanley <joel@jms.id.au>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Subject: hw/arm/aspeed: Why aspeed_machine_init uses empty SD cards?
Message-ID: <3985e947-d798-b12c-1b55-71b3e4ed9189@amsat.org>
Date: Tue, 30 Jun 2020 14:32:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x62c.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Cédric, Eddie,

I'm trying to understand commits 2bea128c3d0 and a29e3e12707,
the Aspeed machines always add SD cards on the SD bus, even
if there are no block drive to attach to. Is that what you
want?

Expected behavior from the board is to create the SoC, the
SoC creates the SDHCI which creates the SD bus. No need to
add phantom SD cards to the machine if they don't exist.

Thoughts?

