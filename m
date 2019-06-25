Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E57C48BD4
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 16:11:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1DC22080C
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 16:11:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lJ+wCtGn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1DC22080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33562 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfo2U-0008Bf-5L
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 12:11:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39127)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hfnp3-0000Y5-S0
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 11:57:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hfnp2-00073L-8C
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 11:57:29 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:41687)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hfnot-0006QE-9Z
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 11:57:21 -0400
Received: by mail-wr1-x442.google.com with SMTP id c2so18473978wrm.8
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2019 08:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=eCy19TIcQjDZBWbVzYAb4ieFgOLBclInzFZoyRzVtgk=;
 b=lJ+wCtGnSF1fifuuQ4TK0P8+pAZKiTGkBU5CVx+Y8aplXNQNdmtVavVq06EZJHtG7R
 0aGwQE7QS9hclgBiMUERVObpz+VPfqHs2lk1bSYtmdurGy7MGD4WoV/CsBWCFVLzhTj4
 V18RHQQK/JZAY9YEHzyQmfyBVXqDipLavNfJ1QJRZN0hA/l7RmGmr4RfgPTXIUtJ6cQK
 MshFjSgO4xHG8rQWMSCy7Ldmec5XJGiEfBzU1AnisdFpqNKIaUhbhtSqd4Vo5ax0KqMo
 Vbf9nEFfda2sXWTxBHxcxzbfMPk3eMBugA0niivrRRj5jciPWleQZwmG2h6IDXyt3qpg
 T9gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=eCy19TIcQjDZBWbVzYAb4ieFgOLBclInzFZoyRzVtgk=;
 b=LPzUpa6PaaHP2DjdoqrEeyoNL9sQwFB7ylvTNfy/+gho9/6jj/ymbGE9TPLFOOfwUk
 HUulhNVFZpZvccEu41nz5hSRpv6nB30pL8+HpfRKGeGmrEYg9XxtlqED3wHpnl3PoQNa
 eVYjwsVIdyLlXWLx7dh8wyzPU4H5mk/c7k6sfjgvAFrZX0JLDPjmiSOlLli3JhSGUC/d
 RPZnr9gEsRq5z2sZh+LWiHlwwUX5zNkayHH2ykAwbqL1cTfipo3zEa1BNSYe8DjcPd2i
 nIFZA3bxFhBKm2Qt7QBRizWZ44YG9KkNQ6cprifapysK70+Yny5Q0uNSgS0nOtN/1dzZ
 jiqQ==
X-Gm-Message-State: APjAAAX8+aI8LDYBqROHsAuhzFWPPUTU39SXJP399BVlQu2rVzglvn9a
 IaS7CEMX+PmRWcQspuWb/sKijg==
X-Google-Smtp-Source: APXvYqxbkjqWDO1vGKVh2oSfMXi8omTMWwM4cMtF3wjKx3ZuTbgCWEb4O3p/g8MtWR/ddGz9pgl1AA==
X-Received: by 2002:adf:f606:: with SMTP id t6mr3495001wrp.265.1561478205161; 
 Tue, 25 Jun 2019 08:56:45 -0700 (PDT)
Received: from [192.168.2.137] (93-34-153-63.ip50.fastwebnet.it.
 [93.34.153.63])
 by smtp.gmail.com with ESMTPSA id r12sm16398133wrt.95.2019.06.25.08.56.44
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Jun 2019 08:56:44 -0700 (PDT)
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <20190519041522.12327-1-richard.henderson@linaro.org>
 <8f28d008-2608-a579-7505-4546b08deb41@linaro.org>
 <085d6881-f518-9888-a13e-081cdc09de46@ilande.co.uk>
 <0b9f4772-37f6-1453-e4ea-5ad9d0f52a5b@ilande.co.uk>
 <acc57487-c8a0-9380-bc2a-4de22541eabf@ilande.co.uk>
 <CAL1e-=iavFqEeFuNm2efVM7mu5OaABBVo90wqJEhmoWa4DQv=Q@mail.gmail.com>
 <ffae3651-5daf-e008-6562-2de09d82ace9@linaro.org>
 <b8aab3f4-e3eb-a137-62b4-ba5ac1a2ad8f@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <68facefc-b801-4902-11c0-4542662bfc4e@linaro.org>
Date: Tue, 25 Jun 2019 17:56:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <b8aab3f4-e3eb-a137-62b4-ba5ac1a2ad8f@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: Re: [Qemu-devel] [PATCH v4 0/7] tcg/ppc: Add vector opcodes
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
Cc: Howard Spoelstra <hsp.cat7@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/25/19 5:37 PM, Mark Cave-Ayland wrote:
> The problem is that in tcg/tcg-op.h we define "DEF(dup2_vec, 1, 2, 0, IMPLVEC |
> IMPL(TCG_TARGET_REG_BITS == 32))" and in the last patchset dup2_vec isn't introduced
> until towards the end. Unfortunately it's not a simple as bringing the patch forward
> within the series to maintain bisectability because the current implementation
> depends on VMRG which only appears in the patch just before it...

Ah, that would explain it.  I admit I haven't looked at v5 that closely.

> Next to try and figure out what exactly is causing the fault. Just a quick question
> out of curiosity: is your Power9 system BE or LE?

The Power9 is LE.

I do have access to a Power7 BE system, and that worked last time I checked.
I'll try that again tomorrow to be sure.


r~

