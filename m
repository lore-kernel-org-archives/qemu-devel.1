Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B0FC4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 11:28:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB7C623BEF
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 11:28:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bLibyYr7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB7C623BEF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNDnj-0001vV-RI
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 07:28:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33902)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kNDlX-0001HQ-Dl
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 07:25:51 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:46707)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kNDlV-0005xy-Pd
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 07:25:51 -0400
Received: by mail-wr1-x442.google.com with SMTP id o5so4915088wrn.13
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 04:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=frXxtQYi69IphiqfNjWkyvKFYG23fByMX4ORFN5LZXo=;
 b=bLibyYr7lEP8Mrwlc/vg0B+AlSaMivvKnfCP8FCqd7poKJt6ER9Y8cuwfWHBj/0r8e
 J6MSCS9pq6UId8DymexX+TbVqZxZWOOKbfiwFfhm66TjVutuQ7tc+Y44lRbdukZOWcEf
 ezeVWXFIrPKoTEebcdT9gCAcdwqEkbUuiqjysnNZQumahQwEhQ7UA71PUvBw5rTROD+T
 vcppCsiwOjXswTZyT5PTdssBVCDXRwEeJVG/oFA/cHa7MPcDSxEk4t05847Cw4mzZ22N
 7PSVV5hZ6ADPQzRj3eYp9OFizua4fhV1uUANDF47edtxSs/mtEQqpbwXXGZnz10QaznX
 Bq4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=frXxtQYi69IphiqfNjWkyvKFYG23fByMX4ORFN5LZXo=;
 b=OIfsXtfHiIPYbW2MDjVXa6nUCDNwgyu4g60D22BDgW0amTQy9Fh4pb8XeGhsLg+ebR
 yMYLPqFojvB9OX6KoxYnmb7logDHRjXbGhQ5tAn8No90bTe78IZfUeDYOBZo/DRYecxr
 paqCw5C9Ve2UMM/mUZXWECVCx6gz5ELRLA7/pZhEvIB8veNCKLRO6Rz9yPjlRG0HDNEh
 gyySRzsJ9koYZJ+MFqjFzNW5+j5ahLah1hB/fXe+H0wWBtQPUJb0EJ53uTckmD3HtF4H
 xWr7W+tEZLIwOnmLhp0bW87iYxRlcKGBoT648Ovwq8Six1pys6CsWPT8uHxr/+37S0sG
 hlfw==
X-Gm-Message-State: AOAM5328V6GczqB4wrtOLvjfk1YWimKw3VHEBJDG/KLCrFaKrCKBPxc0
 3PH+jxO/7nKpMCG4DOIqJvo=
X-Google-Smtp-Source: ABdhPJxzuLhLNu0Yn2Da0jL9qKgQYwnDfBKGYjFylhZFs8Yv4D6QChIRKvUzljdzLTmk+Q79ZZ2ImQ==
X-Received: by 2002:adf:ffc7:: with SMTP id x7mr3707974wrs.405.1601378747944; 
 Tue, 29 Sep 2020 04:25:47 -0700 (PDT)
Received: from [192.168.1.36] (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id t5sm5838484wrb.21.2020.09.29.04.25.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2020 04:25:47 -0700 (PDT)
Subject: Re: [RFC PATCH v4 15/29] Hexagon (target/hexagon) utility functions
To: Taylor Simpson <tsimpson@quicinc.com>, qemu-devel@nongnu.org
References: <1601314138-9930-1-git-send-email-tsimpson@quicinc.com>
 <1601314138-9930-16-git-send-email-tsimpson@quicinc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <7f590a42-4ab2-4945-bd9e-648ad370e711@amsat.org>
Date: Tue, 29 Sep 2020 13:25:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <1601314138-9930-16-git-send-email-tsimpson@quicinc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.199, NICE_REPLY_A=-0.001,
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
Cc: ale@rev.ng, riku.voipio@iki.fi, richard.henderson@linaro.org,
 laurent@vivier.eu, aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/28/20 7:28 PM, Taylor Simpson wrote:
> Utility functions called by various instructions
> 
> Signed-off-by: Taylor Simpson <tsimpson@quicinc.com>
> ---
>  target/hexagon/arch.h     |  42 +++
>  target/hexagon/conv_emu.h |  50 +++
>  target/hexagon/fma_emu.h  |  27 ++
>  target/hexagon/arch.c     | 354 +++++++++++++++++++++
>  target/hexagon/conv_emu.c | 369 ++++++++++++++++++++++
>  target/hexagon/fma_emu.c  | 777 ++++++++++++++++++++++++++++++++++++++++++++++
>  6 files changed, 1619 insertions(+)
>  create mode 100644 target/hexagon/arch.h
>  create mode 100644 target/hexagon/conv_emu.h
>  create mode 100644 target/hexagon/fma_emu.h
>  create mode 100644 target/hexagon/arch.c
>  create mode 100644 target/hexagon/conv_emu.c
>  create mode 100644 target/hexagon/fma_emu.c

Sorry but I lost focus in the middle of conv_emu.c,
after reviewing arch.c.

Suggestion to ease review, split in 3 digestible patches:

1:
target/hexagon/arch.h
target/hexagon/arch.c

2:
target/hexagon/conv_emu.h
target/hexagon/conv_emu.c

3:
target/hexagon/fma_emu.h
target/hexagon/fma_emu.c

Thanks,

Phil.

