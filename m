Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78BA3C2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 16:37:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 412EB20678
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 16:37:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t/NAnoVT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 412EB20678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOOZ3-000868-EZ
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 12:37:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52540)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jOORe-0004Ep-77
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 12:29:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jOORd-0000K3-7X
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 12:29:54 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635]:35177)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jONLt-0007D9-RN
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 11:19:54 -0400
Received: by mail-pl1-x635.google.com with SMTP id y12so53301pll.2
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2020 08:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=LMA7+nc12+TEcnpnCo4NUoMCOGgthvexncXkZ9Bii8Q=;
 b=t/NAnoVTrHxQj4XRlV6+otyKmxI0SC/7svkVdyPN1mj+OK4KZJIwVl0GKrSnoINNcs
 gzBOgqXwjHkgoFLFubTA2wMxMpJpAc0Kp3GkgBaDwn0at2XXZBDiSuQxsg+Mt+N9vuGW
 OWCUIdb10U8dD0DXukeke6E29GZHjUuoQ4RIR8NvQ5l3dHjWG9OZXYIcHh6RZ4p2MxG7
 SLXFfJhvtu4I2Ntcixr+H6+r6vbJuSQKYzhZD07+tV5Z0olHBs5Fuwz/NDc9c3OJVvo3
 A97uC73KtJEL2r22ABDSiKCTOrqzES/oCYhyy4awtOXcSXcmtIw7m+4lQp/B9WOmooqg
 WwSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LMA7+nc12+TEcnpnCo4NUoMCOGgthvexncXkZ9Bii8Q=;
 b=ZAScQvEGC0NuQQJq1+eZHkPiSY4gNzdOknSINTTLE24AG3hz/6GBzZ+E20UPANhggv
 34WvYUE14nN47Sw0x9xwTFwfTq6h90NJ1V7PxkVeFdvlN/ZWe6BVDsha+IePCtnE7NX3
 v/A9NkP10Yxoh49ydCWtTTgy221lZf7exCbHaQrA5w3KfPPN9mqbg5SwfglUdtHcWGEG
 Y1KqwyDXJxlKCKjtuWsWsiMJEMbInG+JdsYN1oAcXiPhSzS6Kl/6gdXLwTHvNFUai4Aj
 7D/DbuSe1mTY/4i/tOL6BK5npp2VBJrlcMoJr8t90HFAnC/JFrS1BWn1OGyG+YZtUnAz
 XeZQ==
X-Gm-Message-State: AGi0PubiuGpOsPPePB/JLhFVXa7lsdIpJIgIYmPGVBvmssa/6cj1/eLb
 BbZ8LO6gPHVolJCbWbdAu/0aug==
X-Google-Smtp-Source: APiQypKYt+1w+oFtSwwkAC2rbdZRI6z11uAX1/tuhthXEEjtkUXEH6Q/pWcJ97RbIGZHmjHWatDSdA==
X-Received: by 2002:a17:90a:1a10:: with SMTP id 16mr704003pjk.31.1586877592428; 
 Tue, 14 Apr 2020 08:19:52 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id d21sm4916243pjs.3.2020.04.14.08.19.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Apr 2020 08:19:51 -0700 (PDT)
Subject: Re: [PATCH-for-5.0] gdbstub: Introduce gdb_get_freg32() to get
 float32 registers
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200414111846.27495-1-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <420ba3eb-996a-6bab-7764-ebf91ab22917@linaro.org>
Date: Tue, 14 Apr 2020 08:19:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200414111846.27495-1-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::635
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/14/20 4:18 AM, Philippe Mathieu-Daudé wrote:
> +static inline int gdb_get_freg32(GByteArray *array, float32 val)
> +{
> +    uint8_t buf[4];
> +
> +    QEMU_BUILD_BUG_ON(sizeof(CPU_FloatU) != sizeof(buf));

Why bother withe the BUG_ON when you could just put the sizeof(CPU_FloatU) into
the array bounds above?


r~

