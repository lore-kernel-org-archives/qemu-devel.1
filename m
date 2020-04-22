Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE1A6C54FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 19:21:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9466C2098B
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 19:21:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bDq13WTr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9466C2098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRKwC-0005P9-QH
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 15:21:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42446)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jRKvG-0004dp-8U
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 15:20:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jRKvF-0005ma-20
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 15:20:38 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:42518)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jRKvE-0005lx-Hw
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 15:20:36 -0400
Received: by mail-pl1-x643.google.com with SMTP id v2so1319784plp.9
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2020 12:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Daf79OsgPMnuEEVxBEtjek7ejgbQ2cP8bZVNkScey1M=;
 b=bDq13WTrecaE1WOgYZ7SqTUUGgr/JyuaM3J/cggxWZj6UasqcZjy7xOXR0pWvgeK/3
 +FJjuABPYyO5Qi+/hM37uG7rZBdRTgc0qrVXPsVjGdiziPQ7wPnzyQcld4QGRxewOJ87
 LQvcPjVwuYHL8I7YLgX0G6KwxenCWhaYQumDTZTmHAKNcNKApkZoSdE41B8WSAxfyo0Z
 sYjiEdZ9B5IbtvQuQVzwKrifadOQrIBw79ZQfMrTu2vp3pkHfiAv+zqtnSM5LirlY2R0
 Qa02IPJrYo9LaGNEp79EMjQh5pqlLLP1BM/1Vnlohwuwn+GoqTAabSQfnsFbfVKEPUJX
 d2EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Daf79OsgPMnuEEVxBEtjek7ejgbQ2cP8bZVNkScey1M=;
 b=YPi2G78FdqTk0CllK+mmfBnhIWfOqY95gwfYrCQopGM9vQvDNCbLnORI83+8MYQzBX
 kxNfSGsgR3RuV7bdc04Lnzd1NhT8Igj+15zcT03997CPkKf1CUJNRCOWWV6slNtusxKM
 83MzjN/7RTN22Jln4y63aKJmuFon1x3MvLwiucKree43bY0VgriS0XSQjLjRGxfmfhs9
 hPtWbH3nin5d/06NakD50jrOJbr6TdkBcxwh+JLCYZYR77l0R5a6/Fr2/M1/McHPZuOP
 DLGBkrjI40gi1DBiY0NxX52Fsmaopo6QaHkOQxpiJGeJqQ3eKxrmYFxlYNaAAojYEpv4
 1j3w==
X-Gm-Message-State: AGi0Puax9C34+shXtlJps4ILmBrsxG07F4aqFtFJkNLawIa0gjca30ov
 OSimEZkQGLq6p8tgBLsFpzkVWw==
X-Google-Smtp-Source: APiQypIb/MLZSY6elOdP17qGFJH0oKZRQXsBmTX22PKKFTUDDsrIEvIVCoDW2iYteZwQMrkxjz4PNA==
X-Received: by 2002:a17:90a:20a8:: with SMTP id
 f37mr280448pjg.148.1587583234472; 
 Wed, 22 Apr 2020 12:20:34 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id i185sm261785pfg.14.2020.04.22.12.20.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Apr 2020 12:20:33 -0700 (PDT)
Subject: Re: [PATCH] linux-user/riscv: fix up struct target_ucontext definition
To: Alistair Francis <alistair23@gmail.com>
References: <20200412020830.607-1-zhiwei_liu@c-sky.com>
 <f6dc4fa7-fed5-28a1-5922-68e9a0510de5@c-sky.com>
 <bf6b46c3-cc39-1b4a-4ae4-9de894721f04@linaro.org>
 <CAKmqyKMZ9x+PXOxnFqE5e-h+cCZjJThEBjJip_OCppjX71DSrg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e65178b8-32b0-b389-c58a-6883b9bc0989@linaro.org>
Date: Wed, 22 Apr 2020 12:20:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAKmqyKMZ9x+PXOxnFqE5e-h+cCZjJThEBjJip_OCppjX71DSrg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x643.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::643
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Riku Voipio <riku.voipio@iki.fi>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 wxy194768@alibaba-inc.com, Laurent Vivier <laurent@vivier.eu>,
 wenmeng_zhang@c-sky.com, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/22/20 11:05 AM, Alistair Francis wrote:
> Just to clarify, this patch is still correct right?

Yes.


r~

