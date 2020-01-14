Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27579C33C9E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 15:48:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E38312072B
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 15:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GvpWRHPO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E38312072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irOQC-0000uI-3V
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 10:48:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45472)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1irOPO-0000Of-2r
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 10:47:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1irOPM-0003CP-Up
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 10:47:09 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d]:44850)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1irOPM-0003Ay-NB
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 10:47:08 -0500
Received: by mail-pl1-x62d.google.com with SMTP id az3so5376471plb.11
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2020 07:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=iwT76sYjLCcOjBO6rGSyKQ3MWwOzv7H/0Gx+1uV1aGg=;
 b=GvpWRHPOvtwb99X9Y7j2LkCSjLHSauNztFNVXMigoV8KUKDGBusJss3SFOfSFloq72
 5IsGpUt5C/8Z2GZkKImqX8nK0Ob8DS3kCDwSsJO8yD3m2DzAQgtXuxUDx+Cg0OJGEZ5z
 cCln1kI9ZSU8AzGVmrDB7pNG8qRbhNHV7RZ3LNZkWDVl4aH9Azehy5sTMxMEQ36uDrnk
 NZk97tDeMUBjIM6rBXPyIL5i5B3opme7P3h2qXGeXrvi1LX7yX+x9DSFJlr8fJwVl00l
 Z4Q5EhdcoKy64IW1Lo4GlgisF/WIo3sfyV7gsJluuzWNamp9itIM2J9jSn1e0xRn2U5r
 nqAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=iwT76sYjLCcOjBO6rGSyKQ3MWwOzv7H/0Gx+1uV1aGg=;
 b=nWC8fPMfnfy9y+h4Pje7hfH9R0M/MkgP18JPSL0raHGq0WpnJWlBHZ4fpXEHwUjdno
 Z8THIBhNvyM1L/4jfV1nFm73/b5lEcDbEW+8BZHIYEwnTI1vQh7KzDe5pDrpHzuNfZjf
 vK79N30M7uuiKILYVxQgknJoYmGX9S7+eqkwAdVgczNF4mC9G/Qc0G32A7MMB74/QIMa
 bfHdFDvRLjzTw264ktGSBRor4yHACxGcPthy8xMZPMkHrEY7i+904dYgGpHG0XFh+4YF
 JD54ZGf0lwYp5DHKhVuzXqE1OslmKNKSam1INoxkyRit5Pvgm5Byu15irR1k4nuk/w6y
 thQg==
X-Gm-Message-State: APjAAAXZgEzXSkp3GkwQ1VG0TrEiHWP97O60wIHqWsuSnmE6lshiRpE2
 m6eVxaYa1EZETqRwXJyncK9CFw==
X-Google-Smtp-Source: APXvYqwAoq2ls0PH66zSG3mflifFup8nQkU/Nx+/yVHGrjqmkVuJifk/JBDH5Trgiwcfm/rt9cwRJQ==
X-Received: by 2002:a17:90a:c983:: with SMTP id
 w3mr29558888pjt.121.1579016827619; 
 Tue, 14 Jan 2020 07:47:07 -0800 (PST)
Received: from [192.168.3.43] (rrcs-66-91-136-155.west.biz.rr.com.
 [66.91.136.155])
 by smtp.gmail.com with ESMTPSA id j38sm17686580pgj.27.2020.01.14.07.47.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jan 2020 07:47:06 -0800 (PST)
Subject: Re: [PATCH v2 3/3] target/riscv: update mstatus.SD when FS is set
 dirty
To: shihpo.hung@sifive.com, qemu-riscv@nongnu.org
References: <1578996840-14863-1-git-send-email-shihpo.hung@sifive.com>
 <1578996840-14863-3-git-send-email-shihpo.hung@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <aefbc769-e964-f43c-d93e-0ada3c009243@linaro.org>
Date: Tue, 14 Jan 2020 05:47:03 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1578996840-14863-3-git-send-email-shihpo.hung@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::62d
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

On 1/14/20 12:14 AM, shihpo.hung@sifive.com wrote:
>      tcg_gen_ori_tl(tmp, tmp, MSTATUS_FS);
> +    tcg_gen_ori_tl(tmp, tmp, MSTATUS_SD);

Merge these:

  tcg_gen_ori_tl(tmp, tmp, MSTATUS_FS | MSTATUS_SD);

The TCG optimizer doesn't try to handle this sort of thing.

With that,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

