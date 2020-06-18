Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F999C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 12:27:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF33A207E8
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 12:27:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AcO4bXkb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF33A207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jltdr-00018f-5G
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 08:27:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49982)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jltd5-00087c-Ag; Thu, 18 Jun 2020 08:26:51 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:45839)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jltd3-0003VB-NW; Thu, 18 Jun 2020 08:26:51 -0400
Received: by mail-wr1-x442.google.com with SMTP id c3so5813175wru.12;
 Thu, 18 Jun 2020 05:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=SmRqn1NMAwNgsF9PUkPB+mNDI4pExxMYe+VGcTHvnno=;
 b=AcO4bXkbXLsCQ7oFbIllH5PpP5i6tqrBapRC2fABiT1vujcsApXzOXCLbv7652w7pq
 Xq10ZOh23LLAkptvG9xDM1PIJ0BfFV7vK8gnLhHb3N+TsCTniUy6s+pYU7/rF5lTu2Aq
 YrQdlhTJQYFXjMcJ3DbK1jG0iBYzYhgbCFJNoOCq5ICtLvylgqXDKnyltixJFyTBgSlC
 Woda6LNJvki9vBOBKUiKMwNfClprZTBOqdUzp+WnDts1BWRN8cAmxbJvTYsiH2JRG1QM
 qsDXZjExQI2oskAkPU+wL8O6oTFR0QwJHPNqH2P3dHYvk1A+7hFBTa74ZYr5wugv1ULh
 70Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SmRqn1NMAwNgsF9PUkPB+mNDI4pExxMYe+VGcTHvnno=;
 b=GzfpZdmH4Rc/yNftAZonWpIBiD3hPFkEzwbVoq6A1NDQFEcnX+fKpQaimW6Imta/pf
 7W79QmsP/+jMEXseQuAEjbkbjcKHLIIvv52HzjQQ6aW9A0shPePwFZ10iQedpDUNIRZ3
 3l8ZygyL6tL4Tdb9w5Py6OAjedR+8qanxEsYaJBMGmpbMfNox7LYpm3x9cKdp3LIgBJn
 eYSOJnUv+w12J3IjZEbZ2n+F7Zyj05HQCpMPo/LkqOtmrdwFrj8FntbTxsdXl7i73wsM
 YI3bvByEZiwIEiyHJJ+rPTWBtUvCryVp+ZriuRrPGyMyZVv3rFuv/7viCD0lQgeaYlE/
 xcGQ==
X-Gm-Message-State: AOAM533w0jr/Ou27tq75aUIIT6wb2+y99YqiOe4rR6a9CmdiyMA4WWPS
 a1FczA3fdVcDzKAbIw4R1Ho=
X-Google-Smtp-Source: ABdhPJzo/BcSvIq5JpNa8MIAI84xo8vh28wQzVGq6P1LpSJ/z88Q9rVk8714yyu2jBL/X3LtPNXkLQ==
X-Received: by 2002:a5d:46d0:: with SMTP id g16mr4723857wrs.229.1592483207320; 
 Thu, 18 Jun 2020 05:26:47 -0700 (PDT)
Received: from [192.168.1.38] (93.red-83-59-160.dynamicip.rima-tde.net.
 [83.59.160.93])
 by smtp.gmail.com with ESMTPSA id s72sm3545069wme.35.2020.06.18.05.26.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jun 2020 05:26:46 -0700 (PDT)
Subject: Re: [PATCH 0/7] misc: Reduce QEMUTimer pressure by using lower
 precision when possible
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20200616075121.12837-1-f4bug@amsat.org>
 <b6170c76-27d3-c3b2-e32f-427fea769350@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <df330613-a75a-5d3c-5290-c080f5c32785@amsat.org>
Date: Thu, 18 Jun 2020 14:26:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <b6170c76-27d3-c3b2-e32f-427fea769350@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, Corey Minyard <minyard@acm.org>,
 David Hildenbrand <david@redhat.com>, Andrew Jeffery <andrew@aj.id.au>,
 "Michael S. Tsirkin" <mst@redhat.com>, Max Reitz <mreitz@redhat.com>,
 qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/18/20 2:23 PM, Paolo Bonzini wrote:
> On 16/06/20 09:51, Philippe Mathieu-Daudé wrote:
>> This series contains few patches resulting from the notes I
>> took while reviewing Mark ADB series last Sunday, in particular:
>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg712078.html
>>
>> I have another patch for hw/input/hid.c but I prefer to hold it
>> to test it more.
> 
> This is in principle a very good idea; however, util/qemu-timer.c does
> not use the scale to coalesce low-precision timers with nearby
> high-precision ones.

IOW this doesn't reduce the pressure, but simply makes the code easier?
Only the cover mentions 'pressure', so maybe the patches can still be
reviewed/queued in their current state?

