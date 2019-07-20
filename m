Return-Path: <SRS0=lwXe=VR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78956C76186
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2019 21:27:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 455652083B
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2019 21:27:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lUST2WiA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 455652083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1howtH-0002XZ-BL
	for qemu-devel@archiver.kernel.org; Sat, 20 Jul 2019 17:27:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35031)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1howt8-00029J-E0
 for qemu-devel@nongnu.org; Sat, 20 Jul 2019 17:27:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1howt7-0003iR-J8
 for qemu-devel@nongnu.org; Sat, 20 Jul 2019 17:27:30 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:44662)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1howt7-0003hg-Bh
 for qemu-devel@nongnu.org; Sat, 20 Jul 2019 17:27:29 -0400
Received: by mail-pl1-x642.google.com with SMTP id t14so17261753plr.11
 for <qemu-devel@nongnu.org>; Sat, 20 Jul 2019 14:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=dzwKaN1zAb/i6mlg/KKuStKIo6qoG4zNpy4HsYJsznE=;
 b=lUST2WiAkyzd4Cnxoe5z6Hth9sWuQRZJoEsqhk139XscPncJRmTxm3VJpiamKgK/cA
 dOepagf9NLDk3Y7cQhmVgXwBhAmPYbt8YbPVfoZ7BANuQUkK9NXySyKBdy/YUVNGfBjZ
 m5crdvzc9X/F4b5KWWD7yQt1+yNDGCK2+cuoeXRmKot/cX+OSB7mfdn9g4nYxPCdyNK5
 putcSY8pCijMf4M2qzaViGltsBX5Jum3FDyaT1Ock3MyFgsH8JbzB5VRN3UlqxRMdbfA
 I9Jjf6KhXC84EL74Zf7glXWX9LpsBp6THsnVaSt180JjrExtHpIQEwrbNvWZ8f8dON2v
 Erag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dzwKaN1zAb/i6mlg/KKuStKIo6qoG4zNpy4HsYJsznE=;
 b=FUAX07femqlsJ5IiV3InQqnuxMpAOaEzLB+pD9QyrR6zjJ1hQVrT+E1itDwB1xMoAS
 Z3kAYmWVBLWiYS+FRq+bqd8q0FnwNVnlP7ZzDA+1GpGv1w8Bl1DyHdaKjMiu8fcPNWUM
 s59A36rPdtwLm1io+bU//fVgxuuTPKv+46mlvxTCH3BW8FJ/tf+Sfv7I2hAYwqgSS+Hr
 GvbPa8Lu6D4VPpONQoxnB7ApXQyDWa+Fx6wFChNDcY+DIQlCJHIG6GwETsZuZiUqx1I2
 VnTUvpHK0rS7RzVfO+hP/ye9EdF9bz/5Taem1d5011PyF8dHmrTd19rAE2hPuKAxAc0F
 ClOg==
X-Gm-Message-State: APjAAAWhK+szW872RM0Aq6EwPUpkVk15P6XDvVZ1q4uQ0rgQtsOJzZzl
 Z0u7bWwnqo+tkZXlnJwMJv3CxA==
X-Google-Smtp-Source: APXvYqzoHWUTipkudLKIgVE4CE/Uly8iZ+tag3ZPDT6OKvEcPiMTq/u4PsBQKyr7lpV8YcgXbQyLvw==
X-Received: by 2002:a17:902:846:: with SMTP id
 64mr65401844plk.265.1563658048016; 
 Sat, 20 Jul 2019 14:27:28 -0700 (PDT)
Received: from [192.168.1.11] (97-126-117-207.tukw.qwest.net. [97.126.117.207])
 by smtp.gmail.com with ESMTPSA id t7sm28676067pjq.15.2019.07.20.14.27.26
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 20 Jul 2019 14:27:27 -0700 (PDT)
To: Jan Bobek <jan.bobek@gmail.com>, qemu-devel@nongnu.org
References: <20190711223300.6061-1-jan.bobek@gmail.com>
 <20190711223300.6061-14-jan.bobek@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <2f30da77-4cf1-5542-2e0c-c8d47b555b8f@linaro.org>
Date: Sat, 20 Jul 2019 14:27:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190711223300.6061-14-jan.bobek@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: Re: [Qemu-devel] [RISU PATCH v3 13/18] x86.risu: add SSE3
 instructions
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/11/19 3:32 PM, Jan Bobek wrote:
> Add SSE3 instructions to the x86 configuration file.
> 
> Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
> ---
>  x86.risu | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

