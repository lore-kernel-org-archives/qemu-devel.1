Return-Path: <SRS0=ZZp+=TS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2631C04AAF
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2019 15:49:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B262C20645
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2019 15:49:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xT7pa0WC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B262C20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35551 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hS1ab-0007AH-Tu
	for qemu-devel@archiver.kernel.org; Sat, 18 May 2019 11:49:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hS1Vo-0003UL-Nj
	for qemu-devel@nongnu.org; Sat, 18 May 2019 11:44:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hS1Ii-0006ed-DD
	for qemu-devel@nongnu.org; Sat, 18 May 2019 11:31:09 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530]:33130)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hS1Ii-0006e5-5u
	for qemu-devel@nongnu.org; Sat, 18 May 2019 11:31:08 -0400
Received: by mail-pg1-x530.google.com with SMTP id h17so4709359pgv.0
	for <qemu-devel@nongnu.org>; Sat, 18 May 2019 08:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=5pi2j4DvWtpw4Fl0j2MQzIazbqQ2B/eC+cMCr7GhPtg=;
	b=xT7pa0WC+3zmvFmWqvDedlLEYBpz1tKh2MWRJRY0mSmxK8OhIfrqBeqZ8FinXoCnwH
	Hq4l7sTCq4tkaXcaJn7MymTe9gAYprTTgVUMb8TDuISGV0Hqh9a/uJEZVpWr/8z+nfXx
	svFfGYr9lXDN/eZilUJogifleB1viF9Xq4+qAsLApjsQqYxc/GzGsdPKKlZw4gIWcAHL
	irV2SzGo02w2iRoVL5rwxl0A2JsgNMO+B3UdwcO/mE7iEyuQjt0dCLV/eCTGx2DZWqT1
	gkrGZe6FDtwTZj4Y/lYfJ4LC/xXLJ2CdwGZXZE9QgKDlMsBoTuBshKyWqPVeWVEjo/8W
	2hVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=5pi2j4DvWtpw4Fl0j2MQzIazbqQ2B/eC+cMCr7GhPtg=;
	b=D/Ud53GfT64RNN+xseZWVDbrnb/Dc1mKoKwcRD9ZAHHeNifq9hK09kh+f++kroZkFj
	mNsgR9YaSdqFnmXWVwrVz2F59XkG4rJYB4bgf0255PvC5L8PfPi8rtlIbRwJY9fX0f9q
	5MDkMdPs8hCB13ca5nUgh2EB+TPeXORVQpRB3B+hcRKaY4T3rgDGnHvybXF8AGIb9rmT
	JFhM4IR5Pwc/cOXEe0ZpHo/fsSmrE53m3UQ6EY9Rxr38NOwVs1wEEJq6B4SavKb6Glt/
	jKTFNWn1e5xCgHaAytn81utUVYLPnjKm8o9bDT7hLJX5CDAR1huxjP2Ei1SGyBh6EBcd
	L8yQ==
X-Gm-Message-State: APjAAAXVbn27pviSYIBoGriJhMiAA2SHoi5E6uevsP2FnrkU1+MOUc82
	rdyGXf+ZwL9sqJZjfMNaiB5tgpxEaK4=
X-Google-Smtp-Source: APXvYqzWV3brZoLkwUQi6FgFpx4WrSU1wKdht/wjh2sZsA1FX5KrHbXM+ZxMfdZ33RLYBodl1ilLbg==
X-Received: by 2002:a63:2325:: with SMTP id j37mr63441348pgj.137.1558193466823;
	Sat, 18 May 2019 08:31:06 -0700 (PDT)
Received: from [192.168.1.11] (97-113-13-231.tukw.qwest.net. [97.113.13.231])
	by smtp.gmail.com with ESMTPSA id
	c127sm21275212pfb.107.2019.05.18.08.31.05
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sat, 18 May 2019 08:31:06 -0700 (PDT)
To: Jan Bobek <jan.bobek@gmail.com>, qemu-devel@nongnu.org
References: <20190517224450.15566-1-jan.bobek@gmail.com>
	<20190517224450.15566-5-jan.bobek@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <d672c5c2-160c-fa03-6073-eca69ac1c1e8@linaro.org>
Date: Sat, 18 May 2019 08:31:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190517224450.15566-5-jan.bobek@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::530
Subject: Re: [Qemu-devel] [RISU v2 04/11] risu_reginfo_i386: implement
 arch-specific reginfo interface
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/17/19 3:44 PM, Jan Bobek wrote:
> CPU-specific code in risu_reginfo_* is expected to define and export
> the following symbols:
> 
> - arch_long_opts, arch_extra_help, process_arch_opt
> - reginfo_size
> - reginfo_init
> - reginfo_is_eq
> - reginfo_dump, reginfo_dump_mismatch
> 
> Make risu_reginfo_i386.c implement this interface; and while we're at
> it, expand the support to x86_64 as well.
> 
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
> ---
>  risu_reginfo_i386.h |  24 ++++----
>  risu_reginfo_i386.c | 147 ++++++++++++++++++++++++++++++++++----------
>  2 files changed, 127 insertions(+), 44 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


