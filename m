Return-Path: <SRS0=Huu6=TF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB2E6C004C9
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2019 15:50:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85715206DF
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2019 15:50:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="stN+DI0d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85715206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42809 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNJPl-0001A8-Rj
	for qemu-devel@archiver.kernel.org; Sun, 05 May 2019 11:50:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49435)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hNJOU-0000Oy-R0
	for qemu-devel@nongnu.org; Sun, 05 May 2019 11:49:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hNJOT-0003Eq-R1
	for qemu-devel@nongnu.org; Sun, 05 May 2019 11:49:38 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433]:42493)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hNJOT-0003Dv-Jw
	for qemu-devel@nongnu.org; Sun, 05 May 2019 11:49:37 -0400
Received: by mail-pf1-x433.google.com with SMTP id 13so5081422pfw.9
	for <qemu-devel@nongnu.org>; Sun, 05 May 2019 08:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=5pjwv8n0Juehh/RddZWZGqhvpPRD9QpoqJ31I7wHZio=;
	b=stN+DI0dLjB4PEdS75gvUT0WgTE1OOjqfOyvrY2rfcCMufywundg+vxTCEr/X2Gaye
	SQRSvfewSwTVrh0HcTB1aJt8OD6lfLxBVRHJi0oe6Udtdz0pYGcIj/H1T0IG6FShYM5q
	UU26awvjRGYeqj+DEFgEhqaod13zvlK9kqCp2XbF6ChQS2beHahELchO26lv2w2rqGW/
	PYGOWkGpZ2BbbXet5Hq6mRqFMq36uY007pazaDMwsy0FBDI7K/ezMCuBWSqEsl5j/NRW
	TH2WbE/qBgUXta4gLYgOJWiQQvcvN/o/ofHEVfT56zfplt5R1Ba5Fho5ebmEYeQQjUT3
	VwbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=5pjwv8n0Juehh/RddZWZGqhvpPRD9QpoqJ31I7wHZio=;
	b=Ywy0CUejRJkACsON2px2GEH8gGhsuaxbNIX9dxoqMPtgg/2QZNa//fF0iTUAKCqwpK
	kzgMEn5DyLzm3JT2P4U2kUoYWiXipkLi9SV+HcUGvm1Px6UyDp3gShJDfXJFjxzabViM
	6mvRLdOWgflh2VCOr2nirI7qKFEtoH7DmpwX9rXc/xasd6IastP9Q0x3GJaee/UOBl3S
	kAGUu/kumZRX8win4/zjMDBDkeCxRPlOwW1gqAWge2q+dTOnPCSv8vgKFRgrybe79CKU
	RhiolMur11qPOnSZs9pKJxuKgdkkzlnMSD+TWuipCh98mPT5gpndYRLIh+pUJwly9keE
	EOCg==
X-Gm-Message-State: APjAAAWNQBMdJy/WUqAbPAChtoDvaBH3ovBZOxqQRpjX/4uHtnLfRo7b
	l43n8VI5aH8zi8VqSLkNvkPX0A==
X-Google-Smtp-Source: APXvYqzrbddPStY7KWGHLjZVxBKYW2qYlzjC8iAJqaqFhEhPM0Kkxe+Jx1k7wTXCc3V9iKs9eBFuTA==
X-Received: by 2002:a65:5684:: with SMTP id v4mr16451725pgs.160.1557071376146; 
	Sun, 05 May 2019 08:49:36 -0700 (PDT)
Received: from [192.168.1.11] (97-113-189-189.tukw.qwest.net. [97.113.189.189])
	by smtp.gmail.com with ESMTPSA id
	e23sm9619328pfi.159.2019.05.05.08.49.34
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 05 May 2019 08:49:35 -0700 (PDT)
To: Sarah Harris <S.E.Harris@kent.ac.uk>, qemu-devel@nongnu.org
References: <20190504083638.13380-1-S.E.Harris@kent.ac.uk>
	<20190504083638.13380-2-S.E.Harris@kent.ac.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <772cbab8-49a2-8969-ba3e-55f190c886ff@linaro.org>
Date: Sun, 5 May 2019 08:49:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190504083638.13380-2-S.E.Harris@kent.ac.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::433
Subject: Re: [Qemu-devel] [PATCH v1 1/8] target/avr: Add instruction decoder
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: A.M.King@kent.ac.uk, mrolnik@gmail.com, E.J.C.Robbins@kent.ac.uk
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190505154933.AVmd2Ef_Nc5ASTSx8Xwbto9wtBR694xB6jxGxKRAmkU@z>

On 5/4/19 1:36 AM, Sarah Harris wrote:
> This utility module builds a decision tree to decode instructions, starting from a human readable list of instruction bit patterns.
> Automatic tree generation will hopefully be more efficient and more maintainable than a hand-designed opcode parser.
> 
> Tree generation happens at startup because this seemed simpler to implement than adding a new build step.

We have such a thing in qemu already, as a separate build step.

See ./scripts/decodetree.py, and some of the uses in

  target/{arm,hppa,riscv}/*.decode

In addition to being able to select the instruction, it also
extracts arguments from the instruction, so there's less
repetition that you have for e.g.

 > +static inline uint32_t MOVW_Rr(uint32_t opcode)
> +{
> +    return extract32(opcode, 0, 4);
> +}
...
> +static inline uint32_t MULS_Rr(uint32_t opcode)
> +{
> +    return extract32(opcode, 0, 4);
> +}


r~

