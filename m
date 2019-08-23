Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC5CCC3A5A1
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 02:31:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 858D7205C9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 02:31:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u56x4olV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 858D7205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0zME-0000B9-IG
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 22:31:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57284)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i0zKq-00085q-EE
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 22:29:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i0zKp-0008Nq-AS
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 22:29:52 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:37207)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i0zKp-0008NI-3Z
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 22:29:51 -0400
Received: by mail-pl1-x644.google.com with SMTP id bj8so4631598plb.4
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2019 19:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=EhhBcECUfd2xLUUNG2/F1RXv3dM6h5nS6+MMkObInrw=;
 b=u56x4olVaFH/BpLBLmc9o6RKj4jZGUdemkvXZlVoeeYO1C6T6S8LKqkbKKTHbJ5kN6
 1oPMJhn5feUZ4ipQpeRVjMqpiorG+KxEd6RGVagLuAq9KyOyPcSgoI9p5OrsadLKIM2c
 SLArRGTBJ6rnpMW23MorCkBO1i4aOeLyp82s9nBZrkCJ/ah0XqAodwaheYm9RZfz5NAl
 aqL1bU3wsxiXW8awgnONpq2phrQS46Z41WJYg5jYU9oO1yO9jLiPC78ah8tLcw9PLug3
 I33W66Hl5Irxa4AP+FvhfDrOOJACqvhPWwYRQ0AOKqZk4BYlZ/oRF7RlvUfi992Tvtql
 QSpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=EhhBcECUfd2xLUUNG2/F1RXv3dM6h5nS6+MMkObInrw=;
 b=VzUlT4iXwfQHoULA2zXv+k13dWs9E5T/EGb9vYW7oE8cJTtx+zJ9qvX30dZ0fN1bUN
 Bn415mhPz9iFGoq0SfAGYA6DAdK7S4RzC7tcHDAIDIYqwgVrcYvwgUYoQuoBwh2Rs5Ni
 34LPocDqxF3fv91IHffHYAEiVWNVMqtw3JaMncdLxl30tA42+8T4K65pXuLUuf/ecp8w
 5ldz9KQLjy5sCRvSzPncCuy9BCGhbt4zKOdN11x6BYRoW/swFXiyHUKTn3AoIMFagaVg
 Z5d0ZHQtt2I2ftkxq/HHmGP0OeLUwisvwxlIYLU+8Ht5LVgmarvtmIVDv16YvfQFwL3Q
 /IYA==
X-Gm-Message-State: APjAAAUfoV1ZtI/FpViB1t/CkRIAp2S2j/FDmPN59kLngwqN7f6exx13
 Z4SrRMvJMq6CnD+QoX8CDHZqoQ==
X-Google-Smtp-Source: APXvYqxLeBk8Dci7RyzNPZMU/xQYWT6D8Pfyqexx5CMLiWHok4RV3RXalmuBLBQniNZFp3efGU80xA==
X-Received: by 2002:a17:902:5a42:: with SMTP id
 f2mr2105689plm.45.1566527389386; 
 Thu, 22 Aug 2019 19:29:49 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id y23sm829640pfr.86.2019.08.22.19.29.47
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 22 Aug 2019 19:29:48 -0700 (PDT)
To: Tony Nguyen <tony.nguyen.git@mail.com>, qemu-devel@nongnu.org
References: <cover.1566466906.git.tony.nguyen@bt.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <a61e429b-6493-3ad0-cd22-07832dbcc1f7@linaro.org>
Date: Thu, 22 Aug 2019 19:29:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <cover.1566466906.git.tony.nguyen@bt.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: Re: [Qemu-devel] [PATCH v9 00/20] Invert Endian bit in SPARCv9 MMU
 TTE
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
Cc: Tony Nguyen <tony.nguyen@bt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/22/19 6:19 PM, Tony Nguyen wrote:
> v9:
> - Rebase on master and test with git am... again apologies to all, thanks for
>   the patience =)

So... after an hour only the cover letter has arrived.
I'm thinking that it didn't work.


r~

