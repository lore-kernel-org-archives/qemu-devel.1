Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB1CAC2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 12:58:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D22C206BB
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 12:58:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e5NoNI9z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D22C206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50818 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZERb-00042f-OE
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 08:58:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55670)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hZER0-0003Tn-3l
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 08:57:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hZEIB-0005gR-Cp
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 08:48:24 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329]:46071)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hZEI7-0005Ol-T9
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 08:48:21 -0400
Received: by mail-ot1-x329.google.com with SMTP id n2so1679122otl.12
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 05:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=xZtP/0b5zjZ3Q3mejZfcvZKvbFgc2zdFrCHy7rHFnII=;
 b=e5NoNI9zWCAP8mLH3yDstHogorBWjIkd6HdlLJg3JqiikexpuczV9gWC5FbRJO8Hqd
 kLeuS85phmApixTByK3M+GJtsffyGVigce15TBd/EcbFRrTvvAbirFGbaNxRFP6bCsYp
 kElNFAuFCdmBQgpmMO/aeOkA8ria66kRemwDcXj9ff3XDMcBWx8n+AVp0cD4oStrORcl
 Xd5uPRJybciZC0bTzK6KGPX7Wzs1MRYIgYc6zdrXRnB3O6xc0AYSP6AcgzEtUAcq2eLC
 tJQDSdMTtfbgya+Jdp7oO/Sx4zPLkpoPxK1PBgTXdb3R7i15tB6AuqcriLwNm6jTTWCF
 VCjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xZtP/0b5zjZ3Q3mejZfcvZKvbFgc2zdFrCHy7rHFnII=;
 b=C/jLfIstvPUdvt4tSgQed/x8v0S3bDDd0/MooWaqyNqb4EeXJ4sLZHfRav0D5ddGRG
 Xzb/AXbt+OLmefIE6yG1ZdRYGeT67o9FOhhiBpl+h4u1ndhbYinL5iZoiglAAW2Nzxnx
 0nlwLbpEv1XKCsLur/kPxyUYdZ2xAvsQeDztjz3dsE/T2knXdOEyMWzMFrEYcq2TjNVw
 Y+/R/flOpJ5RVnN6KTky0kXO3lk1Gg4g5ccwnrYf8N5EpW6EwgSmiZQ9r57jMOvjMrXv
 8WX1rg5kQgkwVviZvrcpoXxgNlgiu+Cyksz7/CGNDAtzllUJbR9Bnt/xy9RFlKx2nRLg
 SX7A==
X-Gm-Message-State: APjAAAXM6omoBOV1cVIEZJQGYnXANXD6mi9IEEm+ThY/ox8VhGG9q2wr
 TaT6bDAmRq9PmCmFQxbF8d+65w==
X-Google-Smtp-Source: APXvYqzWItFYuvw7vCKnhaszNAXXevMeTJI93iDWXa/iU/aewojW+ocim8p9uGI8zBWUzmk+0s36Pw==
X-Received: by 2002:a9d:5907:: with SMTP id t7mr3698832oth.163.1559911696071; 
 Fri, 07 Jun 2019 05:48:16 -0700 (PDT)
Received: from [192.168.3.43] (200-56-192-86-cable.cybercable.net.mx.
 [200.56.192.86])
 by smtp.gmail.com with ESMTPSA id d21sm709488oih.21.2019.06.07.05.48.14
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 07 Jun 2019 05:48:15 -0700 (PDT)
To: "Brenken, David (EFS-GH2)" <david.brenken@efs-auto.de>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 David Brenken <david.brenken@efs-auto.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20190605061126.10244-1-david.brenken@efs-auto.org>
 <20190605061126.10244-4-david.brenken@efs-auto.org>
 <ffb4ba2c-318e-6b08-c206-a90b000074d2@mail.uni-paderborn.de>
 <34F764F04E859040BBA6C4FF41AB17D93B2DA4@AUDIINSX0410.audi.vwg>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <8e4f29db-fb2d-4053-2483-a2d92466ce35@linaro.org>
Date: Fri, 7 Jun 2019 07:48:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <34F764F04E859040BBA6C4FF41AB17D93B2DA4@AUDIINSX0410.audi.vwg>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::329
Subject: Re: [Qemu-devel] [PATCH 3/5] tricore: fix RRPW_INSERT instruction
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
Cc: "Biermanski, Lars \(EFS-GH3\)" <lars.biermanski@efs-auto.de>, "Rasche,
 Robert \(EFS-GH2\)" <robert.rasche@efs-auto.de>, "Hofstetter,
 Georg \(EFS-GH2\)" <Georg.Hofstetter@efs-auto.de>, "Konopik,
 Andreas \(EFS-GH2\)" <andreas.konopik@efs-auto.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/6/19 2:26 AM, Brenken, David (EFS-GH2) wrote:
>>>       case OPC2_32_RRPW_INSERT:
>>> -        if (pos + width <= 31) {
>>> -            tcg_gen_deposit_tl(cpu_gpr_d[r3], cpu_gpr_d[r1], cpu_gpr_d[r2],
>>> -                               width, pos);
>> Can you explain the problem causing the bug? Deposit looks fine to me.
>> After reading the specs again, I agree that the check needs to be <= 32.
> The bug was recognized because of different behavior between actual hardware and QEMU.
> Just from looking at it I would say that deposit masks and then shifts the arg2 (D[b]) while the 
> manual states to first shift D[b] and then mask it. I remember that it was a corner case (e.g. 
> width + pos = 31 or 32). 

The final two arguments to tcg_gen_deposit_tl are swapped.
It should be pos, width.


r~

