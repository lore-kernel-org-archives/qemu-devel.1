Return-Path: <SRS0=KIBN=2T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E8EC2D0C8
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Dec 2019 00:06:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D692218AC
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Dec 2019 00:06:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QlG4WPG9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D692218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ilM65-00013W-LP
	for qemu-devel@archiver.kernel.org; Sat, 28 Dec 2019 19:06:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57873)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ilM5L-0000cL-Ae
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 19:05:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ilM5J-0004St-Pl
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 19:05:31 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:44514)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ilM5I-0004Kc-GY
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 19:05:29 -0500
Received: by mail-pl1-x644.google.com with SMTP id az3so13221276plb.11
 for <qemu-devel@nongnu.org>; Sat, 28 Dec 2019 16:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=UXflO8CbGSRBIv8EQ1dhf4+rQ8m1ELG6SDypL3HKewE=;
 b=QlG4WPG9atfNoxuoSRV1X0jBqIPPZLLy8BZia833iKQigMBTZW4v/p461BV3DAHauJ
 BbMcAtjS6uHoaRc2S4YBKhXq1tfo1g+Nv4TSMCJuRCW6KBJrKs9XTjU5GTZaiGR0D34K
 QjDWc9b7glDJeeUSfilorJ0hDknKdn033uHmBQqkNWvc8haEwSGBoG3APKa8RiBnGtvk
 2vpYGyWOgxxu128/Fn5dHYTNGw6eF5soH03Sdjfg9ganT/VCCTXo4e4cbdvA0cYxVZ+B
 2dVgbPk/SoKDoWOJswuLMGNpI4gP6qNpMku88gqY9JSBNPiZhx19Ad0wxMOebzbSbFGf
 wxRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=UXflO8CbGSRBIv8EQ1dhf4+rQ8m1ELG6SDypL3HKewE=;
 b=JSV0chGn+j8tthT1hDOxi3lTVWxKMdlJ4Shb6nLeu83ZI+okZO2ApUxRe1mkLuEZkH
 SOUflD+VqkR8GD7/QrPCVDAZgy4vHm0tUZJo42L/PIuh2Xyhk2Gv2leGI+NfxEAM1NaN
 577TKMJS/tIKvFLVscKTzKAh7GUyEpRLJzre8Ui/CxLyVAeswq9ygjV+2CT1ScO9rKJj
 ihcwXQ2HIE7idw7Yxo8BHuakSnwgNPYf0QKf1Cj0gXF9Vjc0tatypMnb7CEr16aBCMAH
 TonA7htrUSUXUa027/EC4aTTJFq9mqxBp11fPJLDyP0oQWD09LCJSVOGsDA6umBFaiEo
 g0jA==
X-Gm-Message-State: APjAAAWt/9B+dqpmCYTq9TpatREmJLZ5EeWHNRAUjnq4cevSYDN8hOa0
 9H8S34yZkbHvZJOobcy9fi3nXg==
X-Google-Smtp-Source: APXvYqxrsoiWzcW+sV+CNtAffGmGB6it1Pp329YASDoqc+h4w8eJRQP5XXLHcDaNQEyZGkknBeKUWQ==
X-Received: by 2002:a17:90a:ead3:: with SMTP id
 ev19mr35671396pjb.80.1577577927540; 
 Sat, 28 Dec 2019 16:05:27 -0800 (PST)
Received: from [192.168.1.118] (194-223-58-9.tpgi.com.au. [194.223.58.9])
 by smtp.gmail.com with ESMTPSA id j10sm19596668pjb.14.2019.12.28.16.05.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 28 Dec 2019 16:05:26 -0800 (PST)
Subject: Re: [PATCH v6 11/11] hw/s390x/ipl: replace deprecated qdev_reset_all
 registration
To: Damien Hedde <damien.hedde@greensocs.com>, qemu-devel@nongnu.org
References: <20191220115035.709876-1-damien.hedde@greensocs.com>
 <20191220115035.709876-12-damien.hedde@greensocs.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <91c432cc-5029-0bb9-09a7-c244e78ab390@linaro.org>
Date: Sun, 29 Dec 2019 11:05:18 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191220115035.709876-12-damien.hedde@greensocs.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
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
Cc: peter.maydell@linaro.org, Thomas Huth <thuth@redhat.com>,
 berrange@redhat.com, ehabkost@redhat.com, cohuck@redhat.com,
 mark.burton@greensocs.com, edgari@xilinx.com,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 pbonzini@redhat.com, philmd@redhat.com, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/20/19 10:50 PM, Damien Hedde wrote:
> Replace deprecated qdev_reset_all by resettable_cold_reset_fn for
> the ipl registration in the main reset handlers.
> 
> This does not impact the behavior for the following reasons:
> + at this point resettable just call the old reset methods of devices
>   and buses in the same order than qdev/qbus.
> + resettable handlers registered with qemu_register_reset are
>   serialized; there is no interleaving.
> + eventual explicit calls to legacy reset API (device_reset or
>   qdev/qbus_reset) inside this reset handler will not be masked out
>   by resettable mechanism; they do not go through resettable api.
> 
> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> ---
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: qemu-s390x@nongnu.org
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: Thomas Huth <thuth@redhat.com>
> ---
>  hw/s390x/ipl.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

