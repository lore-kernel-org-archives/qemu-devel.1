Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A6FAC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 21:47:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5768208DB
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 21:47:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zSboyk3y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5768208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeQMu-0004NC-27
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 17:47:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34548)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jeQIA-0004dW-FV
 for qemu-devel@nongnu.org; Thu, 28 May 2020 17:42:22 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:37662)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jeQI8-0002Ir-TX
 for qemu-devel@nongnu.org; Thu, 28 May 2020 17:42:21 -0400
Received: by mail-pg1-x543.google.com with SMTP id d10so230374pgn.4
 for <qemu-devel@nongnu.org>; Thu, 28 May 2020 14:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=SLcemRrV27FRypGxSmJ0n999jQGOckKzL2DBNIihofQ=;
 b=zSboyk3ygVshUiGiRCwZxpIbTxt9ubTNW6L06D48kyF7CpB0R7RuJm7rzumXMNRAny
 D/REzYJYLrArFDjLizzjKVVfMoUBbQWdhY9nZ4MH3DNmPCKT7diD+0O9+59zQReO/Gv+
 7ZbsOp9gcYhVde49QN3Q0BBzcPT/acn7EBdjODKi3yZ/r2xHWgokogo9e8pSbVv+SOWR
 rTOCu46AGRVofJ51EojCu2t5Xv0OgNsPNToNZOfIAdkMVFk6CtCV3fY/QVbvundKKmEs
 ZGTfjO4hVlushssju1XfL1azes/RpjD6bUKwVzXRw/XG5FEQ2AqvQFEBHLbQjZ8QaLP7
 A3CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SLcemRrV27FRypGxSmJ0n999jQGOckKzL2DBNIihofQ=;
 b=SSUEQmAao67Zw6XC2JTIVg8NUbqaX/MbuvDUBFigZEaWgsTQxh8If/PGyaGnKPdmbR
 wKOz9aC/7ucnFGX386n2nbVwT2hGkKUyJ0GvKrwZmtTQ3mPNxOxLRA1ld2MN0Opu3M2w
 9N8j4QXCVu7Cm+J1ii7dHcvEYT+ia2FLZz9+HWztD3fbdAexsOxutuTDiblrVV78dXcj
 deuLDvPm5LgLm6z8IjZgrtQJ/1bvXFyJ6QGRVBv76ONTy3YWJBXbYlQpPFSmuHvkb0Up
 3fJCcxw+26/i/gg+1D7uq2doXuBHpT2FEcdpyyXmjh42x5pTsdwPB3IAG8vHRJIpzuDI
 +ozA==
X-Gm-Message-State: AOAM531JrwnsfWPYRqhR0IWbI8brEnpZkDduDns2nsotddemQOykiyiJ
 v3ZKIjZvkQKhUmV62GrbnjtHqYlupkE=
X-Google-Smtp-Source: ABdhPJyUO4sNXvBtZyI8+Q27Rt6gWwdb0cc3O7gY3BelvB3OS0u+DznIWiGru9GQa+CfqjFRhP6iDg==
X-Received: by 2002:a62:2f43:: with SMTP id v64mr5151440pfv.170.1590702138344; 
 Thu, 28 May 2020 14:42:18 -0700 (PDT)
Received: from [192.168.80.99]
 (h216-228-167-147.bendor.dedicated.static.tds.net. [216.228.167.147])
 by smtp.gmail.com with ESMTPSA id w190sm5371922pfw.35.2020.05.28.14.42.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 May 2020 14:42:17 -0700 (PDT)
Subject: Re: [PATCH 0/2] linux-user: Load a vdso for x86_64
To: Laurent Vivier <laurent@vivier.eu>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20200519194452.9009-1-richard.henderson@linaro.org>
 <CAFEAcA8q-4o3yWX2kwS1inPiajP1yzc3NOLBjzQUubKzDNGhhw@mail.gmail.com>
 <e985a1cb-e4e3-6faa-f158-5e797d0b5e92@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f46f5f0a-3a56-538a-e703-0a6afb78ae3d@linaro.org>
Date: Thu, 28 May 2020 14:42:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <e985a1cb-e4e3-6faa-f158-5e797d0b5e92@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/28/20 3:32 AM, Laurent Vivier wrote:
> Le 28/05/2020 à 12:08, Peter Maydell a écrit :
>> On Tue, 19 May 2020 at 20:45, Richard Henderson
>> <richard.henderson@linaro.org> wrote:
>>>  Makefile                  |   4 +-
>>>  linux-user/elfload.c      | 203 +++++++++++++++++++++++++++++++++++++-
>>>  pc-bios/Makefile          |   5 +
>>>  pc-bios/vdso-linux-x64.S  | 115 +++++++++++++++++++++
>>>  pc-bios/vdso-linux-x64.ld |  81 +++++++++++++++
>>>  pc-bios/vdso-linux-x64.so | Bin 0 -> 7500 bytes
>>
>> I'm not really a fan of binaries in source control :-(
> 
> Can't we see that as a firmware or a ROM?
> It's only 7,4 KB and needs a cross-compilation env to be rebuilt.
> 
> Do you have another solution?
> 
> If you don't like this I can remove the series. Let me know.

I think some more of the questions in the cover letter need answering.  Does
this patch set not break your own --static chroot tests, for example?


r~

