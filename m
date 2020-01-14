Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E69A7C33CB3
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 15:40:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B48EF24672
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 15:40:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kDp31X4H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B48EF24672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irOIJ-0001z6-El
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 10:39:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42371)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1irO8Y-00060D-7r
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 10:29:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1irO8X-0007Rq-4D
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 10:29:46 -0500
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e]:50450)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1irO8W-0007Qb-TV
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 10:29:45 -0500
Received: by mail-pj1-x102e.google.com with SMTP id r67so5847881pjb.0
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2020 07:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=oNmpSnLQPm63kl684uWiRSWlihMm4iv5IcyfVncHJDo=;
 b=kDp31X4HuEWgRZs4P5B2eHxIq+iJ4opMYM0WUrZ7N2MV3t65S7J2XOPLI1a4tLFv7X
 n0HpMob7H9VxsCCfzIEgvqfUOG28kQjhg6/r0M49wt10dI1lnp/4cxh7E6mSH+p1DU3g
 jLFPu8axyyFpWg6B0s2cTUVUg1S2puGCrJfSEkqpTkR3mwbfpuqWL5OPHispSWiyEpNc
 CB25dql/6KqUFK3v73tlypYh2RWZt1m1nySF2WHWvYffowDb5PRjvYO3H8nq+BVU2rmj
 CLX724GxOnDM/Brwo8bNCsDY9AZzlwIZ4M7390pgy2+l8SKEyEawLD5JCFiuQJ7dhXNt
 giNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=oNmpSnLQPm63kl684uWiRSWlihMm4iv5IcyfVncHJDo=;
 b=AwCqur4GWq7pr+3llDc9mjNRJe4KbiTAfchcd7h3XpeTo4A/65bywN+GOICpnQY1J8
 PBt8Na/NOijc2EOY+Rl0DrfS7Hr0J75nXJRLUyVa9JFfm7bYPw3Jc6N7rVOnyu0YEp9a
 9lf1/jRnKR8ueBt1Dgv5TlBV9iUGtyyCQeP9AMhPQpoNO9sDZ6uTzTkrsAqspfTub5lF
 uJGjDb2bSd/yFOkt5SgJE6tXj2NTldNndgRhn2wd6wbqRQHDs7p3upxmZMByZjf/CqCu
 1lxmNlQtW4QgYPnrj52XNRfXKwkkvEli9MBkSU8/Y5aVlHXzAIB9VgKfwxgjZgZwSNMC
 WHtw==
X-Gm-Message-State: APjAAAXlT2w5W32v7xxORCbE7A9URxQr5E4A38+Hkn+UnXfanN10ynbV
 4dbsT7LtU4KRl3Gh+4y2o0Gdlg==
X-Google-Smtp-Source: APXvYqyOFooA8a5KxcafB07X4jMGNEAGYRW6+C7OvoGQ+LyxmeImqF5PyvF2Ys3mNiiHRaTYep04Mg==
X-Received: by 2002:a17:90a:b904:: with SMTP id
 p4mr30068161pjr.62.1579015783891; 
 Tue, 14 Jan 2020 07:29:43 -0800 (PST)
Received: from [192.168.3.43] (rrcs-66-91-136-155.west.biz.rr.com.
 [66.91.136.155])
 by smtp.gmail.com with ESMTPSA id d2sm17681630pjv.18.2020.01.14.07.29.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jan 2020 07:29:43 -0800 (PST)
Subject: Re: [PATCH v2 1/3] target/riscv: Fix tb->flags FS status
To: shihpo.hung@sifive.com, qemu-riscv@nongnu.org
References: <1578996840-14863-1-git-send-email-shihpo.hung@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <6fb13179-c56b-8270-5c64-06ba1d05943e@linaro.org>
Date: Tue, 14 Jan 2020 05:29:39 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1578996840-14863-1-git-send-email-shihpo.hung@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::102e
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
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-devel@nongnu.org,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/14/20 12:13 AM, shihpo.hung@sifive.com wrote:
>      if (riscv_cpu_fp_enabled(env)) {
> -        *flags |= TB_FLAGS_MSTATUS_FS;
> +        *flags |= env->mstatus & MSTATUS_FS;
>      }

Note that riscv_cpu_fp_enabled is *also* testing env->mstatus, and that this
assignment can be made unconditional.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

