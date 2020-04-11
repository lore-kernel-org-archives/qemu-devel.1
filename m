Return-Path: <SRS0=9/5m=53=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DABF1C2BA19
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Apr 2020 18:08:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3A2E20732
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Apr 2020 18:08:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BMsrIGAe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3A2E20732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNKYa-0001ln-RS
	for qemu-devel@archiver.kernel.org; Sat, 11 Apr 2020 14:08:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60218)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jNKY1-0001M1-Ad
 for qemu-devel@nongnu.org; Sat, 11 Apr 2020 14:08:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jNKY0-00084H-7R
 for qemu-devel@nongnu.org; Sat, 11 Apr 2020 14:08:05 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c]:44021)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jNKXz-00083X-QJ
 for qemu-devel@nongnu.org; Sat, 11 Apr 2020 14:08:04 -0400
Received: by mail-pl1-x62c.google.com with SMTP id z6so1803127plk.10
 for <qemu-devel@nongnu.org>; Sat, 11 Apr 2020 11:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=7f5Z3nR1IvUVgXxay1D6YgIjctSPOkHbR13M3a9A4a4=;
 b=BMsrIGAeqvVh9uMnExQD0L8TTjS0IgdRNyPg47O3IN9eKmNa4BW4uEh9m3UjwBrcLL
 t9kxbWSZvsbWv3FIBy/H8qV+iIZ0ITtujmWpJJjWOAlDOcTsEDhcPX/3oDD4jAi2t/MP
 J+NvCAVpEkP/fL6BuCoRa9vUH73a/vJRji5oNyt7SmUgtaUO4bzRUtcSP4hptuxf1G6t
 HHcxKRBbmNKplRKR14IFmJdiVqDCY5ZEGpdQ4/RoKx2164EPs5Doc7lJ6toEHv0ihLKP
 mA2uR1h1jkcSGkd1Wwcf+6FLhVcrqmoqWcjtvIMFmxIuBTQiBj/e6HjE7gc+Rbt1xkFR
 6I/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7f5Z3nR1IvUVgXxay1D6YgIjctSPOkHbR13M3a9A4a4=;
 b=aVoi7yIP0RP7wuX9Pq4y67YzAjd297yvxllZ1c3wPhHkOnesjMKpg7k59lDDFGREdF
 w7uLn9TMBWem9jF1yIzhFKKu7ME3Kom4uVBPybMlK6P79QLdHUjvaL5WevrYtsgrD29z
 rxDFOifDJwMZMFNkgOyoWX7h5KCLf9630Jo2blR7/2U2Q5IYmH2rm3kBMWyNoY8n9HU1
 Yl6uepNjenEZBoPOd9V3Egyhwp2GmBfnNGM0CWyFeyUCpRMmLZMTdZLsvED9xq13auNT
 7qum9EicPDOjB56U2WteFVk/E5pCz0M1f/29Y29mL2HeSlggQBUz24exvmU9Z2RVgRzD
 jgdw==
X-Gm-Message-State: AGi0PubMMudWejrh3GA9O8TDIRRi4MrXpUr7M8/uGBPYIPRwfosul+dX
 xrO3h7coLOd0cLj7ypEAhXf4zw==
X-Google-Smtp-Source: APiQypJJTd/orSNeFgSa+FFNqHSyhyX2NTCBL0zeNnUo3zN6QmtOlmxRbs6u4qxjoSkNqRf3n6v2ww==
X-Received: by 2002:a17:902:8688:: with SMTP id
 g8mr10477156plo.268.1586628482203; 
 Sat, 11 Apr 2020 11:08:02 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id g14sm4780106pjd.15.2020.04.11.11.08.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 11 Apr 2020 11:08:01 -0700 (PDT)
Subject: Re: [PATCH] tcg/mips: mips sync* encode error
To: lixinyu <precinct@mail.ustc.edu.cn>, qemu-devel@nongnu.org
References: <20200411124612.12560-1-precinct@mail.ustc.edu.cn>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c3fac325-df9a-be96-72d0-1898635afef9@linaro.org>
Date: Sat, 11 Apr 2020 11:07:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200411124612.12560-1-precinct@mail.ustc.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::62c
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
Cc: arikalo@wavecomp.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/11/20 5:46 AM, lixinyu wrote:
> OPC_SYNC_WMB, OPC_SYNC_MB, OPC_SYNC_ACQUIRE, OPC_SYNC_RELEASE and
> OPC_SYNC_RMB have wrong encode. According to the mips manual,
> their encode should be 'OPC_SYNC | 0x?? << 6' rather than
> 'OPC_SYNC | 0x?? << 5'. Wrong encode can lead illegal instruction
> errors. These instructions often appear with multi-threaded
> simulation.

Good catch.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Queued to tcg-for-5.0.


r~

