Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1FAEC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 03:27:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A466720674
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 03:27:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dbg911Mt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A466720674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7Vo0-0005Bi-Tg
	for qemu-devel@archiver.kernel.org; Sun, 16 Aug 2020 23:27:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40544)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k7VnT-0004l6-Tx
 for qemu-devel@nongnu.org; Sun, 16 Aug 2020 23:26:55 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:34432)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k7VnR-0002n7-H5
 for qemu-devel@nongnu.org; Sun, 16 Aug 2020 23:26:55 -0400
Received: by mail-pf1-x443.google.com with SMTP id m71so7556396pfd.1
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2020 20:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=HVzCHdApRfOoAyZ7cNP02ne60eguqRFGAf6U+jf8Wco=;
 b=Dbg911MtXrpfj45rETcf33socxlbBN4liH9ucO5zoFJSPYkP87ntxEaoAYgrVvJ32r
 SxoawDGheQThwSdiA7c6c4yBQJ7QPfBdttjXQkF9Cgh0hB0MjwLwo6FIgAXDlP6Vn51o
 x8pHsRqM8u1Q8PnCwfLzoq0xXIHzm09GmfmLFE/rn9vfwrFCgCg6+n/G9njNzNYkN67X
 3ufsLN1uiHAelsmyqQmn9cvHJbXEwK3cNlJBZJpiQD3Zns0FZlZKPJPp+3XzOTTexOlU
 yGP4gHMXw27uGR44rDoqRGUbU9nHxm16bpLtoxQN9IuzzdO2i5e6FXmXZrMU96OoRrlv
 zMbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HVzCHdApRfOoAyZ7cNP02ne60eguqRFGAf6U+jf8Wco=;
 b=Df2qA+7i6onz8pG9CR5beuUtY/1HUNm1YBKUhwENpaNl1mgNXKYlhAV4Sf6T/8/93R
 cgdAJ2P/dHkkoUe/FVs4HU3CV4TmCMLhGrzEvK+Waku4y9rzwrZB6T0LABiIOR//r2FV
 dzjkNl0zLoUcaRdaIlXfwhuYuBjsnBVLO1nu++7PxWVkZZvY10RA6IWbUqpktaU3mxUV
 8Zfyvp405HLXNf7VYbcJ3PiyTS3ue50CP33hRnpiXEl9cyvAao9/NPgnYd2TxIks0frf
 ZxvPBJNsGRGGR31eoR09iFpqeryjAaWILjUX8L2u6WpcOmRVMpayMf02k5AWmgBEH020
 MUPw==
X-Gm-Message-State: AOAM530+6U5tFD21C5hjiwYVJSjDnksiL47YaiBV+Spc4QzVMlADY3Qp
 baFEalWHj6MMI9WRd1tbDN/QfA==
X-Google-Smtp-Source: ABdhPJwp7p1ud/wrSf2dsRlkI7FrbLk9Di8phcvfCHo/XG7SM8gYjcmlHDxDiUP5dQ3v/TRD6avxFQ==
X-Received: by 2002:aa7:9a4c:: with SMTP id x12mr9890970pfj.307.1597634811915; 
 Sun, 16 Aug 2020 20:26:51 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id t11sm16585106pfe.165.2020.08.16.20.26.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Aug 2020 20:26:51 -0700 (PDT)
Subject: Re: [PATCH v4] qapi/opts-visitor: Fixed fallthrough compiler warning
To: Rohit Shinde <rohit.shinde12194@gmail.com>
References: <20200816023127.22268-1-rohit.shinde12194@gmail.com>
 <9abbbc9d-b5d5-fdd1-e6ff-c89071189f7f@linaro.org>
 <CA+Ai=tB3QW7+vt4qSrfSBornPmPJ+1rVajvvXf=p4kg3FG2+ZA@mail.gmail.com>
 <125714a6-e441-629f-e9ab-d04ce8b0d94e@linaro.org>
 <CA+Ai=tAy1C3UwxPw26Jkbm7+DGA_mrryG8Sekm9t9Bk3ZhPTow@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3824d0e6-1db2-04b4-8731-6d45a2d0f014@linaro.org>
Date: Sun, 16 Aug 2020 20:26:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CA+Ai=tAy1C3UwxPw26Jkbm7+DGA_mrryG8Sekm9t9Bk3ZhPTow@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: mdroth@linux.vnet.ibm.com, qemu-devel@nongnu.org, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/16/20 5:57 PM, Rohit Shinde wrote:
> I misread the comment. The comment /* fallthrough */ was meant to stop the
> compiler warning from occurring. I am trying to complete the bite sized task
> mentioned here <https://wiki.qemu.org/Contribute/BiteSizedTasks> under
> "Compiler driven cleanups". I wanted to take that up to get more familiar with
> the codebase.

Fine, but the current comment matches the compiler regexp, so this instance
isn't part of that cleanup.


r~


