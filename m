Return-Path: <SRS0=BZbV=DR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65433C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 15:45:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0D61223AB
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 15:45:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WczRigT+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0D61223AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRH45-0004r3-RE
	for qemu-devel@archiver.kernel.org; Sat, 10 Oct 2020 11:45:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38972)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRH2z-0004D7-LS; Sat, 10 Oct 2020 11:44:37 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:43407)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRH2x-00016h-Vj; Sat, 10 Oct 2020 11:44:37 -0400
Received: by mail-wr1-x442.google.com with SMTP id g12so13446985wrp.10;
 Sat, 10 Oct 2020 08:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=4qMPhKMN+GYtgVaR7MAjuQFtHqQQ8jVSHZcM4SmpAF4=;
 b=WczRigT+uCn8EZ4EgR/+ESR6Yjy5TKK1aITte6jcvAENlqw8P3ezTPh9d+SWxSWwom
 VlQKpz1ijsgbh+DyjtgHrUWw+UtzxiAgWIWE6zhytY90bd3wnBKa0UEIEtnSn+HG8oqk
 dXlHrYQ9i8pOlPWOD4zty/8XAlZoXQdekTbzTWYC/fApL32VtnHO7LDgaoi2bZTN5xr0
 fSmp6zMBqff/M6BbnvKVqftIkOzdCO+3hdL/Ri5BUl0aXI/Gmo+fmAt11+myvrdkI2z7
 QuQRxFGLu+duJ7KCknuJjsi76vdKFbXlZFQYq9zI7zA4xMvcH6LOByrdhSB2BbgIQ4gP
 dHYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:from:to:cc:references:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4qMPhKMN+GYtgVaR7MAjuQFtHqQQ8jVSHZcM4SmpAF4=;
 b=Tk8mZp8HIFSind+QSxzAtce6T32pcJDtEGQH6JUNfZtxdtpDvPSLBLWjnHDubgGnsL
 BEes9lF21ah5MIGnc2wqthq8I8HRiSZ7hzAcPZ/5sHAQoecOJtPBcTbrIMz9Qe6W23jv
 anynCqz6HFpOwoTGcbg5WlJI/iWzHGwMr/0cKiSfUcP6tat8LMe5UqQnqJMoGoqt76x/
 VUySShuxs0NWcg3cwKf1iXjHih5aOLVyErkS83ZYtmWI/nG/+FLjXNk/HSv+bCtLz5CF
 khCjYKCSjcbrBIoeBsSCb5u7+mVbO0cktr7biPqimRsCzdyWYScShEVC8hsfG3T/5DCZ
 xV3Q==
X-Gm-Message-State: AOAM532Kz+Zn91+ec3yQZLe9bGkOht6VAgAhANBRYwmHdOE0sa/yCoiF
 TS3GYLV2gd7kgcs7TOh42N8YXuy6jLg=
X-Google-Smtp-Source: ABdhPJzgkiGxEhpsvCoAQBAXOLHTHkGJFiknityTv0yB9oB8XFtQNirOhnZLAXWgzwVLOC30OQbk/w==
X-Received: by 2002:a5d:4d10:: with SMTP id z16mr653732wrt.360.1602344673810; 
 Sat, 10 Oct 2020 08:44:33 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id u17sm18084328wri.45.2020.10.10.08.44.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 10 Oct 2020 08:44:33 -0700 (PDT)
Subject: Re: [PATCH v3 03/15] hw/core/clock: add the clock_new helper function
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Luc Michel <luc@lmichel.fr>, qemu-devel@nongnu.org
References: <20201010135759.437903-1-luc@lmichel.fr>
 <20201010135759.437903-4-luc@lmichel.fr>
 <f49f1c17-9343-c5dc-51fd-da0edb208314@amsat.org>
Message-ID: <1b60a39a-00a2-9f2a-e022-df1d468a90e6@amsat.org>
Date: Sat, 10 Oct 2020 17:44:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <f49f1c17-9343-c5dc-51fd-da0edb208314@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.207,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Havard Skinnemoen <hskinnemoen@google.com>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Paul Zimmerman <pauldzim@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/10/20 5:17 PM, Philippe Mathieu-Daudé wrote:
> On 10/10/20 3:57 PM, Luc Michel wrote:
>> This function creates a clock and parents it to another object with a 
>> given
>> name. It calls clock_setup_canonical_path before returning the new
>> clock.
>>
>> This function is useful to create clocks in devices when one doesn't
>> want to expose it at the qdev level (as an input or an output).
>>
>> Suggested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> Signed-off-by: Luc Michel <luc@lmichel.fr>
>> ---
>>   include/hw/clock.h | 13 +++++++++++++
>>   hw/core/clock.c    | 15 +++++++++++++++
>>   2 files changed, 28 insertions(+)
> 
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>


