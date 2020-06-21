Return-Path: <SRS0=M+f9=AC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC7F2C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2020 22:26:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEE1F221E7
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2020 22:26:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q065E2xV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEE1F221E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jn8Pa-0001Df-ND
	for qemu-devel@archiver.kernel.org; Sun, 21 Jun 2020 18:26:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49474)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jn8Oh-0000MY-Ak; Sun, 21 Jun 2020 18:25:07 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:44571)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jn8Of-00085Z-O6; Sun, 21 Jun 2020 18:25:07 -0400
Received: by mail-wr1-x441.google.com with SMTP id b6so14761281wrs.11;
 Sun, 21 Jun 2020 15:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=0tBjJ+VwwllJR2SSVVAksBM2TNI9ez+XAXtdiVGE5FM=;
 b=q065E2xVRvbk4eCs0sxhz7PN+Z6nHyHoEHvazBzxQWvfiyDcfoQppu1QNbDXuDFTbw
 HVOBY0Zq9qAANzGjwjaXok8QvOIZH+5JWlUepLtXexI+lXEr3VaqKhIdQ2n2YTK+U5Se
 Q3JXo+uzC94glsz3/8mmcPumUs2TVtnRKRhRci26sDSAZnqfGGk5NJ9v3pYQZWTHXrFP
 jVLl0akC540wUWlDIrdfd5+WD2wujROfAlV3uIWrGLwX3eCYO0/496QGTKVaB+U/5FM4
 1lWv/YnMoXPsTJwSRj+ncTlcr4becqOv9lKQdmLJCCR9pIy6VZ/H9Po49VdtQxWpIme1
 S12Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0tBjJ+VwwllJR2SSVVAksBM2TNI9ez+XAXtdiVGE5FM=;
 b=r90b+1kUIQPVWbmkk+OeIafeMX0zttV9CrTb4nrZYJWZr5J5fpAefUDSGu6PH6SY7r
 C18n7uQZ0NqOA6lw0gz/fSqVPE8pkdhOkyIbUu4TEQusQpKIkLfCuUipfKQarHE08Jg7
 72jn+yMg1B7aw2eeDjohHj9X/GxIxnbkd0nzJtmP2xnYftin6xvwZI4zWg6MHHwLooFt
 YkcE4Np7x4DfFi6CWmw1pslyIiMnHiICqvY5KeiA7by5mdcygi7z0SsQmvDjefAI+HVu
 vDGo/4U8R+9Ni1K7+iZq9Frk1jH14IzC+8db79FNrQp40xTiIx0t6fzZ5lBriaRYKfZ3
 QW3A==
X-Gm-Message-State: AOAM533wdSNJmPje4UvW3/t1U1F1uQBlvNUKDTqRt/1+sm0MYUZZTwvF
 9KXP0sPFazG4CKr39ftaAko=
X-Google-Smtp-Source: ABdhPJxp28+slNz3N2F7a5i4u89l4ih51MSlFCau8jjyu8XqJkG0I1hWs+Mcu2G2jlkqIm9CUIbwRw==
X-Received: by 2002:a5d:4e45:: with SMTP id r5mr16367045wrt.92.1592778303866; 
 Sun, 21 Jun 2020 15:25:03 -0700 (PDT)
Received: from [192.168.1.37] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id j24sm12271043wrd.43.2020.06.21.15.25.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 21 Jun 2020 15:25:02 -0700 (PDT)
Subject: Re: [PATCH v3 3/7] hw/misc/led: Emit a trace event when LED intensity
 has changed
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200620230719.32139-1-f4bug@amsat.org>
 <20200620230719.32139-4-f4bug@amsat.org>
 <ae4a7411-7042-3530-3faf-e25368080820@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c9e3897b-c711-f59b-d400-0bd01fd320b5@amsat.org>
Date: Mon, 22 Jun 2020 00:25:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <ae4a7411-7042-3530-3faf-e25368080820@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/21/20 9:23 PM, Richard Henderson wrote:
> On 6/20/20 4:07 PM, Philippe Mathieu-Daudé wrote:
>> Track the LED intensity, and emit a trace event when it changes.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  include/hw/misc/led.h | 1 +
>>  hw/misc/led.c         | 5 +++++
>>  hw/misc/trace-events  | 1 +
>>  3 files changed, 7 insertions(+)
>>
>> diff --git a/include/hw/misc/led.h b/include/hw/misc/led.h
>> index 883006bb8f..df5b32a2db 100644
>> --- a/include/hw/misc/led.h
>> +++ b/include/hw/misc/led.h
>> @@ -35,6 +35,7 @@ typedef struct LEDState {
>>      DeviceState parent_obj;
>>      /* Public */
>>  
>> +    uint16_t current_intensity;
>>      qemu_irq irq;
> 
> Why not sort this new field next to the other uint16_t and (partially) fill the
> hole?

From a reviewer point of view, I prefer to keep the state fields
separated from the properties fields, wasting few bits of RAM.

Anyway I switched to a percent value. What is better to hold
it, an 'unsigned' or 'uint8_t' type?

> 
> Otherwise,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Thanks!

> 
> 
> r~
> 

