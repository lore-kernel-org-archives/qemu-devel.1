Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C3C3C433E7
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 17:22:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A57E2064B
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 17:22:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aAbj9O+e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A57E2064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTTQs-0004TQ-RE
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 13:22:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36850)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kTTKs-0007N5-KL
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 13:16:15 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:38900)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kTTKo-000824-TY
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 13:16:10 -0400
Received: by mail-pg1-x544.google.com with SMTP id j7so1830732pgk.5
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2020 10:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=3u22fuaUAC4emaWKLqxyzZ3iv7mrxTzsyPsdWnCshfA=;
 b=aAbj9O+e+hncOYXIE//uCEsIdUE/2v5mFQrinnTdWvP/VIz6qU5YdUAYjDi6c6/gyk
 MgwlTmHRcwJWgfdOKJcYnbgpATMB9kVhZDh7zlD1JNz+cSLaMs79HLh1A4CLpkDWwn4Q
 ksMNRH63PicW0NXlHEfLfcgk4On9P1J0LPUv+EpjNRvvfdf1sCKC0E03WtekALDymQVl
 8iItQ/7J6UNn70/e+TDIdc1yOW0LvHuecotarxQYhlOCxpzTE8hwbvvRoraZRhKuzm3h
 FG01PbZ7kU6e7eLTXRbg3L+NO8DRNeOU0RugcCmy2liRxS2kt/qTMgOpWc0qAQNbWjuB
 xk7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3u22fuaUAC4emaWKLqxyzZ3iv7mrxTzsyPsdWnCshfA=;
 b=suPE1m5lCPHs5hGCu4WAt04auHBSnYqjh1yh9v7SCM99aUiKuPaOZmgPqQLRhNgtpi
 w0snwaQxbPf9z22SFAcsmg4KIJx3tKWUnSXwFuh+pnNFr2+mKFJVb3lB+jleC9VBPSIa
 apfwbDPRwx1I/Jq6AecDbiGbif6pMSgDUlfdcAM7axip3T4daMJOGMFVMFsaoqgBm1Rl
 2cTKmFP3DbhhFvdCFsSYsjrGGrxpigOkG87fX4EHMF3b5ZHsEbODVPf2jE0J4cLT1U4+
 gQqsvUDtoNpe9VS39Wp4sVHAz/vhiiHtiRXvzxRKYAbm+0yARNQD1O27RelD6JAhglVn
 1hDA==
X-Gm-Message-State: AOAM530a6uobAZY3ydX5z7Or4bTslLeSzO1/GmoDhIuzJGZYIjaSeMpo
 nYYasuzLiQyBnt2xM+G8qoRtkA==
X-Google-Smtp-Source: ABdhPJxxKpWWWX60mXIUMRNkSeF4LGHxgofXDwd5A+qMudQpjuTe/wtTsVg3+/SIYQ4ZMNeggCathw==
X-Received: by 2002:a63:1212:: with SMTP id h18mr3934041pgl.196.1602868565079; 
 Fri, 16 Oct 2020 10:16:05 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id m4sm3317748pgv.87.2020.10.16.10.16.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Oct 2020 10:16:03 -0700 (PDT)
Subject: Re: [PATCH v2 2/5] [RISCV_PM] Support CSRs required for RISC-V PM
 extension except for ones in hypervisor mode
To: Alexey Baturo <baturo.alexey@gmail.com>
References: <20201015152139.28903-1-space.monkey.delivers@gmail.com>
 <20201015152139.28903-2-space.monkey.delivers@gmail.com>
 <d39e0c59-3b04-6401-aaac-8e202fb5036a@linaro.org>
 <CAFukJ-BwbtRyCYFW3+v4f8xmri3+Yk5ayhgZYen-6fj1xjmD9g@mail.gmail.com>
 <CAFukJ-AYk6VjC=8h83+Y==XbTwXODP34_JMzndW6_taD2uu4+g@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <65746626-278a-d380-7df6-4cd71366344a@linaro.org>
Date: Fri, 16 Oct 2020 10:16:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAFukJ-AYk6VjC=8h83+Y==XbTwXODP34_JMzndW6_taD2uu4+g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.253,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "space.monkey.delivers@gmail.com" <space.monkey.delivers@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Dave Smith <kupokupokupopo@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/15/20 11:05 AM, Alexey Baturo wrote:
> Meanwhile, do you think applying **MTE *masks while reading CSR values is a
> good solution for now?

Yes.


r~

