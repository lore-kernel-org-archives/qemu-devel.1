Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C51C04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 20:38:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A9DB2089E
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 20:38:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zR2/KG7q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A9DB2089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36298 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYz9t-00085y-TD
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 16:38:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43641)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hYz9Q-0007g5-JM
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 16:38:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hYz9P-0000dA-MF
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 16:38:20 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:35060)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hYz9P-0000b9-G4
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 16:38:19 -0400
Received: by mail-oi1-x241.google.com with SMTP id y6so2590257oix.2
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2019 13:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=6dbpXJ4rf5mt0C5hJH9/BMOe9EkYzRZbumk2iCPeE2E=;
 b=zR2/KG7qlCm68fPNrHdWFTHuBGSpmXApx/VKB6NHlq+s3+o3h+t9iI4n2gzljTTUTY
 eQ1PRQBfeR6/zQ1vfgnP0wxDKi85FxVKiOtcVx/WFLMLfnyRTOrv3TdAQk/zi4sDk1sK
 ObIRYbcvuW8gtl3kqFwquG0xayyj+jua9QLPnwwqbKO/g23KaFz5BEaCo32/AAoHRF/m
 kgGoNufeaDZhc8qNJZzd/ZOhtCbUgSe8HVHcnCBcJxco1Ta6uRCtxiWFw7pXPIXoWqtC
 IFUpEy5kxAAgosrlQjBHjyP2VgQL+W//dc7WjU71c0FbXTDdVIvy/yzyAjqXAv8lwJIG
 lTOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6dbpXJ4rf5mt0C5hJH9/BMOe9EkYzRZbumk2iCPeE2E=;
 b=HvKdufWnKRLNkEUn8hkmhi/CT5UjHwWlz6q7dD4dRVFLt7SL2Ohj5LjJDShRH+T7vx
 Opw4RIl8RLqfvw8+nsh7ukuAWimUokJc1aztF5czbVVmDXKzaWfyI7DGTL44Sjvl+SaP
 waAFtFT973BVbB9vETVZqhBnFTk7v3XjrK8OAsnd+MXAobnDMAjNVY4n8l0ISe7g2ReE
 cDRlzwjeiOa3vJi/mGyMcHjRfAuzt6T11EdQOt0ikk99CfzJ6gHZZ2gljHNNY2Jafs5N
 eg1VMQXGKzT/Khuk1RfNaR8J5KWsygj310HkXzuio9cMQt/Y6c0c1m7UxzBQOGOxIDiC
 6sgA==
X-Gm-Message-State: APjAAAXXszmD7LEHH0rpQIf46HK789f4D6KtPVN0TToVyjKWF+qIXmkm
 Fbt2rD1MbEMHYXeazWHP8PJVulLh1/aDVg==
X-Google-Smtp-Source: APXvYqy1ugzBn6mDg64M4Nd7QsRSw/1Lw6NvRej+22nyT/DCygnXspolS4z6r8z1kMwq4G81o9h+MA==
X-Received: by 2002:aca:3c0b:: with SMTP id j11mr1400099oia.125.1559853497529; 
 Thu, 06 Jun 2019 13:38:17 -0700 (PDT)
Received: from [192.168.3.43] (200-56-192-86-cable.cybercable.net.mx.
 [200.56.192.86])
 by smtp.gmail.com with ESMTPSA id f186sm967841oia.52.2019.06.06.13.38.15
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 06 Jun 2019 13:38:16 -0700 (PDT)
To: Stefan Brankovic <stefan.brankovic@rt-rk.com>, qemu-devel@nongnu.org
References: <1559816130-17113-1-git-send-email-stefan.brankovic@rt-rk.com>
 <1559816130-17113-8-git-send-email-stefan.brankovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <93061f61-699f-821d-fda2-4fa287b4506b@linaro.org>
Date: Thu, 6 Jun 2019 15:38:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1559816130-17113-8-git-send-email-stefan.brankovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
Subject: Re: [Qemu-devel] [PATCH 7/8] target/ppc: Optimize emulation of
 vclzh and vclzb instructions
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
Cc: david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/6/19 5:15 AM, Stefan Brankovic wrote:
> Optimize Altivec instruction vclzh (Vector Count Leading Zeros Halfword).
> This instruction counts the number of leading zeros of each halfword element
> in source register and places result in the appropriate halfword element of
> destination register.
For halfword, you're generating 32 operations.  A loop over the halfwords,
similar to the word loop I suggested for the last patch, does not reduce this
total, since one has to adjust the clz32 result.

For byte, you're generating 64 operations.

These expansions are so big that without host vector support it's probably best
to leave them out-of-line.

I can imagine a byte clz expansion like

	t0 = input >> 4;
	t1 = input << 4;
	cmp = input == 0 ? -1 : 0;
	input = cmp ? t1 : input;
	output = cmp & 4;

	t0 = input >> 6;
	t1 = input << 2;
	cmp = input == 0 ? -1 : 0;
	input = cmp ? t1 : input;
	t0 = cmp & 2;
	output += t0;

	t1 = input << 1;
	cmp = input >= 0 ? -1 : 0;
	output -= cmp;

	cmp = input == 0 ? -1 : 0;
	output -= cmp;

which would expand to 20 x86_64 vector instructions.  A halfword expansion
would require one more round and thus 25 instructions.

I'll also note that ARM, Power8, and S390 all support this as a native vector
operation; only x86_64 would require the above expansion.  It probably makes
sense to add this operation to tcg.


r~

