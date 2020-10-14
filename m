Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D67B5C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 21:54:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19F412222A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 21:54:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZVBYbsYb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19F412222A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSoix-0003Jq-4V
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 17:54:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43658)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kSohW-0002TP-TT
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 17:52:52 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:43428)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kSohT-0003tA-Fz
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 17:52:50 -0400
Received: by mail-pf1-x442.google.com with SMTP id a200so626960pfa.10
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2020 14:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=/Mz6RIjhIQS6iuItpzkShw6IriJHVNef2zXMAkN7PZo=;
 b=ZVBYbsYbn7bqpONMpNQb2wJ6riWze4TgFdq+vWffP6V8ujCEs98NcVYbFa5INki1o8
 J6gjvhwizZ2mH2rit2rKG/DW2nPAua2VYZEYSYl0jfhnoCSLzlXE9pGIoKO/f8ZYSNC/
 2ZG65uHElRvxC9RkBC31SIwIMhWI7X0LS/q58OaicxvLbsj+FOiY5+otMijM6g0dpx4I
 DALczSpXaUADPPShi9f2Fae2+ded2m+6ZuQeB1o4+EmSHlUwJwjP2EC6XknOfPIc9IYv
 7X2L5hOTPkNlJgEu10XcZZWx7uaGvI8Y4wgkRi3lTJMIN/tQrMswovViEI17XscjKPR6
 j46w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/Mz6RIjhIQS6iuItpzkShw6IriJHVNef2zXMAkN7PZo=;
 b=QgIsUHr7y3U6RwKwXEszll5sCf1nemehv/RtuXEN6V0I7/sIrLApcqyT4HHQs+/ENy
 6YQbMjZ2u0tSIT5/x5If/V7XrkOSf/QPI5ehPcDXBUBpt0qF4ynYNzLpcM4CvrXdMIsS
 ibZuaMRJOO+HmJVj8EYaeADP2jh+ZovJpprHN8KhKHVd9tZMA0BA979D8yPZACqYazUy
 hfPcRfnj2e86xjFZ9f49G1ZXBznxVMc08/NhNWqilMC1vuKO7FEiuM8foGaHswS8FQ80
 6+DiKxcEvuBXYj/C1MjqOlwqj34F2NY6+pRcbm6oF0S9V5XO3ea6qe8giXRiD515/ZCH
 mcCQ==
X-Gm-Message-State: AOAM5324KfxcPMedF9BlJcyXJ+r4PgpNPUVm+9yQr3aaWHMSrvnNjA00
 V+b/15cMFYr5lDLJH2ZOo1BZCTsm7DUuag==
X-Google-Smtp-Source: ABdhPJwRIu0FZOPuzG3vvTx/E5Hix8kU1EiOEoBEHCdN+zO6BmtE/Tc8AkiX0hA/oh+8HmgROH8UZw==
X-Received: by 2002:a62:53c5:0:b029:156:223c:e88b with SMTP id
 h188-20020a6253c50000b0290156223ce88bmr1185930pfb.38.1602712365437; 
 Wed, 14 Oct 2020 14:52:45 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id ge19sm508532pjb.55.2020.10.14.14.52.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2020 14:52:44 -0700 (PDT)
Subject: Re: [PATCH] qemu-palcode: Changes to support booting NetBSD/alpha
To: Jason Thorpe <thorpej@me.com>, qemu-devel@nongnu.org
References: <20201007025229.7487-1-thorpej@me.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c35e151d-7b9c-849f-e4a0-a9c62d9a31a1@linaro.org>
Date: Wed, 14 Oct 2020 14:52:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201007025229.7487-1-thorpej@me.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/6/20 7:52 PM, Jason Thorpe wrote:
> There are additional changes in Qemu itself.  Those will be sent as
> a follow-up.
> 
> - Change the $a2 value at VM start from "cpu count" to "config word".  Bits
>   0-5 are cpu count, and bit 6 communicates the "-nographic" option from
>   the VM.
> - Provide a Console Terminal Block in the HWRPB.  Initialize this based on
>   the location of the PCI VGA, or to the serial port if Qemu has been run
>   with "-nographic".
> - Initialize hwrpb.hwrpb.cpuid correctly; it's the WHAMI of the primary CPU,
>   not the CPU type.
> - Don't set the "PALcode memory valid" bit in the PCS flags field; those
>   HWRPB fields are not, in fact, valid.
> - Allow swppal() to specify the new $pv value.  Use this to pass the
>   CPU_Restart_data to the cpu spinup entry point.
> - Fix a bug in PCI address configuration that caused the CMD646 IDE registers
>   to be mapped incorrectly.
> - When configuring the PCI bus, program system-specific interrupt routing
>   information into the PCI device "line" register (as SRM does).
> - When building the PALcode, don't include outside header files; put everything
>   that's needed in protos.h.

I'm certainly open to these changes.  But it'll need to be split up -- one
patch per bullet, basically.


r~

